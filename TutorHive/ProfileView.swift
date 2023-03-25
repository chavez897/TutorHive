//
//  ProfileView.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI

struct ProfileView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dob = Date()
    @State private var email = ""
    @State private var phoneNumber = ""
    @State var selectedGender: String = ""
let gender = ["male", "female"]
    var body: some View {
        VStack(spacing: 20) {
            Text("PROFILE")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(50)

            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            DatePicker("Date of Birth", selection: $dob, displayedComponents: [.date])
                .datePickerStyle(CompactDatePickerStyle())

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            DropdownTextField(
                               placeholder: "Gender",
                               options: gender,
                               selection: $selectedGender
                           )
            Spacer()

            Button(action: saveProfile) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.black)
                    .cornerRadius(5)
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .padding()
    }

    func saveProfile() {
        // Implement saving of profile data here
    }
}
struct DropdownTextField: View {
    let placeholder: String
    let options: [String]
    @Binding var selection: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 0.5)
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) {
                        self.selection = option
                    }
                }
            } label: {
                VStack(spacing: 20){
                    HStack{
                        Text(selection.isEmpty ? placeholder : selection)
                            .foregroundColor(selection.isEmpty ? .gray : .black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 10))
                    }
                    .padding(.horizontal)
                }
            }
            .menuStyle(BorderlessButtonMenuStyle())
            .frame(maxWidth: .infinity)
        }
        .frame(width: .infinity, height: 40)
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
