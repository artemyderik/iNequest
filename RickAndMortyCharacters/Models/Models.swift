//
//  CartoonPerson.swift
//  iNequest
//
//  Created by Артемий Дериглазов on 01.07.2023.
//

struct Page: Decodable {
    let info: Info?
    let results: [Character]?

    init(pageData: [String: Any]) {
    info = pageData["info"] as? Info
    results = pageData["results"] as? [Character]
    }
}

struct Info: Decodable {
    let count: Int?
    let pages: Int?
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
    var origin: Place?
    let location: Place?
    let image: String
    let episode: [String]
    let url: String
    
    init(characterData: [String: Any]) {
    id = characterData["id"] as? Int ?? 0
    name = characterData["name"] as? String ?? ""
    status = characterData["status"] as? String ?? ""
    species = characterData["species"] as? String ?? ""
    type = characterData["type"] as? String ?? ""
    gender = characterData["gender"] as? String ?? ""
    origin = characterData["origin"] as? Place
    location = characterData["location"] as? Place
    image = characterData["image"] as? String ?? ""
    episode = characterData["episode"] as? [String] ?? []
    url = characterData["url"] as? String ?? ""
    }
}

struct Place: Decodable {
    let name: String
    let url: String
}
