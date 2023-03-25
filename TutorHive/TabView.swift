//
//  TabView.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import SwiftUI

struct Tabs: View {
    @AppStorage("CurrentTab") var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            SearchTutor().tabItem{
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            SearchTutor().tabItem{
                Image(systemName: "person.crop.circle")
                Text("Profile")
            }
        }
        
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}

