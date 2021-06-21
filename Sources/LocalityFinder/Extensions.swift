//
//  Extensions.swift
//  
//
//  Created by 袁林 on 2021/6/21.
//

import Foundation
import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .hidden(when: true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .hidden(when: true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func hidden(when hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    /// Remove or show the view based on a boolean value.
    @ViewBuilder func removed(when removed: Bool) -> some View {
        if !removed {
            self
        }
    }
    
    /// Remove or show the view based on a boolean value.
    @ViewBuilder func display(onlyWhen display: Bool) -> some View {
        if display {
            self
        }
    }
    
    @ViewBuilder func disabled(when disabled: Bool) -> some View {
        self.disabled(disabled)
    }
}
