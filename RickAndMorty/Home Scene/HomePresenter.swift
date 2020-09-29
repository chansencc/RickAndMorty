import UIKit

protocol HomePresentationLogic {
    func presentCharacters(characters: [Home.Data.Response.Character])
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentCharacters(characters: [Home.Data.Response.Character]) {
        viewController?.presentCharacters(characters: characters)
    }
}
