//
//  PokemonImagesViewModel.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 28/10/2020.
//

import UIKit

class PokemonImagesViewModel: NSObject
{
   private var downloadImageTask: URLSessionDataTask?
   static var imageCache = NSCache<NSString, UIImage>()
   private var downloadedImage : UIImage? = nil
   {
      didSet
      {
         if let image = downloadedImage
         {
            self.bindPokemonImageViewModelToView(image)
         }
      }
   }
   
   var bindPokemonImageViewModelToView : ((UIImage) -> ()) =  {img in }

   deinit
   {
      if self.downloadImageTask != nil
      {
         self.downloadImageTask?.cancel()
      }
   }
   
   func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
   {
      if self.downloadImageTask != nil
      {
         self.downloadImageTask?.cancel()
      }
      self.downloadImageTask = URLSession.shared.dataTask(with: url, completionHandler: completion)
      self.downloadImageTask?.resume()
   }
   
   func downloadImage(from url: URL)
   {
      let absoluteURL : NSString = url.absoluteString as NSString
      let image: UIImage? = PokemonImagesViewModel.imageCache.object(forKey: absoluteURL)
      if image == nil
      {
         getImageData(from: url, completion: {
            data, response, error in
            if let d = data
            {
               if let downloadedImage = UIImage(data: d)
               {
                  self.downloadedImage = downloadedImage
                  PokemonImagesViewModel.imageCache.setObject(downloadedImage, forKey: absoluteURL)
               }
               else
               {
                  print(error.debugDescription)
               }
            }
            else
            {
               print(error.debugDescription)
            }
         })
      }
      else
      {
         DispatchQueue.main.async()
         {
            self.downloadedImage = image
         }
      }
   }
}
