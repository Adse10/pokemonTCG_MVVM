//
//  CardDetailRouter.swift
//  PokemonTCG_MVVM
//
//  Created Adrián Bolaños Ríos on 23/04/2021.
//  Copyright © 2021 . All rights reserved.
//  Generated using MVVM Module Generator by Adrián Bolaños
//

import UIKit


class CardDetailRouter {
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    var idCard: String?
    
    init(idCard: String? = nil) {
        self.idCard = idCard
    }
    
    private func createViewController() -> UIViewController {
        let view = CardDetailView(nibName: "CardDetailView", bundle: nil)
        view.idCard = self.idCard
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else { fatalError("Ha ocurrido un error desconocido")}
        self.sourceView = view
    }
    
}

