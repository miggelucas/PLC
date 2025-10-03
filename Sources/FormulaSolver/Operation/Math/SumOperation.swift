//
//  SumOperation.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//


struct SumOperation: Operation {
    func execute(arguments: [Value]) -> Value {
        let result = arguments.reduce(0.0) { accumulator, nextValue in
            guard case .number(let double) = nextValue else { return accumulator }
            return accumulator + double
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
