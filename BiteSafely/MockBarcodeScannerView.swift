import SwiftUI

struct MockBarcodeScannerView: View {
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

            Text("Mock Barcode Scanner")
                .font(.headline)
                .padding()

            // Simulate scanning a barcode
            Button(action: {
                scannedCode = "3168930000020" // Mock barcode value
                presentationMode.wrappedValue.dismiss() // Close the sheet after "scanning"
            }) {
                Text("Simulate Scan")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
