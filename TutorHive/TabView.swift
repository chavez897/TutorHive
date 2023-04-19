//
//  TabView.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import SwiftUI

struct Tabs: View {
    var body: some View {
        TabView {
            NavigationView {
                SearchTutor()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            
            ProfileView()
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Profile")
            }
            
            NavigationView {
                RegisterTutor()
                      }
                       .tabItem {
                           Image(systemName: "person")
                           Text("Register as User")
                       }
            
        }.navigationBarBackButtonHidden(true)
    }
    
}
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}

