import UIKit

class VLinearEquationsProject:VView, UICollectionViewDelegate, UICollectionViewDataSource
{
    private enum Drag
    {
        case stand
        case restart
        case avoid
    }
    
    private weak var controller:CLinearEquationsProject!
    private weak var viewBar:VLinearEquationsProjectBar!
    private weak var viewControls:VLinearEquationsProjectControls!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private weak var layoutBarTop:NSLayoutConstraint!
    private weak var layoutCollectionLeft:NSLayoutConstraint!
    private weak var layoutControlsRight:NSLayoutConstraint!
    private var drag:Drag
    private let kBarHeight:CGFloat = 210
    private let kControlsMinThreshold:CGFloat = 5
    private let kControlsExtraThreshold:CGFloat = 30
    private let kControlsMenuThreshold:CGFloat = 60
    private let kControlsMaxThreshold:CGFloat = 180
    private let kExtraSpeed:CGFloat = 3
    private let kDeselectTime:TimeInterval = 0.2
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        drag = Drag.stand
        
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsProject
        
        let viewBar:VLinearEquationsProjectBar = VLinearEquationsProjectBar(
            controller:self.controller)
        viewBar.isHidden = true
        self.viewBar = viewBar
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let flow:VLinearEquationsProjectFlow = VLinearEquationsProjectFlow(
            model:self.controller.model,
            barHeight:kBarHeight)
        let collectionView:VCollection = VCollection(flow:flow)
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellIndex.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellPolynomialDecimal.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellPolynomialDivision.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellEquals.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellNewPolynomial.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellNewRow.self)
        self.collectionView = collectionView
        
        let viewControls:VLinearEquationsProjectControls = VLinearEquationsProjectControls(
            controller:self.controller,
            barHeight:kBarHeight)
        self.viewControls = viewControls
        
        addSubview(viewControls)
        addSubview(collectionView)
        addSubview(viewBar)
        addSubview(spinner)
        
        layoutBarTop = NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:collectionView,
            toView:self)
        layoutCollectionLeft = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:viewControls,
            toView:self)
        layoutControlsRight = NSLayoutConstraint.rightToLeft(
            view:viewControls,
            toView:self)
        NSLayoutConstraint.width(
            view:viewControls,
            constant:kControlsMaxThreshold)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsProjectRowItem
    {
        let item:MLinearEquationsProjectRowItem = controller.model.rows[index.section].items[index.item]
        
        return item
    }
    
    private func restartingScroll()
    {
        drag = Drag.avoid
        layoutControlsRight.constant = 0
        layoutCollectionLeft.constant = 0
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            { [weak self] in
                
                self?.layoutIfNeeded()
            })
        { [weak self] (done:Bool) in
            
            self?.drag = Drag.stand
        }
    }
    
    //MARK: public
    
    func refresh()
    {
        restartingScroll()
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        viewBar.isHidden = false
        viewBar.viewIndeterminates.refresh()
        viewControls.refresh()
    }
    
    func startLoading()
    {
        spinner.startAnimating()
        collectionView.isHidden = true
        viewBar.isHidden = true
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
        
        switch drag
        {
        case Drag.stand:
            
            let offsetX:CGFloat = -scrollView.contentOffset.x
            let controlsWidth:CGFloat
            
            if offsetX < 0
            {
                controlsWidth = 0
            }
            else
            {
                let extraDelta:CGFloat = offsetX - kControlsExtraThreshold
                let extraWidth:CGFloat
                
                if extraDelta > 0
                {
                    extraWidth = kExtraSpeed * extraDelta
                }
                else
                {
                    extraWidth = 0
                }
                
                controlsWidth = offsetX + extraWidth
            }
            
            layoutControlsRight.constant = controlsWidth
            
            break
            
        case Drag.restart:
            
            restartingScroll()
            
            break
            
        case Drag.avoid:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView)
    {
        switch drag
        {
        case Drag.restart:
            
            drag = Drag.stand
            
            break
            
        case Drag.avoid:
            
            drag = Drag.restart
            
            break
            
        default:
            
            break
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView:UIScrollView, willDecelerate decelerate:Bool)
    {
        let controlsWidth:CGFloat = layoutControlsRight.constant
        
        if controlsWidth > kControlsMinThreshold
        {
            drag = Drag.avoid
            
            let newControlsWidth:CGFloat
            
            if controlsWidth > kControlsMenuThreshold
            {
                newControlsWidth = kControlsMaxThreshold
            }
            else
            {
                newControlsWidth = kControlsMenuThreshold
            }
            
            layoutControlsRight.constant = newControlsWidth
            layoutCollectionLeft.constant = newControlsWidth
            
            UIView.animate(
                withDuration:kAnimationDuration)
            { [weak self] in
                
                self?.layoutIfNeeded()
            }
        }
        else
        {
            drag = Drag.stand
        }
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int = controller.model.rows.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.rows[section].items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsProjectRowItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsProjectCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VLinearEquationsProjectCell
        cell.config(model:item, indexPath:indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        if drag == Drag.restart
        {
            restartingScroll()
        }
        else
        {
            let item:MLinearEquationsProjectRowItem = modelAtIndex(index:indexPath)
            item.selected(controller:controller)
        }
        
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
