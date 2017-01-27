import UIKit

class VHome:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHome!
    private weak var collectionView:VCollection!
    private let kCollectionTop:CGFloat = 70
    private let kCollectionBottom:CGFloat = 10
    private let kCollectionInterline:CGFloat = 1
    private let kCellHeight:CGFloat = 100
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0.96, alpha:1)
        self.controller = controller as? CHome
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.minimumLineSpacing = kCollectionInterline
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
