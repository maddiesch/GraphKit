//
//  VariableValue.swift
//  
//
//  Created by Maddie Schipper on 4/8/21.
//

import Foundation

public enum Value {
    case string(String)
    case optionalString(String?)
    case integer(Int64)
    case optionalInteger(Int64?)
    case boolean(Bool)
    case id(ID)
    case optionalID(ID?)
    case nilValue
}

extension Value : Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let val):
            try container.encode(val)
        case .optionalString(let optional):
            if let val = optional {
                try container.encode(val)
            } else {
                try container.encodeNil()
            }
        case .integer(let val):
            try container.encode(val)
        case .optionalInteger(let optional):
            if let val = optional {
                try container.encode(val)
            } else {
                try container.encodeNil()
            }
        case .id(let val):
            try container.encode(val)
        case .optionalID(let optional):
            if let val = optional {
                try container.encode(val)
            } else {
                try container.encodeNil()
            }
        case .boolean(let val):
            try container.encode(val)
        case .nilValue:
            try container.encodeNil()
        }
    }
}

extension Value : ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .string(value)
    }
}

extension Value : ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .nilValue
    }
}

extension Value : ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self = .integer(Int64(value))
    }
}

extension Value : ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self = .boolean(value)
    }
}
