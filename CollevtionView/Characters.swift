//
//  Characters.swift
//  CollevtionView
//
//  Created by Ruslan on 02/07/22.
//

import Foundation

struct Characters: Codable {
    let localized_name: String
    let attack_type: String
    let base_health: Int
    let base_mana: Int
    let move_speed: Int
    let img: String
}
