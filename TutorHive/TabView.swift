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
            
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Proile")
            }
            
        }
    }
}
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}

