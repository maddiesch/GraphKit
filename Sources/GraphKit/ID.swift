//
//  ID.swift
//  
//
//  Created by Maddie Schipper on 4/8/21.
//

import Foundation

public struct ID : RawRepresentable, Codable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        try container.encode(self.rawValue)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        self.rawValue = try container.decode(String.self)
    }
}

extension ID : Identifiable {
    public var id: String {
        return self.rawValue
    }
}

extension ID : Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}

extension ID : CustomStringConvertible {
    public var description: String {
        return self.rawValue
    }
}
