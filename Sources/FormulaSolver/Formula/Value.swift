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
        case (.nestedFormula(let l), .nestedFormula(let r)):
            return l == r
        default:
            return false
        }
    }
}
