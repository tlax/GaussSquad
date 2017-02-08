import UIKit

class CLinearEquationsPolynomialIndeterminate:CController
{
    let model:MLinearEquationsIndeterminates
    private weak var viewList:VLinearEquationsIndeterminateList!
    
    init(polynomial:DPolynomial)
    {
        model = MLinearEquationsIndeterminates(polynomial:polynomial)
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewList:VLinearEquationsIndeterminateList = VLinearEquationsIndeterminateList(
            controller:self)
        self.viewList = viewList
        view = viewList
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        viewList.animateShow()
    }
    
    //MARK: public
    
    func close()
    {
        viewList.animateHide()
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func selectIndeterminate(indeterminate:DIndeterminate?)
    {
        model.polynomial?.selectIndeterminate(indeterminate:indeterminate)
        
        close()
    }
}
