//
//  String.swift
//  PLC
//
//  Created by Lucas Barros on 26/09/25.
//

public extension String {
    init(_ bool: Bool) {
        if bool {
            self = "TRUE"
        } else {
            self = "FALSE"
        }
    }
    
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
