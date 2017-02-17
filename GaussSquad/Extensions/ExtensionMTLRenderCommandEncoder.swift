import Foundation
import MetalKit

extension MTLRenderCommandEncoder
{
    func render(
        vertex:MTLBuffer,
        color:MTLBuffer)
    {
        setVertexBuffer(
            vertex,
            offset:0,
            at:MetalConstants.kVertexIndex)
        setFragmentBuffer(
            color,
            offset:0,
            at:MetalConstants.kColorIndex)
        drawPrimitives(
            type:MetalConstants.kPrimitiveType,
            vertexStart:0,
            vertexCount:MetalConstants.kPrimitiveCount)
    }
    
    func projectionMatrix(projection:MTLBuffer)
    {
        setVertexBuffer(
            projection,
            offset:0,
            at:MetalConstants.kProjectionIndex)
    }
}
