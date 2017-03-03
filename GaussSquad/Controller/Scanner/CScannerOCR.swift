import UIKit
import TesseractOCR
import MetalKit

class CScannerOCR:CController, G8TesseractDelegate
{
    let modelMenu:MScannerMenu
    private weak var viewOCR:VScannerOCR!
    private var recognized:Bool
    private let image:UIImage
    private let kLanguage:String = "eng"
    private let kNumbersMin:UInt32 = 48
    private let kNumbersMax:UInt32 = 57
    private let kAlphaCapsMin:UInt32 = 65
    private let kAlphaCapsMax:UInt32 = 90
    private let kAlphaMin:UInt32 = 97
    private let kAlphaMax:UInt32 = 122
    private let kSignPoint:UInt32 = 46
    private let kSignAdd:UInt32 = 43
    private let kSignSubtract:UInt32 = 45
    private let kSignDivide:UInt32 = 47
    private let kSignMultiply:UInt32 = 42
    private let kSignEquals:UInt32 = 61
    private let kNewLine:UInt32 = 10
    
    init(image:UIImage)
    {
        self.image = #imageLiteral(resourceName: "assetTextureTest")
        recognized = false
        modelMenu = MScannerMenu()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewOCR:VScannerOCR = VScannerOCR(controller:self)
        self.viewOCR = viewOCR
        view = viewOCR
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if !recognized
        {
            recognized = true
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.preProcess()
            }
        }
    }
    
    //MARK: private
    
    private func preProcess()
    {
        var image:UIImage = self.image
        
        if let device:MTLDevice = MTLCreateSystemDefaultDevice()
        {
            let filter:MScannerFilter = MScannerFilter()
            
            if let filteredImage:UIImage = filter.filter(
                device:device,
                image:image)
            {
                image = filteredImage
            }
        }
        else
        {
            image = self.image.g8_blackAndWhite()
        }
        
        imageRecognition(image:image)
    }
    
    private func imageRecognition(image:UIImage)
    {
        let tesseract:G8Tesseract = G8Tesseract(
            language:kLanguage,
            engineMode:G8OCREngineMode.cubeOnly)
        tesseract.pageSegmentationMode = G8PageSegmentationMode.singleBlock
        tesseract.image = image
        tesseract.recognize()

        guard
            
            let text:String = tesseract.recognizedText
        
        else
        {
            return
        }
        
        textReady(text:text)
    }
    
    private func textReady(text:String)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewOCR.textRecognized(text:text)
        }
    }
    
    private func asyncClean(text:String)
    {
        var cleanText:String = ""
        var prevSign:String?
        var newLine:String?
        
        for character:Character in text.characters
        {
            let characterString:String = "\(character)"
            
            guard
            
                let unicodeScalar:UnicodeScalar = UnicodeScalar(characterString)
            
            else
            {
                continue
            }
            
            let unicodeInt:UInt32 = unicodeScalar.value
            
            if (unicodeInt >= kNumbersMin && unicodeInt <= kNumbersMax) ||
                (unicodeInt >= kAlphaMin && unicodeInt <= kAlphaMax) ||
                (unicodeInt >= kAlphaCapsMin && unicodeInt <= kAlphaCapsMax)
            {
                if let newLine:String = newLine
                {
                    cleanText.append(newLine)
                }
                
                if let prevSign:String = prevSign
                {
                    cleanText.append(prevSign)
                }
                
                cleanText.append(characterString)
                prevSign = nil
                newLine = nil
            }
            else if unicodeInt == kNewLine
            {
                newLine = characterString
            }
            else
            {
                switch unicodeInt
                {
                case kSignAdd,
                     kSignSubtract,
                     kSignMultiply,
                     kSignDivide,
                     kSignEquals,
                     kSignPoint:
                    
                    prevSign = characterString
                    
                    break
                    
                default:
                    break
                }
            }
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.cleanFinished(newText:cleanText)
        }
    }
    
    private func cleanFinished(newText:String)
    {
        viewOCR.viewText.text = newText
    }
    
    //MARK: public
    
    func back()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func help()
    {   
        let modelHelp:MHelpScanner = MHelpScanner()
        let controllerHelp:CHelp = CHelp(model:modelHelp)
        parentController.push(
            controller:controllerHelp,
            vertical:CParent.TransitionVertical.fromTop,
            background:false)
    }
    
    func clean()
    {
        let text:String = viewOCR.viewText.text
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncClean(text:text)
        }
    }
    
    func calculator()
    {
        
    }
    
    //MARK: tesseract delegate
    
    func shouldCancelImageRecognition(for tesseract:G8Tesseract!) -> Bool
    {
        return false
    }
}
