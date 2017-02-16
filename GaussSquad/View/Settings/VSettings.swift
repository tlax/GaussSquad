import UIKit

class VSettings:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CSettings!
    private weak var collectionView:VCollection!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0.95, alpha:1)
        self.controller = controller as? CSettings
        
        let collectionView:VCollection = VCollection()
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
