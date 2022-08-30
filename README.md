[![Release](https://img.shields.io/github/release/AaronHong1024/PFP_LZ77.svg)](https://github.com/AaronHong1024/PFP_LZ77/releases)

# Lempel-Ziv 77 via Prefix-Free Parsing
Lempel-Ziv 77 described in [1], built on prefix-free parsing compressed suffix tree [1].

If you use the PFP_LZ77 in your research, please cite:
XXXXX

BibTex [here](#citation)

#Usage

## Building the LZ77

To build the LZ77 you can use the `lz_77` pipeline as follows.
```
usage: lz_77 input

positional arguments:
  input           input file name

Once built, the `lz_77` will be stored on disk, under the same directory as the input file.

## Integrating `lz_77` in your code

Integrate the `lz_77` into your code by using the `CMake`

```cmake
include(FetchContent)

## Add PFP_LZ77
FetchContent_declare(
  PFP_LZ77
  GIT_REPOSITORY https://github.com/AaronHong1024/PFP_LZ77
)

FetchContent_GetProperties(PFP_LZ77)
if(NOT PFP_LZ77_POPULATED)
  fetchContent_Populate(PFP_LZ77)
  add_subdirectory(${PFP_LZ77_SOURCE_DIR} ${PFP_LZ77_BINARY_DIR})
 endif()
```





[1] 
[2] Christina Boucher, Ondřej Cvacho, Travis Gagie, Jan Holub, Giovanni Manzini, Gonzalo Navarro, and Massimiliano Rossi . *"PFP Compressed Suffix Tree"*, In Proc. of the SIAM Symposium onAlgorithm Engineering and Experiments (ALENEX21), pp. 60-72. (2021).
