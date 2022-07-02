//
//  FirstScreenViewController.swift
//  CollevtionView
//
//  Created by Ruslan on 01/07/22.
//

import UIKit
import SnapKit

class FirstScreenViewController: UIViewController {

    let json = Json()
  
    var arrayOfCharacters: [Characters] = []
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/5)-4)
        return layout
    }()
    
    lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.ID)
        collection.backgroundColor = .black
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        title = "Characters"
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Futura", size: 25)!]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.barTintColor = .black
        navigationItem.backButtonTitle = "Back"
        
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        json.json{ data in
            self.arrayOfCharacters = data
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collection.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(0)
            make.left.right.equalToSuperview().inset(1.5)
        }
    }
}

extension FirstScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.ID, for: indexPath) as! CustomCollectionViewCell
        cell.characters = arrayOfCharacters[indexPath.row]
        
        let url = "https://api.opendota.com\(arrayOfCharacters[indexPath.row].img)"
        guard let url = URL(string: url) else {return CustomCollectionViewCell()}

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {return}

            DispatchQueue.main.sync {
                cell.characterImage.image = UIImage(data: data)
                cell.indicator.stopAnimating()
            }
        } .resume()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = GeneralInfoViewController()
        
        let url = URL(string: "https://api.opendota.com\(arrayOfCharacters[indexPath.row].img)")
        
        guard let url = url else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {return}
           
            DispatchQueue.main.async {
                vc.imageData = data
                vc.characterName = self.arrayOfCharacters[indexPath.row].localized_name
                self.navigationController?.pushViewController(vc, animated: true)
            }
             
        } .resume()
    }
}
