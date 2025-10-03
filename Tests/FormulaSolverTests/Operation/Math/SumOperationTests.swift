//
//  SumOperationTests.swift
//  PLC
//
//  Created by Lucas Migge on 03/10/25.
//

import Testing
@testable import FormulaSolver


@Suite("SumOperation Tests")
class SumOperationTests {
    let operation: Operation = SumOperation()
    
    @Suite("Solve")
    final class SolveTests: SumOperationTests {
        @Test("Should sum given number arguments")
        func sumOfGiveNumbers() async throws {
            let arguments: [Value] = [.number(2), .number(3)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .number(5))
        }
        
        @Test("Should sum given float numbers")
        func sumOfGiveFloatNumbers() async throws {
            let arguments: [Value] = [.number(2.5), .number(3.5)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .number(6))
        }
        
        @Test("Should sum any given numbers")
        func sumOfAnyNumbers() async throws {
            let arguments: [Value] = [.number(2.5), .number(3.1), .number(4)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .number(9.6))
        }
        
        @Test("Should throw an error if arguments list is empty")
        func emptyArgumentsList() async throws {
            let arguments: [Value] = []
            
            #expect(throws: OperationError.invalidNumberOfArguments(expected: 2, received: 0), performing: {
                let _ = try self.operation.solve(arguments: arguments)
            })
        }
        
        @Test("Should throw an error if any argument are not numbers")
        func nonNumberArguments() async throws {
            let arguments: [Value] = [.number(2.5), .boolean(true)]
            
            #expect(throws: OperationError.invalidArgumentType(expected: .number, received: .boolean), performing: {
                let _ = try self.operation.solve(arguments: arguments)
            })
        }
        
    }
    
    @Suite("Evaluate")
    final class EvaluateTests: SumOperationTests {
        @Test("Should return invalid number of arguments if less than two")
        func shouldReturnInvalidNumberOfArgumentsIfLessThanTwo() async throws {
            let arguments: [Value] = [.number(1)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == OperationError.invalidNumberOfArguments(expected: 2, received: 1))
        }
        
        @Test("Should return invalid argument type if given any arguments that is not a number")
        func shouldReturnInvalidArgumentTypeIfGivenAnyArgumetntThatIsNotANumber() async throws {
            let arguments: [Value] = [.boolean(true), .string("Hello")]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 2)
            #expect(errors.first == OperationError.invalidArgumentType(expected: .number, received: .boolean))
            #expect(errors[1] == OperationError.invalidArgumentType(expected: .number, received: .string))
        }
        
        @Test("Should return empty errors for valid arguments")
        func shouldReturnEmptyErrorsForValidArguments() async throws {
            let arguments: [Value] = [.number(2), .number(2)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.isEmpty)
        }
    }
}
