//
//  FormulaParsing.swift
//  PLC
//
//  Created by Lucas Migge on 03/10/25.
//


protocol FormulaParsing {
    func parseFormula(_ formula: String) throws -> Formula
    
}