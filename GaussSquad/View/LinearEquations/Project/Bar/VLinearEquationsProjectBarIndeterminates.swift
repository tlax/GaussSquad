import UIKit

class VLinearEquationsProjectBarIndeterminates:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquationsProject!
    private weak var collectionView:VCollection!
    private weak var button:UIButton!
    private let kButtonLeft:CGFloat = -18
    private let kButtonSize:CGFloat = 40
    private let kTitleMargin:CGFloat = 10
    private let kTitleWidth:CGFloat = 100
    private let kCellSize:CGFloat = 55
    private let kDeselectTime:TimeInterval = 0.2
    
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
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            #imageLiteral(resourceName: "assetGenericAddIndeterminate").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        button.setImage(
            #imageLiteral(resourceName: "assetGenericAddIndeterminate").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        button.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        button.imageView!.clipsToBounds = true
        button.imageView!.contentMode = UIViewContentMode.center
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        self.button = button
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsProjectBarIndeterminatesCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.itemSize = CGSize(width:kCellSize, height:kCellSize)
        }
        
        addSubview(labelTitle)
        addSubview(button)
        addSubview(collectionView)
        
        NSLayoutConstraint.height(
            view:collectionView,
            constant:kCellSize)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
     
        NSLayoutConstraint.bottomToTop(
            view:labelTitle,
            toView:collectionView)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kButtonSize)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kTitleMargin)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:button,
            toView:labelTitle)
        NSLayoutConstraint.leftToRight(
            view:button,
            toView:labelTitle,
            constant:kButtonLeft)
        NSLayoutConstraint.width(
            view:button,
            constant:kButtonSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller.addIndeterminate()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> DIndeterminate
    {
        let indeterminate:DIndeterminate = controller.model.project!.indeterminates!.array[
            index.item] as! DIndeterminate
        
        return indeterminate
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.isUserInteractionEnabled = true
        button.isUserInteractionEnabled = true
        collectionView.reloadData()
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
        let indeterminate:DIndeterminate = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsProjectBarIndeterminatesCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsProjectBarIndeterminatesCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsProjectBarIndeterminatesCell
        cell.config(indeterminate:indeterminate)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
            collectionView?.isUserInteractionEnabled = true
        }
    }
}
