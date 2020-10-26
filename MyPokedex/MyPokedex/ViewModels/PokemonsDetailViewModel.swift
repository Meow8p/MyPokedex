//
//  PokemonsDetailViewModel.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 30/10/2020.
//

import Foundation
import PokemonAPI

class PokemonsDetailViewModel : NSObject
{
   var pokemon : Pokemon?
   {
      didSet
      {
         filterPokemonImages()
         self.bindPokemonDetailViewModelToController()
      }
   }
   
   override init()
   {
      super.init()
   }
   
   var spriteURLs = Array<URL>()
      
   var bindPokemonDetailViewModelToController : (() -> ()) = {}
   
   func filterPokemonImages()
   {
      spriteURLs = Array<URL>()
      if let u = pokemon?.pokemon?.sprites?.frontDefault, let url = URL(string: u)
      {
         spriteURLs.append(url)
      }
      if let u = pokemon?.pokemon?.sprites?.backDefault, let url = URL(string: u)
      {
         spriteURLs.append(url)
      }
      if let u = pokemon?.pokemon?.sprites?.frontFemale, let url = URL(string: u)
      {
         spriteURLs.append(url)
      }
      if let u = pokemon?.pokemon?.sprites?.backFemale, let url = URL(string: u)
      {
         spriteURLs.append(url)
      }
      if let u = pokemon?.pokemon?.sprites?.frontShiny, let url = URL(string: u)
      {
         spriteURLs.append(url)
      }
      if let u = pokemon?.pokemon?.sprites?.backShiny, let url = URL(string: u)
      {
         spriteURLs.append(url)
      }
      if let u = pokemon?.pokemon?.sprites?.frontShinyFemale, let url = URL(string: u)
      {
         spriteURLs.append(url)
      }
      if let u = pokemon?.pokemon?.sprites?.backShinyFemale, let url = URL(string: u)
      {
         spriteURLs.append(url)
      }
   }
}
