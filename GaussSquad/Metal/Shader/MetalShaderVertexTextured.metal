#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

static constant float destination_position = 1;
static constant float coord_z = 0;

vertex vertex_destination
vertex_textured(constant vertex_source* vertex_array [[buffer(0)]],
                constant projection_matrix& projection [[buffer(1)]],
                unsigned int vid [[vertex_id]])
{
    vertex_source source = vertex_array[vid];
    vertex_destination destination;
    
    float coords_x = source.coords[0];
    float coords_y = source.coords[1];
    
    float projected_x = coords_x / projection.project_width;
    float projected_y = coords_y / projection.project_height;
    
    float4 coords = float4(projected_x, projected_y, coord_z, destination_position);
    
    destination.coords = coords;
    
    return destination;
}
