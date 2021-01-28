//
//  CardViewCell.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import VerticalCardSwiper

class CardViewCell: CardCell {
    
    @IBOutlet weak var goodImages:UIImageView!
    @IBOutlet weak var placeNameLabel:UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        placeNameLabel.font = .boldSystemFont(ofSize: 30.0)
        placeNameLabel.font = placeNameLabel.font.withSize(25.0)
        placeNameLabel.textColor = .white
        goodImages.adjustsImageSizeForAccessibilityContentSizeCategory = true
        goodImages.layer.cornerRadius = 20.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    public func setRandomBackgroundColor(){
        let randomRed: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = 12
        super.layoutSubviews()
    }
}
