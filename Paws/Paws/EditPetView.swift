//
//  EditPetView.swift
//  Paws
//
//  Created by Dhruv Patel on 29/05/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var pet: Pet
    @State private var photosPicketItem:PhotosPickerItem?
    
    var body: some View {
        Form {
            // MARK: - PhotosPicker
            PhotosPicker(selection:$photosPicketItem,matching: .images){
                Label("Select a Photo", systemImage: "photo.badge.plus")
                    .frame(minWidth: 0,maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)
            
            // MARK: - IMAGE
            if let imageData = pet.photo {
                if let petImage = UIImage(data: imageData) {
                    Image(uiImage: petImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                        .frame(minWidth:0,maxWidth:.infinity,minHeight: 0,maxHeight: 300)
                        .padding(.top)
                }
            } else {
                CustomContentUnavailableView(icon: "pawprint.circle",
                                             title: "No Photo", description: "Add a photo of your favourite pet to make it easier to find them.")
                .padding(.top)
            }
            // MARK: - Text Field
            TextField("Name",text: $pet.name)
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle.weight(.light))
                .padding(.vertical)
            
            // MARK: - Button
            Button {
                dismiss()
            } label: {
                Text("Save")
                    .font(.title3.weight(.medium))
                    .padding(8)
                    .frame(minWidth: 0,maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
            .padding(.bottom)
        } // MARK: FORM
        
        .listStyle(.plain)
        .navigationTitle("Edit \(pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onChange(of: photosPicketItem){
            Task {
                pet.photo = try? await photosPicketItem?.loadTransferable(type: Data.self)
            }
        }
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
