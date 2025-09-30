//
//  OperationTypes.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


enum OperationTypes: String {
    // Logic
    case not = "NOT"
    case and = "AND"
    case or = "OR"
    
    var operation: Operation {
        switch self {
        case .not:
            return NotOperation()
        case .and:
            return AndOperation()
        case .or:
            return OrOperation()
        }
    }
}
