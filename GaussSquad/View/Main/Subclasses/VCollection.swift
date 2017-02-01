import UIKit

class VCollection:UICollectionView
{
    weak var flow:UICollectionViewFlowLayout!
    
    convenience init()
    {
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsets.zero
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        self.init(flow:flow)
    }
    
    init(flow:UICollectionViewFlowLayout)
    {
        super.init(frame:CGRect.zero, collectionViewLayout:flow)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        self.flow = flow
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func registerCell(cell:UICollectionViewCell.Type)
    {
        register(
            cell,
            forCellWithReuseIdentifier:cell.reusableIdentifier)
    }
    
    func registerFooter(footer:UICollectionReusableView.Type)
    {
        register(
            footer,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:footer.reusableIdentifier)
    }
    
    func registerHeader(header:UICollectionReusableView.Type)
    {
        register(
            header,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:header.reusableIdentifier)
    }
}
