//
//  SwipePageController.swift
//  raybancards
//
//  Created by Luis Ezcurdia on 10/25/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class SwipePageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let reuseIdentifier = "PageCell"
    private let prevButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PREV", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(tapPrev), for: .touchUpInside)
        return btn
    }()
    private let nextButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("NEXT", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btn.isEnabled = true
        btn.addTarget(self, action: #selector(tapNext), for: .touchUpInside)
        return btn
    }()
    private lazy var pageControl :UIPageControl = {
        let pg = UIPageControl()
        pg.currentPage = 0
        pg.numberOfPages = items.count
        return pg
    }()
    
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
        guard let collection = collectionView else { return }
        
        collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        collection.isPagingEnabled = true
        setupLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    private func setupLayout() {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let currentPage = Int(x / view.frame.width)
        pageControl.currentPage = currentPage
        enableButtons(for: currentPage)
    }
    
    @objc func tapPrev() {
        let prevPage = max(pageControl.currentPage - 1, 0)
        let index = IndexPath(item: prevPage, section: 0)
        pageControl.currentPage = prevPage
        enableButtons(for: prevPage)
        collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }

    @objc func tapNext() {
        let nextPage = min(pageControl.currentPage + 1, items.count - 1)
        let index = IndexPath(item: nextPage, section: 0)
        pageControl.currentPage = nextPage
        enableButtons(for: nextPage)
        collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    private func enableButtons(for currentPage: Int) {
        if currentPage > 0 && currentPage < items.count - 1 {
            prevButton.isEnabled = true
            nextButton.isEnabled = true
        } else if pageControl.currentPage == 0 {
            prevButton.isEnabled = false
        } else if pageControl.currentPage == items.count - 1 {
            nextButton.isEnabled = false
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

