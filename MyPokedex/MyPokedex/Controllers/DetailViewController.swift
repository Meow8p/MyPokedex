//
//  DetailViewController.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 28/10/2020.
//

import UIKit
import PokemonAPI

class DetailViewController: UITableViewController
{
   var pokemon : Pokemon
   
   var pokemonViewModel : PokemonsDetailViewModel!
   var pokemonImagesViewModel : PokemonImagesViewModel!
   
   private var dataSource : PokemonDetailViewDataSource<PokemonImageTableViewCell, PokemonStatTableViewCell, PokemonTypeTableViewCell, URL, PKMPokemonStat, PKMPokemonType>!
   
   init(style: UITableView.Style, pokemon: Pokemon)
   {
      self.pokemon = pokemon
      super.init(style: style)
   }
   
   required init?(coder: NSCoder)
   {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      tableView.register(PokemonImageTableViewCell.classForCoder(), forCellReuseIdentifier: "PokemonImageCell")
      tableView.register(PokemonStatTableViewCell.classForCoder(), forCellReuseIdentifier: "PokemonStatCell")
      tableView.register(PokemonTypeTableViewCell.classForCoder(), forCellReuseIdentifier: "PokemonTypeCell")
      
      self.pokemonViewModel = PokemonsDetailViewModel()
      self.callToViewModelForUIUpdate()
      self.pokemonViewModel.pokemon = self.pokemon
      self.title = self.pokemonViewModel.pokemon?.pokemon?.name
      
      if let urlString = self.pokemonViewModel.pokemon?.pokemon?.sprites?.frontDefault,
         let url = URL(string: urlString)
      {
         self.pokemonImagesViewModel = PokemonImagesViewModel()
         self.pokemonImagesViewModel.bindPokemonImageViewModelToView = { img in
            DispatchQueue.main.async
            {
               self.tableView.tableHeaderView = RoundedImage(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100), image: img)
            }
         }
         self.pokemonImagesViewModel.downloadImage(from: url)
      }
   }
   
   func callToViewModelForUIUpdate()
   {
      self.pokemonViewModel.bindPokemonDetailViewModelToController =
         {
            self.updateDataSource()
         }
   }
   
   func updateDataSource()
   {
      DispatchQueue.main.async
      {
         if let stats = self.pokemonViewModel.pokemon?.pokemon?.stats,
            let types = self.pokemonViewModel.pokemon?.pokemon?.types
         {
            let images : Array<URL> = self.pokemonViewModel.spriteURLs
            self.dataSource = PokemonDetailViewDataSource(imagesCellIdentifier: "PokemonImageCell",
                                                          statsCellIdentifier: "PokemonStatCell",
                                                          typesCellIdentifier: "PokemonTypeCell",
                                                          images: images,
                                                          stats: stats,
                                                          types: types,
                                                          configureImagesCell: { (cell, imageURL) in
                                                            cell.imageURL = imageURL
                                                          },
                                                          configureStatsCell: { (cell, stat) in
                                                            cell.textLabel?.text = stat.stat?.name
                                                            cell.detailTextLabel?.text = String(stat.baseStat ?? 0)
                                                          },
                                                          configureTypesCell: { (cell, type) in
                                                            cell.textLabel?.text = type.type?.name
                                                          })
            
            
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
         }
      }
   }
}
