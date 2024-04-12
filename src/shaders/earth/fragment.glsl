uniform sampler2D uDayTexture;
uniform sampler2D uNightTexture;
uniform sampler2D uSpecularCloudsTexture;

varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vPosition;

void main()
{

    vec3 viewDirection = normalize(vPosition - cameraPosition);
    vec3 normal = normalize(vNormal);
    vec3 color = vec3(0.0);

    // Sun orientation
    vec3 uSunDirection = vec3(0.0, 0.0, 1.0);
    float sunOrientaiton = dot(uSunDirection, normal);
    
    
    // Day / night color
    float dayMix = smoothstep(-0.25, 0.5, sunOrientaiton);
    vec3 dayColor = texture2D(uDayTexture, vUv).rgb;
    vec3 nightColor = texture2D(uNightTexture, vUv).rgb;
    
    color = mix(nightColor, dayColor, dayMix);
    
    



    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}