﻿// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LXH/12 Rock"{

	Properties{
		//_Diffuse("Diffuse Color", Color) = (1,1,1,1)
		_Color("Color",Color) = (1,1,1,1)
		_MainTex("Main Tex",2D) = "white"{}
	}

		SubShader{
			Pass {
				Tags{"LightMode" = "ForwardBase"}
				CGPROGRAM
				#include "Lighting.cginc"
				#pragma vertex vert
				#pragma fragment frag

					//fixed4 _Diffuse;
					fixed4 _Color;
					sampler2D _MainTex;
					float4 _MainTex_ST;

					struct a2v { //给顶点函数传递
						float4 vertex:POSITION;
						float3 normal:NORMAL;
						float4 texcoord:TEXCOORD0;
					};

					struct v2f { //顶点函数和片元函数之间
						float4 svPos:SV_POSITION;
						float3 worldNormal:TEXCOORD0;
						float4 worldVertex:TEXCOORD1;
						float2 uv:TEXCOORD2;
					};

					v2f vert(a2v v) {//顶点函数
						v2f f;
						f.svPos = UnityObjectToClipPos(v.vertex);
						f.worldNormal = UnityObjectToWorldNormal(v.normal);
						f.worldVertex = mul(v.vertex, unity_WorldToObject);
						f.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
						return f;
					}

					fixed4 frag(v2f f) : SV_Target {//片元函数

						fixed3 normalDir = normalize(f.worldNormal);

						fixed3 lightDir = normalize(WorldSpaceLightDir(f.worldVertex));

						fixed3 texColor = tex2D(_MainTex, f.uv.xy) * _Color.rgb;

						fixed3 diffuse = _LightColor0.rgb * texColor * max(dot(normalDir,lightDir),0);

						fixed3 tempColor = diffuse + UNITY_LIGHTMODEL_AMBIENT.rgb * texColor;

						return fixed4(tempColor,1 );
					}


			ENDCG
		}
	}

	Fallback "Diffuse"
}