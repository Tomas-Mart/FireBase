//
//  MyExtensions.swift
//  p5m3_9.1
//
//  Created by Amina TomasMart on 23.02.2024.
//

import UIKit

class MyExtensions {
    
    private let fbManager = FBManager()
        
    func createButton(title: String, action: UIAction?, tag: Int) -> UIButton {
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .black)
        button.tag = tag
        return button
    }
    
    func createTextField(placeholder: String, isPassword: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = isPassword
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.backgroundColor = .white
        return textField
    }
}

