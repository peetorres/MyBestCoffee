//
//  NetworkParse.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import Foundation

class NetworkParse {
    static func JSONDecodable<T: Codable>(to object: T.Type, from data: Data) -> T? {
        do {
            let parseObject = try JSONDecoder().decode(T.self, from: data)
            return parseObject
        } catch {
            print("\n JSONDecoder Error -> \(T.self): \(error)\n")
            return nil
        }
    }
    
    static func JSONDecodable<T: Codable>(to object: [T].Type, from data: Data) -> [T]? {
        do {
            let parseObject = try JSONDecoder().decode([T].self, from: data)
            return parseObject
        } catch {
            print("\n JSONDecoder Error -> \(T.self): \(error)\n")
            return nil
        }
    }
}
