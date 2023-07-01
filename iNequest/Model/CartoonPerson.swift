//
//  CartoonPerson.swift
//  iNequest
//
//  Created by Артемий Дериглазов on 01.07.2023.
//

struct CartoonPerson: Decodable {
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
