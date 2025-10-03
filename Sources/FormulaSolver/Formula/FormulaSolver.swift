//
//  FormulaSolver.swift
//  PLC
//
//  Created by Lucas Barros on 24/09/25.
//


public struct FormulaSolver {
    
    typealias Parser = FormulaParsing & ValueParsing
    
    let parser: Parser
    
    init(parser: Parser = FormulaParser()) {
        self.parser = parser
    }
    
    public init() {
        self.parser = FormulaParser()
    }
}

extension FormulaSolver: FormulaSolving {
    public func solveFormula(_ formula: String, context: [String: String] = [:]) throws -> String {
        let parsedFormula = try parser.parseFormula(formula)
        let parsedContext = try parseValues(context: context)
        
        let result = try solve(parsedFormula, context: parsedContext)
        return result.description
    }
    
    public func isFormulaValid(_ formula: String) throws -> Bool {
        // TODO: Implement validation. Should return bool or expose errors?
        return true
    }
}

extension FormulaSolver {
    func solve(_ formula: Formula, context: [String: Value]) throws -> Value {
        let operation = try OperationFactory.makeOperation(from: formula.operation)
        
        let resolvedArguments = try formula.arguments.map { argument  in
            try resolveArgumentIfNeed(argument, context: context)
        }
        
        return try operation.solve(arguments: resolvedArguments)
    }
    
    func parseValues(context: [String: String]) throws -> [String: Value] {
        return try context.mapValues { valueRaw in
            try parser.parserValue(valueRaw)
        }
    }
    
    private func resolveArgumentIfNeed(_ argument: Value, context: [String: Value]) throws -> Value {
        switch argument {
        case .reference(let variableName):
            guard let value = context[variableName] else {
                throw FormulaParserError.unknownReference(variableName)
            }
            
            if case .nestedFormula(let nestedFormula) = value {
                return try solve(nestedFormula, context: context)
            } else {
                return value
            }
            
        case .nestedFormula(let nestedFormula):
            return try solve(nestedFormula, context: context)
            
        default:
            return argument
        }
    }
}


