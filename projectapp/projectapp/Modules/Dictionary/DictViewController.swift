//
//  DictViewController.swift
//  project
//
//  Created by Тимур Хайруллин on 08.07.2022.
//

import UIKit

class DictViewController: UIViewController{
    var categoryIndex: Int?
    let userDefaults = UserDefaults.standard

    class DictModel {
        var screens = [Card]()
        var screensFiltered = [Card]()
        init(categoryIndex: Int) {
            screens = DataBase.getWords(categoryIndex)
        }
        func addNewWord() {
        }
        func filterWords(text: String) {
            screensFiltered.removeAll()
            
            screensFiltered = screens.filter({ (screen) -> Bool in
                return screen.word.lowercased().contains(text.lowercased())
            })
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
    

    var search = UISearchController()
    let idCell = "Dict"
    lazy var model = DictModel(categoryIndex: categoryIndex!)
    
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
    override func viewWillAppear(_ animated: Bool) {
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
        tableView.reloadData()
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

        
    
  // End class DictViewController
}



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
        var screen:Card
        if isSearch() {
            screen = model.screensFiltered[indexPath.row]
        } else {
            screen = model.screens[indexPath.row]
        }
        cell.firstLabel.text = screen.word
        cell.secondLabel.text = screen.translation
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
            DataBase.removeWord(categoryIndex!, wordIndex: indexPath.item)
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
    @IBAction func addWordScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddWords", bundle: nil)
        guard let AddWordsVC = storyboard.instantiateViewController(
            withIdentifier: "AddWordsViewController"
        ) as? AddWordsViewController else { return }
        AddWordsVC.categoryIndex = self.categoryIndex
        navigationController?.pushViewController(AddWordsVC, animated: true)

    }
    @IBAction func learnScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LearningStoryboard", bundle: nil)
        guard let LearningVC = storyboard.instantiateViewController(
            withIdentifier: "LearningWordsViewController"
        ) as? LearningWordsViewController else { return }
        print(categoryIndex!)
        print("test")
        LearningVC.categoryIndex = self.categoryIndex
        navigationController?.pushViewController(LearningVC, animated: true)
    }
    @IBAction func repeatScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LearningStoryboard", bundle: nil)
        guard let LearningVC = storyboard.instantiateViewController(
            withIdentifier: "RepetitionWordsViewController"
        ) as? RepetitionWordsViewController else { return }
        print(categoryIndex!)
        LearningVC.categoryIndex = self.categoryIndex
        navigationController?.pushViewController(LearningVC, animated: true)
    }
    
}
extension DictViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterSearchWords(text:searchController.searchBar.text!)
    
    }
}


    
