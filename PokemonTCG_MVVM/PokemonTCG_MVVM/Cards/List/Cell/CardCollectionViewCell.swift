//
//  CardCollectionViewCell.swift
//  PokemonTCG_MVVM
//
//  Created by Adrián Bolaños Ríos on 23/04/2021.
//

import UIKit
import SDWebImage

class CardCollectionViewCell: UICollectionViewCell {
    
    static let kIdentifier = "CardCollectionViewCell"
    
    @IBOutlet weak var imgBack: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgBack.image = nil
    }
    
    func loadData(card: Card){
        if let imageCard = card.images?.small {
            imgBack.sd_setImage(with: URL(string: imageCard), placeholderImage: UIImage(named: "pokeball"))
        }
        
    }

}
