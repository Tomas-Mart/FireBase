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
    lazy var nameTextField = ext.createTextField(placeholder: "Name")
    lazy var surnameTextField = ext.createTextField(placeholder: "Surname")
    lazy var emailTextField = ext.createTextField(placeholder: "Email")
    lazy var passwordTextField = ext.createTextField(placeholder: "Password", isPassword: true)
    lazy var entrBtn = ext.createButton(title: "Вход", action: entrBtnAction, tag: 1)
    lazy var regBtn = ext.createButton(title: "Регистрация", action: regBtnAction, tag: 2)
    
    lazy var datePicker: UIDatePicker = {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.maximumDate = Date()
        $0.center.x = view.center.x
        $0.center.y = view.center.y
        return $0
    }(UIDatePicker())
    
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
            guard let self = self else {return}
            let userData = UserData(name: self.nameTextField.text ?? "",
                                    surname: self.surnameTextField.text ?? "",
                                    birthDate: self.datePicker.date,
                                    email: self.emailTextField.text ?? "",
                                    password: self.passwordTextField.text ?? "")
            
            self.fbManager.createNewUser(userData: userData, completion: { result in
                switch result {
                    
                case .success(let isReg):
                    if isReg {
                        NotificationCenter.default.post(name: NSNotification.Name("changeVC"), object: nil, userInfo: ["isLogin": true])
                    } else {
                        print("Не удалось добавить данные")
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            })
        })
    }
        
        func addSubview() {
            view.addSubview(nameTextField)
            view.addSubview(surnameTextField)
            view.addSubview(emailTextField)
            view.addSubview(passwordTextField)
            view.addSubview(datePicker)
            view.addSubview(entrBtn)
            view.addSubview(regBtn)
        }
        
        func addConstraints() {
            
            NSLayoutConstraint.activate([
                
                nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                nameTextField.heightAnchor.constraint(equalToConstant: 40),
                
                surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
                surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                surnameTextField.heightAnchor.constraint(equalToConstant: 40),
                
                emailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 10),
                emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                emailTextField.heightAnchor.constraint(equalToConstant: 40),
                
                passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
                passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                passwordTextField.heightAnchor.constraint(equalToConstant: 40),
                
                entrBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                entrBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                entrBtn.heightAnchor.constraint(equalToConstant: 40),
                
                regBtn.topAnchor.constraint(equalTo: entrBtn.bottomAnchor, constant: 10),
                regBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                regBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                regBtn.heightAnchor.constraint(equalToConstant: 40),
                regBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
