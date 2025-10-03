//
//  FormulaSolverTests.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

import Testing
@testable import FormulaSolver

@Suite("Formula Solver Tests")
struct FormulaSolverTests {
    let solver = FormulaSolver()
    
    @Test("Should solve simple formulas")
    func solveSimpleFormulas() async throws {
        let expression = "AND(TRUE; TRUE)"
        
        let result = try solver.solveFormula(expression)
        
        #expect(result == "TRUE")
    }
    
    @Test("Should solve more complex formulas with nested formulas")
    func solveMoreComplexFormulas() async throws {
        let expression = "AND(FALSE; OR(FALSE; TRUE))"
        
        let result = try solver.solveFormula(expression)
        
        #expect(result == "FALSE")
    }
    
    @Test("Should solve simple formulas with context")
    func solveSimpleFormulasWithContext() async throws {
        let context = ["foo": "TRUE"]
        
        let expression = "AND(foo; foo)"
        
        let result = try solver.solveFormula(expression, context: context)
        
        #expect(result == "TRUE")
    }
    
    @Test("should solve simple aritimet formula")
    func solveSimpleAritimetFormula() async throws {
        let expression = "SUM(1; 4)"
        
        let result = try solver.solveFormula(expression)
        
        #expect(result == "5.0")
    }
    
    @Test("Should solve complex formulas with context")
    func solveComplexFormulasWithContext() async throws {
        let context: [String: String] = [
            "isMale": "TRUE",
            "hasCar": "FALSE",
            "age": "25",
            "A1": "25",
            "B3": "TRUE"
        ]
        
        let expression = "AND(OR(B3; hasCar); EQ(A1; 25))"
        
        let result = try solver.solveFormula(expression, context: context)
        
        #expect(result == "TRUE")
    }
}
