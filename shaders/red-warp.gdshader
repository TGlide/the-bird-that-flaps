shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float strength : hint_range(0.0, 1.0) = 0.2;
uniform float speed : hint_range(0.0, 5.0) = 0.1;
uniform vec2 screen_resolution = vec2(1280.0, 720.0); // Must be set from GDScript
uniform float effect_mix : hint_range(0.0, 1.0) = 1.0;
uniform float warp_strength : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    float t = TIME * speed;

    // Convert SCREEN_UV to range [-1, 1], centering it
    vec2 pos = SCREEN_UV * 2.0 - 1.0;

    // Preserve aspect ratio manually using the screen resolution uniform
    pos.y *= (screen_resolution.y / screen_resolution.x);

    pos *= 4.0; // Scale up for a larger effect

    // Store original pos for warping calculation
    vec2 warp_pos = pos;

    for (float k = 1.0; k < 7.0; k += 1.0) {
        pos.x += strength * sin(2.0 * t + k * 1.5 * pos.y) + t * 0.5;
        pos.y += strength * cos(2.0 * t + k * 1.5 * pos.x);
    }

    // Create warp offset based on the pattern
    vec2 warp_offset = vec2(
        sin(t * 2.0 + warp_pos.x * 3.0 + warp_pos.y * 2.0),
        cos(t * 1.5 + warp_pos.y * 3.0 + warp_pos.x * 2.0)
    ) * warp_strength;

    // Sample the screen texture with warped UV coordinates
    vec2 warped_uv = SCREEN_UV + warp_offset;
    vec4 screen_color = texture(SCREEN_TEXTURE, warped_uv);

    // Create a single intensity value from the pattern
    float intensity = 0.5 + 0.5 * cos(TIME + pos.x + pos.y);

    // Blood-red color palette
    vec3 blood_dark = vec3(0.3, 0.0, 0.0);   // Almost black red
    vec3 blood_mid  = vec3(0.5, 0.0, 0.0);   // Deep crimson
    vec3 blood_bright = vec3(0.7, 0.05, 0.05); // Fresh blood red

    // Mix between blood shades based on the pattern
    vec3 col = mix(blood_mid, blood_bright, intensity);
    col = mix(col, blood_dark, sin(TIME * 0.5 + pos.x * 2.0) * 0.3 + 0.3);

    // Mix the effect with the warped screen content
    COLOR = vec4(mix(screen_color.rgb, col, effect_mix), 1.0);
}
