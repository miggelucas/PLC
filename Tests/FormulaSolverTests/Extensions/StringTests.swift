//
//  StringTests.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

import Testing
import FormulaSolver

@Suite("String Extensions Tests")
struct StringExtensionTests {
    @Test("init from bool true should return TRUE")
    func initFromBoolTrue() {
        #expect("TRUE" == String(true))
    }
    
    @Test("init from bool false should return False")
    func initFromBoolFalse() {
        #expect("FALSE" == String(false))
    }
    
    @Test("toBool from string TRUE should return true")
    func toBoolFromStringTRUE() {
        #expect("TRUE".toBool() == true)
    }
    
    @Test("toBool from string FALSE should return false")
    func toBoolFromStringFALSE() {
        #expect("FALSE".toBool() == false)
    }
    
    @Test("toBool from string invalid should return nil")
    func toBoolFromStringInvalid() {
        #expect("Invalid".toBool() == nil)
    }
}
