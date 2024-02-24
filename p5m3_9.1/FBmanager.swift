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
    
    func createNewUser(userData: UserData, completion: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().createUser(withEmail: userData.email, password: userData.password) { [weak self] result, error in
            if error != nil {
                print(error!.localizedDescription)
                
                let locError = error as? NSError
                completion(.failure(error!))
                return
            }
            
            result?.user.sendEmailVerification()
            guard let uid = result?.user.uid else {return}
            self?.setUserData(uid: uid, userData: userData, completion: { isAdd in
                completion(.success(isAdd))
            })
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                
                let locError = error as? NSError
                print(locError?.code ?? "")
                
                completion(false)
                return
            }
            
            if let verify = result?.user.isEmailVerified {
                completion(true)
            } else {
                print("not verifi")
            }
        }
    }
    
    func signInOut() {
        try? Auth.auth().signOut()
    }
    
    func setUserData(uid: String, userData: UserData, completion: @escaping (Bool) -> ()) {
        let ref = Firestore.firestore()
        let userProfileData: [String: Any] = [
            .name: userData.name,
            .surname: userData.surname,
            .birthDate: userData.birthDate,
            .interests: ["reading", "run"]
        ]
        ref.collection(.users)
            .document(uid)
            .setData(userProfileData) { error in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    func getUserData(completion: @escaping (Result<UserData, Error>) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore()
            .collection(.users)
            .document(uid)
            .addSnapshotListener { snap, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                guard let docData = snap?.data() else {return}
                let name = docData[.name] as! String
                let surname = docData[.surname] as! String
                let interests = docData[.interests] as! [String]
                let birthDate: Date = {
                    let timestamp = docData[.birthDate] as! Timestamp
                    return timestamp.dateValue()
                }()
                
                let userData = UserData(name: name,
                                        surname: surname,
                                        birthDate: birthDate,
                                        email: "",
                                        password: "",
                                        interest: interests)
                completion(.success(userData))
            }
    }
}

extension String {
    static var users = "users"
    static var name = "name"
    static var surname = "surname"
    static var birthDate = "birthDate"
    static var interests = "interests"
}
