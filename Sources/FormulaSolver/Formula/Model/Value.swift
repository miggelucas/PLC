//
//  Value.swift
//  PLC
//
//  Created by Lucas Barros on 27/09/25.
//

/// Representa um valor que pode ser usado em fórmulas.
///
/// `Value` é um enum que encapsula os diferentes tipos de dados suportados
/// pelo sistema de fórmulas. Cada valor pode ser um tipo primitivo ou uma
/// estrutura mais complexa como fórmulas aninhadas ou referências.
///
/// ## Visão Geral
///
/// Os tipos de valores suportados são:
/// - **Boolean**: Valores lógicos (`TRUE` ou `FALSE`)
/// - **Number**: Valores numéricos (inteiros ou decimais)
/// - **String**: Texto literal entre aspas duplas
/// - **NestedFormula**: Uma fórmula completa que será resolvida primeiro
/// - **Reference**: Nome de uma variável do contexto
///
/// ## Exemplo de Parsing
///
/// ```swift
/// // Boolean
/// "TRUE"  → Value.boolean(true)
///
/// // Number
/// "42"    → Value.number(42.0)
///
/// // String
/// "\"hello\"" → Value.string("hello")
///
/// // Reference
/// "idade" → Value.reference("idade")
///
/// // Nested Formula
/// "SUM(1; 2)" → Value.nestedFormula(Formula(...))
/// ```
///
/// ## Tópicos
///
/// ### Casos do Enum
/// - ``boolean(_:)``
/// - ``number(_:)``
/// - ``string(_:)``
/// - ``nestedFormula(_:)``
/// - ``reference(_:)``
///
/// ### Propriedades
/// - ``name``
/// - ``description``
/// - ``selfType``
enum Value {
    /// Um valor booleano.
    ///
    /// Representa `TRUE` ou `FALSE` em uma fórmula.
    case boolean(Bool)
    
    /// Um valor numérico.
    ///
    /// Armazena números como `Double` para suportar inteiros e decimais.
    case number(Double)
    
    /// Um valor de texto.
    ///
    /// Strings literais são delimitadas por aspas duplas na fórmula.
    case string(String)
    
    /// Uma fórmula aninhada.
    ///
    /// Permite que fórmulas sejam usadas como argumentos de outras fórmulas.
    case nestedFormula(Formula)
    
    /// Uma referência a uma variável.
    ///
    /// O nome da variável será resolvido usando o contexto fornecido.
    case reference(String)
    
    /// O nome do tipo do valor.
    ///
    /// Retorna uma string descritiva do tipo (ex: "Boolean", "Number").
    var name: String {
        switch self {
        case .boolean: return "Boolean"
        case .number: return "Number"
        case .string: return "String"
        case .nestedFormula: return "Nested Formula"
        case .reference: return "Reference"
        }
    }
    
    /// Descrição textual do valor.
    ///
    /// Converte o valor de volta para uma representação em string.
    /// Booleanos são convertidos para "TRUE"/"FALSE".
    var description: String {
        switch self {
        case .boolean(let bool):
            return bool.toString()
        case .number(let number):
            return String(number)
        case .string(let string):
            return string
        case .nestedFormula(let formula):
            return "Formula - Operation: \(formula.operation), Arguments: \(formula.arguments)"
        case .reference(let string): return "Reference: \(string)"
        }
    }
}

extension Value: Equatable {
    static func ==(lhs: Value, rhs: Value) -> Bool {
        switch (lhs, rhs) {
        case (.boolean(let l), .boolean(let r)):
            return l == r
        case (.number(let l), .number(let r)):
            return l == r
        case (.string(let l), .string(let r)):
            return l == r
        case (.string(let l), .number(let r)):
            return l == String(r)
        case (.number(let l), .string(let r)):
            return String(l) == r
        case (.nestedFormula(let l), .nestedFormula(let r)):
            return l == r
        case (.reference(let l), (.reference(let r))):
            return l == r
        default:
            return false
        }
    }
}

extension Value {
    /// Tipos disponíveis para valores em fórmulas.
    ///
    /// Usado internamente para validação de tipos em operações.
    enum SelfType {
        case string, number, boolean, nestedFormula, reference, unknown
    }
    
    /// O tipo deste valor.
    ///
    /// Retorna o `SelfType` correspondente a este valor.
    var selfType: SelfType {
        switch self {
        case .boolean:
            return .boolean
        case .number:
            return .number
        case .string:
            return .string
        case .nestedFormula:
            return .nestedFormula
        case .reference:
            return .reference
        }
    }
}
