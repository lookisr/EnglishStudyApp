//
//  StatisticViewController.swift
//  project
//
//  Created by user on 11.07.2022.
//

import UIKit

class StatisticViewController: UIViewController {
    
    var countCorrect: Int?
    var countIncorrect: Int?
    var incorrectWords: [String]?
    
    @IBOutlet weak var incorrectWordsTextView: UITextView!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incorrectWordsTextView.allowsEditingTextAttributes = false
        correctLabel.text = "Number of correct words: \(countCorrect ?? 0)"
        
        incorrectLabel.text = "Number of incorrect words: \(countIncorrect ?? 0)"
        var words = incorrectWords?.joined(separator: ", ")
//        words?.removeLast(2)
        incorrectWordsTextView.text = "Words to repeat: \(words ?? "")"
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
