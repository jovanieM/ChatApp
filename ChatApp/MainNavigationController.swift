//
//  MainNavigationController.swift
//  ChatApp
//
//  Created by CebuSQA on 13/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewController is IndexViewController {
            navigationBar.isHidden = true
        } else {
            navigationBar.isHidden = false
            navigationBar.barTintColor = .white
            
        }
        super.pushViewController(viewController, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
