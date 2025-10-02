//
//  NotOperationTests.swift
//  PLC
//
//  Created by Lucas Migge on 01/10/25.
//

import Testing
@testable import FormulaSolver


@Suite("NotOperation Tests")
class NotOperationTests {
    let operation = NotOperation()
    
    // MARK: - Evaluate testing
    @Suite("Evaluate")
    final class EvaluateTests: NotOperationTests {
        
        @Test("Should return error of argument count if has more than one")
        func evaluate_whenGiveMoreThanOneArgument_shouldReturnInvalidArgumentCountError() {
            let arguments: [Value] = [.boolean(true), .boolean(false)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == .invalidNumberOfArguments(expected: 1, received: 2))
        }
        
        @Test("Should return error of argument type if non-boolean arguments")
        func evaluate_whenGivenNonBooleanArguments_shouldReturnInvalidArgumentTypeError() {
            let arguments: [Value] = [.number(123)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == .invalidArgumentType(expected: "Boolean", received: "Number"))
        }
        
        @Test("Should return empty array for valid arguments")
        func evaluate_whenGivenValidArguments_shouldReturnNoErrors() {
            let arguments: [Value] = [.boolean(true)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.isEmpty)
        }
    }
    
    // MARK: - Solve Testing
    @Suite("Solve")
    final class SolveTests: NotOperationTests {
        
        @Test("Should return true if argument is false")
        func solve_whenAnyArgumentIsFalse_shouldReturnFalse() throws {
            let arguments: [Value] = [.boolean(false)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(true))
        }
        
        @Test("Should return false if argument is true")
        func solve_whenAllArgumentsAreTrue_shouldReturnTrue() throws {
            let arguments: [Value] = [.boolean(true)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(false))
        }
        
        @Test("Should throw error if given more than one argument")
        func solve_whenMoreThanOneArgument_shouldThrowError() {
            let arguments: [Value] = [.boolean(true), .boolean(true)]
            
            #expect(throws: OperationError.self) {
                _ = try self.operation.solve(arguments: arguments)
            }
        }
        
        @Test("Should throw error if given invalid type argument")
        func solve_whenGivenInvalidType_shouldThrowError() {
            let arguments: [Value] = [.boolean(true), .string("TEXTO")]
            
            #expect(throws: OperationError.self) {
                _ = try self.operation.solve(arguments: arguments)
            }
        }
    }
}
