import UIKit

class VLinearEquationsProjectBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private var model:MLinearEquationsProjectBar?
    private weak var controller:CLinearEquationsProject!
    private weak var collectionView:VCollection!
    private let kContentTop:CGFloat = 20
    private let kCellWidth:CGFloat = 70
    
    init(controller:CLinearEquationsProject)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLinearEquationsBarCellButton.self)
        collectionView.registerCell(cell:VLinearEquationsBarCellReport.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        NSLayoutConstraint.topToTop(
            view:self,
            toView:collectionView,
            constant:kContentTop)
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
    
    override func layoutSubviews()
    {
        collectionView.flow.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsProjectBarItem
    {
        let item:MLinearEquationsProjectBarItem = model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh(project:DProject)
    {
        model = MLinearEquationsProjectBar(project:project)
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.size.height
        let cellSize:CGSize = CGSize(width:kCellWidth, height:height)
        
        return cellSize
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        guard
        
            let count:Int = model?.items.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsProjectBarItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsBarCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:item.reusableIdentifier,
            for:indexPath) as! VLinearEquationsBarCell
        cell.config(model:item)
        
        return cell
    }
}
