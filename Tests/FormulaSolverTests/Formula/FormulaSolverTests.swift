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
        
        let result = try solver.solve(expression)
        
        #expect(result == "TRUE")
    }
    
    @Test("Should solve more complex formulas with nested formulas")
    func solveMoreComplexFormulas() async throws {
        let expression = "AND(FALSE; OR(FALSE; TRUE))"
        
        let result = try solver.solve(expression)
        
        #expect(result == "FALSE")
    }
}
