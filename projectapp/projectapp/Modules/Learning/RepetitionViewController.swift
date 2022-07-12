//
//  RepetitionWordsViewController.swift
//  project
//
//  Created by user on 09.07.2022.
//

import UIKit
import Foundation

class RepetitionWordsViewController: UIViewController {
    var previousFrame: CGRect?
    var categoryIndex: Int?
    private var currentId = 0
    private var offset = CGSize.zero
    private  var showingTranslation: Bool?
    private var countCorrect = 0
    private var countIncorrect = 0
    private var incorrectWords = [String]()
    
    lazy var userCards: [Card] = DataBase.getWords(categoryIndex!)
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var cardView: CardsView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var incorrectButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousFrame = self.cardView.frame
        againButton.isHidden = true
        currentId = 0
        offset = CGSize.zero
        showingTranslation = false
        countCorrect = 0
        countIncorrect = 0
        incorrectWords = [String]()
        
        cardView.dropShadow()
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        
        cardView.addGestureRecognizer(tap)
        
        incorrectButton.isHidden = true
        correctButton.isHidden = true
        
        wordLabel.text = userCards[currentId].word
        cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
        checkLabel.text = "tap to check"
        checkLabel.isHidden = false
    }
    
    
    @objc func handleSwipe() {
        UIView.animate(
                   withDuration: 1,
                   delay: 0.0,
                   options: .curveLinear,
                   animations: {

                       self.cardView?.frame.origin.x = -self.previousFrame!.width*2

               }) { (completed) in

               }
        
        cardView.frame = previousFrame!
        showingTranslation = false
        currentId+=1
        
        wordLabel.text = userCards[currentId].word
        cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
        
        self.incorrectButton.isHidden = true
        self.correctButton.isHidden = true
        checkLabel.isHidden = false
        showingTranslation = false
    }
    
    @objc func handleTap() {
        if showingTranslation! {
            wordLabel.text = userCards[currentId].word
            showingTranslation = false
            checkLabel.isHidden = false
        }
        else {
            wordLabel.text = userCards[currentId].translation
            UIView.transition(with: incorrectButton, duration: 1,
                              options: .transitionCrossDissolve,
                              animations: { [self] in
                self.incorrectButton.isHidden = false
            })
            UIView.transition(with: correctButton, duration: 1,
                              options: .transitionCrossDissolve,
                              animations: {
                self.correctButton.isHidden = false
            })
            
            checkLabel.isHidden = true
            showingTranslation = true
        }
        CardsView.transition(with: cardView, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    @IBAction func incorrectButtonDidTap(_ sender: Any) {
        countIncorrect+=1
        
        incorrectWords.append(userCards[currentId].word)
        if currentId == userCards.count-1 {
            showStatistic()
        }
        else { handleSwipe() }
        
    }
    
    @IBAction func correctButtonDidTap(_ sender: Any) {
        countCorrect+=1
        if currentId == userCards.count-1 {
            showStatistic()
        }
        else { handleSwipe() }
        
    }
    
    func showStatistic() {
        againButton.isHidden = false
        guard let statiscticsVC = storyboard?.instantiateViewController(withIdentifier: "StatisticViewController") as? StatisticViewController else {return}
        statiscticsVC.incorrectWords = incorrectWords
        statiscticsVC.countIncorrect = countIncorrect
        statiscticsVC.countCorrect = countCorrect
        present(statiscticsVC, animated: true)
    }
    
    @IBAction func againButtonDidTap(_ sender: Any) {
        self.viewDidLoad()
    }
}
