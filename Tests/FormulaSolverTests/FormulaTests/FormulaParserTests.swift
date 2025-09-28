//
//  FormulaParserTests.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

import Testing
@testable import FormulaSolver

@Suite("Formula Parser Tests")
struct FormulaParserTests {
    let parser = FormulaParser()
    
    @Test("Should parse simple valid expression to Formula")
    func shouldParseSimpleValidExpressionToFormula() async throws {
        let expression = "NOT(TRUE)"
        #expect(throws: Never.self, performing: {
            _ = try parser.parseFormula(expression)
        })
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
        let expression = "EQ(Hello; World)"
        
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
    
    @Test("Should fail to parse invalid expression to Formula")
    func shouldFailToParseInvalidExpressionToFormula() async throws {
        let expression = "AND(TRUE; FALSE"
        #expect(throws: FormulaParserError.self, performing: {
            _ = try parser.parseFormula(expression)
        })
    }
}
