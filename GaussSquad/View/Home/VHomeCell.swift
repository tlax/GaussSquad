import UIKit

class VHomeCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var labelSymbol:UILabel!
    private weak var labelTitle:UILabel!
    private let kImageSize:CGFloat = 70
    private let kAlphaSelected:CGFloat = 0.3
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        let labelSymbol:UILabel = UILabel()
        labelSymbol.isUserInteractionEnabled = false
        labelSymbol.translatesAutoresizingMaskIntoConstraints = false
        labelSymbol.font = UIFont.bold(size:24)
        labelSymbol.textColor = UIColor.black
        labelSymbol.backgroundColor = UIColor.clear
        self.labelSymbol = labelSymbol
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.regular(size:16)
        labelTitle.textColor = UIColor.black
        labelTitle.backgroundColor = UIColor.clear
        self.labelTitle = labelTitle
        
        addSubview(labelTitle)
        addSubview(labelSymbol)
        addSubview(imageView)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:0)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self,
            constant:0)
        NSLayoutConstraint.size(
            view:imageView,
            constant:kImageSize)
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
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MHomeItem)
    {
        imageView.image = model.image
        labelSymbol.text = model.symbol
        labelTitle.text = model.title
        hover()
    }
}
