//
// Created by hongy on 3/23/2022.
//

#ifndef PFP_CST_PPS_SUPPORT_HPP
#define PFP_CST_PPS_SUPPORT_HPP

#endif //PFP_CST_PPS_SUPPORT_HPP
#include <iostream>
#include <vector>

using namespace std;

vector<int64_t> PSV(const vector<int64_t>& proper_phrase_suffix){
    size_t n = proper_phrase_suffix.size();
    vector<int64_t> PSV;
    PSV.reserve(n);
   // int PSV[n];
//    for (int i = 0; i < n; ++i) {
//        PSV.push_back(-1);
//    }
//    for (int i = 1; i < n; ++i) {
//        if (proper_phrase_suffix[i] > proper_phrase_suffix[i-1]){
//            PSV[i] = i-1;
//        }else{
//            int j = PSV[i-1];
//            while(j >= 0){
//                if ( proper_phrase_suffix[i] > proper_phrase_suffix[j]){
//                    PSV[i] = j;
//                    break;
//                }
//                j = PSV[j];
//            }
//        }
//    }
    PSV.push_back(-1);
    for (size_t i = 1; i < n; ++i) {
        PSV.push_back(-1);
        size_t j = i-1;
        while(j >= 0){
            if ( proper_phrase_suffix[i] > proper_phrase_suffix[j]){
                PSV[i] = j;
                break;
            }
            j = PSV[j];
        }
    }

    return PSV;
}

vector<int64_t> NSV(const vector<int64_t>& proper_phrase_suffix){
    size_t n = proper_phrase_suffix.size();
    vector<int64_t> NSV;
    NSV.reserve(n);
//    for (int i = 0; i < n; ++i) {
//        NSV.push_back(-1);
//    }
//
//    for (int i = n-1; i > 1; --i) {
//        if (proper_phrase_suffix[i] < proper_phrase_suffix[i-1]){
//            NSV[i-1] = i;
//        } else{
//            int j = NSV[i];
//            while(j < n+1){
//                if (proper_phrase_suffix[j] < proper_phrase_suffix[i-1]){
//                    NSV[i-1] = j;
//                    break;
//                }
//                j = NSV[j];
//            }
//            NSV[i-1] = j;
//        }
//    }
    NSV.resize(n);
    NSV[n-1] = -1;
    for (size_t i = n-1; i > 1; --i) {
        NSV[i-1] = -1;
        int j = i;
        while(j < n+1){
            if (proper_phrase_suffix[j] < proper_phrase_suffix[i-1]){
                NSV[i-1] = j;
                break;
            }
            j = NSV[j];
        }
    }
    return NSV;
}