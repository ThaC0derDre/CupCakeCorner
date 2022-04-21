//
//  CheckOutView.swift
//  CupCakeCorner
//
//  Created by Andres Gutierrez on 4/20/22.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
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
                
                Button("Place Order"){}
                .padding()
            }
            .navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
