//  ProfileView.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct ProfileView: View {
    
    let db = Firestore.firestore()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dob = Date()
    @State private var email = ""
    @State private var phoneNumber = ""
    @State var selectedGender: String = ""
    @State private var profileImage: UIImage?
    @EnvironmentObject var authModel: AuthenticationModel
    let gender = ["male", "female"]
    @State private var isShowingImagePicker = false
    
    @State private var imageURL: String = ""
    func getDataFromFirebase() {
        if let userId = Auth.auth().currentUser?.uid {
            db.collection("users").document(userId)
                .getDocument { (document, error) in
                    if let document = document, document.exists {
                        let userData = document.data()
                        // Assign values to state variables
                                          firstName = userData?["firstName"] as? String ?? ""
                                          lastName = userData?["lastName"] as? String ?? ""
                                          email = userData?["email"] as? String ?? ""
                                          phoneNumber = userData?["phoneNumber"] as? String ?? ""
                                          selectedGender = userData?["gender"] as? String ?? ""
                                          
                                          if let dobString = userData?["dob"] as? String {
                                              let dateFormatter = DateFormatter()
                                              dateFormatter.dateFormat = "yyyy-MM-dd"
                                              dob = dateFormatter.date(from: dobString) ?? Date()
                                          }
                                          
                                          imageURL = userData?["profileImageUrl"] as? String ?? ""
                        print(userData)
                    } else {
                        print("Document does not exist")
                    }
            }
        }
    }
    var body: some View {
        VStack(spacing: 20) {
            Text("PROFILE")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(50)
            
            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.black)
                    .mask(Circle())
                    .onTapGesture {
                        // Show image picker
                        isShowingImagePicker = true
                    }
            } else if let url = URL(string: imageURL), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.black)
                    .mask(Circle())
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
                    .onTapGesture {
                        isShowingImagePicker = true
                    }
            }
            
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
        .sheet(isPresented: $isShowingImagePicker, onDismiss: nil) {
            ImagePicker(profileView: self, selectedImage: $profileImage)
        }.onAppear {
            getDataFromFirebase()
        }
    }
    
    func saveProfile() {
        authModel.saveProfileData(firstName: firstName, lastName: lastName, dob: dob, email: email, phoneNumber: phoneNumber, selectedGender: selectedGender, profileImageUrl: imageURL){ error in
            if let error = error {
                print("Error saving profile data: \(error.localizedDescription)")
            } else {
                print("Profile data saved successfully")
            }
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
struct ImagePicker: UIViewControllerRepresentable {
    var profileView: ProfileView
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self, profileView: profileView)
    }
}
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var parent: ImagePicker
    var profileView: ProfileView
    init(_ parent: ImagePicker, profileView:ProfileView) {
        self.parent = parent
        self.profileView = profileView
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            parent.selectedImage = selectedImage
            profileView.uploadImage(selectedImage)
        }

        parent.sourceType = .photoLibrary
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.sourceType = .photoLibrary
        picker.dismiss(animated: true)
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
