import UIKit

enum Home {
    // MARK: Use cases
    
//    "id":1,
//    "name":"Rick Sanchez",
//    "status":"Alive",
//    "species":"Human",
//    "type":"",
//    "gender":"Male",
//    "origin":{
//    "name":"Earth (C-137)",
//    "url":"https://rickandmortyapi.com/api/location/1"
//    },
//    "location":{
//    "name":"Earth (Replacement Dimension)",
//    "url":"https://rickandmortyapi.com/api/location/20"
//    },
//    "image":"https://rickandmortyapi.com/api/character/avatar/1.jpeg",
//    "episode":[
//    "https://rickandmortyapi.com/api/episode/1",
//    "https://rickandmortyapi.com/api/episode/2",
//    "https://rickandmortyapi.com/api/episode/41"
//    ],
//    "url":"https://rickandmortyapi.com/api/character/1",
//    "created":"2017-11-04T18:48:46.250Z"

    

    
    
    enum Data {
        struct Request {
            
        }
        struct Response {
            struct Root : Decodable {
                let info: Info
                let results: [Character]
            }
            
            struct Info: Decodable {
                var count, pages: Int
                var next, prev: String?
            }
            struct Result : Decodable {
                let results : [Character]
            }
            
            struct Character : Decodable {
                
                var status, name, species, image: String
                
                private enum CodingKeys : String, CodingKey {
                    case status, name, species, image
                }
                
                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    
                    status = try container.decode(String.self, forKey: .status)
                    name = try container.decode(String.self, forKey: .name)
                    species = try container.decode(String.self, forKey: .species)
                    image = try container.decode(String.self, forKey: .image)
                }
            }
        }
        struct ViewModel {
            var status, name, species, image: String
        }
    }
}
