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
    
    @IBOutlet weak var NewWordLabel: UILabel!
    @IBOutlet weak var NewMeaningLabel: UILabel!
    @IBOutlet weak var NewWordTextField: UITextField!
    @IBOutlet weak var NewMeaningTextField: UITextField!
    
    @IBAction func AddWordsButton(_ sender: Any) {
        guard let newWord = NewWordTextField.text, let newMeaning = NewMeaningTextField.text
        else {return}
        
        //let newWord = ... ()
        //delegate?.SaveWord(newWord: newWord)
        dismiss(animated: true)
        
    }
    
    //weal var delegate:AddWordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewWordTextField.placeholder = "Введите слово"
        NewMeaningTextField.placeholder = "Введите значение"
    }
}
