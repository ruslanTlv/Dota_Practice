//
//  CustomCollectionViewCell.swift
//  CollevtionView
//
//  Created by Ruslan on 02/07/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let ID = "CustomCollectionViewCell"
    
    var characters: Characters? {
        didSet{
            guard let characters = characters else {
                return
            }
            characterName.text = characters.localized_name
        }
    }
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        return indicator
    }()
    
    let characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGreen
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(characterImage)
        contentView.addSubview(characterName)
        contentView.addSubview(indicator)
        indicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        characterImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(0)
            make.bottom.equalTo(contentView).inset(20)
        }
        
        characterName.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(characterImage.snp_bottomMargin).inset(-10)
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
        }
    }
}
