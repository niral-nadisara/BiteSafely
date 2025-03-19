import SwiftUI
import AuthenticationServices // For Sign in with Apple
import GoogleSignIn

struct ContentView: View {
    @State private var scannedCode: String = ""
    @State private var isShowingScanner = false
    @State private var isShowingAuthSheet = false
    
    var body: some View {
        VStack {
            // Logo in the center (round)
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.top, 50)

            // Tagline below the logo
            Text("Scan, Analyze. Choose Better")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .padding(.top, 20)

            // Display scanned barcode
            if !scannedCode.isEmpty {
                Text("Scanned Code: \(scannedCode)")
                    .font(.headline)
                    .padding()
            }

            Spacer()

            // 3 buttons at the bottom
            HStack(spacing: 20) {
                Button("Explore") {
                    print("Explore tapped!")
                }
                .buttonStyle(CustomButtonStyle(color: .blue))

                Button("Scan") {
                    isShowingScanner = true
                }
                .buttonStyle(CustomButtonStyle(color: .green))

                Button("Login/Signup") {
                    isShowingAuthSheet = true
                }
                .buttonStyle(CustomButtonStyle(color: .orange))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .sheet(isPresented: $isShowingScanner) {
            ScannerSheet(scannedCode: $scannedCode)
        }
        .sheet(isPresented: $isShowingAuthSheet) {
                    AuthenticationView()
        }
    }
}

// Wrap BarcodeScannerView in a SwiftUI container
struct ScannerSheet: View {
    @Binding var scannedCode: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Close the sheet
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding()
            }

            Text("Scan a Product")
                .font(.headline)
                .padding()

            // Wrap BarcodeScannerView in a ZStack to apply modifiers
            ZStack {
                Color.clear // Transparent background
                BarcodeScannerView(scannedCode: $scannedCode)
            }
            .frame(height: 300) // Restrict the scanner height
            .background(Color.white) // Background color for the scanner area
            .cornerRadius(10) // Rounded corners for the scanner area
            .padding()
        }
        .background(Color.white) // Background color for the entire sheet
        .cornerRadius(20) // Rounded corners for the entire sheet
        .shadow(radius: 10) // Shadow for the entire sheet
    }
}

// Custom button style for consistent styling
struct CustomButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct AuthenticationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                Text(isSignUp ? "Create Account" : "Hello There!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Email/Password fields
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Login/Signup Button
                Button(action: {
                    if isSignUp {
                        createAccount()
                    } else {
                        login()
                    }
                }) {
                    Text(isSignUp ? "Create Account" : "Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Toggle between Login and Signup
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Already have an account? Login" : "Don't have an account? Sign up")
                        .foregroundColor(.blue)
                }
                
                Divider()
                    .padding(.vertical)
                
                // Social Login Options
                VStack(spacing: 15) {
                    Text("Or continue with")
                        .foregroundColor(.gray)
                    
                    // Google Sign-In Button
                    Button(action: {
                        signInWithGoogle()
                    }) {
                        HStack {
                            Image("google_logo") // Add this image to your assets
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Continue with Google")
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.gray)
            })
        }
    }
    // Authentication functions
    func login() {
        // Implement your login logic here
        print("Logging in with email: \(email)")
        
        // For demo purposes, just dismiss the sheet after "login"
        // In a real app, you would validate credentials and handle authentication
        presentationMode.wrappedValue.dismiss()
    }
    
    func createAccount() {
        // Implement your account creation logic here
        print("Creating account with email: \(email)")
        
        // For demo purposes, just dismiss the sheet after "signup"
        presentationMode.wrappedValue.dismiss()
    }
    
    func signInWithGoogle() {
        // Implement Google Sign-In
        print("Google Sign-In initiated")
        
        // Here you would implement the actual Google Sign-In flow
        // For integration details, see: https://developers.google.com/identity/sign-in/ios/start-integrating
        
        // For demo purposes, just dismiss the sheet
        presentationMode.wrappedValue.dismiss()
    }
}
