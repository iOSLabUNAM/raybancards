//
//  ImageDescriptionCard.swift
//  raybancards
//
//  Created by Luis Ezcurdia on 9/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ImageDescriptionCard: UICollectionViewCell {
    let topContainer : UIView = {
        let view = UIView()
        return view
    }()
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "white-closed")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let textView : UITextView = {
        let lbl = UITextView()
        lbl.isEditable = false
        lbl.isScrollEnabled = false
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    var image : UIImage? {
        didSet { self.imageView.image = self.image }
    }
    var title : String? {
        didSet { updateTextView() }
    }
    var content : String? {
        didSet { updateTextView() }
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
        addSubview(topContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        topContainer.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: topContainer.heightAnchor, multiplier: 0.75)
        ])

        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        ])
    }

    func updateTextView() {
        let attributedText = NSMutableAttributedString(string: (title ?? ""), attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 24)])
        attributedText.append(NSAttributedString(string: "\n\n\n\(content ?? "")", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
    }
}
