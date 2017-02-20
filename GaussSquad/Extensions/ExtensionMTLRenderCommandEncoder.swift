import Foundation
import MetalKit

extension MTLRenderCommandEncoder
{
    func render(
        vertex:MTLBuffer,
        color:MTLBuffer,
        texture:MTLTexture)
    {
        setVertexBuffer(
            vertex,
            offset:0,
            at:MetalConstants.kVertexIndex)
        setFragmentBuffer(
            color,
            offset:0,
            at:MetalConstants.kColorIndex)
        setFragmentTexture(
            texture,
            at:MetalConstants.kFragmentTextureIndex)
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
