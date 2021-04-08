//
//  Response.swift
//  
//
//  Created by Maddie Schipper on 4/8/21.
//

import Foundation

public struct Response<Resource : Decodable> : Decodable {
    public let data: Resource?
    public let errors: [GraphError]?
}

public struct GraphError : Decodable {
    
}

public enum ResponseError : Error {
    case errors([GraphError])
    case missingData
}
