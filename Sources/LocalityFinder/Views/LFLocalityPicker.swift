//
//  LFLocalityPicker.swift
//  
//
//  Created by 袁林 on 2021/6/21.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct LFLocalityPicker: View {
    public init(title: LocalizedStringKey, locality: Binding<LFLocality>) {
        self.title = title
        self._locality = locality
    }
    
    public init(title: LocalizedStringKey, locality: Binding<LFLocality>, isActive: State<Bool>) {
        self.title = title
        self._locality = locality
        self._isActive = isActive
    }
    
    public let title: LocalizedStringKey
    @Binding public var locality: LFLocality
    @State public var isActive: Bool = false
    
    @StateObject var viewModel = LFLocalityPickerViewModel()
    
    public var body: some View {
        Button(action: edit) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                Text(locality.formattedAddress)
                    .foregroundColor(.secondary)
                    .display(onlyWhen: viewModel.displayLevel == .inactive)
                DropdownIndicator(isActive: viewModel.displayLevel.isActive)
            }
        }
        .onAppear {
            viewModel.district = locality
        }
        .onChange(of: viewModel.displayLevel.isActive) { value in
            isActive = value
        }
        
        if viewModel.displayLevel.isActive {
            LFLocalityPickerRow(viewModel: viewModel, title: "province", level: .province, source: viewModel.localitiesDictionary, selected: $viewModel.province)
            LFLocalityPickerRow(viewModel: viewModel, title: "city", level: .city, source: viewModel.province, selected: $viewModel.city)
            LFLocalityPickerRow(viewModel: viewModel, title: "district", level: .district, source: viewModel.city, selected: $viewModel.district)
            Button("done", action: edit)
        }
    }
    
    func edit() {
        withAnimation {
            if viewModel.displayLevel.isActive {
                locality = viewModel.district
            }
            viewModel.displayLevel.isActive.toggle()
        }
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct LFLocalityPicker_Previews: PreviewProvider {
    static var previews: some View {
        let localitiesDictionary = LFFinder().localitiesDictionary
        
        NavigationView {
            Form {
                Section {
                    LFLocalityPicker(title: "locality", locality: .constant(localitiesDictionary["河南省"]!["郑州市"]!["上街区"]!))
                }
            }
            .navigationTitle("locality")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
