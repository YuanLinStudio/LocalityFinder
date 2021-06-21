//
//  DropdownIndicator.swift
//  
//
//  Created by 袁林 on 2021/6/21.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
struct DropdownIndicator: View {
    
    var isActive: Bool
    
    var body: some View {
        Text(Image(systemName: isActive ? "chevron.up" : "chevron.down"))
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundColor(.secondary)
            .opacity(0.5)
        // .frame(width: 10)
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct DropdownIndicator_Previews: PreviewProvider {
    static var previews: some View {
        DropdownIndicator(isActive: true)
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
        
        DropdownIndicator(isActive: false)
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
