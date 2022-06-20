//
//  Todo.swift
//  
//
//  Created by Martin Peth on 20.06.22.
//

import Fluent
import Vapor

final class Todo: Model, Content {
    static let schema = "todo"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "creation_date")
    var creationDate: Date
    
    @Field(key: "modification_date")
    var modificationDate: Date
    
    @Field(key: "completion_date")
    var completionDate: Date
    
    @Field(key: "deleted")
    var deleted: Bool
    
    @Field(key: "completed")
    var completed: Bool

    init() {}

    init(id: UUID? = nil, title: String, description: String, completed: Bool = false, deleted: Bool = false){
        self.id = id
        self.title = title
        self.description = description
        self.completed = completed
        self.deleted = deleted
    }
}
