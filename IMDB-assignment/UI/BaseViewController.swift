//
//  BaseViewController.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /** Assign the default nib to this view controller */
    required init() {
        let className = String(describing: type(of: self))
        super.init(nibName: className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
