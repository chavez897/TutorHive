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
import GoogleSignIn
import FirebaseFirestore

final class AuthenticationModel: ObservableObject {
@Published var error: String?
    @Published var signUpSuccessful: Bool = false
    @Published var isSignedIn = false
    @Published var isResetPassword = false
    @Published var goToHome = false
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
          print("resuuu", result!.user.uid);
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
      print(Auth.auth().currentUser)
    try? Auth.auth().signOut()
      print(Auth.auth().currentUser)
      self.isSignedIn = false
      self.goToHome = true
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
    
    func saveProfileData(
        firstName: String,
        lastName: String,
        dob: Date,
        email: String,
        phoneNumber: String,
        selectedGender: String,
        profileImageUrl: String,
        completion: @escaping (Error?) -> Void
    ) {
        guard let user = Auth.auth().currentUser else {
            completion(NSError(domain: "com.example.TutorHive", code: 0, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found."]))
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // set the desired date format

        let dobString = dateFormatter.string(from: dob) // convert the Date value to a String

        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                userRef.updateData([
                    "firstName": firstName,
                    "lastName": lastName,
                    "dob": dobString,
                    "email": email,
                    "phoneNumber": phoneNumber,
                    "gender": selectedGender,
                    "profileImageUrl": profileImageUrl
                ]) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                userRef.setData([
                    "firstName": firstName,
                    "lastName": lastName,
                    "dob": dobString,
                    "email": email,
                    "phoneNumber": phoneNumber,
                    "gender": selectedGender,
                    "profileImageUrl": profileImageUrl,
                    "uid": user.uid
                ]) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }

    enum AuthenticationError: Error {
      case tokenError(message: String)
    }
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print("There is no root view controller!")
            return false
        }
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            let user = userAuthentication.user
            guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: "ID token missing") }
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            self.isSignedIn = true
            return true
        }
        catch {
            print(error.localizedDescription)
            return false
        }}
   
}
