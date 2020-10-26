//
//  PokemonTableViewCell.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 26/10/2020.
//

import UIKit
import Foundation

class PokemonTableViewCell: UITableViewCell
{
   var pokemon: Pokemon?
   {
      willSet
      {
         if pokemon != newValue
         {
            self.pokemonsImageViewModel = PokemonImagesViewModel()
            self.pokemonsImageViewModel.bindPokemonImageViewModelToView = { image in
               DispatchQueue.main.async
               {
                  self.imageView?.image = image
               }
            };
            
            DispatchQueue.main.async
            {
               self.imageView?.image = UIImage(named: "missing-picture-icon")
            }
            if let urlString = newValue?.pokemon?.sprites?.frontDefault, let url = URL(string: urlString)
            {
               self.pokemonsImageViewModel.downloadImage(from: url)
            }
         }
      }
   }
   private var pokemonsImageViewModel : PokemonImagesViewModel!
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
   {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
   }
   
   required init?(coder aDecoder: NSCoder)
   {
      fatalError("init(coder:) has not been implemented")
   }
}
