//
//  ViewController.swift
//  p5m3_9.1
//
//  Created by Amina TomasMart on 22.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let fbManager = FBManager()
    private let ext = MyExtensions()
    lazy var exitBtn = ext.createButton(title: "Выход", action: exitBtnAction, tag: 3)
    
    lazy var exitBtnAction = UIAction(handler: { [weak self] _ in
        self?.fbManager.signInOut()
        NotificationCenter.default.post(name: NSNotification.Name("changeVC"), object: nil, userInfo: ["isLogin": false])
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(exitBtn)
        addConstraints()
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            
            exitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exitBtn.heightAnchor.constraint(equalToConstant: 50),
            exitBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

