//
//  Response.swift
//  
//
//  Created by Maddie Schipper on 4/8/21.
//

import Foundation

public struct Response<Resource : Decodable, Error : Decodable> : Decodable {
    public let data: Resource?
    public let errors: [Error]?
}

public struct GraphError : Decodable {
    public struct Location : Decodable {
        let line: Int?
        let column: Int?
        let sourceName: String?
    }
    
    let path: String?
    let message: String?
    let locations: [Location]?
}

public enum ResponseError : Error {
    case errors([GraphError])
    case missingData
}
