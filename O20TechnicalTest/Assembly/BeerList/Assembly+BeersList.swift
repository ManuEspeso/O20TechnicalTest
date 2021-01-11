
import UIKit

protocol BeersListViewProvider {
    func getBeersListViewController() -> BeersListViewController
}

extension Assembly: BeersListViewProvider {
    
    func getBeersListViewController() -> BeersListViewController {
        let view = BeersListViewController()
        view.presenter = getBeersListPresenter(view)
        
        return view
    }
    
    func getBeersListPresenter(_ view: BeersListView) -> BeersListPresenter {
        let presenter = BeersListPresenterDefault(getBeersInteractor: getBeersInteractor(),
                                                  getBeersFilterInteractor: getBeersFilterInteractor(),
                                                  wireframe: getBeersWireframe(view))
        presenter.view = view
        
        return presenter
    }
    
    private func getBeersWireframe(_ view: BeersListView) -> BeersListWireframe {
        let wireframe = BeersListWireframeDefault()
        wireframe.sourceView = view as? UIViewController
        
        return wireframe
    }
    
    func getBeersInteractor() -> GetBeersInteractor {
        GetBeersInteractorDefault(punkAPIRepository: getPunkRepository())
    }
    
    func getBeersFilterInteractor() -> GetBeersFilterInteractor {
        GetBeersFilterInteractorDefault(punkAPIRepository: getPunkRepository())
    }
    
    func getPunkRepository() -> PunkAPIRepository {
        PunkAPIRepositoryDefault()
    }
}

