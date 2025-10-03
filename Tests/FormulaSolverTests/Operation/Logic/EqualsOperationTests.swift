//
//  EqualsOperationTests.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//

import Testing
@testable import FormulaSolver

@Suite("EqualsOperation Tests")
class EqualsOperationTests {
    let operation: Operation = EqualsOperation()
    
    @Suite("Solve")
    final class Solve: EqualsOperationTests {
        @Test("Should return true for equal Int numbers")
        func equalIntNumbers() async throws {
            let arguments: [Value] = [.number(2), .number(2)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(true))
        }
        
        @Test("Should return true for equal Float Numbers")
        func equalFloatNumbers() async throws {
            let arguments: [Value] = [.number(2.4), .number(2.4)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(true))
        }
        
        @Test("Should return true for equal Float and Int numbers")
        func equalFloatAndIntNumbers() async throws {
            let arguments: [Value] = [.number(2.0), .number(2)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(true))
        }
        
        @Test("Should return false for different Int Numbers")
        func differentIntNumbers() async throws {
            let arguments: [Value] = [.number(1), .number(2)]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(false))
        }
        
        @Test("Should return true for equal Strings")
        func equalStrings() async throws {
            let arguments: [Value] = [.string("hello"), .string("hello")]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(true))
        }
        
        @Test("Should return false for different Strings")
        func differentStrings() async throws {
            let arguments: [Value] = [.string("hello"), .string("world")]
            
            let result = try operation.solve(arguments: arguments)
            
            #expect(result == .boolean(false))
        }
        
        @Test("Should throw invalid argument count if more than two arguments are given")
        func shouldThrowInvalidArgumentCountIfMoreThanTwoArgumentsAreGiven() async throws {
            let arguments: [Value] = [.string("hello"), .string("world"), .string("!")]
            
            #expect(throws: OperationError.invalidNumberOfArguments(expected: 2, received: 3), performing: {
                let _ = try self.operation.solve(arguments: arguments)
            })
        }
        
        @Test("Should throw invalid argument count if less than two arguments are given")
        func shouldThrowInvalidArgumentCountIfLessThanTwoArgumentsAreGiven() async throws {
            
            let arguments: [Value] = [.string("hello")]
            
            #expect(throws: OperationError.invalidNumberOfArguments(expected: 2, received: 1), performing: {
                let _ = try self.operation.solve(arguments: arguments)
            })
            
        }
    }
    
    @Suite("Evaluate")
    final class Evaluate: EqualsOperationTests {
        
        @Test("Should return invalid argument number if more than two arguments are given")
        func shouldReturnInvalidArgumentNumberIfMoreThanTwoArgumentsAreGiven() async throws {
            let arguments: [Value] = [.string("hello"), .string("world"), .string("!")]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == .invalidNumberOfArguments(expected: 2, received: 3))
        }
        
        @Test("Should return invalid argument number if less than two arguments are given")
        func shouldReturnInvalidArgumentNumberIfLessThanTwoArgumentsAreGiven() async throws {
            let arguments: [Value] = [.string("hello")]
            
            let errors = operation.evaluate(arguments: arguments)
            
            #expect(errors.count == 1)
            #expect(errors.first == .invalidNumberOfArguments(expected: 2, received: 1))
        }
    }
}
