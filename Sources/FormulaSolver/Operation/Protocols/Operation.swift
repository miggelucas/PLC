//
//  Operation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


protocol Operation {
    func solve(arguments: [Value]) throws -> Value
    func execute(arguments: [Value]) -> Value
   
    func evaluate(arguments: [Value]) -> [OperationError]
    func validate(arguments: [Value]) throws
}

extension Operation {
    func validate(arguments: [Value]) throws {
        let errors =  evaluate(arguments: arguments)
        if let error = errors.first {
            throw error
        }
    }
    
    func solve(arguments: [Value]) throws -> Value {
        try validate(arguments: arguments)
        return execute(arguments: arguments)
    }
}
