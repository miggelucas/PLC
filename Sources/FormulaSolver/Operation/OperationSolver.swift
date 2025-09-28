//
//  OperationSolver.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

protocol Operation {
    func solve(arguments: [Value]) throws -> Value
    func evaluate(arguments: [Value]) -> [OperationError]
}

enum OperationError: Error {
    case invalidArgumentType
    case invalidNumberOfArguments
    case unknownOperation
}

enum OperationFactory {
    enum OperationTypes: String {
        case not = "NOT"
        case and = "AND"
        case or = "OR"
    }
    
    static func makeOperation(name: String) throws -> Operation {
        guard let operationType = OperationTypes(rawValue: name.uppercased()) else {
            throw OperationError.unknownOperation
        }
        
        switch operationType {
        case .not: return NotOperation()
        case .and: return AndOperation()
        case .or: return OrOperation()
        }
    }
}

struct NotOperation: Operation {
    func solve(arguments: [Value]) throws -> Value {
        let validationErrors = evaluate(arguments: arguments)
        if let error = validationErrors.first {
            throw error
        }
        
        guard case .boolean(let value) = arguments[0] else {
            throw OperationError.invalidArgumentType
        }
        
        return .boolean(!value)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        if arguments.count == 1 {
            errors.append(.invalidNumberOfArguments)
        }
        
        if case .boolean = arguments[0] {
            errors.append(.invalidArgumentType)
        }
        
        return errors
    }
}

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
            errors.append(.invalidNumberOfArguments)
            return errors
        }
        
        arguments.forEach {
            if case .boolean = $0 {
            } else {
                errors.append(.invalidArgumentType)
            }
        }
        return errors
    }
}

struct OrOperation: Operation {
    func solve(arguments: [Value]) throws -> Value {
        let validationErrors = evaluate(arguments: arguments)
        if let error = validationErrors.first {
            throw error
        }
        
        let result = arguments.reduce(true) { (accumulator, nextArgument) -> Bool in
            guard case .boolean(let nextValue) = nextArgument else { return accumulator }
            return accumulator || nextValue
        }
        
        return .boolean(result)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        
        if arguments.count < 2 {
            errors.append(.invalidNumberOfArguments)
        }
        
        arguments.forEach {
            if case .boolean = $0 {
            } else {
                errors.append(.invalidArgumentType)
            }
        }
        return errors
    }

}
