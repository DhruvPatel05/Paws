//
//  ContentView.swift
//  Paws
//
//  Created by Dhruv Patel on 29/05/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var pets: [Pet]
    
    let layout = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120))
        
    ]
    func addPet() {
        let pet = Pet(name: "Basic Friend")
        modelContext.insert(pet)
    }

    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVGrid(columns: layout){
                    GridRow {
                        ForEach(pets) { pet in
                            NavigationLink(destination:EmptyView()) {
                                VStack {
                                    if let imagedata = pet.photo {
                                        if let petImage = UIImage(data: imagedata) {
                                Image(uiImage: petImage)
                                            
                                        }
                                        
                                    } else {
                                      Image(systemName: "pawprint.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(40)
                                            .foregroundStyle(.quaternary)
                                    }
                                    Spacer()
                                    Text(pet.name)
                                        .font(.title.weight(.light))
                                        .padding(.vertical)
                                    Spacer()
                                }//: VStack
                                .frame(minWidth: 0,maxWidth: .infinity,minHeight:0,maxHeight:.infinity)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8,style:.circular))
                            }
                            .foregroundStyle(.primary)
                        }//:Loop
                    }//:Grid Row
                }//:Grid layout
                .padding(.horizontal)
            }// Scrollview
            .navigationTitle(pets.isEmpty ? "" : "Paws")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add a New Pet", systemImage:"plus.circle",action: addPet)
                }
                
            }
            .overlay {
                if pets.isEmpty {
                    CustomContentUnavailableView(icon:"dog.circle",title: "No Pets",description: "Add a new pet to get started.")
                }
            }
        }
    }
}

#Preview ("Sample Data") {
    ContentView()
        .modelContainer(Pet.preview)
}

#Preview ("No Data"){
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}

