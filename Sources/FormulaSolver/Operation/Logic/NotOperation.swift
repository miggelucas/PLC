//
//  NotOperation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

/// Operação lógica NOT (NÃO).
///
/// `NotOperation` implementa a operação `NOT` que inverte o valor booleano.
///
/// ## Sintaxe
///
/// ```
/// NOT(booleano)
/// ```
///
/// ## Requisitos
///
/// - Exatamente 1 argumento
/// - O argumento deve ser booleano
///
/// ## Tabela Verdade
///
/// | Entrada | Resultado |
/// |---------|-----------|
/// | TRUE    | FALSE     |
/// | FALSE   | TRUE      |
///
/// ## Exemplos
///
/// ```swift
/// // Inverter TRUE
/// NOT(TRUE) → FALSE
///
/// // Inverter FALSE
/// NOT(FALSE) → TRUE
///
/// // Com comparações
/// NOT(EQ(5; 10)) → TRUE
///
/// // Com outras operações
/// NOT(AND(TRUE; FALSE)) → TRUE
/// ```
///
/// ## Tópicos
///
/// ### Implementação
/// - ``execute(arguments:)``
/// - ``evaluate(arguments:)``
struct NotOperation: Operation {
    func execute(arguments: [Value]) -> Value {
        let argument = arguments[0]
        
        var boolean: Bool {
            if case .boolean(let bool) = argument {
                return bool
            } else {
                return true
            }
        }
        
        return .boolean(!boolean)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        if arguments.count > 1 {
            errors.append(
                .invalidNumberOfArguments(expected: 1,
                                          received: arguments.count)
            )
        }
        
        if case .boolean = arguments[0] {} else {
            errors.append(
                .invalidArgumentType(expected: Value.SelfType.boolean,
                                     received: arguments[0].selfType)
            )
        }
        
        return errors
    }
}
