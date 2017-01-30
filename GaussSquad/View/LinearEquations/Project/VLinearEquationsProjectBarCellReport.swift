import UIKit

class VLinearEquationsBarCellReport:VLinearEquationsBarCell
{
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private weak var labelCount:UILabel!
    private let kTitleHeight:CGFloat = 16
    private let kCountHeight:CGFloat = 25
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.medium(size:12)
        self.labelTitle = labelTitle
        
        let labelCount:UILabel = UILabel()
        labelCount.isUserInteractionEnabled = false
        labelCount.translatesAutoresizingMaskIntoConstraints = false
        labelCount.font = UIFont.bold(size:16)
        labelCount.backgroundColor = UIColor.clear
        labelCount.textAlignment = NSTextAlignment.center
        self.labelCount = labelCount
        
        addSubview(imageView)
        addSubview(labelTitle)
        addSubview(labelCount)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelCount,
            toView:self)
        NSLayoutConstraint.height(
            view:labelCount,
            constant:kCountHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelCount,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MLinearEquationsProjectBarItem)
    {
        
    }
}
