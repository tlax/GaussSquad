import UIKit

class VLinearEquationsSolutionBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquationsSolution!
    private weak var collectionView:VCollection!
    private let model:MLinearEquationsSolutionBar
    private let kContentTop:CGFloat = 20
    private let kBorderHeight:CGFloat = 1
    private let kCellWidth:CGFloat = 60
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
        
        let collectionView:VCollection = VCollection()
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsSolutionBarCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        
        addSubview(border)
        addSubview(collectionView)
        
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
            view:collectionView,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToTop(
            view:collectionView,
            toView:border)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsSolutionBarItem
    {
        let item:MLinearEquationsSolutionBarItem = model.items[index.item]
        
        return item
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
        collectionView.isUserInteractionEnabled = false
        let item:MLinearEquationsSolutionBarItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.isUserInteractionEnabled = true
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
