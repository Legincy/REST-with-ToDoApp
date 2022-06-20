//
//  CreateTodo.swift
//  
//
//  Created by Martin Peth on 20.06.22.
//

import Fluent

struct CreateTodo: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todo")
            .id()
            .field("title", .string, .required)
            .field("description", .string)
            .field("created_at", .datetime)
            .field("completed_at", .datetime)
            .field("modified_at", .datetime)
            //.sql(.default("Your default value"))
            .field("deleted", .bool)
            .field("completed", .bool)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todo").delete()
        //
    }
}
