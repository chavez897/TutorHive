//
//  TutorDetail.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-24.
//

import SwiftUI

struct TutorDetail: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Rodrigo Chavez")
            Image(systemName: "person")
              .resizable()
              .frame(width: 60, height: 60)
              .foregroundColor(.white)
              .padding(20)
              .background(Color.black)
              .clipShape(Circle())
            Text("Rodrigo Chavez").font(.title).padding(.top, 30)
            HStack{
                Image(systemName: "book.closed")
                Text("ReactJS, SwiftUI")
            }.padding(.top, 5)
            HStack{
                Image(systemName: "message")
                Text("Spanish, English")
            }.padding(.top, 1)
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has ")
                .padding(.horizontal, 20)
                .padding(.top, 5)
                .multilineTextAlignment(.center)
            Text("CAD $25/hr").padding(.top, 25)
            Button("Contact Tutor") {
                print("Button pressed!")
            }
            .foregroundColor(.white)
            .frame(width: 280, height: 40)
            .background(Color(red: 90/255, green: 100/255, blue: 234/255))
            .cornerRadius(10)
            .padding(.top, 15)
            Image("wise1")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.vertical, 20)
            
            
        }
    }
}

struct TutorDetail_Previews: PreviewProvider {
    static var previews: some View {
        TutorDetail()
    }
}
