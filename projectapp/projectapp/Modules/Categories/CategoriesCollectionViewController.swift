//
//  CategoriesCollectionViewController.swift
//  project
//
//  Created by Rafael Shamsutdinov on 07.07.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCollectionViewController: UICollectionViewController {
    @IBOutlet weak var addItem: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    var newCategoryName: String = ""
    @IBAction func cancel(segue:UIStoryboardSegue) {
    }
    @IBAction func done(segue:UIStoryboardSegue) {
        let NewCategoryViewController = segue.source as! NewCategoryViewController
        newCategoryName = NewCategoryViewController.newCategory
        DataBase.addCategory(newCategoryName)
        listOfCategories = DataBase.getCategories()
        collectionView.reloadData()
        
    }
    @IBAction func deleteItem(_ sender: Any) {
        if let selectedCells = collectionView.indexPathsForSelectedItems {
              let items = selectedCells.map { $0.item }.sorted().reversed()
              for item in items {
                  DataBase.removeCategory(item)
                  listOfCategories = DataBase.getCategories()
              }
              collectionView.deleteItems(at: selectedCells)
              deleteButton.isEnabled = false
            }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CellWordsViewCell
            cell.isInEditingMode = editing
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            deleteButton.isEnabled = false
            let storyboard = UIStoryboard(name: "DictionaryStoryboard", bundle: nil)
            guard let DictTableVC = storyboard.instantiateViewController(
                withIdentifier: "DictViewController"
            ) as? DictViewController else { return }
            print(indexPath.item)
            DictTableVC.categoryIndex = indexPath.item
            print(1)
            navigationController?.pushViewController(DictTableVC, animated: true)
        } else {
            deleteButton.isEnabled = true
        }

    }
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count == 0 {
            deleteButton.isEnabled = false
        
        }
    }
    var listOfCategories = DataBase.getCategories()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.89, green: 0.95, blue: 0.96, alpha: 1.00)
        navigationController?.navigationBar.layer.cornerRadius = 20
        }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    @IBAction func addItemDidTap(_ sender: Any) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfCategories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellWordsViewCell", for: indexPath) as? CellWordsViewCell else { return UICollectionViewCell()}
        cell.nameLabel.text = listOfCategories[indexPath.row].categoryName
        cell.wordsAmount.text = String(listOfCategories[indexPath.row].words.count)
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.isInEditingMode = isEditing
        return cell
    }
}

    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */




