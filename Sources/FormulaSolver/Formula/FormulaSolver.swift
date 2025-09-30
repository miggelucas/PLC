//
//  FormulaSolver.swift
//  PLC
//
//  Created by Lucas Barros on 24/09/25.
//


public protocol FormulaSolverProtocol {
    func solve(_ formula: String) throws -> String
    func isFormulaValid(_ formula: String) throws -> Bool
}

public struct FormulaSolver: FormulaSolverProtocol {
    
    let parser: FormulaParserProtocol
    
    init(parser: FormulaParserProtocol = FormulaParser()) {
        self.parser = parser
    }
    
    public init() {
        self.parser = FormulaParser()
    }
    
    public func solve(_ formula: String) throws -> String {
        let parsedFormula = try parser.parseFormula(formula)
        
        let result = try solve(parsedFormula)
        return result.description
    }
    
    func solve(_ formula: Formula) throws -> Value {
        let operation = try OperationFactory.makeOperation(from: formula.operation)
        
        let solvedArguments = try formula.arguments.map { value in
            if case .nestedFormula(let nestedFormula) = value {
                return try solve(nestedFormula)
            }
            return value
        }
        
        return try operation.solve(arguments: solvedArguments)
    }
    
    public func isFormulaValid(_ formula: String) throws -> Bool {
        return true
    }
    
    private func parseFormula(_ formula: String) -> Formula? {
        return nil
    }
}


