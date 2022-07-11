//
//  SettingsViewController.swift
//  project
//
//  Created by elya on 07.07.2022.
//
import UIKit
import MessageUI

class SettingsViewController: UIViewController {
        
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var termsOfUseButton: UIButton!
    @IBOutlet weak var supportButton: UIButton!
    @IBOutlet weak var howToUseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func privacyPolicyButtonDidTap(_ sender: Any) {
        print("privacyPolicyButtonDidTap")
        guard let privacyPolicyVC = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") else { return }
        present(privacyPolicyVC, animated: true)
    }
    
    @IBAction func termsOfUseButtonDidTap(_ sender: Any) {
        print("termsOfUseButtonDidTap")
        guard let termsOfUseVC = storyboard?.instantiateViewController(withIdentifier: "TermsOfUseViewController") else { return }
        present(termsOfUseVC, animated: true)
    }
    
    @IBAction func supportButtonDidTap(_ sender: Any) {
        print("supportButtonDidTap")
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let supportVC = MFMailComposeViewController()
        
        // делегатор
        supportVC.mailComposeDelegate = self
        // получатели
        supportVC.setToRecipients(["team4@gmail.com"])

        present(supportVC, animated: true)
    }

}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            break
        case .failed:
            break
        case .saved:
            break
        case .sent:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
}

