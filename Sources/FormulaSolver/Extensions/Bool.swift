//
//  Bool.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

public extension Bool {
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
