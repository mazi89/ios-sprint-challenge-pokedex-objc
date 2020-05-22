//
//  APIController.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class APIController: NSObject {

    @objc(sharedController) static let shared = APIController()

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {

    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }

}
