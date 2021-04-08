//
//  URLSession.swift
//  
//
//  Created by Maddie Schipper on 4/8/21.
//

import Foundation
import Combine

extension URLSession {
    public func execute<QueryType : Query>(query: QueryType, at url: URL, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<QueryType.ResultType, Error> {
        do {
            let request = try query.createRequest(for: url)
            
            return self.dataTaskPublisher(for: request)
                .require(httpStatusWithinRange: (200..<201))
                .retry(3)
                .map(\.data)
                .decode(type: Response<QueryType.ResultType>.self, decoder: decoder)
                .tryMap { response -> QueryType.ResultType in
                    if let error = response.errors {
                        throw ResponseError.errors(error)
                    }
                    
                    guard let responseData = response.data else {
                        throw ResponseError.missingData
                    }
                    
                    return responseData
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    fileprivate func require(httpStatusWithinRange range: Range<Int>) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        return self.tryMap { (data, response) -> URLSession.DataTaskPublisher.Output in
            guard let httpResponse = response as? HTTPURLResponse  else {
                throw URLError(.badServerResponse)
            }
            guard range.contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            return URLSession.DataTaskPublisher.Output(data, response)
        }.eraseToAnyPublisher()
    }
}
