//
//  CardDetailView.swift
//  PokemonTCG_MVVM
//
//  Created Adrián Bolaños Ríos on 23/04/2021.
//  Copyright © 2021 . All rights reserved.
//  Generated using MVVM Module Generator by Adrián Bolaños
//

import UIKit
import RxSwift
import ImageViewer

final class CardDetailView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lbBoldName: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBoldSuperType: UILabel!
    @IBOutlet weak var lbSuperType: UILabel!
    @IBOutlet weak var lbBoldSubtypes: UILabel!
    @IBOutlet weak var lbSubTypes: UILabel!
    @IBOutlet weak var lbBoldTypes: UILabel!
    @IBOutlet weak var lbTypes: UILabel!
    @IBOutlet weak var lbBoldHP: UILabel!
    @IBOutlet weak var lbHP: UILabel!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var btnImage: UIButton!
    
    private var router = CardDetailRouter()
    private var viewModel = CardDetailViewModel()
    private var disposeBag = DisposeBag()
    var idCard: String?
    private var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Estilos
        loadStyles()
        // Vamos a obtener los datos
        getData()
    }
    
    
    // MARK: - Funciones privadas
    
    private func loadStyles(){
        // Fuentes
        lbBoldName.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldSuperType.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldSubtypes.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldTypes.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldHP.font = UIFont.boldSystemFont(ofSize: 20)
        // Textos
        lbBoldName.text = "name".localize()
        lbBoldSuperType.text = "supertype".localize()
        lbBoldSubtypes.text = "subtypes".localize()
        lbBoldTypes.text = "types".localize()
        lbBoldHP.text = "hp".localize()
    }
    
    private func getData(){
        guard let idCard = idCard else { return }
        return viewModel.getDetailCard(idCard: idCard).subscribe(
            onNext: { response in
                self.card = response
                DispatchQueue.main.async {
                    self.showData()
                }
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    private func showData(){
        if let card = card {
            lbName.text = card.name
            lbHP.text = card.hp
            lbSuperType.text = card.supertype
            
            // Revisamos los subtipos
            if let subtypes = card.subtypes {
                
                var stringSubtypes = ""
                
                for subtype in subtypes {
                    stringSubtypes += subtype
                    if !(subtypes.last?.elementsEqual(subtype))!{
                        stringSubtypes += ", "
                    }
                }
                lbSubTypes.text = stringSubtypes
            }
            
            // Revisamos los tipos
            if let types = card.types {
                
                var stringTypes = ""
                
                for type in types {
                    stringTypes += type
                    if !(types.last?.elementsEqual(type))!{
                        stringTypes += ", "
                    }
                }
                lbTypes.text = stringTypes
            }
            
            // Ponemos la imagen
            if let imageCard = card.images?.large {
                imgCard.sd_setImage(with: URL(string: imageCard), placeholderImage: UIImage(named: "pokeball"))
            }
        }
    }
    
    // MARK: - Acciones
    
    @IBAction func actionImage(_ sender: Any) {
        ImageViewer.show(imgCard, presentingVC: self)
    }
    
}
