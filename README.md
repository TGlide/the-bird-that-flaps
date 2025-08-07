# The Bird that Flaps

A classic Flappy Bird clone built with Godot 4.4, featuring pixel art graphics, power-ups, and smooth gameplay mechanics.

## Controls

- **Spacebar** or **Left Mouse Click**: Make the bird fly/flap
- **Enter**: Start the game from title screen
- **R**: Restart/reload the current scene

## Technical Details

- **Engine**: Godot 4.4
- **Language**: GDScript
- **Resolution**: 456x256 (with integer scaling)
- **Art Pipeline**: Aseprite integration via AsepriteWizard addon

## Project Structure

```
├── actors/          # Player character scripts and scenes
├── assets/          # Game art, sounds, and sprites
├── autoload/        # Global state management
├── objects/         # Game objects (pipes, power-ups)
├── shaders/         # Visual effects shaders
├── ui/              # User interface components
└── main.gd          # Main game controller
```

## Game Mechanics

### Bird Physics
- Gravity constantly pulls the bird down
- Tapping gives an upward impulse
- Bird rotation changes based on velocity direction
- Collision detection with pipes and ground

### Power-ups
- Clock power-ups appear randomly
- When collected, slows game time to 50% for a limited duration
- Provides temporary advantage for navigating difficult sections

### Scoring
- Points awarded for successfully passing through pipes
- Best score is automatically saved and displayed
- Score resets on game restart

## Development

### Prerequisites
- Godot 4.4 or later
- AsepriteWizard addon (included)

### Running the Game
1. Open the project in Godot
2. Press F5 or click the play button
3. Select `main.tscn` as the main scene if prompted

You can also see a preview at https://organictrain.itch.io/the-bird-that-flaps.

### Asset Pipeline
The project uses Aseprite files (`.aseprite`) for sprites, which are then imported via the AsepriteWizard addon. Original Aseprite files are included in the assets directory.

## Credits

- Sound effects from the original Flappy Bird assets
- Flappy Bird assets from [MegaCrash](https://megacrash.itch.io/flappy-bird-assets)
- Pixel art created with Aseprite
- Built with the Godot game engine

## License

This project is for educational and demonstration purposes.
