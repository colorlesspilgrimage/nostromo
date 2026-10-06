#version 300 es
// Seegson CRT: scanlines, soft phosphor bloom, vignette. Full-screen Hyprland shader.
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
layout(location = 0) out vec4 fragColor;

void main() {
    vec2 px = vec2(fwidth(v_texcoord.x), fwidth(v_texcoord.y));
    vec3 c = texture(tex, v_texcoord).rgb;

    // Cheap bloom: average of a few offset taps, added back at low strength.
    vec3 b = texture(tex, v_texcoord + vec2( 2.0,  0.0) * px).rgb
           + texture(tex, v_texcoord + vec2(-2.0,  0.0) * px).rgb
           + texture(tex, v_texcoord + vec2( 0.0,  2.0) * px).rgb
           + texture(tex, v_texcoord + vec2( 0.0, -2.0) * px).rgb;
    c += (b * 0.25) * 0.05;

    // Scanlines: darken every third pixel row.
    float row = floor(v_texcoord.y / px.y);
    c *= mix(1.0, 0.95, step(2.0, mod(row, 3.0)));

    // Vignette.
    vec2 d = v_texcoord - 0.5;
    c *= 1.0 - dot(d, d) * 0.15;

    fragColor = vec4(c, 1.0);
}
