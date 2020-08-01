//
//  STNavigationController.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

class STNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.backgroundColor = UIColor.standwoodBackgroundGrey()
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                       NSAttributedString.Key.font: UIFont.standwoodNavBarFont()]
    }
}
