//
//  AndOperation.swift
//  PLC
//
//  Created by Lucas Migge on 30/09/25.
//

/// Operação lógica AND (E).
///
/// `AndOperation` implementa a operação `AND` que retorna `TRUE` somente se
/// todos os argumentos forem `TRUE`.
///
/// ## Sintaxe
///
/// ```
/// AND(booleano1; booleano2; ...)
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
/// | TRUE      | FALSE     | FALSE     |
/// | FALSE     | TRUE      | FALSE     |
/// | FALSE     | FALSE     | FALSE     |
///
/// ## Exemplos
///
/// ```swift
/// // Dois argumentos verdadeiros
/// AND(TRUE; TRUE) → TRUE
///
/// // Um argumento falso
/// AND(TRUE; FALSE) → FALSE
///
/// // Múltiplos argumentos
/// AND(TRUE; TRUE; TRUE) → TRUE
///
/// // Com comparações
/// AND(EQ(5; 5); EQ(10; 10)) → TRUE
/// ```
///
/// ## Tópicos
///
/// ### Implementação
/// - ``execute(arguments:)``
/// - ``evaluate(arguments:)``
struct AndOperation: Operation {
    func execute(arguments: [Value]) -> Value {
        let result = arguments.reduce(true) { (accumulator, nextArgument) -> Bool in
            guard case .boolean(let nextValue) = nextArgument else { return accumulator }
            return accumulator && nextValue
        }
        
        return .boolean(result)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        
        if arguments.count < 2 {
            errors.append(.invalidNumberOfArguments(expected: 2, received:  arguments.count))
            return errors
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
