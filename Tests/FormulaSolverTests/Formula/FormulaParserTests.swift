//
//  FormulaParserTests.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

import Testing
@testable import FormulaSolver

@Suite("Formula Parser Tests")
class FormulaParserTests {
    let parser = FormulaParser()
    
    @Suite("Parsing Expressions Tests")
    final class ParsingExpressionTests: FormulaParserTests {
        @Test("Should parse simple valid expression to Formula")
        func shouldParseSimpleValidExpressionToFormula() async throws {
            let expression = "NOT(TRUE)"
               
            let _ = try self.parser.parseFormula(expression)
        }
        
        @Test("Should parse valid expression with more than one argument to Formula")
        func shouldParseValidExpressionWithMoreThanOneArgumentToFormula() async throws {
            let expression = "AND(TRUE; FALSE)"
            let formula = try parser.parseFormula(expression)
            
            #expect(!formula.operation.isEmpty)
            #expect(formula.arguments.count == 2)
        }
        
        @Test("Should parse valid expression with two or more arguments to Formula")
        func shouldParseValidExpressionWithTwoOrMoreArgumentsToFormula() async throws {
            let expression = "SUM(2; 3; 4)"
            
            let formula = try parser.parseFormula(expression)
            
            #expect(!formula.operation.isEmpty)
            #expect(formula.arguments.count == 3)
        }
        
        @Test("Should parse valid expression with string arguments")
        func shouldParseValidExpressionWithStringArguments() async throws {
            let expression = "EQ(\"Hello\"; \"World\")"
            
            let formula = try parser.parseFormula(expression)
            
            #expect(!formula.operation.isEmpty)
            #expect(formula.arguments.count == 2)
            #expect(formula.arguments[0] == .string("Hello"))
            #expect(formula.arguments[1] == .string("World"))
        }
        
        @Test("Should parse valid expression with literal string arguments")
        func shouldParseValidExpressionWithLiteralStringArguments() async throws {
            let expression = "EQ(\";(3+4\"; \"3+4;)\")"
            let formula = try parser.parseFormula(expression)
            
            #expect(!formula.operation.isEmpty)
            #expect(formula.arguments.count == 2)
            #expect(formula.arguments[0] == .string(";(3+4"))
            #expect(formula.arguments[1] == .string("3+4;)"))
        }
        
        @Test("Should parse valid expression to expected Formula")
        func shouldParseEmptyExpressionToFormula() async throws {
            let expression = "AND(TRUE; FALSE)"
            
            let formula = try parser.parseFormula(expression)
            
            #expect(!formula.operation.isEmpty)
            #expect(formula.arguments.count == 2)
        }
        
        @Test("Should parse valid expression with nested functions to Formula")
        func shouldParseValidExpressionWithNestedFunctionsToFormula() async throws {
            let expression = "AND(AND(TRUE; FALSE); NOT(FALSE))"
            
            let formula = try parser.parseFormula(expression)
            
            #expect(!formula.operation.isEmpty)
            #expect(formula.arguments.count == 2)
        }
        
        @Test("Should parse valid expression with reference on arguments")
        func shouldParseValidExpressionWithReferenceOnArguments() async throws {
            let expression = "EQ(A1; B2)"
            
            let formula = try parser.parseFormula(expression)
            
            #expect(!formula.operation.isEmpty)
            #expect(formula.arguments[0] == .reference("A1"))
            #expect(formula.arguments[1] == .reference("B2"))
        }
        
        @Test("Should parse valid expression with nested formulas reference inside")
        func shouldParseValidExpressionWithNestedFormulasReferenceInside() async throws {
            let expression = "AND(TRUE; EQ(A1; B2))"
            
            
            let formula = try parser.parseFormula(expression)
            
            
            let expectedNestedFormula = Formula(operation: "EQ", arguments: [.reference("A1"), .reference("B2")])
            #expect(!formula.operation.isEmpty)
            #expect(formula.arguments.count == 2)
            #expect(formula.arguments[0] == .boolean(true))
            #expect(formula.arguments[1] == .nestedFormula(expectedNestedFormula))
        }
        
        @Test("Should fail to parse invalid expression to Formula")
        func shouldFailToParseInvalidExpressionToFormula() async throws {
            let expression = "AND(TRUE; FALSE"
            #expect(throws: FormulaParserError.self, performing: {
                _ = try self.parser.parseFormula(expression)
            })
        }
        
    }
    
    
    @Suite("Parsing Value Tests")
    final class ParsingValueTests: FormulaParserTests {
        @Test("Parsing a boolean should return a Boolean Value")
        func parsingBoolean() async throws {
            let value = "TRUE"
            
            let result = try parser.parserValue(value)
            
            #expect(result == .boolean(true))
        }
        
        @Test("Parsing a float should return a Number Value")
        func parsingFloatNumber() async throws {
            let value = "123.45"
            
            let result = try parser.parserValue(value)
            
            #expect(result == .number(123.45))
        }
        
        @Test("Parsing a int should return a Number Value")
        func parsingIntNumber() async throws {
            let value = "123"
            
            let result = try parser.parserValue(value)
            
            #expect(result == .number(123))
        }
        
        @Test("Parsing a formula should return a Nested Formula Value")
        func parsingNestedFormula() async throws {
            let value = "SUM(2;3)"
            
            let result = try parser.parserValue(value)
            
            let expectedResult: Value = .nestedFormula(Formula(operation: "SUM", arguments: [.number(2), .number(3)]))
            #expect(result == expectedResult)
        }
        
        @Test("Parsing a reference should return a Reference Value")
        func parsingReference() async throws {
            let value = "A1"
            
            let result = try parser.parserValue(value)
            
            #expect(result == .reference("A1"))
        }
    }
}


