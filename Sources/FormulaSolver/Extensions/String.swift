//
//  String.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

/// Extensões para `String` que adicionam funcionalidades para fórmulas.
///
/// Estas extensões permitem conversão entre strings e booleanos
/// no formato esperado pelas fórmulas.
public extension String {
    /// Inicializa uma string a partir de um booleano.
    ///
    /// - Parameter bool: O booleano a ser convertido.
    ///
    /// ## Exemplo
    ///
    /// ```swift
    /// String(true)  // "TRUE"
    /// String(false) // "FALSE"
    /// ```
    init(_ bool: Bool) {
        if bool {
            self = "TRUE"
        } else {
            self = "FALSE"
        }
    }
    
    /// Converte a string para um booleano.
    ///
    /// - Returns: `true` se a string for "TRUE", `false` se for "FALSE", `nil` caso contrário.
    ///
    /// ## Exemplo
    ///
    /// ```swift
    /// "TRUE".toBool()  // Optional(true)
    /// "FALSE".toBool() // Optional(false)
    /// "true".toBool()  // nil (case-sensitive)
    /// ```
    func toBool() -> Bool? {
        switch self {
        case "TRUE":
            return true
        case "FALSE":
            return false
        default:
            return nil
        }
    }
}
