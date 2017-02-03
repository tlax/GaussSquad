import UIKit

class VLinearEquationsPolynomialControlSign:UIView
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var buttonPositive:UIButton!
    private weak var buttonNegative:UIButton!
    private let kCornerRadius:CGFloat = 8
    private let kButtonWidth:CGFloat = 50
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        self.controller = controller
        
        let buttonPositive:UIButton = UIButton()
        buttonPositive.translatesAutoresizingMaskIntoConstraints = false
        buttonPositive.clipsToBounds = true
        buttonPositive.setImage(
            #imageLiteral(resourceName: "assetGenericColAdd").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        buttonPositive.setImage(
            #imageLiteral(resourceName: "assetGenericColAdd").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonPositive.imageView!.clipsToBounds = true
        buttonPositive.imageView!.contentMode = UIViewContentMode.center
        self.buttonPositive = buttonPositive
        
        let buttonNegative:UIButton = UIButton()
        buttonNegative.translatesAutoresizingMaskIntoConstraints = false
        buttonNegative.clipsToBounds = true
        buttonNegative.setImage(
            #imageLiteral(resourceName: "assetGenericColSubstract").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        buttonNegative.setImage(
            #imageLiteral(resourceName: "assetGenericColSubstract").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonNegative.imageView!.clipsToBounds = true
        buttonNegative.imageView!.contentMode = UIViewContentMode.center
        self.buttonNegative = buttonNegative
        
        addSubview(buttonPositive)
        addSubview(buttonNegative)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonPositive,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonPositive,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonPositive,
            constant:kButtonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonNegative,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonNegative,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonNegative,
            constant:kButtonWidth)
        
        guard
        
            let polynomial:DPolynomial = controller.polynomial
        
        else
        {
            return
        }
        
        if polynomial.isPositive
        {
            makePositive()
        }
        else
        {
            makeNegative()
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionPositive(sender button:UIButton)
    {
        makePositive()
    }
    
    func actionNegative(sender button:UIButton)
    {
        makeNegative()
    }
    
    //MARK: private
    
    private func makePositive()
    {
        buttonNegative.backgroundColor = UIColor(white:0.95, alpha:1)
        buttonNegative.imageView!.tintColor = UIColor(white:0.8, alpha:1)
        buttonNegative.isUserInteractionEnabled = true
        buttonPositive.backgroundColor = UIColor.squadBlue
        buttonPositive.imageView!.tintColor = UIColor.white
        buttonPositive.isUserInteractionEnabled = false
    }
    
    private func makeNegative()
    {
        buttonPositive.backgroundColor = UIColor(white:0.95, alpha:1)
        buttonPositive.imageView!.tintColor = UIColor(white:0.8, alpha:1)
        buttonPositive.isUserInteractionEnabled = true
        buttonNegative.backgroundColor = UIColor.squadBlue
        buttonNegative.imageView!.tintColor = UIColor.white
        buttonNegative.isUserInteractionEnabled = false
    }
}
