//
//  Operation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

/// Protocolo que define uma operação executável em fórmulas.
///
/// Todas as operações (lógicas, matemáticas, etc.) devem conformar a este protocolo.
/// Ele define um contrato para validação e execução de operações.
///
/// ## Visão Geral
///
/// Uma operação passa por três estágios:
/// 1. **Validação**: Verifica se os argumentos são válidos
/// 2. **Execução**: Realiza a operação propriamente dita
/// 3. **Solução**: Combina validação e execução
///
/// ## Implementação Padrão
///
/// O protocolo fornece implementações padrão para `validate(arguments:)` e
/// `solve(arguments:)`, então implementadores precisam apenas fornecer:
/// - `execute(arguments:)` - A lógica da operação
/// - `evaluate(arguments:)` - As regras de validação
///
/// ## Exemplo de Implementação
///
/// ```swift
/// struct MinhaOperacao: Operation {
///     func execute(arguments: [Value]) -> Value {
///         // Implementar lógica da operação
///         return .number(42)
///     }
///
///     func evaluate(arguments: [Value]) -> [OperationError] {
///         // Validar argumentos
///         if arguments.count != 2 {
///             return [.invalidNumberOfArguments(expected: 2, received: arguments.count)]
///         }
///         return []
///     }
/// }
/// ```
///
/// ## Tópicos
///
/// ### Métodos Requeridos
/// - ``execute(arguments:)``
/// - ``evaluate(arguments:)``
///
/// ### Métodos com Implementação Padrão
/// - ``solve(arguments:)``
/// - ``validate(arguments:)``
protocol Operation {
    /// Executa a operação com os argumentos fornecidos.
    ///
    /// Este método deve implementar a lógica principal da operação.
    /// Assume que os argumentos já foram validados.
    ///
    /// - Parameter arguments: Lista de valores a serem processados.
    /// - Returns: O resultado da operação.
    func execute(arguments: [Value]) -> Value
   
    /// Avalia se os argumentos são válidos para esta operação.
    ///
    /// Retorna uma lista de erros encontrados. Lista vazia indica sucesso.
    ///
    /// - Parameter arguments: Lista de valores a serem validados.
    /// - Returns: Array de erros encontrados (vazio se válido).
    func evaluate(arguments: [Value]) -> [OperationError]
    
    /// Valida os argumentos e lança exceção se inválidos.
    ///
    /// - Parameter arguments: Lista de valores a serem validados.
    /// - Throws: O primeiro erro encontrado na validação.
    func validate(arguments: [Value]) throws
    
    /// Valida e executa a operação.
    ///
    /// - Parameter arguments: Lista de valores a serem processados.
    /// - Returns: O resultado da operação.
    /// - Throws: Erros de validação se os argumentos forem inválidos.
    func solve(arguments: [Value]) throws -> Value
}

extension Operation {
    func validate(arguments: [Value]) throws {
        let errors =  evaluate(arguments: arguments)
        if let error = errors.first {
            throw error
        }
    }
    
    func solve(arguments: [Value]) throws -> Value {
        try validate(arguments: arguments)
        return execute(arguments: arguments)
    }
}
