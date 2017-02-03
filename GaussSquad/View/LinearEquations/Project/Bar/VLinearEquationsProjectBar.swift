import UIKit

class VLinearEquationsProjectBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var viewIndeterminates:VLinearEquationsProjectBarIndeterminates!
    private weak var controller:CLinearEquationsProject!
    private weak var collectionView:VCollection!
    private let model:MLinearEquationsProjectBar
    private let kDeselectTime:TimeInterval = 0.2
    private let kContentTop:CGFloat = 20
    private let kCellWidth:CGFloat = 60
    private let kCollectionHeight:CGFloat = 60
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CLinearEquationsProject)
    {
        model = MLinearEquationsProjectBar()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let collectionView:VCollection = VCollection()
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsBarCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let viewIndeterminates:VLinearEquationsProjectBarIndeterminates = VLinearEquationsProjectBarIndeterminates(
            controller:controller)
        self.viewIndeterminates = viewIndeterminates
        
        addSubview(border)
        addSubview(collectionView)
        addSubview(viewIndeterminates)
        
        NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewIndeterminates,
            toView:collectionView)
        NSLayoutConstraint.bottomToBottom(
            view:viewIndeterminates,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewIndeterminates,
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
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsProjectBarItem
    {
        let item:MLinearEquationsProjectBarItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.size.height
        let cellSize:CGSize = CGSize(width:kCellWidth, height:height)
        
        return cellSize
    }
    
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
        let item:MLinearEquationsProjectBarItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsBarCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsBarCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsBarCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MLinearEquationsProjectBarItem = modelAtIndex(index:indexPath)
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
