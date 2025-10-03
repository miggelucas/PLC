//
//  Validate.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

import ArgumentParser
import FormulaSolver

/// Comando para validar a sintaxe de fórmulas.
///
/// O comando `validate` verifica se uma fórmula possui sintaxe válida
/// sem executá-la.
///
/// ## Sintaxe
///
/// ```bash
/// FST validate "FORMULA"
/// ```
///
/// ## Exemplos
///
/// ```bash
/// # Fórmula válida
/// FST validate "AND(TRUE; FALSE)"
/// # ✅ A fórmula é válida.
///
/// # Verificar sintaxe complexa
/// FST validate "IF(EQ(x; y); SUM(a; b); 0)"
/// # ✅ A fórmula é válida.
/// ```
///
/// ## Notas
///
/// Este comando apenas valida a estrutura da fórmula, não verifica se
/// as variáveis referenciadas existem ou se os tipos estão corretos.
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
