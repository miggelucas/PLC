//
//  NotOperation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


struct NotOperation: Operation {
    func execute(arguments: [Value]) -> Value {
        let argument = arguments[0]
        
        var boolean: Bool {
            if case .boolean(let bool) = argument {
                return bool
            } else {
                return true
            }
        }
        
        return .boolean(!boolean)
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
                .invalidArgumentType(expected: Value.SelfType.boolean,
                                     received: arguments[0].selfType)
            )
        }
        
        return errors
    }
}
