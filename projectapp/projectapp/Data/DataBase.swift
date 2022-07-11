//
//  DataBase.swift
//  project
//
//  Created by Rafael Shamsutdinov on 10.07.2022.
////
//
import UIKit

struct Category: Encodable, Decodable{
    var words: [Card] //Example of word: Ball-Мяч Category(words:[Card(word:"Ball", translation:"Мяч")
    var categoryName: String
}
struct Card: Codable {
    let word: String
    let translation: String
}
let cards = [Card(word: "Carpet", translation: "Ковёр"),
             Card(word: "Phone", translation: "Телефон"),
             Card(word: "Deal", translation: "Договорились!"),
             Card(word: "To go nuts", translation: "Сходить с ума"),
             Card(word: "I'll be back", translation: "Я вернусь"),
             Card(word: "I bet", translation: "Держу пари"),
             Card(word: "Awe", translation: "Трепет")]
class DataBase {
    private static var category = Category(words: cards, categoryName: "Basic")
    private static var listCategories: [Category] = []
    private static let userDefaults = UserDefaults.standard
    static func save() {
        if let encoded = try? JSONEncoder().encode(DataBase.listCategories) {
            userDefaults.set(encoded, forKey: "listCat")
        }
    }
    static func check() {
        if let data = userDefaults.data(forKey: "listCat") {
            if let decoded = try? JSONDecoder().decode([Category].self, from:data) {
                listCategories = decoded
            }
        }
    }
    static func addCategory(_ category: String) {
        check()
        listCategories.append(Category(words: [], categoryName: category))
        save()
    }
    static func getCategories() -> [Category]{
        check()
        return listCategories
    }
    static func removeCategory(_ category: Int) {
        check()
        listCategories.remove(at: category)
        save()
    }
    static func getWords(_ index: Int) -> [Card] {
        check()
        return listCategories[index].words
    }
    static func addWord(_ index: Int, card: Card){
        check()
        listCategories[index].words.append(card)
        save()
    }
    static func removeWord(_ categoryIndex: Int, wordIndex: Int){
        check()
        print(listCategories[categoryIndex].words.count)
        listCategories[categoryIndex].words.remove(at: wordIndex)
        save()
        }
    }   // [Category(words: [Card(word: "sss", translation: "ss"),Card(word: "sss", translation: "ss"), categoryName: "name"]


