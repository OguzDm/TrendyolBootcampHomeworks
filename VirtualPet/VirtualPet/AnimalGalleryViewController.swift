//
//  AnimalGalleryViewController.swift
//  VirtualPet
//
//  Created by Oguz Demırhan on 14.05.2021.
//

import UIKit
import CoreData

class AnimalGalleryViewController: UIViewController {
    
    private var collectionView : UICollectionView!
    
    var tempImages = [Data?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        configure()
    }
    
    private func configure() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifer)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = #colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1)
        
        view.addSubview(collectionView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getPhotosFromCoreData()
    }
    
    func getPhotosFromCoreData() {
        
        tempImages.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Animal")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let image = result.value(forKey: "image") as? Data else { continue }
                    
                    tempImages.append(image)
                    print(tempImages.count)
                }
                self.collectionView.reloadData()
            } else {
                //TODO:
            }
        } catch {
            print("Error")
        }
        
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let leftitemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let leftItem = NSCollectionLayoutItem(layoutSize: leftitemSize)
        leftItem.contentInsets = NSDirectionalEdgeInsets(top: 1.5, leading: 1.5, bottom: 1.5, trailing: 1.5)
        let leftGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let leftLeftGroup = NSCollectionLayoutGroup.vertical(layoutSize: leftGroupSize, subitem: leftItem, count: 2)
        let leftRightGroup = NSCollectionLayoutGroup.vertical(layoutSize: leftGroupSize, subitem: leftItem, count: 2)
        
        
        let rightItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let rightItem = NSCollectionLayoutItem(layoutSize: rightItemSize)
        rightItem.contentInsets = NSDirectionalEdgeInsets(top: 1.5, leading: 1.5, bottom: 1.5, trailing: 1.5)
        let rightGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let rightGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rightGroupSize, subitem: rightItem, count: 1)
        
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [leftLeftGroup,leftRightGroup, rightGroup])
        
        let section = NSCollectionLayoutSection(group: outerGroup)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    


}

extension AnimalGalleryViewController : UICollectionViewDelegate {
    
}

extension AnimalGalleryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tempImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifer, for: indexPath) as! PhotoCollectionViewCell
        
        cell.configure(withImageName: tempImages[indexPath.item])
        
        return cell
    }
    
    
}
