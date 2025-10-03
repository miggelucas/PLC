//
//  AndOperationTests.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

import Testing
@testable import FormulaSolver

@Suite("AndOperation Tests")
class AndOperationTests {
    
    let operation = AndOperation()
    
    // MARK: - Evaluate testing
    @Suite("Evaluate")
    final class EvaluateTests: AndOperationTests {
        
        @Test("Should return error of argument count if less than two arguments")
        func evaluate_whenGivenLessThanTwoArguments_shouldReturnInvalidArgumentCountError() {
            let arguments: [Value] = [.boolean(true)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == .invalidNumberOfArguments(expected: 2, received: 1))
        }
        
        @Test("Should return error of argument type if non-boolean arguments")
        func evaluate_whenGivenNonBooleanArguments_shouldReturnInvalidArgumentTypeError() {
            let arguments: [Value] = [.boolean(true), .number(123)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == .invalidArgumentType(expected: .boolean, received: .number))
        }
        
        @Test("Should return empty array for valid arguments")
        func evaluate_whenGivenValidArguments_shouldReturnNoErrors() {
            let arguments: [Value] = [.boolean(true), .boolean(false), .boolean(true)]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.isEmpty)
        }
    }
    
    // MARK: - Solve Testing
    @Suite("Solve")
    final class SolveTests: AndOperationTests {
        
        @Test("Should return false if any argument is false")
        func solve_whenAnyArgumentIsFalse_shouldReturnFalse() throws {
            let arguments: [Value] = [.boolean(true), .boolean(false), .boolean(true)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(false))
        }
        
        @Test("Should return true if all arguments are true")
        func solve_whenAllArgumentsAreTrue_shouldReturnTrue() throws {
            let arguments: [Value] = [.boolean(true) , .boolean(true)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(true))
        }
        
        @Test("Should throw error if given one argument")
        func solve_whenGivenOneArgument_shouldThrowError() {
            let arguments: [Value] = [.boolean(true)]
            
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
