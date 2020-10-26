//
//  PokemonsViewModel.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 26/10/2020.
//

import Foundation
import PokemonAPI

class PokemonsViewModel : NSObject
{
   private let pokemonAPI = PokemonAPI()
   private(set) var pokemonList : PokemonsData = PokemonsData(status: "0", data: [])
   {
      didSet
      {
         self.bindPokemonViewModelToController()
      }
   }
      
   /// The current pagedObject returned from the paginated web service call.
   private var pagedObject: PKMPagedObject<PKMPokemon>?
   
   var bindPokemonViewModelToController : (() -> ()) = {}
   
   init(completion: @escaping ((Result<PKMPagedObject<PKMPokemon>, Error>) -> Void))
   {
      super.init()
      fetchNextPokemonList(completion: completion)
   }
   
   func fetchNextPokemonList(completion: @escaping ((Result<PKMPagedObject<PKMPokemon>, Error>) -> Void))
   {
      if let po = self.pagedObject
      {
         fetchPokemonList(paginationState: .continuing(po, .next), completion:completion)
      }
      else
      {
         fetchPokemonList(paginationState: .initial(pageLimit: 20), completion: completion)
      }
   }
   
   func fetchPokemonList(paginationState: PaginationState<PKMPokemon> = .initial(pageLimit: 20), completion: @escaping ((Result<PKMPagedObject<PKMPokemon>, Error>) -> Void))
   {
      pokemonAPI.pokemonService.fetchPokemonList(paginationState: paginationState)
      { fetchPokemonListResult in
         switch fetchPokemonListResult
         {
            case .success(let pagedObject):
               self.pagedObject = pagedObject
               if let resultList = pagedObject.results
               {
                  self.pokemonList.estimatedSize += resultList.count
                  
                  var i : Int = resultList.startIndex
                  while i != resultList.endIndex
                  {
                     if let p : PKMNamedAPIResource<PKMPokemon> = (resultList[ i ]) as? PKMNamedAPIResource<PKMPokemon>,
                        let name : String = p.name
                     {
                        self.pokemonAPI.pokemonService.fetchPokemon(name)
                        { fetchPokemonResult in
                           switch fetchPokemonResult
                           {
                              case .success(let data):
                                 let pokemon : Pokemon = Pokemon(pokemon: data)
                                 if !self.pokemonList.data.contains(pokemon)
                                 {
                                    self.pokemonList.data.append(pokemon)
                                 }
                                 
                              case .failure(let error):
                                 print(error.localizedDescription)
                           }
                           
                           if self.pokemonList.data.count >= self.pokemonList.estimatedSize
                           {
                              completion(fetchPokemonListResult)
                           }
                        }
                     }
                     i = resultList.index(after: i)
                  }
               }
            case .failure(let error):
               print(error.localizedDescription)
               completion(fetchPokemonListResult)
         }
      }
   }   
}
