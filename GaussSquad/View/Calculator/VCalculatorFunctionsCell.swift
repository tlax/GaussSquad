import UIKit

class VCalculatorFunctionsCell:UICollectionViewCell
{
    private weak var controller:CCalculator?
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private let kTitleHeight:CGFloat = 20
    private let kTitleBottom:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        let labelTitle:UILabel = UILabel()
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.medium(size:13)
        labelTitle.textColor = UIColor.black
        self.labelTitle = labelTitle
        
        addSubview(labelTitle)
        addSubview(imageView)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self,
            constant:kTitleBottom)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:imageView,
            toView:labelTitle)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(
        controller:CCalculator,
        model:MCalculatorFunctionsItem)
    {
        self.controller = controller
        imageView.image = model.icon
        labelTitle.text = model.title
    }
}
