//
//  ContentView.swift
//  PhotoCameraPicker
//
//  Created by Eric on 27/05/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    @FocusState var nameField: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                if !vm.isEditing {
                    imageScroll
                }
                selectedImage
                VStack {
                    if vm.selectedImage != nil {
                      editGroup
                    }
                    pickerButtons
                }
                .padding()
                Spacer()
            }
            .task {
                if FileManager().docExist(named: fileName) {
                    vm.loadMyImagesJSONFile()
                }
            }
            .sheet(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
            }
            .alert("Error", isPresented: $vm.showFileAlert, presenting: vm.appError) { cameraError in
                cameraError.button
            } message: { cameraError in
                Text(cameraError.message)
            }
            .navigationTitle("My Images")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button {
                            nameField = false
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}

extension ContentView {
    var imageScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(vm.myImages) { myImage in
                    VStack {
                        Image(uiImage: myImage.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
                        Text(myImage.name)
                    }
                    .onTapGesture {
                        vm.display(myImage)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    var selectedImage: some View {
        Group {
            if let image = vm.image {
                ZoomableScrollView {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.horizontal)
            }
        }
    }
    
    var editGroup: some View {
        Group {
            TextField("Image Name", text: $vm.imageName) { isEditing in
                vm.isEditing = isEditing
            }
            .focused($nameField, equals: true)
            .textFieldStyle(.roundedBorder)
            HStack {
                Button {
                    if vm.selectedImage == nil {
                        vm.addMyImage(vm.imageName, image: vm.image!)
                    } else {
                        vm.updateSelected()
                        nameField = false
                    }
                } label: {
                    ButtonLabel(symbolName: vm.selectedImage == nil ? "square.and.arrow.down.fill" : "square.and.arrow.up.fill", label: vm.selectedImage == nil ? "Save" : "Update")
                }
                .disabled(vm.buttonDisabled)
                .opacity(vm.buttonDisabled ? 0.6 : 1)
                if !vm.deleteButtonIsHidden {
                    Button {
                        vm.deleteSelected()
                    } label: {
                        ButtonLabel(symbolName: "trash", label: "Delete")
                    }
                }
            }
        }
    }
    
    var pickerButtons: some View {
        HStack {
            Button {
                vm.source = .camera
                vm.showPhotoPicker()
            } label: {
                ButtonLabel(symbolName: "camera", label: "Camera")
            }
            .alert("Error", isPresented: $vm.showCameraAlert, presenting: vm.cameraError) { cameraError in
                cameraError.button
            } message: { cameraError in
                Text(cameraError.message)
            }
            Button {
                vm.source = .library
                vm.showPhotoPicker()
            } label: {
                ButtonLabel(symbolName: "photo", label: "Photo")
            }
        }
    }
}
