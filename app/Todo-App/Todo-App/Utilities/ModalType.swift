//
//  ModalType.swift
//  Todo-App
//
//  Created by Martin Peth on 20.06.22.
//

import Foundation

enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    
    case add
    case update(Todo)
}
