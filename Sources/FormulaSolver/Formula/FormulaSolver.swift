//
//  FormulaSolver.swift
//  PLC
//
//  Created by Lucas Barros on 24/09/25.
//

/// Um resolvedor de fórmulas que interpreta e executa expressões lógicas e matemáticas.
///
/// `FormulaSolver` é a interface principal para trabalhar com fórmulas. Ele fornece métodos
/// para resolver fórmulas a partir de strings e validar sua sintaxe.
///
/// ## Visão Geral
///
/// O `FormulaSolver` combina um parser de fórmulas com um avaliador de expressões para
/// processar fórmulas complexas que podem incluir:
/// - Operações lógicas (AND, OR, NOT, IF, EQ)
/// - Operações matemáticas (SUM)
/// - Fórmulas aninhadas
/// - Referências a variáveis de contexto
///
/// ## Uso Básico
///
/// ```swift
/// let solver = FormulaSolver()
/// let result = try solver.solveFormula("SUM(1; 2; 3)")
/// print(result) // "6.0"
/// ```
///
/// ## Uso com Contexto
///
/// ```swift
/// let solver = FormulaSolver()
/// let context = ["idade": "25", "ativo": "TRUE"]
/// let result = try solver.solveFormula("AND(EQ(idade; 25); ativo)", context: context)
/// print(result) // "TRUE"
/// ```
///
/// ## Tópicos
///
/// ### Inicialização
/// - ``init()``
///
/// ### Resolvendo Fórmulas
/// - ``solveFormula(_:context:)``
/// - ``isFormulaValid(_:)``
public struct FormulaSolver {
    
    typealias Parser = FormulaParsing & ValueParsing
    
    let parser: Parser
    
    init(parser: Parser = FormulaParser()) {
        self.parser = parser
    }
    
    /// Cria uma nova instância de `FormulaSolver`.
    ///
    /// Inicializa o resolvedor com um parser de fórmulas padrão.
    ///
    /// ## Exemplo
    ///
    /// ```swift
    /// let solver = FormulaSolver()
    /// ```
    public init() {
        self.parser = FormulaParser()
    }
}

extension FormulaSolver: FormulaSolving {
    /// Resolve uma fórmula e retorna o resultado como string.
    ///
    /// Este método interpreta a fórmula fornecida, resolve todas as operações e
    /// retorna o resultado final. Suporta fórmulas complexas com operações aninhadas
    /// e referências de contexto.
    ///
    /// - Parameters:
    ///   - formula: A fórmula a ser resolvida em formato de string.
    ///              Exemplo: `"SUM(1; 2; 3)"`, `"AND(TRUE; FALSE)"`.
    ///   - context: Um dicionário opcional com variáveis e seus valores.
    ///              As chaves são nomes de variáveis e os valores são suas representações em string.
    ///              Padrão: dicionário vazio.
    ///
    /// - Returns: O resultado da fórmula como string. Booleanos retornam "TRUE" ou "FALSE",
    ///            números retornam sua representação decimal.
    ///
    /// - Throws: `FormulaParserError` se a fórmula tiver sintaxe inválida ou
    ///           `OperationError` se houver problemas durante a execução.
    ///
    /// ## Exemplo com Fórmula Simples
    ///
    /// ```swift
    /// let solver = FormulaSolver()
    /// let result = try solver.solveFormula("SUM(10; 20)")
    /// print(result) // "30.0"
    /// ```
    ///
    /// ## Exemplo com Contexto
    ///
    /// ```swift
    /// let context = ["x": "5", "y": "10"]
    /// let result = try solver.solveFormula("SUM(x; y)", context: context)
    /// print(result) // "15.0"
    /// ```
    ///
    /// ## Exemplo com Fórmulas Aninhadas
    ///
    /// ```swift
    /// let result = try solver.solveFormula("IF(EQ(5; 5); SUM(1; 2); 0)")
    /// print(result) // "3.0"
    /// ```
    public func solveFormula(_ formula: String, context: [String: String] = [:]) throws -> String {
        let parsedFormula = try parser.parseFormula(formula)
        let parsedContext = try parseValues(context: context)
        
        let result = try solve(parsedFormula, context: parsedContext)
        return result.description
    }
    
    /// Valida se uma fórmula possui sintaxe válida.
    ///
    /// Verifica se a fórmula pode ser interpretada corretamente sem executá-la.
    ///
    /// - Parameter formula: A fórmula a ser validada.
    ///
    /// - Returns: `true` se a fórmula for válida, `false` caso contrário.
    ///
    /// - Throws: Pode lançar erros de parsing se houver problemas na sintaxe.
    ///
    /// - Note: Esta função atualmente sempre retorna `true`. A validação completa
    ///         será implementada em versões futuras.
    ///
    /// ## Exemplo
    ///
    /// ```swift
    /// let isValid = try solver.isFormulaValid("AND(TRUE; FALSE)")
    /// print(isValid) // true
    /// ```
    public func isFormulaValid(_ formula: String) throws -> Bool {
        // TODO: Implement validation. Should return bool or expose errors?
        return true
    }
}

extension FormulaSolver {
    func solve(_ formula: Formula, context: [String: Value]) throws -> Value {
        let operation = try OperationFactory.makeOperation(from: formula.operation)
        
        let resolvedArguments = try formula.arguments.map { argument  in
            try resolveArgumentIfNeed(argument, context: context)
        }
        
        return try operation.solve(arguments: resolvedArguments)
    }
    
    func parseValues(context: [String: String]) throws -> [String: Value] {
        return try context.mapValues { valueRaw in
            try parser.parserValue(valueRaw)
        }
    }
    
    private func resolveArgumentIfNeed(_ argument: Value, context: [String: Value]) throws -> Value {
        switch argument {
        case .reference(let variableName):
            guard let value = context[variableName] else {
                throw FormulaParserError.unknownReference(variableName)
            }
            
            if case .nestedFormula(let nestedFormula) = value {
                return try solve(nestedFormula, context: context)
            } else {
                return value
            }
            
        case .nestedFormula(let nestedFormula):
            return try solve(nestedFormula, context: context)
            
        default:
            return argument
        }
    }
}


