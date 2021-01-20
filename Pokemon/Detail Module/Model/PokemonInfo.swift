//
//  PokemonInfo.swift
//  Pokemon
//
//  Created by Suresh Kumar Linganathan on 20/01/21.
//  Copyright © 2021 SureshKumar. All rights reserved.
//

import Foundation

struct PokemonInfo:Codable {
    
    var abilities: [Ability]
    var forms:[Form]
    var moves:[Move]
    
}

struct Ability: Codable {
    var ability: Species
    var isHidden: Bool
    var slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}
struct Species: Codable {
    var name: String
    var url: String
}

struct Form:Codable {
    var name:String?
    var url:String?
}

struct Move: Codable {
    var move: Species
    var versionGroupDetails: [VersionGroupDetail]
    
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct VersionGroupDetail: Codable {
    var levelLearnedAt: Int
    var moveLearnMethod, versionGroup: Species
    
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

