#ifndef SCSS_AUDIOLINK_INCLUDED
#define SCSS_AUDIOLINK_INCLUDED
// Reference the documentation at 
// https://github.com/llealloo/vrc-udon-audio-link
// for more info.

#ifdef SHADER_TARGET_SURFACE_ANALYSIS
#define AUDIOLINK_COMPILE_COMPATIBILITY
#endif
#include <UnityShaderVariables.cginc>

#include "ACLS_CORE.cginc"

#ifdef AUDIOLINK_COMPILE_COMPATIBILITY
#ifndef AUDIOLINK_CGINC_INCLUDED
sampler2D  _AudioTexture;
#endif
#else
#ifndef AUDIOLINK_CGINC_INCLUDED
Texture2D<float4> _AudioTexture;
#endif
SamplerState sampler_AudioGraph_Linear_Clamp;
#endif

uniform float _alModeR;
uniform float _alModeG;
uniform float _alModeB;
uniform float _alModeA;

uniform float _alBandR;
uniform float _alBandG;
uniform float _alBandB;
uniform float _alBandA;

uniform half4 _alColorR;
uniform half4 _alColorG;
uniform half4 _alColorB;
uniform half4 _alColorA;

uniform float _alTimeRangeR;
uniform float _alTimeRangeG;
uniform float _alTimeRangeB;
uniform float _alTimeRangeA;

uniform float _alUseFallback;
uniform float _alFallbackBPM;


float al_lerpstep(float a, float b, float t)
{
    return saturate((t - a) / (b - a));
}

float2 audioLinkModifyTexcoord(float4 texelSize, float2 p)
{
    p = p * texelSize.zw;
    // Instead of a hard clamp, sharpen to a pixel width for glancing angles
    float2 c = max(0.0, abs(fwidth(p)));
    c.x = 1;
    p = p + abs(c);
    p = floor(p) + saturate(frac(p) / c);
    p = (p - 0.5) * texelSize.xy;
    return p;
}

float audioLinkRenderBar(float grad, float pulse)
{
    float2 deriv = abs(fwidth(grad));
    float step = deriv * 0.5;
    return al_lerpstep(pulse, pulse + step, grad);
}

float al_expImpulse(float x, float k)
{
    const float h = k * x;
    return h * exp(1.0 - h);
}

float al_parabola(float x, float k)
{
    return pow(4.0 * x * (1.0 - x), k);
}

// Samples the AudioLink texture. 
float sampleAudioTexture(float band, float delay, float range)
{
    // Initialisation. 
    float2 audioLinkRes = 0;
    _AudioTexture.GetDimensions(audioLinkRes.x, audioLinkRes.y);

    if (audioLinkRes.x >= 128.0 && _alUseFallback != 2)
    {
        float2 params = float2(delay, band / 4.0);
        // We only want the bottom 4 bands.
        // When reading the texture, we want the bands to be thickly seperated.
        float2 alUV = params * float2(range, 0.0625);
        alUV = audioLinkModifyTexcoord(float4(1.0 / audioLinkRes, audioLinkRes), alUV);
        // sample the texture
        #ifdef AUDIOLINK_COMPILE_COMPATIBILITY
        return tex2Dlod(_AudioTexture, float4(alUV, 0, 0));
        #else
        return _AudioTexture.SampleLevel(sampler_AudioGraph_Linear_Clamp, alUV, 0);
        #endif
    }
    else
    {
        if (_alUseFallback != 0)
        {
            // If not available, fake one.
            float beat = _alFallbackBPM / 60;
            float rowTiming = (4 - band) / 4.0;
            delay *= range;
            beat = (delay - _Time.y) * rowTiming * beat;
            beat = frac(-beat);
            beat = al_expImpulse(beat, 8.0);
            float s;
            float c;
            sincos(beat, s, c);
            float final = saturate(s + (0.5 + c));
            // 
            return final * beat;
        }
    }

    return 0;
}

float audioLinkGetLayer(float weight, const float range, const float band, const float mode)
{
    if (mode == 0)
    {
        return weight * pow(sampleAudioTexture(band - 1, 1 - weight, range), 2.0) * 2.0;
    }
    if (mode == 1)
    {
        return audioLinkRenderBar(weight, 1 - sampleAudioTexture(band - 1, 1 - weight, range));
    }
    return 0;
}

#if defined(_EMISSION)
uniform float _EmissionDetailType;
uniform float _DetailEmissionUVSec;
UNITY_DECLARE_TEX2D(_DetailEmissionMap);
uniform half4 _DetailEmissionMap_ST;
uniform half4 _DetailEmissionMap_TexelSize;
uniform float4 _EmissionDetailParams;
uniform float _UseEmissiveLightSense;
uniform float _EmissiveLightSenseStart;
uniform float _EmissiveLightSenseEnd;
#endif

half4 EmissionDetail(float2 uv)
{
    #if defined(_EMISSION)
    if (_EmissionDetailType == 0) // Pulse
    {
        uv += _EmissionDetailParams.xy * _Time.y;
        half4 ed = UNITY_SAMPLE_TEX2D_SAMPLER(_DetailEmissionMap, _DetailEmissionMap, uv);
        if (_EmissionDetailParams.z != 0)
        {
            float s = (sin(ed.r * _EmissionDetailParams.w + _Time.y * _EmissionDetailParams.z)) + 1;
            ed.rgb = s;
        }
        return ed;
    }
    if (_EmissionDetailType == 1) // AudioLink
    {
        // Load weights texture
        half4 weights = UNITY_SAMPLE_TEX2D_SAMPLER(_DetailEmissionMap, _DetailEmissionMap, uv);
        // Apply a small epsilon to the weights to avoid artifacts.
        const float epsilon = (1.0 / 255.0);
        weights = saturate(weights - epsilon);
        // sample the texture
        float4 col = 0;
        col.rgb += (_alBandR >= 1) ? audioLinkGetLayer(weights.r, _alTimeRangeR, _alBandR, _alModeR) * _alColorR : 0;
        col.rgb += (_alBandG >= 1) ? audioLinkGetLayer(weights.g, _alTimeRangeG, _alBandG, _alModeG) * _alColorG : 0;
        col.rgb += (_alBandB >= 1) ? audioLinkGetLayer(weights.b, _alTimeRangeB, _alBandB, _alModeB) * _alColorB : 0;
        col.rgb += (_alBandA >= 1) ? audioLinkGetLayer(weights.a, _alTimeRangeA, _alBandA, _alModeA) * _alColorA : 0;
        col.a = 1.0;
        return col;
    }
    #endif
    return 1;
}

float2 EmissionDetailTexCoords(float2 uv0, float2 uv1)
{
    float2 texcoord;
    #if defined(_EMISSION)
    texcoord.xy = TRANSFORM_TEX(((_DetailEmissionUVSec == 0) ? uv0 : uv1), _DetailEmissionMap);
    #else
	texcoord.xy = uv0; // Default we won't need
    #endif
    return texcoord;
}

#define sRGB_Luminance float3(0.2126, 0.7152, 0.0722)

float3 addEmissive(float3 emissionIn, g2f i, float3 effectLighting, inout float3 color)
{
    #ifdef IS_OUTLINE
	float isOutline = true;
    #else
    float isOutline = false;
    #endif
    float3 emission;
    float2 emissionDetailUV = EmissionDetailTexCoords(i.uv01, i.uv01);
    float4 emissionDetail = EmissionDetail(emissionDetailUV);

    color = max(0, color - saturate((1 - emissionDetail.w) - (1 - emissionIn)));
    emission = emissionDetail.rgb * emissionIn * _Emissive_Color.rgb;

    // Glow in the dark modifier.
    #if defined(_EMISSION)
    float glowModifier = smoothstep(_EmissiveLightSenseStart, _EmissiveLightSenseEnd,
                                    dot(effectLighting, sRGB_Luminance));
    if (_UseEmissiveLightSense) emission *= glowModifier;
    #endif

    emission *= (1 - isOutline);
    return emission;
}

// Get the ambient (L0) SH contribution correctly
// Provided by Dj Lukis.LT - Unity's SH calculation adds a constant
// factor which produces a slight bias in the result.
half3 GetSHAverage()
{
    return float3(unity_SHAr.w, unity_SHAg.w, unity_SHAb.w)
        + float3(unity_SHBr.z, unity_SHBg.z, unity_SHBb.z) / 3.0;
}

//from bgolus https://forum.unity.com/threads/fixing-screen-space-directional-shadows-and-anti-aliasing.379902/
#if defined(SHADOWS_SCREEN) && defined(UNITY_PASS_FORWARDBASE) // fix screen space shadow arficats from msaa

#ifndef HAS_DEPTH_TEXTURE
#define HAS_DEPTH_TEXTURE
sampler2D_float _CameraDepthTexture;
float4 _CameraDepthTexture_TexelSize;
#endif

float SSDirectionalShadowAA(float4 _ShadowCoord, float atten)
{
    float a = atten;
    float2 screenUV = _ShadowCoord.xy / _ShadowCoord.w;
    float shadow = tex2D(_ShadowMapTexture, screenUV).r;

    if (frac(_Time.x) > 0.5)
        a = shadow;

    float fragDepth = _ShadowCoord.z / _ShadowCoord.w;
    float depth_raw = tex2D(_CameraDepthTexture, screenUV).r;

    float depthDiff = abs(fragDepth - depth_raw);
    float diffTest = 1.0 / 100000.0;

    if (depthDiff > diffTest)
    {
        float2 texelSize = _CameraDepthTexture_TexelSize.xy;
        float4 offsetDepths = 0;

        float2 uvOffsets[5] = {
            float2(1.0, 0.0) * texelSize,
            float2(-1.0, 0.0) * texelSize,
            float2(0.0, 1.0) * texelSize,
            float2(0.0, -1.0) * texelSize,
            float2(0.0, 0.0)
        };

        offsetDepths.x = tex2D(_CameraDepthTexture, screenUV + uvOffsets[0]).r;
        offsetDepths.y = tex2D(_CameraDepthTexture, screenUV + uvOffsets[1]).r;
        offsetDepths.z = tex2D(_CameraDepthTexture, screenUV + uvOffsets[2]).r;
        offsetDepths.w = tex2D(_CameraDepthTexture, screenUV + uvOffsets[3]).r;

        float4 offsetDiffs = abs(fragDepth - offsetDepths);

        float diffs[4] = {offsetDiffs.x, offsetDiffs.y, offsetDiffs.z, offsetDiffs.w};

        int lowest = 4;
        float tempDiff = depthDiff;
        for (int i = 0; i < 4; i++)
        {
            if (diffs[i] < tempDiff)
            {
                tempDiff = diffs[i];
                lowest = i;
            }
        }

        a = tex2D(_ShadowMapTexture, screenUV + uvOffsets[lowest]).r;
    }
    return a;
}
#endif

#endif //SCSS_AUDIOLINK_INCLUDED
