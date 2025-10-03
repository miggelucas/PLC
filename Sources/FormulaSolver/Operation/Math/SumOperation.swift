//
//  SumOperation.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//

/// Operação de soma que adiciona valores numéricos.
///
/// `SumOperation` implementa a operação `SUM` que soma todos os argumentos numéricos fornecidos.
///
/// ## Sintaxe
///
/// ```
/// SUM(número1; número2; ...)
/// ```
///
/// ## Requisitos
///
/// - Pelo menos 2 argumentos
/// - Todos os argumentos devem ser números
///
/// ## Exemplos
///
/// ```swift
/// // Soma simples
/// SUM(1; 2; 3) → 6.0
///
/// // Soma com decimais
/// SUM(1.5; 2.5; 3.0) → 7.0
///
/// // Múltiplos argumentos
/// SUM(10; 20; 30; 40) → 100.0
/// ```
///
/// ## Tópicos
///
/// ### Implementação
/// - ``execute(arguments:)``
/// - ``evaluate(arguments:)``
struct SumOperation: Operation {
    func execute(arguments: [Value]) -> Value {
        let result = arguments.reduce(0.0) { accumulator, nextValue in
            guard case .number(let double) = nextValue else { return accumulator }
            return accumulator + double
        }
        return .number(result)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        if arguments.count >= 2 { } else {
            errors.append(.invalidNumberOfArguments(expected: 2, received: arguments.count))
        }
        
        arguments.forEach { value in
            if case .number = value {} else  {
                errors.append(.invalidArgumentType(expected: Value.SelfType.number, received: value.selfType))
            }
        }
        
        return errors
    }
}
