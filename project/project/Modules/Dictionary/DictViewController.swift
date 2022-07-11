//
//  DictViewController.swift
//  project
//
//  Created by Тимур Хайруллин on 08.07.2022.
//

import UIKit

class DictViewController: UIViewController{
    
    let userDefaults = UserDefaults.standard
    
    struct Screen {
        var name: String
        var subject: String
    }

    class DictModel {
        var screens = [Screen]()
        var screensFiltered = [Screen]()
        
        init() {
            setup()
        }
        func addNewWord() {
            let word = Screen(name: "Новое слово", subject: "Перевод")
            screens.insert(word, at: 0)
        }
        func filterWords(text: String) {
            screensFiltered.removeAll()
            
            screensFiltered = screens.filter({ (screen) -> Bool in
                return screen.name.lowercased().contains(text.lowercased())
            })
        }
        func setup() {
            let names = ["abandon", "abate", "abduct", "abide", "able"]
            let subjects = ["оставить", "ослабевать", "похищать", "смириться", "способный"]
            
            for number in 0..<names.count {
                let screen = Screen(name: names[number], subject: subjects[number])
                screens.append(screen)
                    
            }
        }
    
//        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//            let myDel = UIContextualAction(style: .destructive, title: nil) {(myDel, _, complitionHand) in
//                self.screens.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                complitionHand(true)
//                myDel.backgroundColor = .red
//            }
//            return UISwipeActionsConfiguration(actions: [myDel])
//        }
    
}
    var search = UISearchController()
    let idCell = "Dict"
    var model = DictModel()
    
    @IBOutlet weak var tableView:
        UITableView!
    
    
    
    
    override func viewDidLoad() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.89, green: 0.95, blue: 0.96, alpha: 1.00)
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
//        tableView.isEditing = true
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self as! UISearchResultsUpdating
        self.navigationItem.searchController = search
        
//        let btnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
//        navigationItem.leftBarButtonItem = btnAdd
    }
//    @objc func addWord() {
//
//        tableView.performBatchUpdates( {
//            self.model.addNewWord()
//            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        }) {(result) in
//            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
//        }

        
    }
    
  // End class DictViewController




extension UIViewController{
    func centerTitle(){
        for navItem in(self.navigationController?.navigationBar.subviews)! {
             for itemSubView in navItem.subviews {
                 if let largeLabel = itemSubView as? UILabel {
                    largeLabel.center = CGPoint(x: navItem.bounds.width/2, y: navItem.bounds.height/2)
                    return;
                 }
             }
        }
    }
}
extension DictViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch() {
            return model.screensFiltered.count
        }
        return model.screens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! DictTableViewCell
        var screen:Screen
        if isSearch() {
            screen = model.screensFiltered[indexPath.row]
        } else {
            screen = model.screens[indexPath.row]
        }
        cell.firstLabel.text = screen.name
        cell.secondLabel.text = screen.subject
//        cell.wordLabel.text = "Word"
//        cell.translateLabel.text = "Translate"
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObjTemp = model.screens[sourceIndexPath.item]
        model.screens.remove(at: sourceIndexPath.item)
        model.screens.insert(moveObjTemp, at: destinationIndexPath.item)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            model.screens.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func searchBarIsEmpty() -> Bool {
        return search.searchBar.text?.isEmpty ?? true
    }
    func isSearch() -> Bool {
        return search.isActive && !searchBarIsEmpty()
    }
    func filterSearchWords(text:String) {
        model.filterWords(text: text)
        tableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Yeah")
//    }
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Готово" : "Изменить"
    }
    
    
}
extension DictViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterSearchWords(text:searchController.searchBar.text!)
    
    }
}


    
