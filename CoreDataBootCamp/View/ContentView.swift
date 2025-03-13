//
//  ContentView.swift
//  CoreDataBootCamp
//
//  Created by Gina Saviano on 13/03/25.
//

import SwiftUI

struct ContentView: View {
    //here we are initializing the variable which will call all the properties and method of the CoreDataVM
    @StateObject var coreDataVM = CoreDataViewModel()
    @State var textFieldText: String = "" //for the binded text inside the TextField
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20) {
                TextField("Add your fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else { return }
                    coreDataVM.addFruit(nameText: textFieldText)
                    ///we are call the function `addFruit` thanks to the variable we setted up before
                    textFieldText = ""
                } label: {
                    Text("Add")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                }
                .padding(.horizontal)

                
                Spacer()
                
                List {
                    ForEach(coreDataVM.savedEntities) { entity in
                        Text(entity.name ?? "No name, man!" )
                            .onTapGesture {
                                coreDataVM.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: coreDataVM.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
        
    }
}

#Preview {
    ContentView()
}
