
# Lempel-Ziv 77 via Prefix-Free Parsing (PFP-LZ77)[![Release](https://img.shields.io/github/release/AaronHong1024/PFP_LZ77.svg)](https://github.com/AaronHong1024/PFP_LZ77/releases/tag/v2.0)

[LZ77 via Prefix-Free Parsing](https://epubs.siam.org/doi/abs/10.1137/1.9781611977561.ch11)

This repository provides an implementation of PFP-LZ77, an algorithm for constructing the Lempel-Ziv 77 (LZ77) factorization using prefix-free parsing (PFP). By augmenting PFP with primitives for previous/next smaller value queries, PFP-LZ77 efficiently computes the LZ77 parse, scaling to large and highly repetitive datasets such as human chromosome collections and SARS-CoV-2 genomes

# Usage

## Building the LZ77

To build the LZ77 you can use the `lz_77` pipeline as follows.
```
usage: lz_77 [-w WSIZE] input

positional arguments:
  -w WSIZE, --wsize WSIZE
                        sliding window size (def. 10)
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
./_deps/bigbwt-build/newscanNT.x ../data/yeast.fasta -w 10 -p 100 -f
./src/lz_77 ../data/yeast.fasta
```
We need to run the bigbwt first to generate the dictionary file and pars file. The -w is the window size and -p is the hash modulus.
# External resources

* [Big-BWT](https://github.com/alshai/Big-BWT.git)
    * [gSACA-K](https://github.com/felipelouza/gsa-is.git)
    * [malloc_count](https://github.com/bingmann/malloc_count)
* [sdsl-lite](https://github.com/simongog/sdsl-lite)
    * [Divsufsort](https://github.com/simongog/libdivsufsort.git)

# Citation

If you use this code or reproduce the results, please cite:

> Hong, A., Rossi, M., & Boucher, C. (2023). LZ77 via Prefix-Free Parsing. In Proceedings. 2023 Proceedings of the Symposium on Algorithm Engineering and Experiments (ALENEX) (pp. 123–134). doi:10.1137/1.9781611977561.ch11


