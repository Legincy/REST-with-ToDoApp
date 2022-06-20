//
//  AddUpdateTodo.swift
//  Todo-App
//
//  Created by Martin Peth on 20.06.22.
//

import SwiftUI

struct AddUpdateTodo: View {
    @ObservedObject
    var viewModel: AddUpdateTodoViewModel
    
    @Environment(\.presentationMode) var viewMode
    
    var body: some View {
        VStack{
            TextField("Titel", text: $viewModel.todoTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Beschreibung", text: $viewModel.todoDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button{
                viewModel.addUpdateAction {
                    viewMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonText)
            }
        }
    }
}

struct AddUpdateTodo_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateTodo(viewModel: AddUpdateTodoViewModel())
    }
}
