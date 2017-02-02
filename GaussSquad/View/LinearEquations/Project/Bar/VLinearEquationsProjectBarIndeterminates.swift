import UIKit

class VLinearEquationsProjectBarIndeterminates:UIView
{
    private weak var controller:CLinearEquationsProject!
    private weak var collectionView:VCollection!
    private let kCollectionHeight:CGFloat = 60
    private let kTitleHeight:CGFloat = 20
    private let kTitleMargin:CGFloat = 10
    
    init(controller:CLinearEquationsProject)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.regular(size:14)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VLinearEquationsProjectBarIndeterminates_title", comment:"")
        
        let collectionView:VCollection = VCollection()
        self.collectionView = collectionView
        
        addSubview(labelTitle)
        addSubview(collectionView)
        
        NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
     
        NSLayoutConstraint.bottomToTop(
            view:labelTitle,
            toView:collectionView)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self,
            margin:kTitleMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
