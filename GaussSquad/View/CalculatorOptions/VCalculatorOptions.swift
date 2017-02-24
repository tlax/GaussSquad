import UIKit

class VCalculatorOptions:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCalculatorOptions!
    private weak var collectionView:VCollection!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kBaseHeight:CGFloat = 280
    private let kAnimationDuration:TimeInterval = 0.25
    private let kCellHeight:CGFloat = 50
    private let kHeaderHeight:CGFloat = 60
    private let kCollectionBottom:CGFloat = 20
    private let kInterItem:CGFloat = 1
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCalculatorOptions
        
        let blur:VBlur = VBlur.dark()
        
        let closeButton:UIButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewBase:UIView = UIView()
        viewBase.backgroundColor = UIColor(white:0.95, alpha:1)
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(header:VCalculatorOptionsHeader.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
            flow.minimumInteritemSpacing = kInterItem
            flow.minimumLineSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:0,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        viewBase.addSubview(collectionView)
        addSubview(blur)
        addSubview(closeButton)
        addSubview(viewBase)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:closeButton,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewBase,
            constant:kBaseHeight)
        layoutBaseBottom = NSLayoutConstraint.bottomToBottom(
            view:viewBase,
            toView:self,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:viewBase)
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
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: public
    
    func viewAppeared()
    {
        layoutBaseBottom.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
    }
}
