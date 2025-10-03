//
//  Formula.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

/// Representa uma fórmula com uma operação e seus argumentos.
///
/// `Formula` é a estrutura de dados fundamental que representa uma expressão
/// após ser analisada pelo parser. Contém a operação a ser executada e seus argumentos.
///
/// ## Visão Geral
///
/// Uma fórmula é composta por:
/// - **Operação**: Nome da operação a ser executada (ex: "SUM", "AND", "IF")
/// - **Argumentos**: Lista de valores que serão processados pela operação
///
/// ## Exemplo
///
/// Para a string `"SUM(1; 2; 3)"`, a estrutura `Formula` seria:
/// ```swift
/// Formula(
///     operation: "SUM",
///     arguments: [.number(1), .number(2), .number(3)]
/// )
/// ```
///
/// ## Tópicos
///
/// ### Propriedades
/// - ``operation``
/// - ``arguments``
struct Formula {
    /// O nome da operação a ser executada.
    ///
    /// Exemplos: "SUM", "AND", "OR", "IF", "EQ", "NOT"
    let operation: String
    
    /// Os argumentos da operação.
    ///
    /// Cada argumento pode ser um valor literal, uma referência ou outra fórmula aninhada.
    let arguments: [Value]
    
}

extension Formula: Equatable {
    static func == (lhs: Formula, rhs: Formula) -> Bool {
        return lhs.operation == rhs.operation &&
        lhs.arguments == rhs.arguments
    }
}
