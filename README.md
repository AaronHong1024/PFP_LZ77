
# PFP-LZ77: Lempel-Ziv 77 via Prefix-Free Parsing

[![Release](https://img.shields.io/github/release/AaronHong1024/PFP_LZ77.svg)](https://github.com/AaronHong1024/PFP_LZ77/releases/tag/v2.0)
[![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](LICENSE)
[![Language](https://img.shields.io/badge/language-C++-blue.svg)](https://isocpp.org/)
[![CMake](https://img.shields.io/badge/CMake-3.15+-green.svg)](https://cmake.org/)

An efficient implementation of the Lempel-Ziv 77 (LZ77) factorization algorithm using Prefix-Free Parsing (PFP). This implementation scales to large and highly repetitive datasets such as human chromosome collections and SARS-CoV-2 genomes.

**Paper**: [LZ77 via Prefix-Free Parsing](https://epubs.siam.org/doi/abs/10.1137/1.9781611977561.ch11)


## Overview

PFP-LZ77 constructs the Lempel-Ziv 77 factorization by augmenting Prefix-Free Parsing (PFP) with primitives for previous/next smaller value queries. This approach enables efficient compression of highly repetitive text collections while maintaining scalability.

**Key Benefits:**
- Efficient processing of large, repetitive datasets
- Memory-efficient implementation
- Scalable to genomic-scale data
- Based on solid theoretical foundations

## Features

-  **Efficient LZ77 Construction**: Fast computation using prefix-free parsing
-  **Memory Optimized**: Designed for large-scale datasets
-  **Genomic Data Support**: Optimized for biological sequences
-  **CMake Integration**: Easy integration into existing projects
-  **Cross-platform**: Works on Linux, macOS, and Windows

## Requirements

### System Requirements
- **OS**: Linux, macOS, or Windows
- **Compiler**: GCC 7+ or Clang 6+ with C++14 support
- **CMake**: Version 3.15 or higher
- **Memory**: Depends on input size (typically 5-10x input size)

### Dependencies
All dependencies are automatically downloaded and built using CMake FetchContent:
- [Big-BWT](https://github.com/alshai/Big-BWT.git)
- [SDSL-lite](https://github.com/simongog/sdsl-lite)
- [libdivsufsort](https://github.com/simongog/libdivsufsort.git)
- [gSACA-K](https://github.com/felipelouza/gsa-is.git)


## Installation

### Clone the Repository
```bash
git clone https://github.com/AaronHong1024/PFP_LZ77.git
cd PFP_LZ77
```

### Build from Source
```bash
# Create build directory
mkdir build && cd build

# Configure with CMake
cmake ..

# Build the project
make -j$(nproc)
```


## Quick Start

### Basic Usage
```bash
# Step 1: Generate dictionary and parse files using Big-BWT
./_deps/bigbwt-build/newscanNT.x input.fasta -w 10 -p 100 -f

# Step 2: Compute LZ77 factorization
./lz77 input.fasta
```

### Command Line Options
```bash
# Basic usage
./lz77 input_file

# With 64-bit version
./lz77_64 input_file
```

## Usage

### Building LZ77 Factorization

The main executable `pfp-cst_build` computes the LZ77 factorization:

```bash
./lz77 [OPTIONS] input_file
```

**Parameters:**
- `input_file`: Path to input text file
- `-w, --wsize`: Sliding window size (default: 10)

**Available Executables:**
- `pfp-cst_build`: Standard version
- `pfp-cst_build64`: 64-bit optimized version
- `lz_77_test`: Test executable
- `lz_77_test64`: 64-bit test executable

**Output:**
The LZ77 factorization will be stored in the same directory as the input file with appropriate extensions.

### File Formats

**Input:** Plain text files (FASTA format supported for genomic data)  
**Output:** Binary files containing LZ77 factors

### Prerequisites

Before running the LZ77 construction, you need to generate dictionary and parse files using Big-BWT:

```bash
# Generate required files
./_deps/bigbwt-build/newscanNT.x input_file -w window_size -p hash_modulus -f
```

**Big-BWT Parameters:**
- `-w`: Window size (affects compression ratio)
- `-p`: Hash modulus (typically 100)
- `-f`: Force overwrite existing files

## Integration

### CMake Integration

Add PFP-LZ77 to your CMake project:

```cmake
include(FetchContent)

# Fetch PFP-LZ77
FetchContent_Declare(
  PFP_LZ77
  GIT_REPOSITORY https://github.com/AaronHong1024/PFP_LZ77.git
  GIT_TAG        v2.0  # Use specific version
)

FetchContent_MakeAvailable(PFP_LZ77)

# Link to your target
add_executable(my_app main.cpp)
target_link_libraries(my_app PFP_LZ77)
```


## Dependencies

This project automatically manages the following dependencies:

- **[Big-BWT](https://github.com/alshai/Big-BWT.git)**: For suffix array construction
  - **[gSACA-K](https://github.com/felipelouza/gsa-is.git)**: Generalized suffix array construction
  - **[malloc_count](https://github.com/bingmann/malloc_count)**: Memory usage tracking
- **[SDSL-lite](https://github.com/simongog/sdsl-lite)**: Succinct data structures library
  - **[libdivsufsort](https://github.com/simongog/libdivsufsort.git)**: Suffix array library


## Citation

If you use this software in your research, please cite:

> Hong, A., Rossi, M., & Boucher, C. (2023). LZ77 via Prefix-Free Parsing. In Proceedings. 2023 Proceedings of the Symposium on Algorithm Engineering and Experiments (ALENEX) (pp. 123–134). doi:10.1137/1.9781611977561.ch11


---
**Developed by**: Aaron Hong, Massimiliano Rossi, Christina Boucher  
**Affiliation**: University of Florida  
**Contact**: [Aaron Hong](https://github.com/AaronHong1024)


