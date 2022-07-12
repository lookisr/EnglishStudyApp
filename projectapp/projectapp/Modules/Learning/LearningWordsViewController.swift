//
//  LearningWordsViewController.swift
//  project
//
//  Created by user on 09.07.2022.
//

import UIKit

class LearningWordsViewController: UIViewController {
    var previousFrame: CGRect?
    var categoryIndex: Int?
    private var currentId = 0
    private var offset = CGSize.zero
    private  var showingTranslation = false
    @IBOutlet weak var againButton: UIButton!
    lazy var userCards: [Card] = DataBase.getWords(categoryIndex!)
    @IBOutlet weak var cardView: CardsView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousFrame = self.cardView.frame
        currentId = 0
        offset = CGSize.zero
        showingTranslation = false
        againButton.isHidden = true
        cardView.dropShadow()

        let tap = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        
        let leftSlide = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_: )))
        
        let rightSlide = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_: )))
        leftSlide.direction = .left
        rightSlide.direction = .right
        
        cardView.addGestureRecognizer(tap)
        cardView.addGestureRecognizer(leftSlide)
        cardView.addGestureRecognizer(rightSlide)
        
        wordLabel.text = userCards[currentId].word
        cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
        
    }
    
    @objc func handleSwipe(_ gesture : UISwipeGestureRecognizer) {
        
        let direction = gesture.direction
        let previousFrame = self.cardView.frame
        
        if currentId == userCards.count-1 {
            againButton.isHidden = false
        }
        else {
            if direction == .left {
                
                UIView.animate(
                           withDuration: 1,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: {

                               self.cardView?.frame.origin.x = -self.previousFrame!.width*2

                       }) { (completed) in

                       }
                
                cardView.frame = previousFrame
                showingTranslation = false
                currentId+=1
                translateLabel.isHidden = false
                wordLabel.text = userCards[currentId].word
                cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
                
            }
            if direction == .right {
                
                UIView.animate(
                           withDuration: 1,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: {

                               self.cardView?.frame.origin.x = self.previousFrame!.width*2

                       }) { (completed) in

                       }
                
                cardView.frame = previousFrame
                showingTranslation = false
                currentId-=1
                translateLabel.isHidden = false
                wordLabel.text = userCards[currentId].word
                cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
            }
        }
        
    }
    
    @objc func handleTap() {
        if showingTranslation {
            wordLabel.text = userCards[currentId].word
            showingTranslation = false
            translateLabel.isHidden = false
        }
        else {
            wordLabel.text = userCards[currentId].translation
            
            showingTranslation = true
            translateLabel.isHidden = true
        }
        CardsView.transition(with: cardView, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    
    @IBAction func againButtonDidTap(_ sender: Any) {
        self.viewDidLoad()
    }
}
