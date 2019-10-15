// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LXH/06 Diffuse Fragment Half Lambert"{//半兰伯特 逐像素漫反射
	Properties{
		_Diffuse("Diffuse Color",Color) = (1,1,1,1)
	}

		SubShader{
			Pass {
				Tags{"LightModel" = "ForwardBase"}
				CGPROGRAM
				#include "Lighting.cginc"
				#pragma vertex vert
				#pragma fragment frag
				fixed4 _Diffuse;

				struct a2v {
					float4 vertex : POSITION;
					float3 normal : NORMAL;
				};

				struct v2f {
					float4 position:SV_POSITION;
					fixed3 worldNormalDir : COLOR0;
				};

				v2f vert(a2v v) {
					v2f f;
					f.position = UnityObjectToClipPos(v.vertex);

					f.worldNormalDir = mul(v.normal, (float3x3) unity_WorldToObject);

					return f;
				}

				fixed4 frag(v2f f):SV_Target {
					fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;

					fixed3 normalDir = normalize(f.worldNormalDir);

					fixed3 lightDir = normalize(_WorldSpaceLightPos0.xyz);

					float halflambert = dot(normalDir, lightDir) * 0.5 + 0.5;

					fixed3 diffuse = _LightColor0.rgb * halflambert *_Diffuse.rgb;
					fixed3 tempColor = diffuse + ambient;
					return fixed4(tempColor,1);
				}

			ENDCG

		}
	}
	Fallback "Diffuse"
}