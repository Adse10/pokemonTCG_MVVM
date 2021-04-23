//
//  CardListViewModel.swift
//  PokemonTCG_MVVM
//
//  Created by Adrián Bolaños Ríos on 23/04/2021.
//

import Foundation
import RxSwift

class CardListViewModel {
    
    private weak var view: CardListView?
    private var router: CardListRouter?
    private var managerConnections = ManagerConnections()
    private var page = 1
    
    func bind(view: CardListView, router: CardListRouter){
        self.view = view
        self.router = router
        // Bindear el router con la vista
        self.router?.setSourceView(view)
    }
    
    /* Funcion para obtener los datos del listado de cartas */
    func getListCard() -> Observable<[Card]>{
        return managerConnections.getCardList(page: page)
    }
    
    /* Función para aumentar la página */
    func addPage() {
        page += 1
    }
    
    /* Función para ir al detalle de una carta */
    func makeDetailCard(idCard: String){
        router?.makeDetailCard(idCard)
    }
}
