// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import FormulaSolver

/// Ferramenta de linha de comando para resolver fórmulas.
///
/// `FormulaSolverTool` (FST) é uma aplicação CLI que permite resolver e validar
/// fórmulas diretamente do terminal.
///
/// ## Visão Geral
///
/// A ferramenta oferece dois comandos principais:
/// - `solve`: Resolve uma fórmula e retorna o resultado
/// - `validate`: Verifica se uma fórmula tem sintaxe válida
///
/// ## Uso
///
/// ```bash
/// # Resolver uma fórmula
/// FST solve "SUM(1; 2; 3)"
///
/// # Validar uma fórmula
/// FST validate "AND(TRUE; FALSE)"
/// ```
///
/// ## Ajuda
///
/// ```bash
/// FST --help
/// FST solve --help
/// FST validate --help
/// ```
@main
struct FormulaSolverTool: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Um resolvedor de fórmulas para a linha de comando.",
        
        subcommands: [Solve.self, Validate.self],
        
        defaultSubcommand: Solve.self
    )
}


