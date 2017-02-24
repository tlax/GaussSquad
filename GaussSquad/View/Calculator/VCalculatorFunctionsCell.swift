import UIKit

class VCalculatorFunctionsCell:UICollectionViewCell
{
    private weak var controller:CCalculator?
    private weak var background:UIView!
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private let kTitleHeight:CGFloat = 18
    private let kTitleBottom:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let background:UIView = UIView()
        background.clipsToBounds = true
        background.translatesAutoresizingMaskIntoConstraints = false
        background.isUserInteractionEnabled = false
        self.background = background
        
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
        self.labelTitle = labelTitle
        
        addSubview(background)
        addSubview(labelTitle)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
        
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
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            background.backgroundColor = UIColor.white
            background.layer.borderWidth = 3
            background.layer.borderColor = UIColor.squadBlue.cgColor
        }
        else
        {
            background.backgroundColor = UIColor(white:0.985, alpha:1)
            background.layer.borderWidth = 1
            background.layer.borderColor = UIColor(white:0, alpha:0.06).cgColor
        }
    }
    
    //MARK: public
    
    func config(
        controller:CCalculator,
        model:MCalculatorFunctionsItem)
    {
        self.controller = controller
        imageView.image = model.icon
        labelTitle.text = model.title
        
        hover()
    }
}
