//
//  ContentView.swift
//  BiteSafely
//
//  Created by Niral sara on 3/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var scannedCode: String = ""
    @State private var isShowingScanner = false

    var body: some View {
        VStack {
            // Logo in the center (round)
            Image("logo") // Replace "logo" with the name of your image
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle()) // Makes the logo round
                .overlay(Circle().stroke(Color.gray, lineWidth: 4)) // Optional: Add a border
                .shadow(radius: 10) // Optional: Add a shadow
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

            Spacer() // Pushes content to the top and bottom

            // 3 buttons at the bottom
            HStack(spacing: 20) {
                Button(action: {
                    print("Explore tapped!")
                }) {
                    Text("Explore")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    isShowingScanner = true // Open the scanner
                }) {
                    Text("Scan")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    print("Login/Signup tapped!")
                }) {
                    Text("Login/Signup")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .sheet(isPresented: $isShowingScanner) {
            BarcodeScannerView(scannedCode: $scannedCode)
        }
    }
}
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
