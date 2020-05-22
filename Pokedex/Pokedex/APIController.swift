//
//  APIController.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class APIController: NSObject {


    private enum Errors: Error {
        case badData
    }

    // MARK: - Properties
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    @objc(sharedController) static let shared = APIController()

    @objc func fetchAllPokemon(completion: @escaping ([PokemonBase]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all poke pokes : \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, Errors.badData)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = json["results"] as! Array<Dictionary<String, String>>

                var pokemen: [PokemonBase] = []
                for pokemon in results {
                    guard let name = pokemon["name"],
                        let urlString = pokemon["url"],
                        let url = URL(string: urlString) else {
                            NSLog("Something went wrong unwrapping pokemon \(pokemon)")
                            completion(nil, error)
                            return
                    }
                    let newPokemonBase = PokemonBase(name: name, url: url)
                    pokemen.append(newPokemonBase)
                }

                completion(pokemen, nil)
                return
            } catch {
                NSLog("Error dealing with json \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: PokemonBase) {
        willChangeValue(forKey: "finished")
        didChangeValue(forKey: "finished")
    }

}
