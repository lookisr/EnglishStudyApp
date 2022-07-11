//
//  AddWordsViewController.swift
//  project
//
//  Created by Aliya on 07.07.2022.
//

import UIKit

//protocol AddWordDelegate: AnyObject{
//    func SaveWord (newWord:...)
//}

class AddWordsViewController: UIViewController {
    var categoryIndex: Int?
    @IBOutlet weak var NewWordLabel: UILabel!
    @IBOutlet weak var NewMeaningLabel: UILabel!
    @IBOutlet weak var NewWordTextField: UITextField!
    @IBOutlet weak var NewMeaningTextField: UITextField!
    
    @IBAction func AddWordsButton(_ sender: Any) {
        guard let newWord = NewWordTextField.text, let newMeaning = NewMeaningTextField.text
        else {return}
        DataBase.addWord(categoryIndex!, card: Card(word: newWord, translation: newMeaning))
        print("testttt")
        let storyboard = UIStoryboard(name: "DictionaryStoryboard", bundle: nil)
        guard let DictTableVC = storyboard.instantiateViewController(
            withIdentifier: "DictViewController"
        ) as? DictViewController else { return }
        navigationController?.popViewController(animated: true)
        DictTableVC.categoryIndex = categoryIndex
        DictTableVC.navigationController?.popViewController(animated: true)
        DictTableVC.model.screens = DataBase.getWords(categoryIndex!)
        DictTableVC.tableView?.reloadData()
    }
    
    
    //weal var delegate:AddWordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewWordTextField.placeholder = "Введите слово"
        NewMeaningTextField.placeholder = "Введите значение"
    }
}
