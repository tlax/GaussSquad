import UIKit

class CLinearEquationsIndeterminate:CController
{
    private weak var viewIndeterminate:VLinearEquationsIndeterminate!
    private weak var model:MLinearEquationsProject!
    private let kNumbersMin:UInt32 = 48
    private let kNumbersMax:UInt32 = 57
    private let kLowerCaseMin:UInt32 = 65
    private let kLowerCaseMax:UInt32 = 90
    private let kUpperCaseMin:UInt32 = 97
    private let kUpperCaseMax:UInt32 = 122
    
    init(model:MLinearEquationsProject)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewIndeterminate:VLinearEquationsIndeterminate = VLinearEquationsIndeterminate(
            controller:self)
        self.viewIndeterminate = viewIndeterminate
        view = viewIndeterminate
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewIndeterminate.startEdition()
    }
    
    //MARK: private
    
    private func validation(name:String) -> String?
    {
        let countCharacters:Int = name.characters.count
        
        if countCharacters == 0
        {
            let error:String = NSLocalizedString(
                "CLinearEquationsIndeterminate_errorInvalid",
                comment:"")
            
            return error
        }
        
        for indexCharacter:Int in 0 ..< countCharacters
        {
            let character:Character = name[
                name.index(
                    name.startIndex,
                    offsetBy:indexCharacter)]
            let charString:String = "\(character)"
            
            guard
            
                let scalar:UnicodeScalar = UnicodeScalar(charString)
            
            else
            {
                continue
            }
            
            let unicode:UInt32 = scalar.value
            
            if unicode < kLowerCaseMin || unicode > kLowerCaseMax
            {
                if unicode < kUpperCaseMin || unicode > kUpperCaseMax
                {
                    if indexCharacter == 0
                    {
                        if unicode >= kNumbersMin && unicode <= kNumbersMax
                        {
                            let error:String = NSLocalizedString(
                                "CLinearEquationsIndeterminate_errorNoNumber",
                                comment:"")
                            
                            return error
                        }
                    }
                    
                    if unicode < kNumbersMin || unicode > kNumbersMax
                    {
                        let error:String = NSLocalizedString(
                            "CLinearEquationsIndeterminate_errorCharacters",
                            comment:"")
                        
                        return error
                    }
                }
            }
        }
        
        return nil
    }
    
    func alreadyUsingIndeterminate(name:String) -> Bool
    {
        guard
        
            let indeterminates:[DIndeterminate] = model.project?.indeterminates?.array as? [DIndeterminate]
        
        else
        {
            return false
        }
        
        for indeterminate:DIndeterminate in indeterminates
        {
            guard
            
                let symbol:String = indeterminate.symbol
            
            else
            {
                continue
            }
            
            if symbol == name
            {
                return true
            }
        }
        
        return false
    }
    
    //MARK: public
    
    func cancel()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        viewIndeterminate.endEdition()
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func save()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        guard
        
            let indeterminateName:String = viewIndeterminate.viewText.text
        
        else
        {
            return
        }
        
        let error:String? = validation(name:indeterminateName)
        
        if let error:String = error
        {
            viewIndeterminate.toastMessage(message:error)
        }
        else
        {
            if alreadyUsingIndeterminate(name:indeterminateName)
            {
                let error:String = NSLocalizedString(
                    "CLinearEquationsIndeterminate_errorExistingIndeterminate",
                    comment:"")
                viewIndeterminate.toastMessage(message:error)
            }
            else
            {
                model.addIndeterminate(name:indeterminateName)
                {
                    DispatchQueue.main.async
                    { [weak self] in
                        
                        self?.cancel()
                    }
                }
            }
        }
    }
}
