#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

static constant float3 color_white = float3(1,1,1);
static constant float min_white = 0.92;

kernel void
kernel_effects(texture2d<float, access::read> read_texture [[texture(0)]],
               texture2d<float, access::write> write_texture [[texture(1)]],
               uint2 grid_id [[thread_position_in_grid]])
{
    float4 textel = read_texture.read(grid_id);
    float3 current_color = float3(textel[0], textel[1], textel[2]);
    
    if (all(current_color == color_white))
    {
        float x_pos = grid_id.x;
        float y_pos = grid_id.y;
        float cos_x = cos(x_pos);
        float cos_y = cos(y_pos);
        float sin_x = sin(x_pos);
        float sin_y = sin(y_pos);
        float rand = max(max(max(cos_x, cos_y), max(sin_x, sin_y)), min_white);
        float4 new_color = float4(rand, rand, rand, 1);
        write_texture.write(new_color, grid_id);
    }
}
