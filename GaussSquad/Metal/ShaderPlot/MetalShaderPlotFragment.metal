#include <metal_stdlib>

using namespace metal;
#include "MetalShaderPlotStructs.h"

fragment float4
plot_fragment(vertex_destination interpolated [[stage_in]],
              constant fragment_color& input_color [[buffer(0)]],
              texture2d<float> current_texture [[texture(0)]],
              sampler curret_sampler [[sampler(0)]])
{
    
    float4 texture_color = current_texture.sample(curret_sampler, interpolated.texture);
    float alpha = texture_color[3];
    float4 overlay_color = float4(input_color.red * alpha, input_color.green * alpha, input_color.blue * alpha, alpha);
    
    return overlay_color;
}
