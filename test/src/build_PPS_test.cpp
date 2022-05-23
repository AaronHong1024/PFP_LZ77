//
// Created by aaron hong on 4/3/2022.
//

#include <iostream>
#include <vector>

#include <sdsl/rmq_support.hpp>
#include <sdsl/int_vector.hpp>
#include <sdsl/lcp.hpp>
#include <sdsl/suffix_arrays.hpp>

#include <common.hpp>
#include <pfp.hpp>
#include <lz_77.hpp>
#include <sa_support.hpp>


extern "C" {
    #include<gsacak.h>
}

void test(){

    // initialize data
    //(#,0)(0,1)(G,0)(A,0)(T,0)
    std::vector<char> text = {'#','#','G','A','T','T','A','C','A','T','#',
                              'G','A','T','A','C','A','T','#',
                              'G','A','T','T','A','G','A','T','A','#','#'};
    std::vector<std::string> dict{"#GATTAC", "ACAT#", "AGATA##", "T#GATAC", "T#GATTAG"};
    std::vector<uint32_t> parse{1, 2, 4, 2, 5, 3, 0};
    std::vector<uint32_t> indices{0, 1, 2, 3, 4};
    std::vector<uint8_t> dict2 = {'G', 'A', 'T', 'T', 'A', 'C', EndOfWord,
                                  'A', 'C', 'A', 'T', '#', EndOfWord,
                                  'A', 'G', 'A', 'T', 'A', '#', '#', EndOfWord,
                                  'T', '#', 'G', 'A', 'T', 'A', 'C', EndOfWord,
                                  'T', '#', 'G', 'A', 'T', 'T', 'A', 'G', EndOfWord, EndOfDict};
    sdsl::bit_vector b_d = {1, 0, 0, 0, 0, 0, 0, 0, 0,
                            1, 0, 0, 0, 0, 0,
                            1, 0, 0, 0, 0, 0, 0, 0,
                            1, 0, 0, 0, 0, 0, 0, 0,
                            1, 0, 0, 0, 0, 0, 0, 0, 0, 1};
    const size_t n_phrases = 5;
    const std::vector<size_t> phrase_length{8, 5, 7, 7, 8};
    sdsl::bit_vector b_bwt = {1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1};

    const std::vector<std::pair<size_t, std::pair<size_t, size_t>>> M{
            {2, {0, 0}}, {6, {2, 2}}, {7, {3, 3}}, {7, {4, 4}}, {3, {0, 0}},
            {2, {2, 3}}, {2, {4, 4}}, {3, {1, 1}}, {5, {0, 0}}, {4, {2, 2}},
            {5, {3, 3}}, {5, {4, 4}}, {4, {1, 1}}, {6, {0, 0}}, {5, {2, 2}},
            {6, {3, 3}}, {6, {4, 4}}, {2, {1, 1}}, {4, {0, 0}}, {3, {2, 3}},
            {3, {4, 4}}, {4, {3, 3}}, {4, {4, 4}}
    };
    const std::vector<uint32_t> bwt_p = {3, 1, 4, 5, 2, 2};

    // Extract the reverse of the phrases
    std::vector<std::pair<std::string,uint32_t>> rev_dict;
    int i = 0;
    int rank = 0;
    while(i < dict2.size()-1){
        std::string s;
        while(i < dict2.size()-1 && dict2[i] != EndOfWord) s.append(1,dict2[i++]);
        i++;
        reverse(s.begin(), s.end());
        rev_dict.push_back({s,rank++});
    }
    std::sort(rev_dict.begin(),rev_dict.end());

    std::vector<uint32_t> rev_dict_lcp(rev_dict.size(),0);
    for(int i = 1; i < rev_dict.size(); ++i)
    {
        std::string& a = rev_dict[i-1].first;
        std::string& b = rev_dict[i].first;
        size_t lcp_i = 0;
        while(lcp_i < std::min(a.size(), b.size()) && a[lcp_i] == b[lcp_i])
            lcp_i++;

        rev_dict_lcp[i] = lcp_i;
    }

    std::vector<uint32_t> frequencies{0, 1, 2, 1, 1, 1};
    size_t w = 2;

    cout << "---------------- start paper test --------------------------"<<endl;
    pf_parsing<> pf(dict2,parse, frequencies,w);
    lz_77<> lz77(pf);
    //lz77.compute_lz_77();
}

int main(){
    test();
    return 1;
}

