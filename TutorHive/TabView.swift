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
                Text("Proile")
            }
            
            NavigationView {
                Statistics()
                      }
                       .tabItem {
                           Image(systemName: "chart.bar")
                           Text("Statistics")
                       }
            
        }.navigationBarBackButtonHidden(true)
    }
    
}
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}

