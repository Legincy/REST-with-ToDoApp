//
//  Todo.swift
//  Todo-App
//
//  Created by Martin Peth on 20.06.22.
//

import Foundation

struct Todo: Identifiable, Codable {
    let id: UUID?
    var title: String
    var description: String
    var deleted: Bool
    var completed: Bool
    let creationDate: String?
    let completionDate: String?
    let modificationDate: String?
}
