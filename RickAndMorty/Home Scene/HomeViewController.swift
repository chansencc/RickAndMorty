import UIKit

protocol HomeDisplayLogic: class {
    func presentCharacters(characters: [Home.Data.Response.Character])
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
    

        
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    func fetchCharacters() {
        // configure request
        interactor?.fetchCharacters(request: Home.Data.Request())
    }
    
    
    func doSomething() {
    }
    
    func presentCharacters(characters: [Home.Data.Response.Character]) {
        viewModelArray = characters
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    var viewModelArray: [Home.Data.Response.Character] = []
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterCell else {
            assert(false, "Invalid tableview cell")
            return UITableViewCell()
        }
        let viewModel = viewModelArray[indexPath.row]
        cell.viewModel = viewModel
        return cell
    }
    
}


//Create a sample application to show the list of Characters from the show Rick and Morty.
//
//API Doc: https://rickandmortyapi.com/documentation/#get-all-characters
//
//The application:
//• Should fetch the list of characters (https://rickandmortyapi.com/api/character/)
//• Should show a scrollable list of those characters including Name, Status, Species and an image of the character
//• When a character is clicked, it should show a popup or dialog stating the character’s location Name (location.name)
//
//
//Plus Points:
//• Can work both on Landscape (Grid View) and Portrait (Vertical List)
//• The list of characters consists of several pages; can implement fetching additional pages of characters as the User scrolls
//
//
//NOTE:
//• The code must be shared in GitHub or BitBucket, with frequent commits.
