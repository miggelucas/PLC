//
//  FormulaParserError.swift
//  PLC
//
//  Created by Lucas Barros on 27/09/25.
//


enum FormulaParserError: Error {
    case invalidFormat
    case unknownOperation
    case missingParameters
    case unbalancedParentheses
    case unknownReference(String)
}
