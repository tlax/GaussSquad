import UIKit

class VLinearEquations:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquations!
    private weak var collectionView:VCollection!
    private weak var viewBar:VLinearEquationsBar!
    private weak var buttonBack:UIButton!
    private weak var buttonAdd:UIButton!
    private weak var spinner:VSpinner!
    private weak var layoutBarTop:NSLayoutConstraint!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private weak var layoutButtonAddLeft:NSLayoutConstraint!
    private let kDeselectTime:TimeInterval = 0.2
    private let kCellHeight:CGFloat = 180
    private let kCollectionBottom:CGFloat = 20
    private let kInterline:CGFloat = 1
    private let kBackTop:CGFloat = 20
    private let kBackWidth:CGFloat = 60
    private let kBackHeight:CGFloat = 44
    private let kButtonAddSize:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0.98, alpha:1)
        self.controller = controller as? CLinearEquations
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VLinearEquationsBar = VLinearEquationsBar(
            controller:self.controller)
        viewBar.isHidden = true
        self.viewBar = viewBar
        
        let buttonAdd:UIButton = UIButton()
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetGenericAdd"),
            for:UIControlState.normal)
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetGenericAddSelected"),
            for:UIControlState.highlighted)
        buttonAdd.imageView!.contentMode = UIViewContentMode.center
        buttonAdd.imageView!.clipsToBounds = true
        buttonAdd.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonAdd.isHidden = true
        self.buttonAdd = buttonAdd
        
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
        buttonBack.isHidden = true
        self.buttonBack = buttonBack
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterline
        }
        
        addSubview(spinner)
        addSubview(collectionView)
        addSubview(viewBar)
        addSubview(buttonBack)
        addSubview(buttonAdd)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:viewBar,
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
        
        layoutBarTop =  NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonAdd,
            toView:viewBar)
        NSLayoutConstraint.size(
            view:buttonAdd,
            constant:kButtonAddSize)
        layoutButtonAddLeft = NSLayoutConstraint.leftToLeft(
            view:buttonAdd,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        viewBar.layoutIfNeeded()
        let width:CGFloat = bounds.maxX
        let barMaxHeight:CGFloat = viewBar.border.frame.maxY
        let buttonAddRemain:CGFloat = width - kButtonAddSize
        let buttonAddMargin:CGFloat = buttonAddRemain / 2.0
        
        layoutBarHeight.constant = barMaxHeight
        layoutButtonAddLeft.constant = buttonAddMargin
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionAdd(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller.add()
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
        spinner.stopAnimating()
        collectionView.isHidden = false
        viewBar.isHidden = false
        buttonAdd.isHidden = false
        buttonAdd.isUserInteractionEnabled = true
        buttonBack.isHidden = false
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsItem
    {
        let item:MLinearEquationsItem = controller.model!.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        var offsetY:CGFloat = -scrollView.contentOffset.y
        
        if offsetY > 0
        {
            offsetY = 0
        }
        
        layoutBarTop.constant = offsetY
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let collectionTop:CGFloat = layoutBarHeight.constant
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:collectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        
        return insets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = bounds.width
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        guard
        
            let count:Int = controller.model?.items.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MLinearEquationsItem = modelAtIndex(index:indexPath)
        controller.selectedProject(model:item)
        
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
