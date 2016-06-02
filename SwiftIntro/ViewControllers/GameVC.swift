//
//  GameVC.swift
//  SwiftIntro
//
//  Created by Alexander Georgii-Hemming Cyon on 01/06/16.
//  Copyright © 2016 SwiftIntro. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSourceAndDelegate: MemoryDataSourceAndDelegate! {
        didSet {
            collectionView.dataSource = dataSourceAndDelegate
            collectionView.delegate = dataSourceAndDelegate
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchData()
    }
}

private extension GameVC {
    private func setupViews() {
        collectionView.registerNib(CardCVCell.nib, forCellWithReuseIdentifier: CardCVCell.cellIdentifier)
    }

    private func fetchData() {
        showLoader()
        APIClient.sharedInstance.getPhotos {
            (result: Result<MediaModel>) in
            self.hideLoader()
            guard let model = result.model else { return }
            let cards = model.cardModels
            self.dataSourceAndDelegate = MemoryDataSourceAndDelegate(cards)
        }
    }
}