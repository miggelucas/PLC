//
//  Value.swift
//  PLC
//
//  Created by Lucas Barros on 27/09/25.
//


enum Value {
    case boolean(Bool)
    case number(Double)
    case string(String)
    case nestedFormula(Formula)
    case reference(String)
    
    var name: String {
        switch self {
        case .boolean: return "Boolean"
        case .number: return "Number"
        case .string: return "String"
        case .nestedFormula: return "Nested Formula"
        case .reference: return "Reference"
        }
    }
    
    var description: String {
        switch self {
        case .boolean(let bool):
            return bool.toString()
        case .number(let number):
            return String(number)
        case .string(let string):
            return string
        case .nestedFormula(let formula):
            return "Formula - Operation: \(formula.operation), Arguments: \(formula.arguments)"
        case .reference(let string): return "Reference: \(string)"
        }
    }
}

extension Value: Equatable {
    static func ==(lhs: Value, rhs: Value) -> Bool {
        switch (lhs, rhs) {
        case (.boolean(let l), .boolean(let r)):
            return l == r
        case (.number(let l), .number(let r)):
            return l == r
        case (.string(let l), .string(let r)):
            return l == r
        case (.string(let l), .number(let r)):
            return l == String(r)
        case (.number(let l), .string(let r)):
            return String(l) == r
        case (.nestedFormula(let l), .nestedFormula(let r)):
            return l == r
        case (.reference(let l), (.reference(let r))):
            return l == r
        default:
            return false
        }
    }
}

extension Value {
    enum SelfType {
        case string, number, boolean, nestedFormula, reference, unknown
    }
    
    var selfType: SelfType {
        switch self {
        case .boolean:
            return .boolean
        case .number:
            return .number
        case .string:
            return .string
        case .nestedFormula:
            return .nestedFormula
        case .reference:
            return .reference
        }
    }
}
