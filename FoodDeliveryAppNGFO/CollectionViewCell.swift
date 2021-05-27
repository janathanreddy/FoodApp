//
//  CollectionViewCell.swift
//  FoodDeliveryAppNGFO
//
//  Created by Admin Macappstudio on 27/05/21.
//

import UIKit

class CollectionViewCell1: UICollectionViewCell {
   
    @IBOutlet weak var imagecell1: UIImageView!
    @IBOutlet weak var viewcell1: UIView!
    @IBOutlet weak var details: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func awakeFromNib() {
        details.layer.cornerRadius = 8
        details.layer.masksToBounds = true
        
    }
    
}
class CollectionViewCell2: UICollectionViewCell {
   
    @IBOutlet weak var imagecell2: UIImageView!
    @IBOutlet weak var labelcell2: UILabel!
    override func awakeFromNib() {
        let radius: CGFloat = 10

        self.contentView.layer.cornerRadius = radius
        // Always mask the inside view
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        // Never mask the shadow as it falls outside the view
        self.layer.masksToBounds = false

        // Matching the contentView radius here will keep the shadow
        // in sync with the contentView's rounded shape
        self.layer.cornerRadius = radius
    }
}
