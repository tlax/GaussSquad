import UIKit

class VLinearEquationsIndeterminateList:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquationsPolynomialIndeterminate!
    private weak var collectionView:VCollection!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kHeaderHeight:CGFloat = 60
    private let kCellHeight:CGFloat = 40
    private let kInterLine:CGFloat = 1
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
        baseView.backgroundColor = UIColor.white
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsIndeterminateListCell.self)
        collectionView.registerHeader(header:VLinearEquationsIndeterminateListHeader.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
            flow.minimumInteritemSpacing = kInterLine
        }
        
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
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VLinearEquationsIndeterminateListCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsIndeterminateListCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsIndeterminateListCell
        
        return cell
    }
}
