//
//  CardListView.swift
//  PokemonTCG_MVVM
//
//  Created by Adrián Bolaños Ríos on 23/04/2021.
//

import UIKit
import RxSwift

final class CardListView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var router = CardListRouter()
    private var viewModel = CardListViewModel()
    private var disposeBag = DisposeBag()
    
    private var listCards: [Card]?
    private var otherPage = true
    private var isLoadingPage = true

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        
        // Registramos  las celdas
        registerCells()
        
        // Obtenemos los datos
        getData()

    }
    
    
    // MARK: - Funciones privadas
    
    private func registerCells(){
        collectionView.register(UINib(nibName: CardCollectionViewCell.kIdentifier, bundle: nil) , forCellWithReuseIdentifier: CardCollectionViewCell.kIdentifier)
    }
    
    private func getData(){
        // Aquí vamos a ir obteniendo las diferentes páginas de los datos
        return viewModel.getListCard().subscribe(
            onNext: { response in
                self.reloadCollection(response)
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    private func reloadCollection(_ response: [Card]){
        self.isLoadingPage = false
        // Añadimos elemento al array
        if self.listCards != nil {
            self.listCards! += response
        }else{
            listCards = response
        }
        // Comprobamos si tenemos más paginas
        if response.count < 20 {
            otherPage = false
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.bounds.size.height)
        && otherPage == true && isLoadingPage == false {
            isLoadingPage = true
            viewModel.addPage()
            getData()
        }
    }
}

extension CardListView: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.kIdentifier, for: indexPath) as? CardCollectionViewCell
        guard let listCard = listCards else { return UICollectionViewCell()}
        cell!.loadData(card: listCard[indexPath.row])
        return cell!
    }

}

extension CardListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listCard = listCards {
            guard let idCard = listCard[indexPath.row].idCard else { return }
            router.makeDetailCard(idCard)
        }
    }
}

extension CardListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 3), height: (UIScreen.main.bounds.width / 3 * 1.5))
    }
}
