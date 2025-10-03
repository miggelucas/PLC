//
//  OperationError.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


enum OperationError: Error {
    case invalidArgumentType(expected: Value.SelfType, received: Value.SelfType)
    case invalidNumberOfArguments(expected: Int, received: Int)
    case unknownOperation
}

extension OperationError: Equatable {}
