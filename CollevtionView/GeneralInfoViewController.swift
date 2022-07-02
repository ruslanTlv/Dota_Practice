//
//  GeneralInfoViewController.swift
//  CollevtionView
//
//  Created by Ruslan on 02/07/22.
//

import UIKit

class GeneralInfoViewController: UIViewController {
    
    var imageData: Data!
    var characterName: String!
    
    lazy var imageView: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(data: imageData)
        photo.contentMode = .scaleAspectFill
        photo.layer.cornerRadius = 10
        photo.clipsToBounds = true
        return photo
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.text = characterName
        label.font = UIFont(name: "Chalkduster", size: 35)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(imageView)
        view.addSubview(name)
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(150)
        }
        
        name.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp_bottomMargin).inset(-30)
        }
    }

}
