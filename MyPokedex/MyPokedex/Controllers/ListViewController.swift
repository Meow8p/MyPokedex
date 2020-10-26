//
//  ViewController.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 26/10/2020.
//

import UIKit
import PokemonAPI

class ListViewController: UITableViewController
{
   private var pokemonViewModel : PokemonsViewModel!
   private var dataSource : PokemonTableViewDataSource<PokemonTableViewCell,Pokemon>!
   private var loadingView : LoadingView?
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      tableView.register(PokemonTableViewCell.classForCoder(), forCellReuseIdentifier: "PokemonCell")
      callToViewModelForUIUpdate()
      self.loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
      self.title = "Pokemon"
   }
   
   func callToViewModelForUIUpdate()
   {
      self.showLoadingView()
      self.pokemonViewModel =  PokemonsViewModel(completion: loadingCompletionHandler)
      self.pokemonViewModel.bindPokemonViewModelToController =
         {
            self.updateDataSource()
         }
   }
   
   func updateDataSource()
   {
      DispatchQueue.main.async
      {
         self.dataSource = PokemonTableViewDataSource(cellIdentifier: "PokemonCell", items: self.pokemonViewModel.pokemonList.data, configureCell: { (cell, pokemon) in
            DispatchQueue.main.async
            {
               cell.textLabel?.text = pokemon.pokemon?.name
               cell.accessoryType = .disclosureIndicator
            }
            cell.pokemon = pokemon
         })
         
         self.tableView.dataSource = self.dataSource
         self.tableView.delegate = self
         self.tableView.reloadData()
      }
   }
   
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
   {
      let lastElement = self.pokemonViewModel.pokemonList.estimatedSize - 1
      if indexPath.row == lastElement
      {
         self.showLoadingView()
         self.pokemonViewModel.fetchNextPokemonList(completion: loadingCompletionHandler)
      }
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
      let viewController = DetailViewController(style: .grouped, pokemon: self.pokemonViewModel.pokemonList.data[indexPath.row])
      self.navigationController?.pushViewController(viewController, animated: true)
   }
   
   func showLoadingView()
   {
      DispatchQueue.main.async
      {
         self.loadingView?.show(superView: self.navigationController ?? self)
      }
   }
   
   func hideLoadingView()
   {
      DispatchQueue.main.async
      {
         self.loadingView?.hide()
      }
   }
   
   func loadingCompletionHandler(result: Result<PKMPagedObject<PKMPokemon>, Error>)
   {
      self.hideLoadingView()
   }
}

