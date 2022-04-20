//
//  ContentView.swift
//  CupCakeCorner
//
//  Created by Andres Gutierrez on 4/7/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order  = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Type of Cake", selection: $order.type) {
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Amount of Cakes: \(order.amount)", value: $order.amount, in: 3...20)
                }
                Section{
                    Toggle("Special Requests?", isOn: $order.specialRequest)
                    if order.specialRequest {
                        Toggle("Add Sprinkles", isOn: $order.addSprinkles)
                        Toggle("Extra Frosting", isOn: $order.extraFrosting)
                    }
                }
                Section{
                    NavigationLink{
                    AddressView(order: order)
                    } label: {
                        Text("Delievery Details")
                    }
                }
            }
            .navigationTitle("CupCake Corner")
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
