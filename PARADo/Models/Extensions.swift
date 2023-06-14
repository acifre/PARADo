//
//  Extensions.swift
//  PARADo
//
//  Created by Anthony Cifre on 6/11/23.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }


        func navigationBarTitleTextColor(_ color: Color) -> some View {
            let uiColor = UIColor(color)

            // Set appearance for both normal and large sizes.
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]

            return self
        }
    }
#endif

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T> {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
