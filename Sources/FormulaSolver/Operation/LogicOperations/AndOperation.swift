//
//  AndOperation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


struct AndOperation: Operation {
    func solve(arguments: [Value]) throws -> Value {
        let validationErrors = evaluate(arguments: arguments)
        if let error = validationErrors.first {
            throw error
        }
        
        let result = arguments.reduce(true) { (accumulator, nextArgument) -> Bool in
            guard case .boolean(let nextValue) = nextArgument else { return accumulator }
            return accumulator && nextValue
        }
        
        return .boolean(result)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        
        if arguments.count < 2 {
            errors.append(.invalidNumberOfArguments(expected: 2, received:  arguments.count))
            return errors
        }
        
        arguments.forEach {
            if case .boolean = $0 {
            } else {
                errors.append(.invalidArgumentType(expected: "Bool", received: $0.name))
            }
        }
        return errors
    }
}
