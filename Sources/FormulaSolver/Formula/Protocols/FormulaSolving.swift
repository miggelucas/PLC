//
//  FormulaSolving.swift
//  PLC
//
//  Created by Lucas Migge on 03/10/25.
//

/// Protocolo que define a interface para resolução de fórmulas.
///
/// Este protocolo estabelece os métodos necessários para um resolvedor de fórmulas,
/// incluindo a capacidade de resolver expressões e validar sua sintaxe.
///
/// ## Visão Geral
///
/// Implementações deste protocolo devem ser capazes de:
/// - Interpretar fórmulas em formato de string
/// - Resolver as operações contidas nas fórmulas
/// - Validar a sintaxe das fórmulas
/// - Trabalhar com contextos de variáveis
///
/// ## Tópicos
///
/// ### Métodos Requeridos
/// - ``solveFormula(_:context:)``
/// - ``isFormulaValid(_:)``
public protocol FormulaSolving {
    /// Resolve uma fórmula e retorna o resultado.
    ///
    /// - Parameters:
    ///   - formula: A fórmula a ser resolvida.
    ///   - context: Dicionário com variáveis e seus valores.
    /// - Returns: O resultado da fórmula como string.
    /// - Throws: Erros de parsing ou execução.
    func solveFormula(_ formula: String, context: [String: String]) throws -> String
    
    /// Verifica se uma fórmula é válida sintaticamente.
    ///
    /// - Parameter formula: A fórmula a ser validada.
    /// - Returns: `true` se a fórmula for válida.
    /// - Throws: Erros de validação.
    func isFormulaValid(_ formula: String) throws -> Bool
}