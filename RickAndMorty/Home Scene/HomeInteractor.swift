import UIKit

protocol HomeBusinessLogic {
    func fetchCharacters(request: Home.Data.Request)

}

protocol HomeDataStore {
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    func fetchCharacters(request: Home.Data.Request) {
        // worker -
        worker = HomeWorker()
        // fetch
        worker?.delegate = self
        worker?.fetchCharacters()
    }
}

extension HomeInteractor: HomeWorkerDelegate {
    func fetched(characters: [Home.Data.Response.Character]) {
        print(characters)
        presenter?.presentCharacters(characters: characters)
    }
}
