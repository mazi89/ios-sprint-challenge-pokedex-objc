//
//  APIController.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class APIController: NSObject {

    // MARK: - Properties
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    private(set) var pokemon:[Pokemon] = []

    @objc(sharedController) static let shared = APIController()

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all poke pokes : \(error)")
            }

            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = json["results"] as! Array<Dictionary<String, String>>

                for pokemon in results {
                    
                }
            } catch {
                NSLog("Error dealing with json \(error)")
            }
        }
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }

}
