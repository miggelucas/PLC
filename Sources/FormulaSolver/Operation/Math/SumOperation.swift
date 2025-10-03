//
//  SumOperation.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//


struct SumOperation: Operation {
    func solve(arguments: [Value]) throws -> Value {
        let errors = evaluate(arguments: arguments)
        if let erro = errors.first {
            throw erro
        }
        
        var result: Double = 0
        arguments.forEach { value in
            if case .number(let double) = value {
                result = result + double
            }
        }
        
        return .number(result)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        if arguments.count >= 2 { } else {
            errors.append(.invalidNumberOfArguments(expected: 2, received: arguments.count))
        }
        
        arguments.forEach { value in
            if case .number = value {} else  {
                errors.append(.invalidArgumentType(expected: Value.SelfType.number, received: value.selfType))
            }
        }
        
        return errors
    }
}
