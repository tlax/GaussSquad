#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

static constant float4 color_white = float4(1,1,1,1);
static constant float4 color_black = float4(0,0,0,1);

kernel void
kernel_effects(texture2d<float, access::read> read_texture [[texture(0)]],
               texture2d<float, access::write> write_texture [[texture(1)]],
               uint2 grid_id [[thread_position_in_grid]])
{
    int width = read_texture.get_width();
    int height = read_texture.get_height();
    float2 uv = float2(grid_id) / float2(width, height);
    
    float4 current_color = read_texture.read(grid_id);
    
    if (all(current_color == color_white))
    {
        if (all(current_color != color_black))
        {
            
        }
    }
    
    write_texture.write(float4(color, 1), grid_id);
}
