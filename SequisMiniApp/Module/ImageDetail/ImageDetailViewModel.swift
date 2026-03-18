//
//  ImageDetailViewModel.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/18/26.
//

import Foundation

struct ImageDetailViewModel {
    private var firstNames: [String] {
        if let url = Bundle.main.url(forResource: "firstNames", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            do {
                let stringArray = try JSONDecoder().decode([String].self, from: data)
                return stringArray
            } catch {
                return []
            }
        }
        return []
    }

    private var lastNames: [String] {
        if let url = Bundle.main.url(forResource: "lastNames", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            do {
                let stringArray = try JSONDecoder().decode([String].self, from: data)
                return stringArray
            } catch {
                return []
            }
        }
        return []
    }

    private var nouns: [String] {
        if let url = Bundle.main.url(forResource: "nouns", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            do {
                let stringArray = try JSONDecoder().decode([String].self, from: data)
                return stringArray
            } catch {
                return []
            }
        }
        return []
    }

    private var verbs: [String] {
        if let url = Bundle.main.url(forResource: "verbs", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            do {
                let stringArray = try JSONDecoder().decode([String].self, from: data)
                return stringArray
            } catch {
                return []
            }
        }
        return []
    }

    var generatedRandomNames: String {
        if let firstName = firstNames.randomElement(), let lastName = lastNames.randomElement() {
            return "\(firstName) \(lastName)"
        }
        return ""
    }

    var generatedRandomComments: String {
        let randomNouns = Array(nouns.shuffled().prefix(3))
        let randomVerbs = Array(verbs.shuffled().prefix(3))
        return zip(randomNouns, randomVerbs)
            .map { "\($0.0) \($0.1)" } // Combine each pair with a space
            .joined(separator: " ")
    }
}
