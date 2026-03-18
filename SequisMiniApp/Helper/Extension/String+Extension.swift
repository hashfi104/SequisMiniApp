//
//  String+Extension.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/18/26.
//

extension String {
    func getInitial() -> String {
        let components = split(separator: " ").map { String($0) }
        let firstWord = components.first?.capitalized ?? ""
        let lastWord = components.last?.capitalized ?? ""
        return "\(String(firstWord.first ?? Character("")))\(String(lastWord.first ?? Character("")))"
    }
}
