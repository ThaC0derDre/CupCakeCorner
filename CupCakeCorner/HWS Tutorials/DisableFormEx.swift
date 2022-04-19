//
//  DisableFormEx.swift
//  CupCakeCorner
//
//  Created by Andres Gutierrez on 4/19/22.
//

import SwiftUI

// How to disable interaction if criteria isnt met...
// interaction: textfield, button, slider, etc...


struct DisableFormEx: View {
    @State private var username = ""
    @State private var email = ""
    
    // created computed property that returns Bool
    var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form{
            Section{
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section{
                Button("Create Account"){
                    print("Account created")
                }
            }
            // add disabled modifier to section
            .disabled(disabledForm)
        }
    }
}

struct DisableFormEx_Previews: PreviewProvider {
    static var previews: some View {
        DisableFormEx()
    }
}
