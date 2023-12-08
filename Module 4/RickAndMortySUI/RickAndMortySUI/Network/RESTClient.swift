//
//  RESTClient.swift
//  RickAndMortySUI
//
//  Created by Diplomado on 08/12/23.
//

import Foundation

struct RESTClient<T: Codable> {
    let client: Client
    let decoder: JSONDecoder = {
            var dec = JSONDecoder()
            dec.keyDecodingStrategy = .convertFromSnakeCase
            return dec
    }()
    
    init(client: Client) {
        self.client = client
    }
    
    typealias successHandler = ((T) -> Void)
    
    func show(_ path: String, success: @escaping successHandler){
        client.get(path: path) { data in
            guard let data = data else { return }
            
            do {
                let json = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async { success(json) }
            } catch let err {
                #if DEBUG
                debugPrint(err)
                #endif
            }
        }
    }
//    usando async await
    func show(path: String, page: Int = 1) async throws -> Result<T?, Error> {
        let response = client.get(path, query: ["page": "\(page)"])
        switch response {
        case .success(let data):
            guard let data = data else { return nil }
            let json = try decoder.decode(T.self, from: data)
            return .success(json)
        case .failure(let error):
            return .failure(error)
        }
    }
}
