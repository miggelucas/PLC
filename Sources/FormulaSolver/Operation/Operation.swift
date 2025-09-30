//
//  Operation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


protocol Operation {
    func solve(arguments: [Value]) throws -> Value
    func evaluate(arguments: [Value]) -> [OperationError]
}