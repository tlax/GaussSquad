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
    }
    
    func animateHide()
    {
        layoutBaseBottom.constant = kBaseHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
