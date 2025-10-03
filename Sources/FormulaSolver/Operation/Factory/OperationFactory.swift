//
//  OperationFactory.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

/// Factory para criar instâncias de operações.
///
/// `OperationFactory` é responsável por criar operações a partir de seus nomes.
/// É usado internamente pelo sistema para resolver fórmulas.
///
/// ## Visão Geral
///
/// O factory converte strings de nomes de operações (case-insensitive)
/// em instâncias de operações concretas.
///
/// ## Operações Suportadas
///
/// - **Lógicas**: AND, OR, NOT, IF, EQ
/// - **Matemáticas**: SUM
///
/// ## Exemplo Interno
///
/// ```swift
/// let operation = try OperationFactory.makeOperation(from: "SUM")
/// // Retorna uma instância de SumOperation
/// ```
enum OperationFactory {
    /// Cria uma operação a partir de seu nome.
    ///
    /// - Parameter name: O nome da operação (case-insensitive).
    /// - Returns: Uma instância da operação correspondente.
    /// - Throws: `OperationError.unknownOperation` se a operação não for reconhecida.
    static func makeOperation(from name: String) throws -> Operation {
        guard let operationType = OperationTypes(rawValue: name.uppercased()) else {
            throw OperationError.unknownOperation
        }
        
        return operationType.operation
    }
}
