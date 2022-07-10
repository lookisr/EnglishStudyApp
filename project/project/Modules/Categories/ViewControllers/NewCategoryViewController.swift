//
//  NewCategoryViewController.swift
//  project
//
//  Created by Rafael Shamsutdinov on 10.07.2022.
//

import UIKit

class NewCategoryViewController: UIViewController {
    @IBOutlet weak var nameCategory: UITextField!
        
        var newCategory:String = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.navigationBar.barTintColor = UIColor(red: 0.89, green: 0.95, blue: 0.96, alpha: 1.00)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            newCategory = nameCategory.text!
        }
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


