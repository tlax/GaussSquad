import UIKit

class VLinearEquationsProjectControls:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private var model:MLinearEquationsProjectControls?
    private weak var collectionView:VCollection!
    private weak var controller:CLinearEquationsProject!
    private let barHeight:CGFloat
    private let kCellWidth:CGFloat = 60
    private let kCellHeight:CGFloat = 50
    private let kBorderWidth:CGFloat = 1
    
    init(
        controller:CLinearEquationsProject,
        barHeight:CGFloat)
    {
        self.barHeight = barHeight
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let collectionView:VCollection = VCollection()
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsProjectControlsCell.self)
        self.collectionView = collectionView

        if let flow:UICollectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            flow.itemSize = CGSize(width:kCellWidth, height:kCellHeight)
        }
        
        addSubview(border)
        addSubview(collectionView)
        
        NSLayoutConstraint.equalsVertical(
            view:border,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:border,
            toView:self)
        NSLayoutConstraint.width(
            view:border,
            constant:kBorderWidth)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsProjectControlsItem
    {
        let item:MLinearEquationsProjectControlsItem = model!.items[index.section][index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        model = MLinearEquationsProjectControls(
            project:controller.model)
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let top:CGFloat
        let width:CGFloat = collectionView.bounds.maxX
        let items:CGFloat = CGFloat(model!.items[section].count)
        let itemsWidth:CGFloat = items * kCellWidth
        let remain:CGFloat = width - itemsWidth
        
        if section == 0
        {
            top = barHeight
        }
        else
        {
            top = 0
        }
        
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:top,
            left:remain,
            bottom:0,
            right:0)
        
        return insets
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int
        
        if let model:MLinearEquationsProjectControls = self.model
        {
            count = model.items.count
        }
        else
        {
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model!.items[section].count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsProjectControlsItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsProjectControlsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsProjectControlsCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsProjectControlsCell
        cell.config(model:item)
        
        return cell
    }
}
