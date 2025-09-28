//
//  FormulaSolver.swift
//  PLC
//
//  Created by Lucas Barros on 24/09/25.
//


public protocol FormulaSolverProtocol {
    func solve(_ formula: String) throws -> String
}

public struct FormulaSolver: FormulaSolverProtocol {
    
    public init() {}
    
    public func solve(_ formula: String) throws -> String {
        return "Hello, World!"
    }
    
    private func parseFormula(_ formula: String) -> Formula? {
        return nil
    }
}


