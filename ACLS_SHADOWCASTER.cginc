//// ACiiL
//// Citations in readme and in source.
//// https://github.com/ACIIL/ACLS-Shader
#ifndef ACLS_SHADOWCASTER
#define ACLS_SHADOWCASTER
            ////
            #include "./ACLS_HELPERS.cginc"

            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _ClippingMask; uniform float4 _ClippingMask_ST;
            uniform sampler2D _Outline_Sampler; uniform float4 _Outline_Sampler_ST;
#ifdef ShadowDither
            sampler3D _DitherMaskLOD;
#endif // ShadowDither

            uniform int _DetachShadowClipping;
            uniform half _Tweak_transparency;
            uniform half _Clipping_Level;
            uniform half _Clipping_Level_Shadow;
            uniform int _Inverse_Clipping;
            uniform int _IsBaseMapAlphaAsClippingMask;
            // outline
            uniform half _outline_mode;
            uniform half _Outline_Width;
            uniform half _Farthest_Distance;
            uniform half _Nearest_Distance;
            uniform half _Offset_Z;



            struct v2f {
                // V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD0;
                float4 worldPos    : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };
            
            
            
            void vert
            (
                appdata v,
                out v2f o,
                out float4 opos : SV_POSITION
            )
            {
                // o  = (v2f)0;
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                AdaptorDPS(v);
                o.uv0 = v.uv0;
                opos = UnityObjectToClipPos(v.vertex);
                o.normalDir = UnityObjectToWorldNormal( v.normal);
                o.worldPos  = mul( unity_ObjectToWorld, v.vertex);
                float4 position = UnityClipSpaceShadowCasterPos(v.vertex, v.normal);
                o.worldPos      = UnityApplyLinearShadowBias(position);
                opos    = o.worldPos;
            }






            float4 frag(v2f i, UNITY_VPOS_TYPE screenPos : VPOS) : SV_TARGET 
            {
                UNITY_SETUP_INSTANCE_ID(i);
#ifndef NotAlpha
                float2 Set_UV0          = i.uv0;
                float4 clippingMaskTex  = tex2D(_ClippingMask,TRANSFORM_TEX(Set_UV0, _ClippingMask));
                float4 mainTex          = tex2D(_MainTex, TRANSFORM_TEX(Set_UV0, _MainTex));
                float useMainTexAlpha   = (_IsBaseMapAlphaAsClippingMask) ? mainTex.a : clippingMaskTex.r;
                float alpha             = (_Inverse_Clipping) ? (1.0 - useMainTexAlpha) : useMainTexAlpha;
                float clipTest          = (_DetachShadowClipping) ? _Clipping_Level_Shadow : _Clipping_Level;
                clip(alpha - clipTest);
                clipTest                = saturate(alpha + _Tweak_transparency);
    #ifdef ShadowDither
                uint sampleCount    = GetRenderTargetSampleCount();
                float dither    = ScreenDitherToAlphaCutout_ac(screenPos.xy, (1 - clipTest));
                alpha           = clipTest - dither;
                // alpha           = clipTest - dither/sampleCount + 1. / (sampleCount);
                clip(alpha );
    #else //// ShadowDither
                clip(clipTest);
    #endif //// ShadowDither
                // return 0;
                SHADOW_CASTER_FRAGMENT(i)
#else //// NotAlpha
                // return 0;
                SHADOW_CASTER_FRAGMENT(i)
#endif //// NotAlpha
            }
#endif // ACLS_SHADOWCASTER
