//
//  LFLocalityPickerRow.swift
//  
//
//  Created by 袁林 on 2021/6/21.
//

import SwiftUI
import OrderedDictionary

@available(iOS 14.0, macOS 11.0, *)
struct LFLocalityPickerRow<T: Hashable>: View {
    
    @ObservedObject var viewModel: LFLocalityPickerViewModel
    
    let title: LocalizedStringKey
    let level: LFLocalityPickerViewModel.DisplayLevel
    let source: OrderedDictionary<String, T>
    
    @Binding var selected: T
    
    @State private var shouldShowPicker: Bool = false
    
    var body: some View {
        
        Button {
            withAnimation {
                if viewModel.displayLevel != level {
                    viewModel.displayLevel = level
                }
                else {
                    viewModel.displayLevel = .active
                }
            }
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                Text(source.first(where: { $1 == selected })!.key)
                    .foregroundColor(.secondary)
                DropdownIndicator(isActive: viewModel.displayLevel == level)
            }
        }
        .onReceive(viewModel.$displayLevel) { displayLevel in
            withAnimation {
                shouldShowPicker = displayLevel == level
            }
        }
        
        Picker(title, selection: $selected) {
            ForEach(source.orderedKeys, id: \.self) { key in
                Text(key).tag(source[key]!)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .display(onlyWhen: shouldShowPicker)
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct LFLocalityPickerRow_Previews: PreviewProvider {
    static var previews: some View {
        let localitiesDictionary = LFFinder().localitiesDictionary
        
        LFLocalityPickerRow(viewModel: .init(), title: "district", level: .district, source: localitiesDictionary["河南省"]!["郑州市"]!, selected: .constant(localitiesDictionary["河南省"]!["郑州市"]!["上街区"]!))
    }
}
