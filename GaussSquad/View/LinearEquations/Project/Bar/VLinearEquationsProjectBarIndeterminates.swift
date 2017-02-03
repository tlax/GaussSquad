import UIKit

class VLinearEquationsProjectBarIndeterminates:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquationsProject!
    private weak var collectionView:VCollection!
    private let kCollectionHeight:CGFloat = 50
    private let kTitleHeight:CGFloat = 20
    private let kTitleMargin:CGFloat = 10
    private let kCellWidth:CGFloat = 40
    private let kHeaderWidth:CGFloat = 70
    
    init(controller:CLinearEquationsProject)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.regular(size:12)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VLinearEquationsProjectBarIndeterminates_title", comment:"")
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(header:VLinearEquationsProjectBarIndeterminatesHeader.self)
        collectionView.registerCell(cell:VLinearEquationsProjectBarIndeterminatesCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.headerReferenceSize = CGSize(width:kHeaderWidth, height:0)
            flow.itemSize = CGSize(width:kCellWidth, height:kCollectionHeight)
        }
        
        addSubview(labelTitle)
        addSubview(collectionView)
        
        NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
     
        NSLayoutConstraint.bottomToTop(
            view:labelTitle,
            toView:collectionView)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self,
            margin:kTitleMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if let indeterminates:Int = controller.model.project?.indeterminates?.count
        {
            count = indeterminates
        }
        else
        {
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VLinearEquationsProjectBarIndeterminatesCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsProjectBarIndeterminatesCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsProjectBarIndeterminatesCell
        
        return cell
    }
}
