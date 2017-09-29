//
//  ViewController.swift
//  raybancards
//
//  Created by Luis Ezcurdia on 9/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var container: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let cellId = "cellId"
    
    let items : [Item] = {
        let item1 = Item(image: UIImage(named: "black-open")!,
                         name: "Black Rayban",
                         description: "lorem ipsum dolor quet sit amet consectetur adipsum eluit")
        let item2 = Item(image: UIImage(named: "black-closed")!,
                         name: "Black Rayban Summer",
                         description: "lorem ipsum dolor quet sit amet consectetur adipsum eluit")
        let item3 = Item(image: UIImage(named: "white-open")!,
                         name: "White Rayban",
                         description: "lorem ipsum dolor quet sit amet consectetur adipsum eluit")
        let item4 = Item(image: UIImage(named: "white-closed")!,
                         name: "White Rayban Summer",
                         description: "lorem ipsum dolor quet sit amet consectetur adipsum eluit")
        return [item1, item2, item3, item4]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.95, green:0.81, blue:0.33, alpha:1.00)
        setupSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupSubviews() {
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        container.register(ImageDescriptionCard.self, forCellWithReuseIdentifier: cellId)
    }

}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageDescriptionCard
        let item = items[indexPath.row]
        cell.title = item.name
        cell.content = item.description
        cell.image = item.image
        cell.backgroundColor = UIColor(red:0.95, green:0.81, blue:0.33, alpha:1.00)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
