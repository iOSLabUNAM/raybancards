//
//  ViewController.swift
//  raybancards
//
//  Created by Luis Ezcurdia on 9/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let prevButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PREV", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        return btn
    }()
    private let nextButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("NEXT", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btn.isEnabled = true
        btn.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return btn
    }()
    private lazy var pageControl :UIPageControl = {
        let pg = UIPageControl()
        pg.currentPage = 0
        pg.numberOfPages = items.count
        return pg
    }()

    lazy var container: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
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
        container.register(ImageDescriptionCard.self, forCellWithReuseIdentifier: cellId)
        setupLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupLayout() {
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let navControllerView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        navControllerView.translatesAutoresizingMaskIntoConstraints = false
        navControllerView.distribution = .fillEqually
        view.addSubview(navControllerView)
        NSLayoutConstraint.activate([
            navControllerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navControllerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navControllerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navControllerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func prevPage() {
        pageControl.currentPage -= 1
        let index = IndexPath(item: pageControl.currentPage, section: 0)
        container.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        nextButton.isEnabled = true
        if pageControl.currentPage == 0 {
            prevButton.isEnabled = false
        }
    }
    
    @objc func nextPage() {
        pageControl.currentPage += 1
        let index = IndexPath(item: pageControl.currentPage, section: 0)
        container.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        prevButton.isEnabled = true
        if pageControl.currentPage + 1 == items.count {
            nextButton.isEnabled = false
        }
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
        cell.backgroundColor = UIColor(named: "yellow")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
