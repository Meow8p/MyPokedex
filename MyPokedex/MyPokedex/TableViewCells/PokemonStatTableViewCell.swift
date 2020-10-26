//
//  PokemonStatTableViewCell.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 28/10/2020.
//

import UIKit

class PokemonStatTableViewCell: UITableViewCell
{
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
   {
      super.init(style: .value1, reuseIdentifier: reuseIdentifier)
   }
   
   required init?(coder aDecoder: NSCoder)
   {
      fatalError("init(coder:) has not been implemented")
   }

}
