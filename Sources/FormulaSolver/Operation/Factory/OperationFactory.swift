//
//  OperationFactory.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


enum OperationFactory {
    static func makeOperation(from name: String) throws -> Operation {
        guard let operationType = OperationTypes(rawValue: name.uppercased()) else {
            throw OperationError.unknownOperation
        }
        
        return operationType.operation
    }
}
