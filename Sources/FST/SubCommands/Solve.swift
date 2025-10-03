//
//  Solve.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

import ArgumentParser
import FormulaSolver

/// Comando para resolver fórmulas.
///
/// O comando `solve` calcula o resultado de uma fórmula fornecida.
///
/// ## Sintaxe
///
/// ```bash
/// FST solve "FORMULA"
/// ```
///
/// ## Exemplos
///
/// ```bash
/// # Operações matemáticas
/// FST solve "SUM(1; 2; 3)"
/// # ✅ Resultado: 6.0
///
/// # Operações lógicas
/// FST solve "AND(TRUE; TRUE)"
/// # ✅ Resultado: TRUE
///
/// # Fórmulas complexas
/// FST solve "IF(EQ(10; 10); SUM(5; 5); 0)"
/// # ✅ Resultado: 10.0
/// ```
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
