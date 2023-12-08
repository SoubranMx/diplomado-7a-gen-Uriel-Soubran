//
//  PaginatedResponse.swift
//  RickAndMortySUI
//
//  Created by Diplomado on 08/12/23.
//

import Foundation

struct PaginatedResponse<T: Codable>: Codable {
    let info: Info
    let results: [T]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
