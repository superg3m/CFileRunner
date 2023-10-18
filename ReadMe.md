### Description

- Run/Debug C and C++ code
- Link multiple C/C++ files together into one executable
- Add compiler flags
- link external libraries

## Getting Started

## Requirements

- g++ [Download here](https://code.visualstudio.com/docs/languages/cpp)
- gdb (if you want to debug) [Download here](https://code.visualstudio.com/docs/languages/cpp)

### Running the Program

- `powershell -ExecutionPolicy Bypass -File ../CFileRunner/RunC.ps1`

- `Add libraries`

### Debugging the Program

- `powershell -ExecutionPolicy Bypass -File ../CFileRunner/DebugC.ps1`

### Adding CompilerFlags and Libraries (Open RunC.ps1 or Debug.ps1)

- `$CompilerFlags = @("-Wall", "-pedantic")   # Add custom flags here (e.g., "-Wall")`
- `$libraryPath = @("", "")            # Example: -L<Path> ../Libs`
- `$Libraries = @("-luser32", "")         # link libraries here (e.g., "-lm -lYourLibraryNameHere")`

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For questions or support, you can reach to me at jovannidstudent@gmail.com.
