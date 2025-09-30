//
//  Validate.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

import ArgumentParser
import FormulaSolver


struct Validate: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "validate",
        abstract: "Verifica se a sintaxe de uma fórmula é válida, sem calcular o resultado."
    )
    
    @Argument(help: "A fórmula a ser validada, entre aspas duplas.")
    var formulaString: String
    
    mutating func run() throws {
        print("🔎 Validando a fórmula: \(formulaString)")
        
        let solver = FormulaSolver()
        
        if try solver.isFormulaValid(formulaString) {
            print("✅ A fórmula é válida.")
        } else {
            print("❌ A fórmula é inválida.")
            throw ExitCode.failure
        }
    }
}
