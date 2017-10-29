//
//  ImageDescriptionCard.swift
//  raybancards
//
//  Created by Luis Ezcurdia on 9/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    let topContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "white-closed")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let textView : UITextView = {
        let lbl = UITextView()
        lbl.isEditable = false
        lbl.isScrollEnabled = false
        lbl.backgroundColor = .clear
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var item : Item? {
        didSet {
            guard let unwrapedItem = item else { return }
            self.imageView.image = unwrapedItem.image
            updateTextView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        self.backgroundColor = UIColor(named: "yellow")!
        addSubview(topContainer)
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        topContainer.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: topContainer.heightAnchor, multiplier: 0.75)
        ])

        addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }

    func updateTextView() {
        let attributedText = NSMutableAttributedString(string: (item?.name ?? ""), attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 24)])
        attributedText.append(NSAttributedString(string: "\n\n\n\(item?.description ?? "")", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
    }
}
