//
//  PokemonImageTableViewCell.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 28/10/2020.
//

import UIKit

class PokemonImageTableViewCell: UITableViewCell
{
   private var pokemonsImageViewModel : PokemonImagesViewModel!
   var imageURL : URL?
   {
      willSet
      {
         if imageURL != newValue
         {
            self.pokemonsImageViewModel = PokemonImagesViewModel()
            self.pokemonsImageViewModel.bindPokemonImageViewModelToView = { image in
               DispatchQueue.main.async
               {
                  self.imageView?.image = image
               }
            };

            self.imageView?.image = UIImage(named: "missing-picture-icon")
            if let url = newValue
            {
               self.pokemonsImageViewModel.downloadImage(from: url)
            }
         }
      }
   }
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
   {
      super.init(style: .value1, reuseIdentifier: reuseIdentifier)
   }
   
   required init?(coder aDecoder: NSCoder)
   {
      fatalError("init(coder:) has not been implemented")
   }

   
}
