//
//  PokemonDetailViewDataSource.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 28/10/2020.
//

import UIKit
import Foundation
import PokemonAPI

class PokemonDetailViewDataSource<IMAGESCELL : UITableViewCell, STATSCELL : UITableViewCell, TYPESCELL: UITableViewCell, I, S, T> : NSObject, UITableViewDataSource
{
   private var imagesCellIdentifier : String!
   private var statsCellIdentifier : String!
   private var typesCellIdentifier : String!
   
   private var images : [I]!
   private var stats : [S]!
   private var types : [T]!
   var configureImagesCell : (IMAGESCELL, I) -> () = {_,_ in }
   var configureStatsCell : (STATSCELL, S) -> () = {_,_ in }
   var configureTypesCell : (TYPESCELL, T) -> () = {_,_ in }
   
   init(imagesCellIdentifier : String, statsCellIdentifier : String, typesCellIdentifier : String, images : [I], stats : [S], types : [T], configureImagesCell : @escaping (IMAGESCELL, I) -> (), configureStatsCell : @escaping (STATSCELL, S) -> (), configureTypesCell : @escaping (TYPESCELL, T) -> ())
   {
      self.imagesCellIdentifier = imagesCellIdentifier
      self.statsCellIdentifier = statsCellIdentifier
      self.typesCellIdentifier = typesCellIdentifier
      self.images = images
      self.stats = stats
      self.types = types
      self.configureImagesCell = configureImagesCell
      self.configureStatsCell = configureStatsCell
      self.configureTypesCell = configureTypesCell
   }
   
   func numberOfSections(in tableView: UITableView) -> Int
   {
      return 3
   }
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
   {
      var title = ""
      switch section
      {
         case 0:
            title = "Images"
         case 1:
            title = "Stats"
         case 2:
            title = "Types"
         default:
            title = ""
      }
      return title
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   {
      var count = 0
      switch section
      {
         case 0:
            count = images.count
         case 1:
            count = stats.count
         case 2:
            count = types.count
         default:
            count = 0
      }
      return count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      var cell : UITableViewCell
      switch indexPath.section
      {
         case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: imagesCellIdentifier, for: indexPath)
            let item = self.images[indexPath.row]
            self.configureImagesCell(cell as! IMAGESCELL, item)
         case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: statsCellIdentifier, for: indexPath)
            let item = self.stats[indexPath.row]
            self.configureStatsCell(cell as! STATSCELL, item)
         case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: typesCellIdentifier, for: indexPath)
            let item = self.types[indexPath.row]
            self.configureTypesCell(cell as! TYPESCELL, item)
         default:
            cell = UITableViewCell()
      }
      
      return cell
   }
}
