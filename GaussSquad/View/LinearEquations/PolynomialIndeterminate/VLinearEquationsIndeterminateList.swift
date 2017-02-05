import UIKit

class VLinearEquationsIndeterminateList:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquationsPolynomialIndeterminate!
    private weak var collectionView:VCollection!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kHeaderHeight:CGFloat = 52
    private let kCellHeight:CGFloat = 50
    private let kBorderHeight:CGFloat = 1
    private let kBaseHeight:CGFloat = 290
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsPolynomialIndeterminate
        
        let blur:VBlur = VBlur.dark()
        let borderTop:VBorder = VBorder(color:UIColor.black)
        
        let baseView:UIView = UIView()
        baseView.backgroundColor = UIColor.clear
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        
        let dismissButton:UIButton = UIButton()
        dismissButton.backgroundColor = UIColor.clear
        dismissButton.clipsToBounds = true
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(
            self,
            action:#selector(actionDimiss(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsIndeterminateListCell.self)
        collectionView.registerHeader(header:VLinearEquationsIndeterminateListHeader.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        }
        
        baseView.addSubview(collectionView)
        addSubview(blur)
        addSubview(dismissButton)
        addSubview(borderTop)
        addSubview(baseView)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:dismissButton,
            toView:self)
        
        NSLayoutConstraint.height(
            view:baseView,
            constant:kBaseHeight)
        layoutBaseBottom = NSLayoutConstraint.bottomToBottom(
            view:baseView,
            toView:self,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:baseView,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:borderTop,
            toView:baseView)
        NSLayoutConstraint.height(
            view:borderTop,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:borderTop,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:baseView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionDimiss(sender button:UIButton)
    {
        controller.close()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsIndeterminatesItem
    {
        let item:MLinearEquationsIndeterminatesItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func animateShow()
    {
        layoutBaseBottom.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
        
        guard
            
            let selected:Int = controller.model.selected
        
        else
        {
            return
        }
        
        let indexPath:IndexPath = IndexPath(item:selected, section:0)
        collectionView.selectItem(
            at:indexPath,
            animated:false,
            scrollPosition:UICollectionViewScrollPosition.centeredVertically)
    }
    
    func animateHide()
    {
        layoutBaseBottom.constant = kBaseHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let header:VLinearEquationsIndeterminateListHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VLinearEquationsIndeterminateListHeader.reusableIdentifier,
            for:indexPath) as! VLinearEquationsIndeterminateListHeader
        header.config(controller:controller)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsIndeterminatesItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsIndeterminateListCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsIndeterminateListCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsIndeterminateListCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MLinearEquationsIndeterminatesItem = modelAtIndex(index:indexPath)
        controller.selectIndeterminate(
            indeterminate:item.indeterminate)
    }
}
