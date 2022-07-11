//
//  RepetitionWordsViewController.swift
//  project
//
//  Created by user on 09.07.2022.
//

import UIKit
import Foundation





class RepetitionWordsViewController: UIViewController {
    var categoryIndex: Int?
    private var currentId = 0
    private var offset = CGSize.zero
    private  var showingTranslation = false
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
        
    }
    
//    func setData<T: Encodable>(customData: T, key: String) {
//        do {
//            // Create JSON Encoder
//            let encoder = JSONEncoder()
//
//            // Encode Note
//            let data = try encoder.encode(customData)
//
//            // Write/Set Data
//            UserDefaults.standard.set(data, forKey: key)
//
//        } catch {
//            print("Unable to Encode Note (\(error))")
//        }
//    }
//
//    func getData<T: Decodable>(customData: T, key: String) -> T? {
//        if let data = UserDefaults.standard.data(forKey: key) {
//            do {
//                // Create JSON Decoder
//                let decoder = JSONDecoder()
//
//                // Decode Note
//                let userData = try decoder.decode(T.self, from: data)
//                return userData
//            } catch {
//                print("Unable to Decode Note (\(error))")
//            }
//        }
//        return nil
//    }
    
    
    @objc func handleSwipe() {
        let duration = 1.0
        let previousFrame = self.cardView.frame
        UIView.animate(withDuration: duration, animations: {
            self.cardView.transform = CGAffineTransform(translationX: -self.cardView.frame.width * 2 , y: 0)
        }
        )
        
        cardView.frame = previousFrame
        showingTranslation = false
        currentId+=1
        
        wordLabel.text = userCards[currentId].word
        cardNumberLabel.text = "\(currentId+1)/\(userCards.count)"
        
        self.incorrectButton.isHidden = true
        self.correctButton.isHidden = true
        
    }
    
    @objc func handleTap() {
        if showingTranslation {
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
            
            showingTranslation = true
            checkLabel.isHidden = true
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
