//
//  ValueParsing.swift
//  PLC
//
//  Created by Lucas Migge on 03/10/25.
//

/// Protocolo que define a interface para parsing de valores.
///
/// Implementações deste protocolo convertem strings em valores tipados
/// que podem ser usados como argumentos em fórmulas.
///
/// ## Visão Geral
///
/// O parser de valores identifica e converte:
/// - Valores booleanos (`TRUE`, `FALSE`)
/// - Valores numéricos (inteiros e decimais)
/// - Strings literais (entre aspas duplas)
/// - Referências a variáveis
/// - Fórmulas aninhadas
///
/// ## Tópicos
///
/// ### Métodos Requeridos
/// - ``parserValue(_:)``
protocol ValueParsing {
    /// Analisa uma string e a converte em um `Value` tipado.
    ///
    /// - Parameter string: A representação em string do valor.
    /// - Returns: Um `Value` correspondente ao tipo identificado.
    /// - Throws: Erros de parsing se o valor não puder ser interpretado.
    func parserValue(_ string: String) throws -> Value
}
