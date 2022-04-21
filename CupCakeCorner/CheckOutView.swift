//
//  CheckOutView.swift
//  CupCakeCorner
//
//  Created by Andres Gutierrez on 4/20/22.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMesage   = ""
    @State private var showConfirmation     = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Total is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order"){
                    Task{
                        await placeOrder()
                    }
                }
                .padding()
            }
            .navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $showConfirmation) {
                Button("Ok"){}
            }message: {
                Text(confirmationMesage)
            }
        }
    }
    
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode data")
            return
        }
        
        let url             = URL(string: "https://reqres.in/api/cupcakes")!
        var request         = URLRequest(url: url)
        request.httpMethod  = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let (data, _)       = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedData     = try JSONDecoder().decode(Order.self, from: data)
            
            confirmationMesage  = "Your order of \(decodedData.amount)x \(Order.types[decodedData.type].lowercased()) cupcakes is on it's way!"
            showConfirmation    = true
        }catch{
            print("Failed to decode data")
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
