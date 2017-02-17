import MetalKit

class MetalConstants
{
    static let kVertexFunction:String = "vertex_textured"
    static let kFragmentFunction:String = "fragment_simple"
    static let kPixelFormat:MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    static let kRgbBlendOperation:MTLBlendOperation = MTLBlendOperation.add
    static let kAlphaBlendOperation:MTLBlendOperation = MTLBlendOperation.add
    static let kSourceRgbBlendFactor:MTLBlendFactor = MTLBlendFactor.one
    static let kSourceAlphaBlendFactor:MTLBlendFactor = MTLBlendFactor.one
    static let kDestinationRgbBlendFactor:MTLBlendFactor = MTLBlendFactor.oneMinusSourceAlpha
    static let kDestinationAlphaBlendFactor:MTLBlendFactor = MTLBlendFactor.oneMinusSourceAlpha
    static let kPrimitiveType:MTLPrimitiveType = MTLPrimitiveType.triangle
    static let kTextureUsage:NSObject = MTLTextureUsage.shaderRead.rawValue as NSObject
    static let kTextureSrgb:NSObject = false as NSObject
    static let kPrimitiveCount:Int = 6
    static let kBufferElementSize:Int = 4
    static let kColorAttachmentIndex:Int = 0
    static let kVertexIndex:Int = 0
    static let kColorIndex:Int = 0
    static let kProjectionIndex:Int = 1
    static let kBlendingEnabled:Bool = true
}
