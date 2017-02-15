import UIKit

class VLinearEquationsSolutionCellEquals:VLinearEquationsSolutionCell
{
    private weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MLinearEquationsSolutionEquationItem, index:IndexPath)
    {
        guard
        
            let model:MLinearEquationsSolutionEquationItemEquals = model as? MLinearEquationsSolutionEquationItemEquals
        
        else
        {
            return
        }
        
        imageView.image = model.image
    }
}
