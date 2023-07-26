//
//  NetworkManager.swift
//  iNequest
//
//  Created by Артемий Дериглазов on 05.07.2023.
//
import Foundation

enum Link: String, CaseIterable {
    case rickSanchez = "https://rickandmortyapi.com/api/character/1"
    case mortySmith = "https://rickandmortyapi.com/api/character/2"
    case summerSmith = "https://rickandmortyapi.com/api/character/3"
    case garblovian = "https://rickandmortyapi.com/api/character/133"
    case glen = "https://rickandmortyapi.com/api/character/145"
    case millionAnts = "https://rickandmortyapi.com/api/character/226"
    case florflock = "https://rickandmortyapi.com/api/character/665"
    case yoYoRick = "https://rickandmortyapi.com/api/character/773"
    case gotronPilot = "https://rickandmortyapi.com/api/character/777"
    case squidCostumeBeth = "https://rickandmortyapi.com/api/character/704"
    case davin = "https://rickandmortyapi.com/api/character/394"
    case mortyJrSInterviewer = "https://rickandmortyapi.com/api/character/401"
    case turkeyPresidentCurtis = "https://rickandmortyapi.com/api/character/761"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchPage(from url: String, completion: @escaping(Result<Page, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let page = try JSONDecoder().decode(Page.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(page))
                }
            }
            catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func fetchCharacter(from url: String, completion: @escaping(Result<Character, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(character))
                }
            }
            catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

