import UIKit

class VLinearEquationsProjectBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private var model:MLinearEquationsProjectBar?
    private weak var controller:CLinearEquationsProject!
    private weak var collectionView:VCollection!
    
    init(controller:CLinearEquationsProject)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func refresh(project:DProject)
    {
        model = MLinearEquationsProjectBar(project:project)
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
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
}
