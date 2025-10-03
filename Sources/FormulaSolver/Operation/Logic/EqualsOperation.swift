//
//  EqualsOperation.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//


struct EqualsOperation: Operation {
    func execute(arguments: [Value]) -> Value {
        let isEqual = arguments[0] == arguments[1]
        return .boolean(isEqual)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        if arguments.count == 2 {} else {
            errors.append(.invalidNumberOfArguments(expected: 2, received: arguments.count))
        }
        
        arguments.forEach { value in
            switch value {
            case .number, .string:
                break
            default:
                errors.append(.invalidArgumentType(expected: Value.SelfType.string, received: value.selfType))
            }
        }
        
        return errors
    }
}
