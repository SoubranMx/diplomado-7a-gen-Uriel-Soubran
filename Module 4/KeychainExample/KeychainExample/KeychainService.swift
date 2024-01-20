//
//  KeychainService.swift
//  KeychainExample
//
//  Created by Diplomado on 19/01/24.
//

import Foundation

struct KeychainService {
    let defaultService = "mx.unam.ioslab.keychainExample"
    enum KeychainError: Error {
        case noPassword
        case unhandledError(status: OSStatus)
    }
    func save(key account: String, value: String) throws {
        guard let data = value.data(using: .utf8) else { return }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: defaultService,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
//        puede ser con closure, que tire una exepcion, que sea async await, etc.
//        Asegurarse que el status sea un estado aceptable
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func load(key account: String) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: defaultService,
            kSecAttrAccount as String: account,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true,
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.noPassword
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
        
        if let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
}
