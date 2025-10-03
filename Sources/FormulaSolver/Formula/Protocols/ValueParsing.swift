//
//  ValueParsing.swift
//  PLC
//
//  Created by Lucas Migge on 03/10/25.
//


protocol ValueParsing {
    func parserValue(_ string: String) throws -> Value
}
