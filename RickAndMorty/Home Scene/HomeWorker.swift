import UIKit

protocol HomeWorkerDelegate {
    func fetched(characters: [Home.Data.Response.Character])
}

class HomeWorker {
    
    var delegate: HomeWorkerDelegate?
    
    func fetchCharacters() {
        let session = URLSession.shared
        var urlString = Constants.Endpoints.baseURL
        guard let url = URL(string: urlString) else { return }
        
        let sessionTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            if error != nil {
                // Handle error
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Home.Data.Response.Root.self, from: data)
                print(root.results)
                print("first ")
                let first = root.results[0]
//                self.delegate?.charactersFetched(response: <#T##Home.Data.Response#>)
                self.delegate?.fetched(characters: root.results)
            } catch {
                print("error: ", error)
            }
        }
        sessionTask.resume()
    }
}
