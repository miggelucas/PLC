//
//  IfOperation.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//

/// Operação condicional que retorna um valor baseado em uma condição.
///
/// `IfOperation` implementa a operação `IF` que avalia uma condição booleana
/// e retorna um de dois valores possíveis.
///
/// ## Sintaxe
///
/// ```
/// IF(condição; valorSeVerdadeiro; valorSeFalso)
/// ```
///
/// ## Requisitos
///
/// - Exatamente 3 argumentos
/// - Primeiro argumento deve ser booleano
/// - Segundo e terceiro argumentos podem ser de qualquer tipo
///
/// ## Exemplos
///
/// ```swift
/// // Condicional simples
/// IF(TRUE; 10; 20) → 10
///
/// // Com comparação
/// IF(EQ(5; 5); "igual"; "diferente") → "igual"
///
/// // Com operações aninhadas
/// IF(AND(TRUE; TRUE); SUM(1; 2); 0) → 3.0
/// ```
///
/// ## Tópicos
///
/// ### Implementação
/// - ``execute(arguments:)``
/// - ``evaluate(arguments:)``
struct IfOperation: Operation {
    func execute(arguments: [Value]) -> Value {
        let condition = arguments[0]
        let valueIfTrue = arguments[1]
        let valueIfFalse = arguments[2]
        
        var isTrue: Bool {
            if case .boolean(let bool) = condition {
                return bool
            } else {
                return false
            }
        }
        
        return isTrue ? valueIfTrue : valueIfFalse
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors = [OperationError]()
        if arguments.count == 3 {} else {
            errors.append(OperationError.invalidNumberOfArguments(expected: 3, received: arguments.count))
        }
        
        
        let firstArgument = arguments.first
        switch firstArgument {
        case .boolean, .nestedFormula:
            break
        default:
            errors.append(.invalidArgumentType(expected: Value.SelfType.boolean, received: firstArgument?.selfType ?? .unknown))
        }
        
        return errors
    }
}
