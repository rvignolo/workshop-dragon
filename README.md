# Workshop: Learning DRAGON V5 as a Production Code for Cross-Sections

**Meeting:** III Annual Meeting of the Argentinean Group of Calculation and Reactor Analysis.

**Date:** November 17, 2016.

**Location:** Central Headquarters of the National Atomic Energy Commission.

**Total Duration:** 6 hours.

**Instructor:** Ramiro Vignolo.

## Abstract

DRAGON contains a series of models that enable the simulation of neutron behavior in a
nuclear reactor fuel cell or fuel element. This code includes the main features of a cell
code: interpolation of microscopic cross-sections obtained from libraries; self-shielding
calculations in multidimensional geometries; multigroup and multidimensional neutron flux
calculations; homogenization of nuclear properties for core calculations and isotopic
depletion. In this workshop, participants will learn to use the DRAGON cell code in its
fifth version, covering the different stages that constitute a generic input and performing
various examples that reinforce the understanding of each of them. Finally, the use of
external tools recommended by the developers as well as by the workshop instructors will be
addressed.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Workshop Structure](#workshop-structure)
- [General Considerations](#general-considerations)
- [File Description](#file-description)
- [Directory Description](#directory-description)
- [Usage Examples](#usage-examples)
- [Technical Background](#technical-background)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

Before starting this workshop, ensure you have the following software installed:

### Required Software

- **DRAGON V5**: Nuclear reactor cell calculation code
  - Download from [Merlin server](http://www.polymtl.ca/merlin/version5.htm)
  - Must be accessible via the `dragon` command in your terminal
- **Bash shell**: For running the provided scripts
- **C compiler**: For compiling custom routines (GCC recommended)

### Recommended Software

- **GhostView**: For PostScript file visualization
- **Gnuplot**: For 2D and 3D plotting
- **Pyxplot**: Alternative to gnuplot for 2D plots (if available)
- **Kate**: Text editor with [DRAGON syntax highlighting](https://github.com/rvignolo/dragon-highlighting)

## Installation

1. **Clone this repository:**

   ```bash
   git clone https://github.com/rvignolo/workshop-dragon.git
   cd workshop-dragon
   ```

2. **Verify DRAGON installation:**

   ```bash
   dragon --version
   ```

   If this command fails, ensure DRAGON is properly installed and added to your PATH.

3. **Set up your environment:**

   ```bash
   # Make all scripts executable
   find . -name "*.sh" -exec chmod +x {} \;
   ```

4. **Test the installation:**
   ```bash
   cd 1.materials/1.macroscopic
   ./run.sh
   ```

## Workshop Structure

The workshop is organized into 5 progressive modules, each building upon the previous
knowledge:

```
workshop-dragon/
├── 1.materials/           # Cross-section definitions and libraries
│   ├── 1.macroscopic/     # Macroscopic cross-sections
│   └── 2.microscopic/     # Microscopic cross-sections
├── 2.geometries-and-tracking/  # Geometry definitions and ray tracing
│   ├── 1.cna2_excelt/     # CANDU-2 EXCELT geometry
│   ├── 2.cna2_nxt/        # CANDU-2 NXT geometry
│   ├── 3.square_ass/      # Square assembly
│   ├── 4.candu_marleau/   # CANDU Marleau geometry
│   └── 5.hexagonal_ass/   # Hexagonal assembly
├── 3.flux-calculation/    # Neutron flux calculations
│   └── 1.flux-dist/       # Flux distribution analysis
├── 4.reference-burnup/    # Reference burnup calculations
└── 5.local-perturbations/ # Local perturbation analysis
    └── 1.linear-loop/     # Linear perturbation loop
```

## General Considerations

1. The main directory contains various folders with DRAGON inputs and scripts organized in 5
   numbered directories. The numbering respects the order in which the workshop topics will
   be addressed.

2. It is recommended to have GhostView installed for PostScript visualization and gnuplot
   for 2D and 3D plotting. However, if you have pyxplot available, 2D plots will be
   generated using this program instead of gnuplot.

3. As a text editor, the use of Kate is recommended since we have written [syntax
   highlighting](https://github.com/rvignolo/dragon-highlighting) for DRAGON.

4. It is necessary to have DRAGON installed globally and accessible via the `dragon`
   command. It can be downloaded from the [Merlin
   server](http://www.polymtl.ca/merlin/version5.htm).

5. In the [downloads
   section](https://bitbucket.org/rvignolo/taller-dragon-garcar-2016/downloads), you will
   find slides that can be used to accompany the workshop reading.

## File Description

The numbered directories from `1.` to `5.` contain the complete practical part of the
workshop, including DRAGON inputs and scripts. In the generic case, a directory may contain
the following files:

### Input Files

1. **`.x2m` files**: DRAGON input files containing the main calculation parameters
2. **`.c2m` files**: DRAGON procedure files with reusable code modules

### Scripts

3. **`clean.sh`**: Cleans the information obtained after running an input (note that you can
   modify this script as needed)
4. **`run.sh`**: Properly executes the DRAGON input. Additionally, if the `-g` option is
   given, it will display PostScript outputs in GhostView
5. **`xs-plot.sh`**: Generates cross-section plots in gnuplot or pyxplot and in 2D and 3D as
   appropriate
6. **`compile.sh`**: Compiles C routines using GanLib libraries

### Output Files

After executing the `run.sh` script in each directory, in the most general case, files of
the following type will be obtained:

1. **`.result` files**: Contain the DRAGON output with calculation results
2. **`.ps` files**: PostScript files with geometry plots showing region distribution,
   mixtures, or flux
3. **`.m` files**: MATLAB/Octave files containing ray tracing information
4. **`Database.dat`**: File generated by the `COMPO:` module of DRAGON and converted to
   ASCII
5. **`.dat` files**: Cross-section information after processing `Database.dat` with C
   routines

## Directory Description

Each workshop directory will be briefly and individually explained.

### `1.materials`

This directory contains two subdirectories, `1.macroscopic` and `2.microscopic`, where the
input format for the `MAC:` and `LIB:` modules respectively is specified. Particular
attention should be paid to, for example, the format of scattering cross-sections and the
results of the runs.

**Key Learning Objectives:**

- Understand macroscopic vs. microscopic cross-section definitions
- Learn proper input formatting for DRAGON modules
- Analyze scattering cross-section matrices
- Interpret calculation results

### `2.geometries-and-tracking`

This directory contains inputs that describe different types of geometries, to which
different ray tracing modules can be applied. It is important to analyze each of the
geometries and understand both material definitions and boundary conditions. Once each of
these cases is understood, propose a geometry and try to implement it.

**Key Learning Objectives:**

- Master geometry definition in DRAGON
- Understand ray tracing algorithms
- Learn boundary condition specification
- Practice with different fuel assembly types

### `3.flux-calculation`

Flux calculation is proposed in the same geometry but defined in different ways. Compare the
results and understand the use of DRAGON's new tools, such as the `G2S:` and `SALT:`
modules.

**Key Learning Objectives:**

- Compare different flux calculation methods
- Understand the `G2S:` and `SALT:` modules
- Analyze flux distribution patterns
- Validate calculation convergence

### `4.reference-burnup`

The reference burnup is, precisely, a run that performs isotopic evolution. The output of
this run consists of cross-sections as a function of burnup. The important aspects are
understanding both the algorithm used for burning and the tools employed to collect the
information.

**Key Learning Objectives:**

- Understand burnup algorithms
- Learn isotopic evolution tracking
- Master cross-section interpolation
- Analyze burnup-dependent behavior

### `5.local-perturbations`

Local perturbations take the reference burnup and traverse it while locally perturbing some
parameter. This allows obtaining cross-sections as a function of burnup and a local
perturbation. By post-processing these values, it is possible to obtain, for example, the
derivatives of cross-sections with respect to the local parameter as a function of burnup.

**Key Learning Objectives:**

- Implement local perturbation methods
- Calculate sensitivity coefficients
- Understand uncertainty propagation
- Master post-processing techniques

## Usage Examples

### Basic Run

```bash
cd 1.materials/1.macroscopic
./run.sh
```

### Run with Graphics

```bash
cd 2.geometries-and-tracking/1.cna2_excelt
./run.sh -g
```

### Clean and Re-run

```bash
./clean.sh
./run.sh
```

### Compile and Run with Custom Routines

```bash
cd 4.reference-burnup
./compile.sh
./run.sh
```

## Technical Background

### DRAGON V5 Overview

DRAGON (Deterministic Transport Analysis of Reactor Physics) is a deterministic neutron
transport code developed at École Polytechnique de Montréal. Version 5 represents a
significant advancement in nuclear reactor cell calculations, offering:

- **Advanced Geometry Modeling**: Support for complex 2D and 3D geometries
- **Multiple Transport Methods**: Method of characteristics, collision probability, and
  discrete ordinates
- **Comprehensive Cross-section Processing**: Self-shielding, resonance treatment, and
  temperature interpolation
- **Burnup Capabilities**: Isotopic evolution and depletion calculations
- **Sensitivity Analysis**: Local and global perturbation methods

### Key Modules Used in This Workshop

- **`MAC:`**: Macroscopic cross-section definition
- **`LIB:`**: Microscopic cross-section library processing
- **`GEO:`**: Geometry definition and representation
- **`EXCELT:`**: Method of characteristics ray tracing
- **`FLU:`**: Flux calculation
- **`BURN:`**: Burnup calculations
- **`COMPO:`**: Composition tracking

## Troubleshooting

### Common Issues

**DRAGON command not found:**

```bash
# Check if DRAGON is in your PATH
which dragon
# If not found, add to your PATH or install DRAGON
```

**Permission denied on scripts:**

```bash
chmod +x *.sh
```

**PostScript files not displaying:**

```bash
# Install GhostView
sudo apt-get install gv  # Ubuntu/Debian
brew install ghostscript # macOS
```

**Gnuplot not available:**

```bash
# Install gnuplot
sudo apt-get install gnuplot  # Ubuntu/Debian
brew install gnuplot          # macOS
```

### Getting Help

- Check the DRAGON user manual
- Review the `.result` files for error messages
- Ensure all input files are properly formatted
- Verify that all required modules are available

## Contributing

This workshop material is part of the nuclear engineering community. If you find errors or
have suggestions for improvements:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

Please ensure that:

- All scripts remain executable
- Input files follow DRAGON V5 syntax
- Documentation is updated accordingly

## License

This workshop material is provided for educational purposes. Please respect the original
author's work and cite appropriately when using these materials in publications or
presentations.

---

**Note:** This workshop assumes basic knowledge of nuclear reactor physics and neutron
transport theory. For additional background, refer to standard nuclear engineering textbooks
and the DRAGON user manual.
