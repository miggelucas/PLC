//
//  Solve.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

import ArgumentParser
import FormulaSolver


struct Solve: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "solve",
        abstract: "Calcula e retorna o resultado de uma fórmula."
    )
    
    @Argument(help: "A fórmula a ser resolvida, entre aspas duplas.")
    var formulaString: String
    
    mutating func run() throws {
        print("🔍 Calculando a fórmula: \(formulaString)")
        
        let solver = FormulaSolver()
        
        do {
            let result = try solver.solveFormula(formulaString)
            print("✅ Resultado: \(result)")
        } catch {
            print("❌ Erro ao calcular: \(error.localizedDescription)")
            throw ExitCode.failure
        }
    }
}
