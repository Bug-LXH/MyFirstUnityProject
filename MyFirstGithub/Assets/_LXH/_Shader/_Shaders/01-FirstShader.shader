Shader "LXH/01 myshader"{ //这里指定shader的文件名不要求与文件名保持一致

	Properties{
		//属性
		_Color("Color",Color) = (1,1,1,1)        //float4
		_Vector("Vector",Vector) = (1,2,3,4)   //float4
		_Int("Int",Int) = 1234                       //float4
		_Float("Float",Float) = 3.14               //float4
		_Range("Range",Range(1,11)) = 6     //float4
		_2D("Texture",2D) = "white"{}          //sampler2D
		_Cube("Cube",Cube) = "white"{}      //samplerCube
		_3D("Texture",3D) = "black"{}         //sampler3D
	}
		//SubShader可以写很多个 显卡运行效果的时候，从第一个SubShader开始，
		//如果第一个SubShader里面的效果都可以实现，那么就使用第一个SubShader，
		//如果显卡发现这个SubShader里面某些效果实现不了，它会自动运行下一个
	SubShader{
		//至少有一个Pass
		Pass{

			//在这里编写shader代码
			CGPROGRAM
			//使用CG语言编写shader代码
			float4 _Color;             //float half fixed
			 float3 t1;//half3 fixed3
			float2 t2;//half2 fixed2
			float   t3;
			float4 _Vector;
			float _Int;
			float _Float;
			float _Range;
			sampler2D _2D;
			samplerCube _Cube;
			sampler3D _3D;
			//float  32位存储
			//half   16位存储  -6w~6w
			//fixed  11位存储 -2~2

			ENDCG
		}
	}

	Fallback "VertexLit"
}