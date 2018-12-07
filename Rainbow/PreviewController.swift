//
//  PreviewController.swift
//  Rainbow
//
//  Created by Shawn on 06/12/2018.
//  Copyright © 2018 Shawn. All rights reserved.
//

import Foundation
import UIKit



class PreviewController: UIViewController {
    
    var image: UIImage?
    var imageView: UIImageView?
    
    let cancelButton:UIButton = {
        let cancel = UIButton(type: .custom)
        cancel.setImage(UIImage(named: "x"), for: .normal)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return cancel
    }()
    
    // Button handles
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        
        imageView = UIImageView(image: image)
        
        // Subviews
        view.addSubview(imageView!)
        view.addSubview(cancelButton)
        
        // Layout settings
        setupImageViewLayout()
        setupButtonLayout()
        
        
    }
    
    func setupImageViewLayout(){
        
//        // Enable autolayout for view
//        imageView?.translatesAutoresizingMaskIntoConstraints = false
//        imageView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        imageView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        imageView?.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
//        imageView?.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        imageView?.contentMode = .scaleAspectFill
        imageView?.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
    }
    
    func setupButtonLayout(){
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }
    
}

// View layout extension, courtesy of LBTA
extension UIView{
    func anchor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: top).isActive = true
        leadingAnchor.constraint(equalTo: leading).isActive = true
        bottomAnchor.constraint(equalTo: bottom).isActive = true
        trailingAnchor.constraint(equalTo: trailing).isActive = true
    }
}
