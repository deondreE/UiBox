//
//  Form.swift
//
//
//  Created by Deondre English on 1/4/24.
//
import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
public struct FormInput: View {
    private var placeholder: String
    @Binding var inputValue: String
        
    public init(placeholder: String, inputValue: Binding<String>) {
        self.placeholder = placeholder
        self._inputValue = inputValue
    }
    
     public var body: some View {
         TextField(placeholder, text: $inputValue)
            .disableAutocorrection(true)
            .border(Color.gray)
            .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black)
                        .stroke(Color.gray, lineWidth: 1)
            )
    }
}

@available(iOS 17.0, macOS 14.0, *)
public struct FormPassword: View {
    @Binding var passwordValue: String
        
    public init(passwordValue: Binding<String>) {
        self._passwordValue = passwordValue
    }
    
    public var body: some View {
        SecureField("test", text: $passwordValue, prompt: Text("Password"))
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

@available(iOS 17.0, macOS 14.0, *)
public struct Checkbox: View {
    @Binding private var checked: Bool
    
    public init(checked: Binding<Bool>) {
        self._checked = checked
    }
    
    public var body: some View {
        Toggle("Testing Toggle", isOn: $checked)
    }
}
