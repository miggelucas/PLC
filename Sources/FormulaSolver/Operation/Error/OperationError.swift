//
//  OperationError.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

/// Erros que podem ocorrer durante a execução de operações.
///
/// Estes erros indicam problemas na validação ou execução de operações,
/// como tipos incompatíveis ou número incorreto de argumentos.
///
/// ## Casos
///
/// - ``invalidArgumentType(expected:received:)``: Tipo de argumento incorreto
/// - ``invalidNumberOfArguments(expected:received:)``: Número incorreto de argumentos
/// - ``unknownOperation``: Operação não reconhecida
enum OperationError: Error {
    /// Tipo de argumento inválido.
    ///
    /// O tipo do argumento fornecido não corresponde ao esperado pela operação.
    ///
    /// - Parameters:
    ///   - expected: O tipo esperado pela operação.
    ///   - received: O tipo que foi recebido.
    case invalidArgumentType(expected: Value.SelfType, received: Value.SelfType)
    
    /// Número de argumentos inválido.
    ///
    /// A quantidade de argumentos fornecida não corresponde ao esperado.
    ///
    /// - Parameters:
    ///   - expected: O número de argumentos esperado.
    ///   - received: O número de argumentos recebido.
    case invalidNumberOfArguments(expected: Int, received: Int)
    
    /// Operação desconhecida.
    ///
    /// A operação solicitada não está registrada no sistema.
    case unknownOperation
}

extension OperationError: Equatable {}
