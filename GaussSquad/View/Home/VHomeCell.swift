import UIKit

class VHomeCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var labelSymbol:UILabel!
    private weak var labelTitle:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        let labelSymbol:UILabel = UILabel()
        labelSymbol.isUserInteractionEnabled = false
        labelSymbol.translatesAutoresizingMaskIntoConstraints = false
        labelSymbol.font = UIFont.bold(size:20)
        labelSymbol.textColor = UIColor.black
        labelSymbol.backgroundColor = UIColor.black
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MHomeItem)
    {
        imageView.image = model.image
        labelSymbol.text = model.symbol
        labelTitle.text = model.title
    }
}
