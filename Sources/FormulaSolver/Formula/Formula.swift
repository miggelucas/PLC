//
//  Formula.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

struct Formula {
    let operation: String
    let arguments: [Value]
}

extension Formula: Equatable {
    static func == (lhs: Formula, rhs: Formula) -> Bool {
        return lhs.operation == rhs.operation &&
        lhs.arguments == rhs.arguments
    }
}
