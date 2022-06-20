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
    var title: String?
    
    @Field(key: "description")
    var description: String?
    
    @Timestamp(key: "created_at", on: .create)
    var creationDate: Date?
    
    @Timestamp(key: "modified_at", on: .update)
    var modificationDate: Date?
    
    @Field(key: "completed_at")
    var completionDate: Date?
    
    @Field(key: "deleted")
    var deleted: Bool?
    
    @Field(key: "completed")
    var completed: Bool?

    init() {}

    init(id: UUID? = nil, title: String, description: String, deleted: Bool, completed: Bool){
        self.id = id
        self.title = title
        self.description = description
        self.deleted = deleted
        self.completed = completed
    }
}
