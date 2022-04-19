//
//  AsyncAwaitURLSEx.swift
//  CupCakeCorner
//
//  Created by Andres Gutierrez on 4/18/22.
//

import SwiftUI


//Converting swift objects to JSON and back.

struct Response: Codable {
    var results: [Result]
}

struct Result : Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


struct Contents: View {
    @State private var results = [Result]()
    var body: some View {
        NavigationView{
            List(results, id: \.trackId){ track in
                VStack(alignment: .leading){
                    Text(track.trackName)
                        .font(.headline)
                    Text(track.collectionName)
                }
                // To call async method, call task with 'await' keyword
            }
            .task {
                await loadData()
            }
        }
    }
    
    // First step is to create async 'sleeping' method
    func loadData () async {
        // 1) Create URL
        guard let url = URL(string: "https://itunes.apple.com/search?term=J.+Cole&entity=song") else {
            print ("Invalid URL")
            return
        }
        //2 Fetch Data from URL.
        do{
            // Tuple, as this api return (data, metaData).
            //We create 'data' constant to store date, and use '_' to disregard the metaData.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //3. Decode into a Response struct
            if let decodedData  = try? JSONDecoder().decode(Response.self, from: data){
                // if successful, add results to 'Content' results array.
                // Notice how Response struct and Content's results have identical property-values: '[Result]'
                results = decodedData.results
            }
        }catch{
            print("Invalid Data")
        }
    }
}


struct Contents_Previews: PreviewProvider {
    static var previews: some View {
        Contents()
    }
}
