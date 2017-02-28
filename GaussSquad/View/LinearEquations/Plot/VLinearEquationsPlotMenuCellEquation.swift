import UIKit

class VLinearEquationsPlotMenuCellEquation:VLinearEquationsPlotMenuCell
{
    private weak var imageView:UIImageView!
    private weak var label:UILabel!
    private let kImageWidth:CGFloat = 40
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericPoint").withRenderingMode(
            UIImageRenderingMode.alwaysTemplate)
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:16)
        label.textColor = UIColor.black
        self.label = label

        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:imageView)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    override func config(model:MLinearEquationsPlotMenuItem)
    {
        super.config(model:model)
        
        guard
            
            let model:MLinearEquationsPlotMenuItemEquation = model as? MLinearEquationsPlotMenuItemEquation
        
        else
        {
            return
        }
        
        imageView.tintColor = model.color
        label.attributedText = model.title
    }
}
