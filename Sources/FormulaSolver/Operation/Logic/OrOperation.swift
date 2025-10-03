//
//  OrOperation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//


struct OrOperation: Operation {
    func execute(arguments: [Value]) -> Value {        
        let result = arguments.reduce(false) { (accumulator, nextArgument) -> Bool in
            guard case .boolean(let nextValue) = nextArgument else { return accumulator }
            return accumulator || nextValue
        }
        
        return .boolean(result)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        
        if arguments.count < 2 {
            errors.append(.invalidNumberOfArguments(expected: 2, received: arguments.count))
        }
        
        arguments.forEach {
            if case .boolean = $0 {
            } else {
                errors.append(.invalidArgumentType(expected: Value.SelfType.boolean, received: $0.selfType))
            }
        }
        return errors
    }

}
