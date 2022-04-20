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
    
    
}
