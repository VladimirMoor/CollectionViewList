//
//  MainViewController.swift
//  CollectionViewList
//
//  Created by Vladimir on 17.05.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    
    
    let section = [0]
    var numbers = [0,1,2,3,4,5,6,7,8,9,10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, num) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.createCell(), for: indexPath, item: num)
            return cell
            
        })
            
        var listSnapshot = dataSource.snapshot()
        listSnapshot.appendSections(section)
        for sec in section {
        listSnapshot.appendItems(numbers, toSection: sec)
        }
        dataSource.apply(listSnapshot)
        
    }
    
    func createCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Int> {
        let cell = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { (cell, indexPath, number) in
            
            var content = cell.defaultContentConfiguration()
            content.text = "Section: \(indexPath.section) Row: \(indexPath.row)"
            
            cell.contentConfiguration = content
            
            var bgConf = UIBackgroundConfiguration.listPlainCell()
            bgConf.backgroundColor = .systemTeal
            bgConf.cornerRadius = 5
            bgConf.strokeColor = .red
            bgConf.strokeWidth = 3
            bgConf.backgroundInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            cell.accessories = [.disclosureIndicator()]
            cell.backgroundConfiguration = bgConf
            
        }
        return cell
    }
}
