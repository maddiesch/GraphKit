//
//  Query.swift
//  
//
//  Created by Maddie Schipper on 4/8/21.
//

import Foundation

public protocol Query {
    associatedtype ResultType : Decodable
    
    var queryString: String { get }
    var operationName: String? { get }
    var variables: [String: Value] { get }
    
    func prepare(request: inout URLRequest) throws
}

extension Query {
    public var variables: [String: Value] { [:] }
    
    public var operationName: String? { nil }
    
    public func prepare(request: inout URLRequest) throws {}
    
    private var requestBody: RequestBody {
        return RequestBody(
            query: self.queryString,
            variables: self.variables,
            operationName: self.operationName
        )
    }
    
    public func createRequest(for url: URL, encoder: JSONEncoder = JSONEncoder()) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try encoder.encode(self.requestBody)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        try self.prepare(request: &request)
        
        return request
    }
}

fileprivate struct RequestBody : Encodable {
    let query: String
    let variables: [String: Value]
    let operationName: String?
}
