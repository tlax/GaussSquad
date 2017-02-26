import UIKit

class VLinearEquationsPlotMenu:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquationsPlot!
    private weak var collectionView:VCollection!
    private let kCellWidth:CGFloat = 140
    private let kInterLine:CGFloat = 1
    private let kBorderHeight:CGFloat = 1
    private let kDeselectTime:TimeInterval = 0.2
    
    init(controller:CLinearEquationsPlot)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let blur:VBlur = VBlur.light()
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsPlotMenuCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.minimumInteritemSpacing = kInterLine
            flow.minimumLineSpacing = kInterLine
            flow.sectionInset = UIEdgeInsets(
                top:0,
                left:kInterLine,
                bottom:0,
                right:kInterLine)
        }
        
        addSubview(blur)
        addSubview(collectionView)
        addSubview(border)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
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
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MPlotMenuItem
    {
        let item:MPlotMenuItem = controller.model.modelMenu!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width:kCellWidth, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        guard
        
            let count:Int = controller.model.modelMenu?.items.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MPlotMenuItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsPlotMenuCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsPlotMenuCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsPlotMenuCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MPlotMenuItem = modelAtIndex(index:indexPath)
        controller.viewPlot.centerItem(item:item)
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
        
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
