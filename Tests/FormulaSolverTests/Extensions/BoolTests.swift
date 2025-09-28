//
//  BoolTests.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

import Testing
import FormulaSolver

@Suite("Bool Extension Tests")
struct BoolTests {
    @Test("Init from string TRUE should return expected Bool")
    func initFromStringTrueShouldBeTrue() {
        let bool = Bool("TRUE")
        #expect(bool == true)
    }
    
    @Test("Init from string FALSE should return expected Bool")
    func initFromStringFaselShouldBeFalse() {
        let bool = Bool("FALSE")
        #expect(bool == false)
    }
    
    @Test("Init from invalid string should return nil")
    func initFromInvalidStringShouldReturnNil() {
        let bool = Bool("False")
        #expect(bool == nil)
    }
    
    @Test("toString from true should return TRUE")
    func toStringFromTrueShouldReturnTRUE() {
        let bool = true.toString()
        #expect(bool == "TRUE")
    }
    
    @Test("toString from false should return FALSE")
    func toStringFromFalseShouldReturnFalse() {
        let bool = false.toString()
        #expect(bool == "FALSE")
    }
}
