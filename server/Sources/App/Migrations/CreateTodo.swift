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
            .field("creation_date", .datetime)
            .field("completion_date", .datetime)
            .field("modification_date", .datetime, .required)
            .field("deleted", .bool, .sql(.default(false)))
            .field("completed", .bool, .sql(.default(false)))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todo").delete()
        //
    }
}
