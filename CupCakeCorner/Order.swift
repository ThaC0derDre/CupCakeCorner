//
//  Order.swift
//  CupCakeCorner
//
//  Created by Andres Gutierrez on 4/20/22.
//

import SwiftUI

class Order: ObservableObject {
    
    static let types                = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]
                
    @Published var type             = 0
    @Published var amount           = 3
    
    @Published var specialRequest   = false {
        didSet{
           if specialRequest == false {
                addSprinkles    = false
                extraFrosting   = false
            }
        }
    }
    @Published var addSprinkles     = false
    @Published var extraFrosting    = false
    
    @Published var name             = ""
    @Published var address          = ""
    @Published var city             = ""
    @Published var zipCode          = ""
    
    var validAddress: Bool {
        if name.isEmpty || address.isEmpty || city.isEmpty || zipCode.isEmpty {
            return true
        }
        return false
    }
}
