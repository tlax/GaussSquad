#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

fragment float4
fragment_simple(vertex_destination interpolated [[stage_in]],
                constant fragment_color& input_color [[buffer(0)]])
{
    float4 color = float4(input_color.red, input_color.green, input_color.blue, input_color.alpha);
    return color;
}
