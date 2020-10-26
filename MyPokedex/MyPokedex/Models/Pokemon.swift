//
//  Pokemon.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 26/10/2020.
//

import Foundation
import PokemonAPI

struct PokemonsData: Decodable
{
   var status: String
   var data: [Pokemon]
   var estimatedSize: Int = 0 /// Size of data when loading will terminate
}

class Pokemon: NSObject, Decodable
{
   var pokemon : PKMPokemon?
   
   override init()
   {
      super.init()
   }
   
   init(pokemon: PKMPokemon)
   {
      super.init()
      self.pokemon = pokemon
   }
   
   required init(from decoder: Decoder) throws
   {
      super.init()
      try self.pokemon = PKMPokemon(from: decoder)
   }
   
   static func == (lhs: Pokemon, rhs: Pokemon) -> Bool
   {
      return lhs.pokemon?.id == rhs.pokemon?.id
   }
}
