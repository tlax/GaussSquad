import UIKit
import TesseractOCR
import MetalKit

class CScannerOCR:CController, G8TesseractDelegate
{
    private weak var viewOCR:VScannerOCR!
    private var recognized:Bool
    private let image:UIImage
    private let kLanguage:String = "eng"
    
    init(image:UIImage)
    {
        self.image = #imageLiteral(resourceName: "assetTextureTest")
        recognized = false
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
    
    //MARK: tesseract delegate
    
    func shouldCancelImageRecognition(for tesseract:G8Tesseract!) -> Bool
    {
        return false
    }
}
