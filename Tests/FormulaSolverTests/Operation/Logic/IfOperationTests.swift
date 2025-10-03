//
//  IfOperationTests.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//

import Testing
@testable import FormulaSolver

@Suite("IfOperation Tests")
class IfOperationTests {
    let operation: Operation = IfOperation()
    
    @Suite("Solve")
    final class Solve: IfOperationTests {
        @Test("if first argument is true should return second given argument")
        func trueArgument() async throws {
            let arguments: [Value] = [.boolean(true), .number(2), .number(3)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .number(2))
        }
        
        @Test("if first argument is false should return third given argument")
        func falseArgument() async throws {
            let arguments: [Value] = [.boolean(false), .number(2), .number(3)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .number(3))
        }
    
        
        @Test("should return invalid argument error if first argument is not resolved to Boolean")
        func invalidArgumentError() async throws {
            let arguments: [Value] = [.number(2), .number(2), .number(3)]
            
            #expect(throws: OperationError.invalidArgumentType(expected: .boolean, received: .number), performing: {
                let _ = try self.operation.solve(arguments: arguments)
            })
        }
    }
    
    @Suite("Evaluate")
    final class Evaluate: IfOperationTests {
        @Test("Should return invalid argument numbers if has more than 3")
        func invalidArgumentNumbersIfMoreThan3() async throws {
            let arguments: [Value] = [.boolean(false), .number(2), .number(3), .number(4)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == OperationError.invalidNumberOfArguments(expected: 3, received: 4))
        }
        
        @Test("Should return invalid argument numbers if has less than 3")
        func invalidArgumentNumbersIfLessThan3() async throws {
            let arguments: [Value] = [.boolean(false), .number(2)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == OperationError.invalidNumberOfArguments(expected: 3, received: 2))
        }
        
        @Test("Should return invalid argument type if first argument isn't bool or nested formula")
        func invalidArgumentTypeIfFirstArgumentIsntBoolOrNestedFormula() async throws {
            let arguments: [Value] = [ .number(2), .number(3), .number(4)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == OperationError.invalidArgumentType(expected: .boolean, received: .number))
        }
        
        @Test("Should not return errors if argument given are valid")
        func shouldNotReturnErrorsIfGivenArgumentsAreValid() async throws {
            let arguments: [Value] = [.boolean(false), .number(2), .number(3)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.isEmpty)
        }

    }
    
    
}
