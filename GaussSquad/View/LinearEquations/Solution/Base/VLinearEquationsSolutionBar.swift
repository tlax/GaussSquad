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
    private let kCellSize:CGFloat = 70
    private let kDeselectTime:TimeInterval = 0.25
    
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
        collectionView.registerCell(cell:VLinearEquationsSolutionBarCell.self)
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
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsSolutionBarItem
    {
        let item:MLinearEquationsSolutionBarItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsSolutionBarItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsSolutionBarCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsSolutionBarCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsSolutionBarCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MLinearEquationsSolutionBarItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
