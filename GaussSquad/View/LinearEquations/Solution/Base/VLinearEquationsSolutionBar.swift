import UIKit

class VLinearEquationsSolutionBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private let model:MLinearEquationsSolutionBar
    private weak var controller:CLinearEquationsSolution!
    private weak var collectionView:VCollection!
    private let kBorderHeight:CGFloat = 1
    private let kBackTop:CGFloat = 20
    private let kBackWidth:CGFloat = 60
    private let kBackHeight:CGFloat = 44
    private let kCellSize:CGFloat = 60
    
    init(controller:CLinearEquationsSolution)
    {
        model = MLinearEquationsSolutionBar()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let collectionView:VCollection = VCollection()
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        if let flow:UICollectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.itemSize = CGSize(width:kCellSize, height:kCellSize)
            flow.sectionInset = UIEdgeInsets(
                top:0,
                left:kBackWidth,
                bottom:0,
                right:0)
        }
        
        addSubview(border)
        addSubview(collectionView)
        addSubview(buttonBack)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:self,
            constant:kBackTop)
        NSLayoutConstraint.height(
            view:buttonBack,
            constant:kBackHeight)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kBackWidth)
        
        NSLayoutConstraint.height(
            view:collectionView,
            constant:kCellSize)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: public
    
    func refresh()
    {
        
    }
}
