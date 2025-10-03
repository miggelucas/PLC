//
//  EqualsOperation.swift
//  PLC
//
//  Created by Lucas Migge on 02/10/25.
//

/// Operação de igualdade que compara dois valores.
///
/// `EqualsOperation` implementa a operação `EQ` que verifica se dois valores são iguais.
///
/// ## Sintaxe
///
/// ```
/// EQ(valor1; valor2)
/// ```
///
/// ## Requisitos
///
/// - Exatamente 2 argumentos
/// - Argumentos devem ser números ou strings
/// - Permite comparação entre número e string
///
/// ## Comportamento
///
/// - Números são comparados numericamente
/// - Strings são comparadas como texto
/// - Número pode ser comparado com string (conversão automática)
///
/// ## Exemplos
///
/// ```swift
/// // Comparação de números
/// EQ(5; 5) → TRUE
/// EQ(5; 10) → FALSE
///
/// // Comparação de strings
/// EQ("hello"; "hello") → TRUE
/// EQ("hello"; "world") → FALSE
///
/// // Comparação mista (número e string)
/// EQ(5; "5") → TRUE
///
/// // Com referências
/// // contexto: ["idade": "25"]
/// EQ(idade; 25) → TRUE
/// ```
///
/// ## Tópicos
///
/// ### Implementação
/// - ``execute(arguments:)``
/// - ``evaluate(arguments:)``
struct EqualsOperation: Operation {
    func execute(arguments: [Value]) -> Value {
        let isEqual = arguments[0] == arguments[1]
        return .boolean(isEqual)
    }
    
    func evaluate(arguments: [Value]) -> [OperationError] {
        var errors: [OperationError] = []
        if arguments.count == 2 {} else {
            errors.append(.invalidNumberOfArguments(expected: 2, received: arguments.count))
        }
        
        arguments.forEach { value in
            switch value {
            case .number, .string:
                break
            default:
                errors.append(.invalidArgumentType(expected: Value.SelfType.string, received: value.selfType))
            }
        }
        
        return errors
    }
}
