//
//  OrOperation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

/// Operação lógica OR (OU).
///
/// `OrOperation` implementa a operação `OR` que retorna `TRUE` se pelo menos
/// um dos argumentos for `TRUE`.
///
/// ## Sintaxe
///
/// ```
/// OR(booleano1; booleano2; ...)
/// ```
///
/// ## Requisitos
///
/// - Pelo menos 2 argumentos
/// - Todos os argumentos devem ser booleanos
///
/// ## Tabela Verdade
///
/// | Entrada 1 | Entrada 2 | Resultado |
/// |-----------|-----------|-----------|
/// | TRUE      | TRUE      | TRUE      |
/// | TRUE      | FALSE     | TRUE      |
/// | FALSE     | TRUE      | TRUE      |
/// | FALSE     | FALSE     | FALSE     |
///
/// ## Exemplos
///
/// ```swift
/// // Pelo menos um verdadeiro
/// OR(TRUE; FALSE) → TRUE
///
/// // Todos falsos
/// OR(FALSE; FALSE) → FALSE
///
/// // Múltiplos argumentos
/// OR(FALSE; FALSE; TRUE) → TRUE
///
/// // Com comparações
/// OR(EQ(5; 10); EQ(10; 10)) → TRUE
/// ```
///
/// ## Tópicos
///
/// ### Implementação
/// - ``execute(arguments:)``
/// - ``evaluate(arguments:)``
struct OrOperation: Operation {
    func execute(arguments: [Value]) -> Value {        
        let result = arguments.reduce(false) { (accumulator, nextArgument) -> Bool in
            guard case .boolean(let nextValue) = nextArgument else { return accumulator }
            return accumulator || nextValue
        }
        
        return .boolean(result)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        
        if arguments.count < 2 {
            errors.append(.invalidNumberOfArguments(expected: 2, received: arguments.count))
        }
        
        arguments.forEach {
            if case .boolean = $0 {
            } else {
                errors.append(.invalidArgumentType(expected: Value.SelfType.boolean, received: $0.selfType))
            }
        }
        return errors
    }

}
