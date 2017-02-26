import UIKit
import MetalKit

class MLinearEquationsPlot
{
    weak var stepDone:MLinearEquationsSolutionStepDone?
    private(set) var zoom:Double = 1
    private(set) var modelRender:MLinearEquationsPlotRender?
    private(set) var modelMenu:MLinearEquationsPlotMenu?
    private weak var device:MTLDevice?
    private let kDeltaPosition:Double = 10
    private let colors:[UIColor]
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        self.stepDone = stepDone
        
        colors = [
            UIColor.squadBlue,
            UIColor.squadRed,
            UIColor.squadGreen,
            UIColor.purple,
            UIColor.brown,
            UIColor.orange,
            UIColor.yellow
        ]
    }
    
    //MARK: private
    
    private func makeIndeterminates()
    {
        guard
            
            let device:MTLDevice = self.device,
            let stepDone:MLinearEquationsSolutionStepDone = self.stepDone,
            let modelRender:MLinearEquationsPlotRender = self.modelRender
            
        else
        {
            return
        }
        
        let modelMenu:MLinearEquationsPlotMenu = MLinearEquationsPlotMenu()
        modelRender.clearIndeterminates()
        
        let positionZoom:Double = kDeltaPosition * zoom
        let positionZoom2:Double = positionZoom + positionZoom
        var positionX:Double = positionZoom
        var indexItem:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in stepDone.equations
        {
            guard
                
                let coefficient:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant,
                let polynomial:MLinearEquationsSolutionEquationItemPolynomial = equation.items.first as? MLinearEquationsSolutionEquationItemPolynomial
                
            else
            {
                continue
            }
            
            let coefficientValue:Double = coefficient.coefficient
            let coefficientString:String = MSession.sharedInstance.stringFrom(
                number:coefficientValue)
            let indeterminate:String = polynomial.indeterminate.symbol
            let indeterminateCoefficient:String = "\(indeterminate): \(coefficientString)"
            let indexColor:Int = indexItem % colors.count
            let color:UIColor = colors[indexColor]
            let positionY:Double = coefficientValue * positionZoom
            
            modelRender.addIndeterminate(
                device:device,
                positionX:positionX,
                positionY:positionY,
                color:color)
            modelMenu.addItem(
                color:color,
                title:indeterminateCoefficient,
                value:coefficientValue,
                positionX:positionX,
                positionY:positionY)
            
            positionX += positionZoom2
            indexItem += 1
        }
        
        self.modelMenu = modelMenu
    }
    
    //MARK: public
    
    func makeRender(device:MTLDevice)
    {
        self.device = device
        modelRender = MLinearEquationsPlotRender(device:device)
        makeIndeterminates()
    }
    
    func updateZoom(zoom:Double) -> Double
    {
        let increase:Double
        
        if zoom >= self.zoom
        {
            increase = kDeltaPosition
        }
        else
        {
            increase = -kDeltaPosition
        }
        
        self.zoom = zoom
        makeIndeterminates()
        
        return increase
    }
}
