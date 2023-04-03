//
//  AuthenticationModel.swift
//  TutorHive
//
//  Created by Moanisha V on 2023-04-01.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase

final class AuthenticationModel: ObservableObject {
@Published var error: String?
    @Published var signUpSuccessful: Bool = false
    @Published var isSignedIn = false
    @Published var isResetPassword = false
  var user: User? {
    didSet {
      objectWillChange.send()
    }
  }

  func listenToAuthState() {
    Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self = self else {
        return
      }
      self.user = user
    }
  }

  func signUp(
    name: String,
    emailAddress: String,
    password: String
  ) {
      Auth.auth().createUser(withEmail: emailAddress, password: password){(result, err) in
          DispatchQueue.main.async {
              if let err = err {
                  self.error = err.localizedDescription
              } else {
                  let db = Firestore.firestore()
                  db.collection("users").addDocument(data: ["name": name, "uid": result!.user.uid]) { (error) in
                      if let error = error {
                          self.error = error.localizedDescription
                      } else {
                          self.signUpSuccessful = true
                      }
                  }
              }
              
          }}
  }

  func signIn(
    emailAddress: String,
    password: String
  ) {
      Auth.auth().signIn(withEmail: emailAddress, password: password){(result, err) in
          if(err != nil){
              print(err?.localizedDescription ?? "")
          } else {
              print("success")
              self.isSignedIn = true
          }
         
      }
  }

  func signOut() {
    try? Auth.auth().signOut()
  }
    
    func resetPassword( emailAddress: String) {
        Auth.auth().sendPasswordReset(withEmail: emailAddress) { error in
                          if let error = error {
                              self.error = error.localizedDescription
                          } else {
                              self.isResetPassword = true
                              print("Password reset send successfully")
                          }
                      }
    }
}
