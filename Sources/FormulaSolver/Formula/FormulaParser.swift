//
//  FormulaParser.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

import Foundation

protocol FormulaParsing {
    func parseFormula(_ formula: String) throws -> Formula
    
}

protocol ValueParsing {
    func parserValue(_ string: String) throws -> Value
}


struct FormulaParser {
    
    init() {}

    enum KeyChar {
        static let openParenthesis = "("
        static let closeParenthesis = ")"
        static let parameterSeparator = ";"
        static let stringLiteral = "\""
    }
}

extension FormulaParser: FormulaParsing {
    func parseFormula(_ formula: String) throws -> Formula {
        let components = formula.split(separator: "(", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
        
        guard components.count == 2,
              var parametersContent = components.last,
              let operation = components.first,
              !operation.isEmpty,
              parametersContent.hasSuffix(")") else {
            throw FormulaParserError.invalidFormat
        }
        
        parametersContent.removeLast()
        
        let parameterStrings = try splitParameters(from: parametersContent)
        
        let arguments = try parameterStrings.map { try parserValue($0) }
        
        guard !arguments.isEmpty else {
            throw FormulaParserError.missingParameters
        }
        
        return Formula(operation: operation, arguments: arguments)
    }
}

extension FormulaParser: ValueParsing {
    func parserValue(_ string: String) throws -> Value {
        if let boolValue = Bool(string) {
            return .boolean(boolValue)
        }
        
        if let numberValue = Double(string) {
            return .number(numberValue)
        }
        
        if string.hasPrefix(KeyChar.stringLiteral) && string.hasSuffix(KeyChar.stringLiteral) {
            let startIndex = string.index(after: string.startIndex)
            let endIndex = string.index(before: string.endIndex)
            return .string(String(string[startIndex..<endIndex]))
        }
        
        if string.contains(KeyChar.openParenthesis) && string.hasSuffix(KeyChar.closeParenthesis) {
            return .nestedFormula(try parseFormula(string))
        }
        
        return .reference(string)
    }
}

private extension FormulaParser {
    func splitParameters(from string: String) throws -> [String] {
        var parameters: [String] = []
        var currentParameter = ""
        var parenthesisCount = 0
        var inStringLiteral = false
        
        for char in string {
            switch String(char) {
            case KeyChar.openParenthesis where !inStringLiteral:
                parenthesisCount += 1
                currentParameter.append(char)
                
            case KeyChar.closeParenthesis where !inStringLiteral:
                parenthesisCount -= 1
                currentParameter.append(char)
                
            case KeyChar.stringLiteral:
                inStringLiteral.toggle()
                currentParameter.append(char)
                
            case KeyChar.parameterSeparator where parenthesisCount == 0 && !inStringLiteral:
                parameters.append(currentParameter.trimmingCharacters(in: .whitespaces))
                currentParameter = ""
                
            default:
                currentParameter.append(char)
            }
            
            if parenthesisCount < 0 {
                throw FormulaParserError.unbalancedParentheses
            }
        }
        
        if parenthesisCount != 0 {
            throw FormulaParserError.unbalancedParentheses
        }
        
        if !currentParameter.isEmpty || !parameters.isEmpty {
            parameters.append(currentParameter.trimmingCharacters(in: .whitespaces))
        }
        
        return parameters
    }
}
