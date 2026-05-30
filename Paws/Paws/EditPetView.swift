//
//  EditPetView.swift
//  Paws
//
//  Created by Dhruv Patel on 29/05/26.
//

import SwiftUI
import SwiftData

struct EditPetView: View {
    @Bindable var pet: Pet
    var body: some View {
        Form {
            // MARK: - IMAGE
            
            // MARK: - Photo Picker
        }
        .listStyle(.plain)
        .navigationTitle("Edit \(pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    NavigationStack {
        do {
            let configuraion = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Pet.self, configurations:configuraion)
            let sampleData = Pet(name: "Daisy")
            
            return EditPetView(pet:sampleData)
                .modelContainer(container)
        } catch {
            fatalError("Could not load preview data. \(error.localizedDescription)")
        }
    }
}
