//
//  UITableViewExtension.swift
//  chatApp
//
//  Created by Shaobai Li on 1/8/17.
//  Copyright © 2017 Shaobai. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(class: T.Type) {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else{
            fatalError("Could not dequeue cell with Identifier \(T.reuseIdentifier)")
        }
        
        return cell
    }
    
}
