//
//  CardDetailViewModel.swift
//  PokemonTCG_MVVM
//
//  Created Adrián Bolaños Ríos on 23/04/2021.
//  Copyright © 2021 . All rights reserved.
//  Generated using MVVM Module Generator by Adrián Bolaños
//

import Foundation
import RxSwift

class CardDetailViewModel {
    
    private weak var view: CardDetailView?
    private var router: CardDetailRouter?
    private var manageConnections = ManagerConnections()
    
    func bind(view: CardDetailView, router: CardDetailRouter){
        self.view = view
        self.router = router
        // Bindear el router con la vista
        self.router?.setSourceView(view)
    }
    
    /* Función para obtener el detalle de una carta */
    func getDetailCard(idCard: String) -> Observable<Card>{
        return manageConnections.getCardDetail(idCard: idCard)
    }
}
