#ifndef ACLS_3_HELPERS
#define ACLS_3_HELPERS

//invert matrix
float4x4 inverse(float4x4 input)
{
    #define minor(a,b,c) determinant(float3x3(input.a, input.b, input.c))
    //determinant(float3x3(input._22_23_23, input._32_33_34, input._42_43_44))

    const float4x4 cofactors = float4x4(
        minor(_22_23_24, _32_33_34, _42_43_44),
        -minor(_21_23_24, _31_33_34, _41_43_44),
        minor(_21_22_24, _31_32_34, _41_42_44),
        -minor(_21_22_23, _31_32_33, _41_42_43),

        -minor(_12_13_14, _32_33_34, _42_43_44),
        minor(_11_13_14, _31_33_34, _41_43_44),
        -minor(_11_12_14, _31_32_34, _41_42_44),
        minor(_11_12_13, _31_32_33, _41_42_43),

        minor(_12_13_14, _22_23_24, _42_43_44),
        -minor(_11_13_14, _21_23_24, _41_43_44),
        minor(_11_12_14, _21_22_24, _41_42_44),
        -minor(_11_12_13, _21_22_23, _41_42_43),

        -minor(_12_13_14, _22_23_24, _32_33_34),
        minor(_11_13_14, _21_23_24, _31_33_34),
        -minor(_11_12_14, _21_22_24, _31_32_34),
        minor(_11_12_13, _21_22_23, _31_32_33)
    );
    #undef minor
    return transpose(cofactors) / determinant(input);
}

inline float4 ClipToObjectPosODS(float3 inPos)
{
    float3 worldPos;
    #if defined(STEREO_CUBEMAP_RENDER_ON)
    float3 offset = ODSOffset(posWorld, unity_HalfStereoSeparation.x);
    worldPos = mul(inverse(UNITY_MATRIX_VP), float4(inPos + offset, 1.0));
    #else
    worldPos = mul(inverse(UNITY_MATRIX_VP), float4(inPos, 1.0));
    #endif
    float4 objectPos = mul(inverse(unity_ObjectToWorld), float4(worldPos,1.0));

    return objectPos;
}

// Tranforms position from object to homogenous space
inline float4 ClipToObjectPos(in float3 pos)
{
    #if defined(STEREO_CUBEMAP_RENDER_ON)
    return ClipToObjectPosODS(pos);
    #else
    return mul(inverse(unity_ObjectToWorld), mul(inverse(UNITY_MATRIX_VP), float4(pos, 1.0)));
    #endif
}

inline float4 ClipToObjectPos(float4 pos)
{
    return ClipToObjectPos(pos.xyz);
}

#endif
