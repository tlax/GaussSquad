import MetalKit

class MetalConstants
{
    static let kPlotVertexFunction:String = "plot_vertex"
    static let kPlotFragmentFunction:String = "plot_fragment"
    static let kPlotKernelFunction:String = "plot_kernel"
    static let kFilterHighContrastKernelFunction:String = "filter_highcontrast_kernel"
    static let kPixelFormat:MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    static let kFloatPixelFormat:MTLPixelFormat = MTLPixelFormat.r32Float
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
    static let kTextureMipMapped:Bool = false
    static let kColorAttachmentIndex:Int = 0
    static let kVertexIndex:Int = 0
    static let kColorIndex:Int = 0
    static let kProjectionIndex:Int = 1
    static let kPositionIndex:Int = 2
    static let kFragmentTextureIndex:Int = 0
    static let kFragmentSamplerIndex:Int = 0
    static let kBlendingEnabled:Bool = true
    static let kTextureDepth:Int = 1
    static let kRepeatingElement:Float = 0
    static let kReplaceElement:Float = 1
    static let kThreadgroupWidth:Int = 2
    static let kThreadgroupHeight:Int = 2
    static let kThreadgroupDeep:Int = 1
}
