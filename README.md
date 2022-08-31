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
```
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
Link the `PFP_LZ77` target library to example `LZ_app`.

```cmake
add_executable(LZ_app LZ_app.cpp)
target_link_libraries(LZ_app PFP_LZ77)
```
### Project Mockup

#Example
### Download

```console
git clone https://github.com/AaronHong1024/PFP_LZ77.git
```

### Compile

```console
mkdir build
cd build
cmake ..
make 
```

### Run

```console
./src/lz_77 ../data/yeast.fasta
```

# External resources

* [Big-BWT](https://github.com/alshai/Big-BWT.git)
    * [gSACA-K](https://github.com/felipelouza/gsa-is.git)
    * [malloc_count](https://github.com/bingmann/malloc_count)
* [sdsl-lite](https://github.com/simongog/sdsl-lite)
    * [Divsufsort](https://github.com/simongog/libdivsufsort.git)

# Citation

Please, if you use this tool in an acdemic setting cite the following paper:

XXXXX


# Authors

### Theoretical results:

* Yu Hong
* Massimiliano Rossi
* Christina Boucher

#Reference

[1] 
[2] Christina Boucher, Ondřej Cvacho, Travis Gagie, Jan Holub, Giovanni Manzini, Gonzalo Navarro, and Massimiliano Rossi . *"PFP Compressed Suffix Tree"*, In Proc. of the SIAM Symposium onAlgorithm Engineering and Experiments (ALENEX21), pp. 60-72. (2021).
