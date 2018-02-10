// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Beginners/Flat Color" 
{
	Properties
	{
		_Color("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
	}

	//There can be multiple sub-shaders 1 for PS, 1 for Xbox etc.
	SubShader{
		Pass
		{
			//CG is nvidia's shading language. CGPROGRAM-ENDCG block will be treated outside of shaderlab.
			CGPROGRAM
			//pragmas 
			#pragma vertex vert //-this pragma tells unity to look for vertex function in vert(if vertex function is named bob then this pragma should be #pragma vertex bob)
			#pragma fragment frag //-this pragma tells unity to look for fragment function in frag

			//user-defined vars
			uniform float4 _Color;//keyword uniform is cg-specific, it makes it generic

			//base input structs
			struct vertexInput //shaders come with a lot of semantics attached to them(Positions, UV data, color data)
			{
				float4 vertex:POSITION;//semantic for position, take mesh's vertext position
			};

			struct vertexOutput 
			{
				float4 pos:SV_POSITION;//Unity will take the pos and applies to mesh's vertex position
			};

			//vertex function
			vertexOutput vert(vertexInput v)
			{
				vertexOutput o;
				o.pos = UnityObjectToClipPos(v.vertex);//vertex's elements(x,y,z,w) get multiplied by unity matrix elements xyzw
				
				return o;
			}

			//fragment function
			float4 frag(vertexOutput i):COLOR 
			{
				return _Color;
			}
			ENDCG
		}
	}

	//Fallback is commented out during dev, fallback block triggers if none other shader runs(like on an older GPU)
	//Fallback = "Diffuse"
}