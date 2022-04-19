



import Foundation

/*Problem, you have a class you want to be 'CODABLE',
 but you also want it to conform to 'Observable Object.
 @Published is a propterty wrapper that does not coform to codable.
 
 To fix this, you must make the property in @Published a codable property.
 1) Create and enum that conforms to CodingKey. Add the desired property to the enum as a case.
 2) Now, make the property decodable by adding a req'd init. Or, mark class as final to prevent subclassing.
 3) In the init, create a container to hold values from enum.
 4) Apply decoded value to property.
 ..Property now conforms to decoable. Now for encodable..
 5) Call encode function, and create a container to modify properties to JSON.
 
 */

class User: ObservableObject, Codable {
    //1 Create enum of CodingKey.type
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Dre Gucci"
    
    //2 Call req'd init.
    required init(from decoder: Decoder) throws {
        //3 Capture properties from CodingKeys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //4 Decode properties in container, and set as value
        name = try container.decode(String.self, forKey: .name)
    }
    //5 Call encoder func. Create container and encode to JSON.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
