//
//  TutorHiveApp.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import SwiftUI
import FirebaseCore
import Firebase
import GoogleSignIn

@main
struct TutorHiveApp: App {
    
    init() {
      FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environmentObject(AuthenticationModel())
              .environment(\.colorScheme, .light)
        }
    }
}

