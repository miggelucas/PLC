//
//  FormulaParserError.swift
//  PLC
//
//  Created by Lucas Barros on 27/09/25.
//

/// Erros que podem ocorrer durante o parsing de fórmulas.
///
/// Estes erros indicam problemas na sintaxe ou estrutura da fórmula
/// fornecida como string.
///
/// ## Casos
///
/// - ``invalidFormat``: A fórmula não segue o formato esperado
/// - ``unknownOperation``: A operação especificada não é reconhecida
/// - ``missingParameters``: A fórmula não possui os parâmetros necessários
/// - ``unbalancedParentheses``: Parênteses não estão balanceados
/// - ``unknownReference(_:)``: Referência a uma variável não encontrada no contexto
enum FormulaParserError: Error {
    /// Formato da fórmula é inválido.
    ///
    /// Ocorre quando a string não pode ser interpretada como uma fórmula válida.
    case invalidFormat
    
    /// Operação desconhecida.
    ///
    /// A operação especificada não está registrada no sistema.
    case unknownOperation
    
    /// Parâmetros ausentes.
    ///
    /// A fórmula não possui os argumentos necessários.
    case missingParameters
    
    /// Parênteses desbalanceados.
    ///
    /// O número de parênteses de abertura não corresponde ao de fechamento.
    case unbalancedParentheses
    
    /// Referência desconhecida.
    ///
    /// Uma variável referenciada não foi encontrada no contexto fornecido.
    ///
    /// - Parameter String: O nome da variável não encontrada.
    case unknownReference(String)
}
