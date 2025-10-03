//
//  Bool.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

/// Extensões para `Bool` que adicionam funcionalidades para fórmulas.
///
/// Estas extensões permitem conversão entre booleanos e strings
/// no formato esperado pelas fórmulas ("TRUE" e "FALSE").
public extension Bool {
    /// Inicializa um booleano a partir de uma string.
    ///
    /// - Parameter string: A string a ser convertida ("TRUE" ou "FALSE").
    /// - Returns: `nil` se a string não for "TRUE" ou "FALSE".
    ///
    /// ## Exemplo
    ///
    /// ```swift
    /// Bool("TRUE")  // Optional(true)
    /// Bool("FALSE") // Optional(false)
    /// Bool("true")  // nil (case-sensitive)
    /// ```
    init?(_ string: String) {
        switch string {
        case "TRUE":
            self = true
        case "FALSE":
            self = false
        default:
            return nil
        }
    }
    
    /// Converte o booleano para string no formato de fórmula.
    ///
    /// - Returns: "TRUE" se verdadeiro, "FALSE" se falso.
    ///
    /// ## Exemplo
    ///
    /// ```swift
    /// true.toString()  // "TRUE"
    /// false.toString() // "FALSE"
    /// ```
    func toString() -> String {
        return self ? "TRUE" : "FALSE"
    }
    
    static func ==(lhs: Bool, rhs: String) -> Bool {
        let boolAsString = lhs ? "TRUE" : "FALSE"
        return boolAsString == rhs
    }

    static func ==(lhs: String, rhs: Bool) -> Bool {
        return rhs == lhs
    }
}
