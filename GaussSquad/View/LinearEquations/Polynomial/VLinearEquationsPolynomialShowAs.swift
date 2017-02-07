import UIKit

class VLinearEquationsPolynomialShowAs:UIView
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var buttonDivision:UIButton!
    private weak var buttonDecimal:UIButton!
    private let kButtonWidth:CGFloat = 50
    private let kCornerRadius:CGFloat = 6
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        self.controller = controller
        
        let buttonDivision:UIButton = UIButton()
        buttonDivision.translatesAutoresizingMaskIntoConstraints = false
        buttonDivision.clipsToBounds = true
        buttonDivision.setImage(
            #imageLiteral(resourceName: "assetGenericColDivision").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        buttonDivision.setImage(
            #imageLiteral(resourceName: "assetGenericColDivision").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonDivision.imageView!.clipsToBounds = true
        buttonDivision.imageView!.contentMode = UIViewContentMode.center
        buttonDivision.addTarget(
            self,
            action:#selector(actionDivision(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonDivision = buttonDivision
        
        let buttonDecimal:UIButton = UIButton()
        buttonDecimal.translatesAutoresizingMaskIntoConstraints = false
        buttonDecimal.clipsToBounds = true
        buttonDecimal.setImage(
            #imageLiteral(resourceName: "assetGenericColDecimal").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        buttonDecimal.setImage(
            #imageLiteral(resourceName: "assetGenericColDecimal").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonDecimal.imageView!.clipsToBounds = true
        buttonDecimal.imageView!.contentMode = UIViewContentMode.center
        buttonDecimal.addTarget(
            self,
            action:#selector(actionDecimal(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonDecimal = buttonDecimal
        
        addSubview(buttonDivision)
        addSubview(buttonDecimal)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDivision,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonDivision,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonDivision,
            constant:kButtonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDecimal,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonDecimal,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonDecimal,
            constant:kButtonWidth)
        
        guard
            
            let polynomial:DPolynomial = controller.polynomial
            
        else
        {
            return
        }
        
        if polynomial.showAsDivision
        {
            makeDivision()
        }
        else
        {
            makeDecimal()
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionDivision(sender button:UIButton)
    {
        makeDivision()
    }
    
    func actionDecimal(sender button:UIButton)
    {
        makeDecimal()
    }
    
    //MARK: private
    
    private func makeDivision()
    {
        buttonDecimal.backgroundColor = UIColor(white:0.9, alpha:1)
        buttonDecimal.imageView!.tintColor = UIColor(white:0.6, alpha:1)
        buttonDecimal.isUserInteractionEnabled = true
        buttonDivision.backgroundColor = UIColor.squadBlue
        buttonDivision.imageView!.tintColor = UIColor.white
        buttonDivision.isUserInteractionEnabled = false
        
        controller.polynomial?.showAsDivision = true
        DManager.sharedInstance?.save()
    }
    
    private func makeDecimal()
    {
        buttonDivision.backgroundColor = UIColor(white:0.9, alpha:1)
        buttonDivision.imageView!.tintColor = UIColor(white:0.6, alpha:1)
        buttonDivision.isUserInteractionEnabled = true
        buttonDecimal.backgroundColor = UIColor.squadBlue
        buttonDecimal.imageView!.tintColor = UIColor.white
        buttonDecimal.isUserInteractionEnabled = false
        
        controller.polynomial?.showAsDivision = false
        DManager.sharedInstance?.save()
    }
}
