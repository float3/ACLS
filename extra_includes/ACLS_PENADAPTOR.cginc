#ifndef ACLS_PENADAPTOR
#define ACLS_PENADAPTOR

    #ifdef PEN
    #include "./CGI_PoiPenetration.cginc"
    #endif // PEN
    void AdaptorDPS(inout appdata v)
    {
        #ifdef PEN
        float3 vertex = v.vertex.xyz;
        float3 normal = v.normal;
        applyRalivDynamicPenetrationSystem(vertex, normal, v);
        v.vertex.xyz = vertex;
        v.normal = normal;
        #endif // PEN
    }

    // void AdaptorDPS(inout appdata v)
    // {
    // }


#endif // PENADAPTOR