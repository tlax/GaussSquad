#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

fragment float4
fragment_simple(vertex_destination interpolated [[stage_in]])
{
    float4 color = float4(1,0,0,1);
    return color;
}
