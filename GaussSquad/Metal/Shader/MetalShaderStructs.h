#ifndef MetalShaderStructs_h
#define MetalShaderStructs_h

struct vertex_source
{
    float2 coords;
};

struct vertex_destination
{
    float4 coords [[position]];
};

struct projection_matrix
{
    float project_width;
    float project_height;
};

#endif
