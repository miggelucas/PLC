//
//  IfOperation.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//

struct IfOperation: Operation {
    func solve(arguments: [Value]) throws -> Value {
        let erros = evaluate(arguments: arguments)
        if let anyError = erros.first {
            throw anyError
        }
        
        let condition = arguments[0]
        let valueIfTrue = arguments[1]
        let valueIfFalse = arguments[2]
        
        guard case .boolean(let isTrue) = condition else {
            throw OperationError.invalidArgumentType(expected: Value.SelfType.boolean, received: condition.selfType)
        }
        
        return isTrue ? valueIfTrue : valueIfFalse
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors = [OperationError]()
        if arguments.count == 3 {} else {
            errors.append(OperationError.invalidNumberOfArguments(expected: 3, received: arguments.count))
        }
        
        
        let firstArgument = arguments.first
        switch firstArgument {
        case .boolean, .nestedFormula:
            break
        default:
            errors.append(.invalidArgumentType(expected: Value.SelfType.boolean, received: firstArgument?.selfType ?? .unknown))
        }
        
        return errors
    }
}
