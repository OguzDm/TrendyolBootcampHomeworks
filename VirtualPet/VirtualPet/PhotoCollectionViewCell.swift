//
//  PhotoCollectionViewCell.swift
//  VirtualPet
//
//  Created by Oguz Demırhan on 14.05.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    static let reuseIdentifer = "photoCell"
    let featuredPhotoView = UIImageView()
      
      override init(frame: CGRect) {
          
          super.init(frame: frame)
        
        featuredPhotoView.contentMode = .scaleAspectFill
        featuredPhotoView.layer.masksToBounds = true
        
      }

      required init?(coder: NSCoder) {
          
          fatalError("init(coder:) has not been implemented")
      }
      
      func configure(withImageName name: Data?) {
        
        
          
          featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false

          contentView.addSubview(featuredPhotoView)
          
          NSLayoutConstraint.activate([

              featuredPhotoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              featuredPhotoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              featuredPhotoView.topAnchor.constraint(equalTo: contentView.topAnchor),
              featuredPhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
          ])

        featuredPhotoView.image = UIImage(data: name!)
      }
}
