//
//  LearningWordsViewController.swift
//  project
//
//  Created by user on 09.07.2022.
//

import UIKit

class LearningWordsViewController: UIViewController {
    
    private var currentId = 0
    private var offset = CGSize.zero
    private  var showingTranslation = false
    
    @IBOutlet weak var againButton: UIButton!
    
    @IBOutlet weak var cardView: CardsView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        if let userCards=getData(customData: cards, key: "cards") {
            wordLabel.text = userCards[currentId].word
            cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
        }
    }
    
    func getData<T: Decodable>(customData: T, key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let userData = try decoder.decode(T.self, from: data)
                return userData
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return nil
    }
    
    @objc func handleSwipe(_ gesture : UISwipeGestureRecognizer) {
        
        let duration = 1.0
        let direction = gesture.direction
        let previousFrame = self.cardView.frame
        
        if let userCards=getData(customData: cards, key: "cards") {
            if currentId == userCards.count-1 {
                againButton.isHidden = false
            }
            else {
                if direction == .left {
                    
                    UIView.animate(withDuration: duration, animations: {
                        self.cardView.transform = CGAffineTransform(translationX: -self.cardView.frame.width * 2 , y: 0)
                    }
                    )
                    
                    cardView.frame = previousFrame
                    showingTranslation = false
                    currentId+=1
                    
                    wordLabel.text = userCards[currentId].word
                    cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
                    
                }
                if direction == .right {
                    UIView.animate(withDuration: duration, animations: {
                        self.cardView.transform = CGAffineTransform(translationX: self.cardView.frame.width * 2, y: 0)
                    }
                    )
                    
                    cardView.frame = previousFrame
                    showingTranslation = false
                    currentId-=1
                    
                    wordLabel.text = userCards[currentId].word
                    cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
                }
            }
        }
    }
    
    @objc func handleTap() {
        let  userCards=getData(customData: cards, key: "cards")
        if showingTranslation {
            wordLabel.text = userCards?[currentId].word
            showingTranslation = false
            translateLabel.isHidden = false
        }
        else {
            wordLabel.text = userCards?[currentId].translation
            
            showingTranslation = true
            translateLabel.isHidden = true
        }
        CardsView.transition(with: cardView, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    
    @IBAction func againButtonDidTap(_ sender: Any) {
        self.viewDidLoad()
    }
}
