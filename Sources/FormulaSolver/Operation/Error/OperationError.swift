//
//  OperationError.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


enum OperationError: Error {
    case invalidArgumentType(expected: String, received: String)
    case invalidNumberOfArguments(expected: Int, received: Int)
    case unknownOperation
}

extension OperationError: Equatable {}
