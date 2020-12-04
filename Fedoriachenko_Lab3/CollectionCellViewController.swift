//
//  CollectionCellViewController.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 02.12.2020.
//

import UIKit

class CollectionCellViewController: UIViewController {

    @IBOutlet weak var cellCollectionView: UICollectionView!
    
    var photos: [PhotoCollectionCell] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellCollectionView.collectionViewLayout = CollectionCellViewController.createLayout()
        cellCollectionView.frame = .zero
        // Do any additional setup after loading the view.
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        // items
        
        // first horizontal group
        let firstVertItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/3)
            )
        )
        
        let FirstVertStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/5),
                heightDimension: .fractionalHeight(1)
            ),
            subitem: firstVertItem,
            count: 3
        )
        
        // second horizontal group
        let secondHorItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(3/5),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        // third horizontal group
        let thirdVertItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/3)
            )
        )
        
        let ThirdVertStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/5),
                heightDimension: .fractionalHeight(1)
            ),
            subitem: thirdVertItem,
            count: 3
        )
        // groups
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ),
            subitems: [FirstVertStackGroup, secondHorItem, ThirdVertStackGroup]
//            subitems: [FirstVertStackGroup]
        )
        
        let vertGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(3/5)
            ),
            subitems: [group]
        )

        // sections
        let section = NSCollectionLayoutSection(group: vertGroup)
        
        // return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    @IBAction func didPressButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
}

extension CollectionCellViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            photos.append(PhotoCollectionCell(image: image))
            cellCollectionView.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CollectionCellViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        let photo = photos[indexPath.item]
        
        cell.setPhoto(photo: photo)
        cell.cellImage.clipsToBounds = true
        cell.cellImage.contentMode = .scaleAspectFill
        
        return cell
    }
}
