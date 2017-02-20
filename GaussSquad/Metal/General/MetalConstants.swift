import MetalKit

class MetalConstants
{
    static let kVertexFunction:String = "vertex_arrangement"
    static let kFragmentFunction:String = "fragment_simple"
    static let kKernelFunction:String = "kernel_effects"
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
    static let kSamplerMinFilter:MTLSamplerMinMagFilter = MTLSamplerMinMagFilter.linear
    static let kSamplerMagFilter:MTLSamplerMinMagFilter = MTLSamplerMinMagFilter.linear
    static let kSamplerMipFilter:MTLSamplerMipFilter = MTLSamplerMipFilter.linear
    static let kSamplerSAddressMode:MTLSamplerAddressMode = MTLSamplerAddressMode.clampToEdge
    static let kSamplerTAddressMode:MTLSamplerAddressMode = MTLSamplerAddressMode.clampToEdge
    static let kSamplerRAddressMode:MTLSamplerAddressMode = MTLSamplerAddressMode.clampToEdge
    static let kSamplerLodMaxClamp:Float = FLT_MAX
    static let kSamplerLodMinClamp:Float = 0
    static let kSamplerMaxAnisotropy:Int = 1
    static let kSamplerNormalizedCoordinates:Bool = true
    static let kPrimitiveCount:Int = 6
    static let kBufferElementSize:Int = 4
    static let kTextureReadIndex:Int = 0
    static let kTextureWriteIndex:Int = 1
    static let kColorAttachmentIndex:Int = 0
    static let kVertexIndex:Int = 0
    static let kColorIndex:Int = 0
    static let kProjectionIndex:Int = 1
    static let kFragmentTextureIndex:Int = 0
    static let kFragmentSamplerIndex:Int = 0
    static let kBlendingEnabled:Bool = true
}
