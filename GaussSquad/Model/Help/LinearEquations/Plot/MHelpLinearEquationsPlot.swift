import Foundation

class MHelpLinearEquationsPlot:MHelp
{
    init()
    {
        let itemDescartes:MHelpLinearEquationsPlotItemDescartes = MHelpLinearEquationsPlotItemDescartes()
        let itemOrigin:MHelpLinearEquationsPlotItemOrigin = MHelpLinearEquationsPlotItemOrigin()
        let itemCenter:MHelpLinearEquationsPlotItemCenter = MHelpLinearEquationsPlotItemCenter()
        let itemZoom:MHelpLinearEquationsPlotItemZoom = MHelpLinearEquationsPlotItemZoom()
        
        let items:[MHelpItem] = [
            itemDescartes,
            itemOrigin,
            itemCenter,
            itemZoom
        ]
        
        super.init(items:items)
    }
}
