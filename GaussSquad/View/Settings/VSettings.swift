import UIKit

class VSettings:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CSettings!
    private weak var collectionView:VCollection!
    private let kCollectionTop:CGFloat = 70
    private let kCollectionBottom:CGFloat = 20
    private let kInterLine:CGFloat = 1
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0.97, alpha:1)
        self.controller = controller as? CSettings
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VSettingsCellFractionDigits.self)
        collectionView.registerCell(cell:VSettingsCellSupport.self)
        collectionView.registerCell(cell:VSettingsCellReview.self)
        collectionView.registerCell(cell:VSettingsCellShare.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumInteritemSpacing = kInterLine
            flow.minimumLineSpacing = kInterLine
            flow.sectionInset = UIEdgeInsets(
                top:kCollectionTop,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSettingsItem
    {
        let item:MSettingsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MSettingsItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.size.width
        let size:CGSize = CGSize(width:width, height:item.cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSettingsItem = modelAtIndex(index:indexPath)
        let cell:VSettingsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VSettingsCell
        cell.config(controller:controller, model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
