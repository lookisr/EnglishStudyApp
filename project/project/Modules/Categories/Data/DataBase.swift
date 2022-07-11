//
//  DataBase.swift
//  project
//
//  Created by Rafael Shamsutdinov on 10.07.2022.
////
//
//import UIKit
//
//class DataBase {
//    private static var listCategories: [Category] = []
//    private static let userDefaults = UserDefaults.standard
//    static func save() {
//        if let encoded = try? JSONEncoder().encode(DataBase.listCategories) {
//            userDefaults.set(encoded, forKey: "listCat")
//        }
//    }
//    static func check() {
//        if let data = userDefaults.data(forKey: "listCat") {
//            if let decoded = try? JSONDecoder().decode([Category].self, from:data) {
//                listCategories = decoded
//            }
//        }
//    }
//    static func addCategory(_ category: String) {
//        check()
//        listCategories.append(Category(words: [], categoryName: category))
//        save()
//    }
//    struct Category: Encodable, Decodable{
//        var words: [String] //Example of word: Ball-Мяч
//        var categoryName: String
//    }
//}
