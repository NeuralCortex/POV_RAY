# POV-Ray Mathematical 3D Art

![POV-Ray Image](https://github.com/NeuralCortex/POV_RAY/blob/main/images/readme.png)

## Overview

The Persistence of Vision Raytracer (POV-Ray) is a powerful ray-tracing tool that uses a 3D scene description language. This allows users to create and manipulate objects like spheres, cylinders, and other shapes in 3D space with customizable colors and textures. A key feature of POV-Ray is its ability to leverage mathematical functions to design intricate and complex 3D models.

## Important Note

For optimal results, use a 16:9 aspect ratio for image output to avoid distortions. The camera's "Right Vector" can be adjusted in the POV-Ray scene files to fine-tune the perspective.

## Software Used

All files in this project were created using [POV-Ray 3.7.0 for Windows](http://www.povray.org/).

## Getting Started

### Prerequisites
- Install [POV-Ray 3.7.0](http://www.povray.org/) for your operating system (Windows, macOS, or Linux).
- Ensure the POV-Ray executable is accessible in your system's PATH or located in the project directory.

### Running POV-Ray Files
1. **Download the project**: Clone or download the repository to your local machine.
2. **Open a POV-Ray file**: Locate the `.pov` files in the project directory.
3. **Render the scene**:
   - **Windows**: 
     - Open POV-Ray 3.7.0.
     - Load a `.pov` file via the GUI or run from the command line: `povray filename.pov`.
     - Example batch file to render a file (save as `render_povray.bat`):
       ```batch
       @echo off
       REM Batch file to render a POV-Ray scene
       SET POV_FILE=example.pov
       povray %POV_FILE% +W1920 +H1080
       pause
       ```
       - Update `POV_FILE` to your `.pov` file name.
       - `+W1920 +H1080` sets a 16:9 resolution (1920x1080). Adjust as needed.
       - Run the batch file from the command prompt.
   - **Linux/macOS**:
     - Run from the terminal: `povray filename.pov +W1920 +H1080`.
     - Example shell script (save as `render_povray.sh`):
       ```bash
       #!/bin/bash
       # Script to render a POV-Ray scene
       POV_FILE=example.pov
       povray $POV_FILE +W1920 +H1080
       ```
       - Update `POV_FILE` to your `.pov` file name.
       - Make executable: `chmod +x render_povray.sh`.
       - Run: `./render_povray.sh`.
4. **View output**: The rendered image will be saved in the same directory as the `.pov` file, typically as a PNG.

### Customizing Scenes
- Edit `.pov` files in a text editor to modify object positions, colors, textures, or camera settings.
- Adjust the "Right Vector" in the camera block to correct perspective or aspect ratio issues.
- Use mathematical functions to create complex models, as described in the [POV-Ray documentation](http://www.povray.org/documentation/).

## Troubleshooting
- **Distorted Output**: Ensure the output resolution matches a 16:9 aspect ratio (e.g., 1920x1080 or 1280x720).
- **POV-Ray Not Found**: Verify POV-Ray is installed and the executable is in your PATH or project directory.
- **Syntax Errors**: Check `.pov` files for correct syntax, ensuring all brackets and parameters are properly closed.