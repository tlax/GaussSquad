#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

fragment float4
fragment_simple(vertex_destination interpolated [[stage_in]],
                constant fragment_color& input_color [[buffer(0)]],
                texture2d<float> current_texture [[texture(0)]],
                sampler curret_sampler [[sampler(0)]])
{
    float4 overlay_color = float4(input_color.red, input_color.green, input_color.blue, input_color.alpha);
    float4 color = current_texture.sample(curret_sampler, interpolated.texture);
    return color;
}
