#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

static constant float destination_position = 1;

vertex vertex_destination
vertex_textured(const device vertex_source* vertex_array [[buffer(0)]],
                const device projection_matrix& projection [[buffer(1)]],
                const device position_matrix& position [[buffer(2)]],
                unsigned int vid [[vertex_id]])
{
    vertex_source source = vertex_array[vid];
    vertex_destination destination;
    
    float coord_x = source.coords[0];
    float coord_y = source.coords[1];
    float coord_z = source.coords[2];
    float projected_x = coord_x * projection.project_width;
    float projected_y = coord_y * projection.project_height;
    
    float move_projected_x = position.move_x * projection.project_width;
    float move_projected_y = position.move_y * projection.project_height;
    
    float final_x = projected_x + move_projected_x;
    float final_y = projected_y + move_projected_y;
    float4 coords = float4(final_x, final_y, coord_z, destination_position);
    
    destination.coords = coords;
    destination.texture = source.texture;
    
    return destination;
}
