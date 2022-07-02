//
//  Json.swift
//  CollevtionView
//
//  Created by Ruslan on 02/07/22.
//

import Foundation

struct Json {
    func json(arr: @escaping ([Characters]) -> ()) {
        let url = "https://api.opendota.com/api/heroStats"
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode([Characters].self, from: data)
                arr(characters)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } .resume()
    }
}
