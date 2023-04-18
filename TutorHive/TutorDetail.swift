//
//  TutorDetail.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-24.
//

import SwiftUI

struct TutorDetail: View {
    @State var tutor: Tutor
    var body: some View {
        VStack{
            Spacer()
            Text(tutor.name + " " + tutor.lastName)
            if let url = URL(string: tutor.image), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.black)
                    .mask(Circle())
                    
            } else {
                Image(systemName: "person")
                  .resizable()
                  .frame(width: 60, height: 60)
                  .foregroundColor(.white)
                  .padding(20)
                  .background(Color.black)
                  .clipShape(Circle())
            }
            Text(tutor.name + " " + tutor.lastName).font(.title).padding(.top, 30)
            HStack{
                Image(systemName: "book.closed")
                Text(tutor.skills.joined(separator: ", "))
            }.padding(.top, 5)
            HStack{
                Image(systemName: "message")
                Text(tutor.language.joined(separator: ", "))
            }.padding(.top, 1)
            Text(tutor.description)
                .padding(.horizontal, 20)
                .padding(.top, 5)
                .multilineTextAlignment(.center)
            Text(String(format: "CAD $ %.2f/hr", tutor.price)).padding(.top, 25)
            NavigationLink(destination: ContactView()){
                Text("Contact")
                    .foregroundColor(.white)
                    .frame(width: 280, height: 40)
                    .background(Color(red: 90/255, green: 100/255, blue: 234/255))
                    .cornerRadius(10)
                    .padding(.top, 15)
            }
            
            Image("wise1")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.vertical, 20)
            
            
        }
    }
}

struct TutorDetail_Previews: PreviewProvider {
    static var previews: some View {
        TutorDetail(tutor: Tutor(id: "Asdfa", name: "Rodrigo", lastName: "Chavez", skills: ["Cooking", "Play"], language: ["Spanish"], description: "My descr", price: 5.0, image: "asdfasd"))
    }
}
