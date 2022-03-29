//// ACiiL
//// Citations in readme and in source.
//// https://github.com/ACIIL/ACLS-Shader
#ifndef ACLS_VERT_FRAG
#define ACLS_VERT_FRAG
    #include "./ACLS_HELPERS.cginc"

//// global properties
    sampler2D _MainTex; uniform float4 _MainTex_ST;
    sampler2D _DepthZoneMask; uniform float4 _DepthZoneMask_ST;
    uniform float4 _Color;
#ifdef OutlinesContext
    uniform int _useOutline;
    uniform int _fillOutlineDepth;
#endif // OutlinesContext

//// simple depth write
    emptyV2f emptyVert (emptyAppdata v)
    {
        UNITY_SETUP_INSTANCE_ID(v);
        emptyV2f o;
        UNITY_INITIALIZE_OUTPUT(emptyV2f, o);
        UNITY_TRANSFER_INSTANCE_ID(v, o);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
        
    #ifdef OutlinesContext
        UNITY_BRANCH
        if (!(_useOutline && _fillOutlineDepth))
        {
            o.vertex = 1.0;
            return o;
        }

    #endif // OutlinesContext
        o.vertex = UnityObjectToClipPos(v.vertex);
        return o;
    }

    fixed4 emptyFrag (emptyV2f i) : SV_Target
    {
        UNITY_SETUP_INSTANCE_ID(i);
        return 0;
    }
////

//// depth start
    depthV2f depthVert (depthAppdata v)
    {
        UNITY_SETUP_INSTANCE_ID(v);
        depthV2f o;
        UNITY_INITIALIZE_OUTPUT(depthV2f, o);
        UNITY_TRANSFER_INSTANCE_ID(v, o);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

        // o.uv01 = float4(TRANSFORM_TEX(v.uv, _MainTex).xy, 0, 0);
        o.uv01      = float4(v.uv0, v.uv1);
        o.uv02      = float4(v.uv2, v.uv3);
        o.pos       = UnityObjectToClipPos(v.vertex);
        o.wNormal   = UnityObjectToWorldNormal(v.normal);
        UNITY_TRANSFER_SHADOW(o, 0);
        // TRANSFER_SHADOW(o)
        o.worldPos = mul(UNITY_MATRIX_M, v.vertex).xyz;
        return o;
    }

    fixed4 depthFrag (depthV2f i) : COLOR
    {
        UNITY_SETUP_INSTANCE_ID(i);
        i.wNormal       = normalize(i.wNormal);
        float3 dirView  = normalize(_WorldSpaceCameraPos - i.worldPos.xyz);

    // #ifdef DIRECTIONAL
        UNITY_LIGHT_ATTENUATION_NOSHADOW(lightAtten, i, i.worldPos.xyz);
        half1 shadowAtten = lightAtten;
    // #else
    //     UNITY_LIGHT_ATTENUATION_NOSHADOW(lightAtten, i, i.worldPos.xyz);
    //     half shadowAtten = UNITY_SHADOW_ATTENUATION(i, i.worldPos.xyz);
    // #endif

        float1 ndv              = 1 - abs(dot(dirView, i.wNormal));
        fixed4 depthZoneMask    = tex2D(_DepthZoneMask, UVPick01(i.uv01, i.uv02, 0));
        clip((1-depthZoneMask.r) - 0.5);
        float1 depth    = distance(i.worldPos, worldCameraRawMatrix().xyz);
        return fixed4(depth, ndv, 0, 0);
        // return fixed4(depth, ndv, shadowAtten, 0);
    }
////
#endif // ACLS_VERT_FRAG