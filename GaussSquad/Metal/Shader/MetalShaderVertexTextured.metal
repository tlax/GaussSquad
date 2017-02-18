#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

static constant float destination_position = 1;
static constant float coord_z = 0;

vertex void
vertex_textured(constant vertex_source* vertex_array [[buffer(0)]],
                constant projection_matrix& projection [[buffer(1)]],
                unsigned int vid [[vertex_id]])
{
    vertex_source source = vertex_array[vid];
    vertex_destination destination;
    
    float2 vector_start = source.vector_start;
    float2 vector_end = source.vector_end;
    float projection_width = projection.project_width;
    float projection_height = projection.project_height;
    
    float2 vector = vector_end - vector_start;
    float2 normal = normalize(float2(-vector.y, vector.x));
    float2 thickness = source.line_width * normal;
    float2 point_start_a = vector_start - thickness;
    float2 point_start_b = vector_start + thickness;
    float2 point_end_a = vector_end - thickness;
    float2 point_end_b = vector_end + thickness;
    
    float projected_start_a_x = point_start_a[0] / projection_width;
    float projected_start_a_y = point_start_a[1] / projection_height;
    float projected_y = coords_y / projection.project_height;
    
    float4 coords = float4(projected_x, projected_y, coord_z, destination_position);
    
    destination.coords = coords;
    
    return destination;
}
