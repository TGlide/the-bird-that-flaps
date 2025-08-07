shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float strength : hint_range(0.0, 1.0) = 0.2;
uniform float speed : hint_range(0.0, 2.0) = 0.1;
uniform vec2 screen_resolution = vec2(1280.0, 720.0); // Must be set from GDScript
uniform float effect_mix : hint_range(0.0, 1.0) = 0.6;

void fragment() {
    float t = TIME * speed;

    // Convert SCREEN_UV to range [-1, 1], centering it
    vec2 pos = SCREEN_UV * 2.0 - 1.0;

    // Preserve aspect ratio manually using the screen resolution uniform
    pos.y *= (screen_resolution.y / screen_resolution.x);

    pos *= 4.0; // Scale up for a larger effect

    for (float k = 1.0; k < 7.0; k += 1.0) {
        pos.x += strength * sin(2.0 * t + k * 1.5 * pos.y) + t * 0.5;
        pos.y += strength * cos(2.0 * t + k * 1.5 * pos.x);
    }

    // Create a single intensity value from the pattern
    float intensity = 0.5 + 0.5 * cos(TIME + pos.x + pos.y);

    // Create purple colors by mixing different purple shades
    vec3 purple1 = vec3(0.4, 0.1, 0.8);  // Deep purple
    vec3 purple2 = vec3(0.8, 0.2, 1.0);  // Bright magenta
    vec3 purple3 = vec3(0.2, 0.0, 0.6);  // Dark purple

    // Mix between purple shades based on the pattern
    vec3 col = mix(purple1, purple2, intensity);
    col = mix(col, purple3, sin(TIME * 0.5 + pos.x * 2.0) * 0.3 + 0.3);

    // Get the original screen content
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);

    // Mix the effect with the original screen content
    COLOR = vec4(mix(screen_color.rgb, col, effect_mix), 1.0);
}