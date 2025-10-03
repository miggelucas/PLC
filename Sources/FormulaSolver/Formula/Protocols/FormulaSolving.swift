//
//  FormulaSolving.swift
//  PLC
//
//  Created by Lucas Migge on 03/10/25.
//


public protocol FormulaSolving {
    func solveFormula(_ formula: String, context: [String: String]) throws -> String
    func isFormulaValid(_ formula: String) throws -> Bool
}