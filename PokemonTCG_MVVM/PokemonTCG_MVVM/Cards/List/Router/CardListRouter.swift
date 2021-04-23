//
//  CardListRouter.swift
//  PokemonTCG_MVVM
//
//  Created by Adrián Bolaños Ríos on 23/04/2021.
//

import Foundation
import UIKit

class CardListRouter {
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = CardListView(nibName: "CardListView", bundle: nil)
        let navController = UINavigationController(rootViewController: view)
        return navController
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else { fatalError("Ha ocurrido un error desconocido")}
        self.sourceView = view
    }
    
    /* Función para ir al detalle de una carta */
    func makeDetailCard(_ idCard: String){
        
        let detailView = CardDetailRouter(idCard: idCard).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
