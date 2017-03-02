import Foundation
import MetalKit

protocol MScannerFilterItem
{
    static func filterTexture(
        device:MTLDevice,
        library:MTLLibrary,
        texture:MTLTexture) -> MTLTexture?
}
