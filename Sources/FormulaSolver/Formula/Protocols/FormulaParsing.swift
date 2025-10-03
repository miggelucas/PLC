//
//  FormulaParsing.swift
//  PLC
//
//  Created by Lucas Migge on 03/10/25.
//

/// Protocolo que define a interface para parsing de fórmulas.
///
/// Implementações deste protocolo convertem strings representando fórmulas
/// em estruturas de dados `Formula` que podem ser processadas.
///
/// ## Visão Geral
///
/// O parser é responsável por:
/// - Analisar a sintaxe da fórmula
/// - Identificar a operação principal
/// - Extrair e processar os argumentos
/// - Detectar fórmulas aninhadas
///
/// ## Tópicos
///
/// ### Métodos Requeridos
/// - ``parseFormula(_:)``
protocol FormulaParsing {
    /// Analisa uma string e a converte em uma estrutura `Formula`.
    ///
    /// - Parameter formula: A fórmula em formato de string.
    /// - Returns: Uma estrutura `Formula` representando a expressão.
    /// - Throws: `FormulaParserError` se a sintaxe for inválida.
    func parseFormula(_ formula: String) throws -> Formula
    
}