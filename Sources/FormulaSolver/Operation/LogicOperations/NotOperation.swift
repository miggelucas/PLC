//
//  NotOperation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


struct NotOperation: Operation {
    func solve(arguments: [Value]) throws -> Value {
        let validationErrors = evaluate(arguments: arguments)
        if let error = validationErrors.first {
            throw error
        }
        
        guard case .boolean(let value) = arguments[0] else {
            throw OperationError.invalidArgumentType(expected: "Boolean", received: arguments[0].name)
        }
        
        return .boolean(!value)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        if arguments.count > 1 {
            errors.append(
                .invalidNumberOfArguments(expected: 1,
                                          received: arguments.count)
            )
        }
        
        if case .boolean = arguments[0] {} else {
            errors.append(
                .invalidArgumentType(expected: "Boolean",
                                     received: arguments[0].name)
            )
        }
        
        return errors
    }
}
