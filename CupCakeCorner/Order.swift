//
//  Order.swift
//  CupCakeCorner
//
//  Created by Andres Gutierrez on 4/20/22.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey{
        case type, amount, addSprinkles, extraFrosting, name, address, city, zipCode
    }
    
    static let types                = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
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
    
    var cost: Double {
        // $2 per cake
        var cost = Double(amount) * 2
        
        // extra per level of difficulty
        cost += (Double(type) / 2)
        
        // .50 per cake
        if addSprinkles{
            cost += Double(amount) / 2
        }
        // $1 per cake
        if extraFrosting {
            cost += Double(amount)
        }
        return cost
    }
    
    
    init() { }
    
    
    func encode(to encoder: Encoder) throws {
        var container   = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(amount, forKey: .amount)
        
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(zipCode, forKey: .zipCode)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        
        type            = try container.decode(Int.self, forKey: .type)
        amount          = try container.decode(Int.self, forKey: .amount)
        
        extraFrosting   = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles    = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name            = try container.decode(String.self, forKey: .name)
        address         = try container.decode(String.self, forKey: .address)
        city            = try container.decode(String.self, forKey: .city)
        zipCode         = try container.decode(String.self, forKey: .zipCode)
    }
    
}
