// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import FormulaSolver


@main
struct FormulaSolverTool: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Um resolvedor de fórmulas para a linha de comando.",
        
        subcommands: [Solve.self, Validate.self],
        
        defaultSubcommand: Solve.self
    )
}


