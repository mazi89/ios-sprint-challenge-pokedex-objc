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

    @objc func fillInDetails(for pokemon: Pokemon) {

        URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching da business : \(error)")
                return
            }

            guard let data = data else {
                NSLog("error  with corrupt data.")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                guard let id = json["id"] as? Int,
                let abilities = json["abilities"] as? Array<Dictionary<String, Any>>,
                let sprites = json["sprites"] as? Dictionary<String, Any>,
                    let urlString = sprites["front_default"] as? String else {
                        NSLog("Error decoding json: \(json)")
                        return
                }

                pokemon.iD = Int32(id)
                self.willChangeValue(forKey: "id")
                self.didChangeValue(forKey: "id")

                for items in abilities {
                    if let object = items["ability"] as? Dictionary<String, Any>,
                        let ability = object["name"] as? String {
                        pokemon.abilities.add(NSString(string: ability))
                    }
                }
                self.willChangeValue(forKey: "abilities")
                self.didChangeValue(forKey: "abilities")

                guard let url = URL(string: urlString) else {
                    NSLog("error making the url with urlString: \(urlString)")
                    return
                }

                URLSession.shared.dataTask(with: url) { (data, _, error) in
                    if let error = error {
                        NSLog("Error fetching pookemon image : \(error)")
                        return
                    }

                    guard let data = data else {
                        NSLog("Bad data from pokemon sprite url")
                        return
                    }

                    pokemon.imageData = data
                    self.willChangeValue(forKey: "image")
                    self.didChangeValue(forKey: "image")
                }.resume()


            } catch {
                NSLog("Error unwrapping json : \(error)")
                return
            }

        }.resume()


    }

}
