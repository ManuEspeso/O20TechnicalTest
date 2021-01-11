
import RxSwift

protocol BeersListPresenter {
    func loadBeers()
    func filterBeers(by filter: String)
    func reloadBeers() -> [Beers]
    func navigateToDetailBeer(_ beerSelected: Beers)
}

class BeersListPresenterDefault {
    
    weak var view: BeersListView?
    
    private var isLoading: Bool = false
    private let beersViewModel: BeersViewModel = BeersViewModel()
    private let getBeersInteractor: GetBeersInteractor
    private let getBeersFilterInteractor: GetBeersFilterInteractor
    private let wireframe: BeersListWireframe
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(getBeersInteractor: GetBeersInteractor, getBeersFilterInteractor: GetBeersFilterInteractor, wireframe: BeersListWireframe) {
        self.getBeersInteractor = getBeersInteractor
        self.getBeersFilterInteractor = getBeersFilterInteractor
        self.wireframe = wireframe
    }
    
    private func onRequestBeersSuccess(_ beersResponse: [BeersResponse]) {
        if !beersResponse.isEmpty {
            let beers = beersViewModel.map(beersResponse)
            view?.showBeers(beers: beers)
            isLoading = false
        } else {
            view?.removeFooterSpinner()
        }
    }
    
    private func onRequestFilterBeersSuccess(_ beersResponse: [BeersResponse]) {
        let beers = beersViewModel.mapBeersFilter(beersResponse)
        view?.showFilterBeers(beers: beers)
        isLoading = false
    }
    
    private func onRequestBeersError(_ error: Error) {
        isLoading = false
        
        if let candidatesError = error as? GetBeersInteractorError, case .paginationCompleted = candidatesError {
            view?.removeFooterSpinner()
            return
        }
        
        guard let error = error as? ServiceError, case .recivedServiceError(let message) = error else {
            view?.showError(message: "alertMessage_generic".toLocalized())
            return
        }
        view?.showError(message: message)
    }
}

// MARK: - Delegate

extension BeersListPresenterDefault: BeersListPresenter {
    
    func loadBeers() {
        guard !isLoading else { return }
        isLoading = true
        
        getBeersInteractor
            .execute()
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onSuccess: { [weak self] beersResponse in
                self?.onRequestBeersSuccess(beersResponse)
                }, onFailure: { [weak self] error in
                    self?.onRequestBeersError(error)
            })
            .disposed(by: disposeBag)
    }
    
    func filterBeers(by filter: String) {
        getBeersFilterInteractor
            .execute(filter: filter)
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onSuccess: { [weak self] beersResponse in
                self?.onRequestFilterBeersSuccess(beersResponse)
                }, onFailure: { [weak self] error in
                    self?.onRequestBeersError(error)
            })
            .disposed(by: disposeBag)
    }
    
    func reloadBeers() -> [Beers] {
        beersViewModel.localBeers
    }
    
    func navigateToDetailBeer(_ beerSelected: Beers) {
        wireframe.navigateToBeerDetail(beerSelected)
    }
}
