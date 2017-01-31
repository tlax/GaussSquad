import UIKit

class VLinearEquationsBarCellReport:VLinearEquationsBarCell
{
    private weak var imageView:UIImageView!
    private weak var labelCount:UILabel!
    private let kCountHeight:CGFloat = 34
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        let labelCount:UILabel = UILabel()
        labelCount.isUserInteractionEnabled = false
        labelCount.translatesAutoresizingMaskIntoConstraints = false
        labelCount.font = UIFont.bold(size:10)
        labelCount.backgroundColor = UIColor.clear
        labelCount.textAlignment = NSTextAlignment.center
        self.labelCount = labelCount
        
        addSubview(imageView)
        addSubview(labelCount)
        
        NSLayoutConstraint.equals(
            view:imageView,
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
        super.config(model:model)
        
        guard
        
            let model:MLinearEquationsProjectBarItemReport = model as? MLinearEquationsProjectBarItemReport
        
        else
        {
            return
        }
        
        imageView.image = model.image
        labelCount.text = model.count
    }
}
