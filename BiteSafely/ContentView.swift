import SwiftUI

struct ContentView: View {
    @State private var scannedCode: String = ""
    @State private var isShowingScanner = false
    
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
                    print("Login tapped!")
                }
                .buttonStyle(CustomButtonStyle(color: .orange))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .sheet(isPresented: $isShowingScanner) {
            ScannerSheet(scannedCode: $scannedCode)
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
