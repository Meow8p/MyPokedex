//
//  LoadingView.swift
//  MyPokedex
//
//  Created by Isabella Bonetto on 27/10/2020.
//

import UIKit

class LoadingView: UIView
{
   var isPresented : Bool = false
   
   override init(frame: CGRect)
   {
      super.init(frame: frame)
      
      let overlay = UIView(frame: frame)
      overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
      self.addSubview(overlay)
      self.bringSubviewToFront(overlay)
      
      overlay.translatesAutoresizingMaskIntoConstraints = false
      let overlayConstraints = [
         overlay.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
         overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
         overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
         overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
      ]
      NSLayoutConstraint.activate(overlayConstraints)
      
      let spinner = UIActivityIndicatorView(style: .large)
      spinner.color = UIColor.white
      self.addSubview(spinner)
      self.bringSubviewToFront(spinner)
      spinner.startAnimating()
      
      spinner.translatesAutoresizingMaskIntoConstraints = false
      let spinnerConstraints = [
         spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      ]
      NSLayoutConstraint.activate(spinnerConstraints)
   }
   
   required init?(coder: NSCoder)
   {
      fatalError("init(coder:) has not been implemented")
   }
   
   func show(superView: UIViewController)
   {
      if !self.isPresented
      {
         self.isPresented = true
         self.frame=superView.view.frame
         superView.view.addSubview(self)
         superView.view.bringSubviewToFront(self)
         superView.view.isUserInteractionEnabled = false
      }
   }
   
   func hide()
   {
      superview?.isUserInteractionEnabled = true
      self.removeFromSuperview()
      self.isPresented = false
   }
}
