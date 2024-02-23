//
//  FBmanager.swift
//  p5m3_9.1
//
//  Created by Amina TomasMart on 22.02.2024.
//
import Foundation
import Firebase

class FBManager {
    
    func checkAuth() -> Bool {
        guard let currentUser = Auth.auth().currentUser else {return false}
        return true
    }
    
    func createNewUser(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                print(error!.localizedDescription)
                
                let locError = error as? NSError
                print(locError?.code ?? "")
                
                completion(false)
                return
            }
            
            result?.user.sendEmailVerification()
            completion(true)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                print(error!.localizedDescription)
                
                let locError = error as? NSError
                print(locError?.code ?? "")
                
                completion(false)
                return
            }
            
            if let verify = result?.user.isEmailVerified {
                self!.checkAuth()
                completion(true)
            } else {
                
            }
        }
    }
    
    func signInOut() {
        try? Auth.auth().signOut()
    }
}

