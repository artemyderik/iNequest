//
//  CartoonPerson.swift
//  iNequest
//
//  Created by Артемий Дериглазов on 01.07.2023.
//

struct Page: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    var origin: Place
    let location: Place
    let image: String
    let episode: [String]
    let url: String
}

struct Place: Decodable {
    let name: String
    let url: String
}
