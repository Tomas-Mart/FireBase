//
//  LoginViewController.swift
//  p5m3_9.1
//
//  Created by Amina TomasMart on 22.02.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let fbManager = FBManager()
    private let ext = MyExtensions()
    lazy var emailTextField = ext.createTextField(placeholder: "Email")
    lazy var passwordTextField = ext.createTextField(placeholder: "Password", isPassword: true)
    lazy var entrBtn = ext.createButton(title: "Вход", action: entrBtnAction, tag: 1)
    lazy var regBtn = ext.createButton(title: "Регистрация", action: regBtnAction, tag: 2)
    
    var entrBtnAction: UIAction?
    var regBtnAction: UIAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        signIn()
        createNewUser()
        addSubview()
        addConstraints()
    }
    
    func signIn() {
        entrBtnAction = UIAction(handler: { [weak self] _ in
            self?.fbManager.signIn(email: self?.emailTextField.text ?? "",
                                   password: self?.passwordTextField.text ?? "") {
                isEntr in print(isEntr)
                if isEntr {
                    NotificationCenter.default.post(name: NSNotification.Name("changeVC"), object: nil, userInfo: ["isLogin": true])
                }
            }
        })
    }
    
    func createNewUser() {
        regBtnAction = UIAction(handler: { [weak self] _ in
            self?.fbManager.createNewUser(email: self?.emailTextField.text ?? "",
                                          password: self?.passwordTextField.text ?? "") {
                isReg in print(isReg)
                if isReg {
                    NotificationCenter.default.post(name: NSNotification.Name("changeVC"), object: nil, userInfo: ["isLogin": true])
                }
            }
        })
    }
    
    func addSubview() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(entrBtn)
        view.addSubview(regBtn)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            entrBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            entrBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            entrBtn.heightAnchor.constraint(equalToConstant: 50),
            
            regBtn.topAnchor.constraint(equalTo: entrBtn.bottomAnchor, constant: 20),
            regBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            regBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            regBtn.heightAnchor.constraint(equalToConstant: 50),
            regBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

