//
//  Client.swift
//  RickAndMortySUI
//
//  Created by Diplomado on 08/12/23.
//

import Foundation

struct Client {
    static let rickAndMorty = Client(baseUrl: "")
    let session = URLSession.shared
    let baseUrl: String
    private let contentType: String
    
    
    enum NetworkError: Error {
        case conection
        case invalidRequest
        case invalidResponse
        case client
        case server
        
    }
    
    
    init(baseUrl: String, contentType:String = "application/json") {
        self.baseUrl = baseUrl
        self.contentType = contentType
    }
    
    typealias requestHandler = ((Data?) -> Void)
    typealias errorHandler = ((NetworkError) -> Void)
    
    func get (path: String, success: requestHandler?, failure: errorHandler? = nil){
        request(method: "GET", path: path, body: nil, success: success, failure: failure)
    }
    
    func get(_ path: String, query: [String: String]) async throws -> Result<Data?, NetworkError> {
        
    }
    
    
    func request(method: String, path: String, body: Data?, success: requestHandler?, failure: errorHandler? = nil ){
        guard let request = buildRequest(method: method, path: path, body: body) else{
            failure?(NetworkError.invalidRequest)
            return
        }
        
        #if DEBUG
        debugPrint(request)
        #endif
        
        let task = session.dataTask(with: request) { data, response, error in
            if let err = error {
                #if DEBUG
                debugPrint(err)
                #endif
                failure?(NetworkError.conection)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(NetworkError.invalidResponse)
                return
            }
            
            let status = StatusCode(rawValue: httpResponse.statusCode)
            #if DEBUG
            print("Status: \(httpResponse.statusCode)")
//            debugPrint(httpResponse)
            #endif
            switch status {
            case .success:
                success?(data)
            case .clientError:
                failure?(NetworkError.client)
            case .serverError:
                failure?(NetworkError.server)
            default:
                failure?(NetworkError.invalidResponse)
            }
            
        }
        task.resume()
    }
    
    private func buildRequest(method: String, path: String, body: Data?) -> URLRequest? {
        var urlComp = URLComponents(string: baseUrl)!
        urlComp.path = path
        
        guard let url = urlComp.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        #if DEBUG
        debugPrint(request)
        #endif
        return request
    }
}
