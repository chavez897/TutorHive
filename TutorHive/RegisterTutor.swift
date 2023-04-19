//
//  RegisterTutor.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

struct RegisterTutor: View {
    
    @State var name: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var skills: [String] = []
    @State var skill: String = ""
    @State var language: String = ""
    @State var languages : [String] = []
    @State var price: Float = 0.0
    @State var prices: String = ""
    //@State var selectedcurrency: String = ""
    @State var description: String = ""
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    
    @State private var profileImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var imageURL: String = ""
    
   // let currency = ["USD", "CAD", "EUR", "Pound Sterling","INR"]
    
    
    var body: some View {
        
        VStack(alignment:.center,spacing:20) {
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
                    Text("Register As Tutor")
                        .font(.system(size: 28))
                        .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                        .offset(y:-30)
                    
                    if let image = profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.black)
                            .mask(Circle())
                            .offset(y:-30)
                            .onTapGesture {
                                // Show image picker
                                isShowingImagePicker = true
                            }
                    } else if let url = URL(string: imageURL), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black)
                            .mask(Circle())
                            .offset(y:-30)
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.black)
                            .clipShape(Circle())
                            .offset(y:-30)
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                    }
                    
                    HStack{
                        
                        TextField("Firstname", text: $name)
                            .frame(width: 140)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                            .cornerRadius(10)
                        
                        TextField("Lastname", text: $lastName)
                            .frame(width: 140)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                            .cornerRadius(10)
                        
                    }
                }
            }
            
            HStack{
                TextField("Email", text: $email)
                    .frame(width: 140)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                
                TextField("Phone no.", text: $phone)
                    .frame(width: 140)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                
            }
            HStack{
                
                TextField("Skills", text: $skill)
                    .frame(width: 320)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                
            }.onChange(of: skill) { newValue in
                skills = newValue.components(separatedBy: ",")
            }
            
            HStack{
                TextField("Languages", text: $language)
                    .frame(width: 140)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                TextField("Hourly Cost",text:$prices)
                    .frame(width: 140)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
            }.onChange(of: language) { newValue1 in
                languages = newValue1.components(separatedBy: ",")
            }.onChange(of: prices, perform: { value in
                if let price = Float(value) {
                    self.price = price
                }
            })
            
            HStack{
                TextEditor(text: $description)
                    .frame(maxHeight: 100)
                    .border(Color.gray, width: 0.5)
                    .overlay(
                        Group {
                            if description.isEmpty {
                                Text("Tell us something about yourself")
                                    .foregroundColor(Color.gray)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 8)
                                
                            }
                        }, alignment: .topLeading
                    )
            }
            .padding(.horizontal)
            .frame(width: 350)
            .background(Color(red: 227/255, green: 229/255, blue: 232/255))
            .cornerRadius(10)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Button("Submit") {
                    // Handle submission here
                    
                    let db = Firestore.firestore()
                
                    db.collection("tutors").addDocument(data: [
                        "name": name,
                        "lastName":lastName,
                        "email":email,
                        "phone":phone,
                        "skills": skills, "languages":languages,
                        "price":price, "image":imageURL,
                        "description": description
                    ]) { error in
                        if let error = error {
                            alertMessage = "Error adding document: \(error.localizedDescription)"
                        } else {
                            alertMessage = "Registered successfully as a Tutor!"
                            
                        }
                        isShowingAlert = true
                    }
                }
                .alert(isPresented: $isShowingAlert) {
                    Alert(
                        title: Text(alertMessage),
                        dismissButton: .default(Text("OK")) {
                            isShowingAlert = false
                        }
                    )
                }
                .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(50)
            }
            
        }.sheet(isPresented: $isShowingImagePicker, onDismiss: nil) {
            ImagePicker1(registerTutor: self, selectedImage: $profileImage)
        }
        
    }
    func uploadImage(_ image: UIImage) {
        print("upload image")
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let storageRef = Storage.storage().reference().child("profileImages/\(UUID().uuidString).jpg")
        let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
            } else {
                print("Image uploaded successfully")
                // Get download URL and save profile data
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                    } else if let url = url {
                        print(url.absoluteString)
                        imageURL = url.absoluteString
                        // Save profile data to Firestore
                        // ...
                    }
                }
            }
        }
        // Observe the upload progress
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Upload progress: \(percentComplete)%")
        }
    }
}

struct ImagePicker1: UIViewControllerRepresentable {
    var registerTutor: RegisterTutor
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator1 {
        Coordinator1(self, registerTutor: registerTutor)
    }
}
class Coordinator1: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var parent: ImagePicker1
    var registerTutor: RegisterTutor
    init(_ parent: ImagePicker1, registerTutor:RegisterTutor) {
        self.parent = parent
        self.registerTutor = registerTutor
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            parent.selectedImage = selectedImage
            registerTutor.uploadImage(selectedImage)
        }

        parent.sourceType = .photoLibrary
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.sourceType = .photoLibrary
        picker.dismiss(animated: true)
    }
}



struct RegisterTutor_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTutor()
    }
}
