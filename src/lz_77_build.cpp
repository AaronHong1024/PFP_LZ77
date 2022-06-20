//
// Created by yu hong on 1/19/22.
//

#include<iostream>

//change the file name
#define VERBOSE

#include <common.hpp>
#include <pfp_cst.hpp>

#include <malloc_count.h>
using namespace std;

int main(int argc, char* const argv[]) {
    Args args;
    parseArgs(argc, argv, args);

    verbose("Window size set to: " , args.w);

    verbose("Computing LZ77");
    std::chrono::high_resolution_clock::time_point t_insert_start = std::chrono::high_resolution_clock::now();

    pf_parsing<> pf(args.filename, args.w);

    std::chrono::high_resolution_clock::time_point t_insert_end = std::chrono::high_resolution_clock::now();

    verbose("PFP DS construction complete");

}
