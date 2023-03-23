//
//  Statistics.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-23.
//

import SwiftUI

struct Statistics: View {
    var body: some View {
        VStack(alignment:.center,spacing:30) {
            HStack {
                Spacer()
                Image("wise1")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 100)
                Text("TutorHive")
                    .font(.system(size: 35))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    .offset(x:-100)
                
                
            }
            Divider()
            Spacer()
            
            HStack{
                VStack{
                    Text("Andre Ainsley")
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                        .offset(y:-10)
                    
                    
                }
            }
            HStack{
                Text("Statistics / week")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    
            }
            HStack{
                Text("Contacted no of times: ")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    
                Text("8")
                    .font(.system(size: 40))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                  
            }
            HStack{
                Text("Skills")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    
            }
            HStack{
                List {
                                Text("React")
                                Text("Angular")
                                Text("Java")
                            }
                            .listStyle(InsetGroupedListStyle())
                    
            }
        }
    }
}

struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics()
    }
}
