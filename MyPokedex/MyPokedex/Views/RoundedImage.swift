//
//  RoundedImage.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 26/10/2020.
//

import UIKit

class RoundedImage: UIView
{
   var imageView: UIImageView!
   
   init(frame: CGRect, image: UIImage)
   {
      super.init(frame: frame)
      
      imageView = UIImageView()
      imageView.backgroundColor = UIColor.white
      imageView.contentMode = UIView.ContentMode.scaleAspectFit
      imageView.clipsToBounds = true
      imageView.layer.borderWidth = 2.0
      imageView.layer.borderColor = UIColor.lightGray.cgColor
      imageView.layer.cornerRadius = CGFloat(min(image.cgImage?.width ?? 0, image.cgImage?.height ?? 0) / 2)
      imageView.image = image
      
      self.addSubview(imageView)
      
      imageView.translatesAutoresizingMaskIntoConstraints = false
      
      let constraints = [
         imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
         imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
         ]
      NSLayoutConstraint.activate(constraints)
   }
   
   required init?(coder aDecoder: NSCoder)
   {
      super.init(coder: aDecoder)
   }
   
   
}
