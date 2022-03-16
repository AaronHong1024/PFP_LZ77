/* pfp-dictionary - prefix free parsing dictionary
    Copyright (C) 2020 Massimiliano Rossi

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/ .
*/
/*!
   \file dictionary.hpp
   \brief dictionary.hpp define and build the prefix-free dictionary data structure.
   \author Massimiliano Rossi
   \date 03/04/2020
*/


#ifndef _PFP_DICTIONARY_HH
#define _PFP_DICTIONARY_HH

#include <queue>

#include <common.hpp>

#include <sdsl/rmq_support.hpp>
#include <sdsl/int_vector.hpp>
#include <wm.hpp>
extern "C" {
    #include<gsacak.h>
}


// TODO: Extend it to integer alphabets
class dictionary{
public:
  typedef sdsl::sd_vector<> bv_t;

  std::vector<uint8_t> d;
  std::vector<uint_t> saD;
  std::vector<uint_t> isaD;
  std::vector<int_da> daD;
  std::vector<int_t> lcpD;
  sdsl::rmq_succinct_sct<> rmq_lcp_D;
  bv_t b_d; // Starting position of each phrase in D
  bv_t::rank_1_type rank_b_d;
  bv_t::select_1_type select_b_d;
  std::vector<int_t> colex_daD;
  sdsl::rmq_succinct_sct<> rmq_colex_daD;
  sdsl::range_maximum_sct<>::type rMq_colex_daD;
  std::vector<uint_t> colex_id;

  std::vector<int_t> lcps; // Longest common phrase suffix in colex order
  sdsl::rmq_succinct_sct<> rmq_lcps;

  bool saD_flag = false;
  bool isaD_flag = false;
  bool daD_flag = false;
  bool lcpD_flag = false;
  bool rmq_lcp_D_flag = false;
  


  typedef size_t size_type;

  // default constructor for load.
  dictionary() {}

  dictionary( std::vector<uint8_t>& d_,
              size_t w,
              bool saD_flag_ = true,
              bool isaD_flag_ = true,
              bool daD_flag_ = true,
              bool lcpD_flag_ = true,
              bool rmq_lcp_D_flag_ = true ):
              d(d_)
  {
    build(saD_flag_, isaD_flag_, daD_flag_, lcpD_flag_, rmq_lcp_D_flag_);
    //assert(d[0] == Dollar);

  }

  dictionary(std::string filename,
             size_t w,
             bool saD_flag_ = true,
             bool isaD_flag_ = true,
             bool daD_flag_ = true,
             bool lcpD_flag_ = true,
             bool rmq_lcp_D_flag_ = true)
  {
    // Building dictionary from file
    std::string tmp_filename = filename + std::string(".dict");
    read_file(tmp_filename.c_str(), d);
    assert(d[0] == Dollar);
    // Prepending w dollars to d
    // 1. Count how many dollars there are
    int i = 0;
    int n_dollars = 0;
    while(i < d.size() && d[i++] == Dollar)
      ++n_dollars;
    std::vector<uint8_t> dollars(w-n_dollars,Dollar);
    d.insert(d.begin(), dollars.begin(),dollars.end());

    build(saD_flag_, isaD_flag_, daD_flag_, lcpD_flag_, rmq_lcp_D_flag_);

  }

  inline size_t length_of_phrase(size_t id){
    assert(id > 0);
    return select_b_d(id+1)-select_b_d(id) - 1; // to remove the EndOfWord
  }

  inline size_t n_phrases(){
    return rank_b_d(d.size()-1);
  }

  void build(bool saD_flag_, bool isaD_flag_, bool daD_flag_, bool lcpD_flag_, bool rmq_lcp_D_flag_){

    // Building the bitvector with a 1 in each starting position of each phrase in D
    std::vector<size_t> onset;
    // b_d.resize(d.size());
    // for(size_t i = 0; i < b_d.size(); ++i) b_d[i] = false; // bug in resize
    onset.push_back(0); //b_d[0] = true; // Mark the first phrase
    for(int i = 1; i < d.size(); ++i )
      if(d[i-1]==EndOfWord)
        onset.push_back(i);//b_d[i] = (d[i-1]==EndOfWord);
    if(onset.back() != (d.size()-1))
      onset.push_back(d.size()-1);//b_d[d.size()-1] = true; // This is necessary to get the length of the last phrase

    sdsl::sd_vector_builder builder(d.size(), onset.size());
    for (auto idx : onset)
      builder.set(idx);
    b_d = bv_t(builder);

    rank_b_d = bv_t::rank_1_type(&b_d);
    select_b_d = bv_t::select_1_type(&b_d);


    assert(!rmq_lcp_D_flag_ || (lcpD_flag || lcpD_flag_));

    // TODO: check if it has been already computed
    if(saD_flag_ && daD_flag_ && lcpD_flag_){
      saD.resize(d.size());
      lcpD.resize(d.size());
      daD.resize(d.size());
      // suffix array, LCP array, and Document array of the dictionary.
      verbose("Computing SA, LCP, and DA of dictionary");
      _elapsed_time(
        gsacak(&d[0],&saD[0],&lcpD[0],&daD[0],d.size())
      );
    }else if(saD_flag_ && lcpD_flag_){
      saD.resize(d.size());
      lcpD.resize(d.size());
      // suffix array and LCP array of the dictionary.
      verbose("Computing SA, and LCP of dictionary");
      _elapsed_time(
        gsacak(&d[0],&saD[0],&lcpD[0],nullptr,d.size())
      );
    } else if(saD_flag_ && daD_flag_){
      saD.resize(d.size());
      daD.resize(d.size());
      // suffix array and LCP array of the dictionary.
      verbose("Computing SA, and DA of dictionary");
      _elapsed_time(
        gsacak(&d[0],&saD[0],nullptr,&daD[0],d.size())
      );
    } else if(saD_flag_){
      saD.resize(d.size());
      // suffix array and LCP array of the dictionary.
      verbose("Computing SA of dictionary");
      _elapsed_time(
        gsacak(&d[0],&saD[0],nullptr,nullptr,d.size())
      );
    }

    assert(!isaD_flag_ || (saD_flag || saD_flag_) );
    if(isaD_flag_ && !isaD_flag){
      // inverse suffix array of the dictionary.
      verbose("Computing ISA of dictionary");
      _elapsed_time(
        {
          isaD.resize(d.size());
          for(int i = 0; i < saD.size(); ++i){
            isaD[saD[i]] = i;
          }
        }
      );
    }

    assert(!rmq_lcp_D_flag_ || (lcpD_flag || lcpD_flag_));
    if(rmq_lcp_D_flag_ && ! rmq_lcp_D_flag){
      rmq_lcp_D_flag = true;

      verbose("Computing RMQ over LCP of dictionary");
      // Compute the LCP rank of D
      _elapsed_time(
        rmq_lcp_D = sdsl::rmq_succinct_sct<>(&lcpD)
      );
    }

    // if(colex_daD_flag_){
      // co-lex document array of the dictionary.
      verbose("Computing co-lex DA of dictionary");
      _elapsed_time(
        // {  
        //   std::vector<uint_t>colex_id(n_phrases());
        //   std::vector<uint_t>inv_colex_id(n_phrases()); // I am using it as starting positions
        //   for(int i = 0, j = 0; i < d.size(); ++i )
        //     if(d[i+1]==EndOfWord){
        //       colex_id[j] = j;
        //       inv_colex_id[j++] = i;
        //     }

        //   colex_document_array_helper(inv_colex_id,colex_id,0,n_phrases());

        //   // computing inverse colex id
        //   for(int i = 0; i < colex_id.size(); ++i){
        //     inv_colex_id[colex_id[i]] = i;
        //   }
        //   colex_id.clear();

        //   colex_daD.resize(d.size());
        //   for(int i = 0; i < colex_daD.size(); ++i ){
        //     colex_daD[i]  = inv_colex_id[daD[i]];
        //   }
        // }
        {
          compute_colex_da();
          rmq_colex_daD = sdsl::rmq_succinct_sct<>(&colex_daD);
          rMq_colex_daD = sdsl::range_maximum_sct<>::type(&colex_daD);
          rmq_lcps = sdsl::rmq_succinct_sct<>(&lcps);
        }
      );

    // }

  }

  // I am assuming that the alphabet fits in an unsigned char
  void colex_document_array_helper(std::vector<uint_t>& sp, std::vector<uint_t>& id, size_t start, size_t end ){
    if((end - start < 2) || (start > end)) return;


    std::vector<uint32_t> count(256,0);
    for(size_t i = start; i < end; ++i ){
      count[ d[ sp[i] ] ] ++;
    }

    std::vector<uint32_t> psum(256,0);
    for(size_t i = 1; i < 256; ++i){
      psum[i] = psum[i-1] + count[i-1];
    }

    std::vector<uint_t> tmp(end-start+1,0);
    std::vector<uint_t> tmp_id(end-start+1,0);
    for(size_t i = start; i < end; ++i ){
      size_t index = psum[ d[sp[i] ] ] ++;
      tmp[index] = std::min(sp[i]-1, static_cast<uint_t>(d.size()-1));
      tmp_id[index] = id[i];
    }


    // Recursion
    size_t tmp_start = 0;
    for(size_t i = 0; i < 256; ++i ){
      for(size_t j = 0; j < count[i]; ++j){
        sp[start + j] = tmp[tmp_start];
        id[start + j] = tmp_id[tmp_start ++];
      }
      end = start + count[i];
      if(i > EndOfWord) colex_document_array_helper(sp,id,start,end);
      start = end;
    }

  }

  void compute_colex_da(){
    colex_id.resize(n_phrases());
    lcps.resize(n_phrases(), 0);
    std::vector<uint_t> inv_colex_id(n_phrases()); // I am using it as starting positions
    for (int i = 0, j = 0; i < d.size(); ++i)
      if (d[i + 1] == EndOfWord)
      {
        colex_id[j] = j;
        inv_colex_id[j++] = i;
      }

    // buckets stores the begin and the end of each bucket.
    std::queue<std::pair<int,int> > buckets;
    // the first bucket is the whole array.
    buckets.push({0,colex_id.size()});

    // for each bucket
    while(!buckets.empty()){
      auto bucket = buckets.front(); buckets.pop();
      int start = bucket.first;
      int end = bucket.second;
      if ((start < end) && (end - start > 1))
      {
        std::vector<uint32_t> count(256, 0);
        for (size_t i = start; i < end; ++i)
        {
          count[d[inv_colex_id[i]]]++;
        }

        std::vector<uint32_t> psum(256, 0);
        for (size_t i = 1; i < 256; ++i)
        {
          psum[i] = psum[i - 1] + count[i - 1];
        }

        std::vector<uint_t> tmp(end - start, 0);
        std::vector<uint_t> tmp_id(end - start, 0);
        for (size_t i = start; i < end; ++i)
        {
          size_t index = psum[d[inv_colex_id[i]]]++;
          tmp[index] = std::min(inv_colex_id[i] - 1, static_cast<uint_t>(d.size() - 1));
          tmp_id[index] = colex_id[i];
        }

        uint_t depth = lcps[end-1];
        // Recursion
        size_t tmp_start = 0;
        for (size_t i = 0; i < 256; ++i)
        {
          for (size_t j = 0; j < count[i]; ++j)
          {
            inv_colex_id[start + j] = tmp[tmp_start];
            colex_id[start + j] = tmp_id[tmp_start++];
          }
          end = start + count[i];
          if (i > EndOfWord){
            if(end > start + 1)
            {
              buckets.push({start, end});
              if(end > bucket.first + 1) // is not the first elemnt of the bucket
                lcps[end-1] = depth + 1;
            }
            else if(end > start && end > bucket.first + 1) // is not the first elemnt of the bucket
              lcps[end-1] = depth ;

          }else{

            for (size_t j = (start == bucket.first?1:0); j < count[i]; ++j)
              lcps[start + j] = depth;

          }
          start = end;
        }
      }

    }

    // computing inverse colex id
    for (int i = 0; i < colex_id.size(); ++i)
    {
      inv_colex_id[colex_id[i]] = i;
    }
    colex_id.clear();


    colex_daD.resize(d.size());
    for (int i = 0; i < colex_daD.size(); ++i)
    {
      colex_daD[i] = inv_colex_id[daD[i]];
    }

    return;


  }

  size_t longest_common_phrase_prefix(size_t a, size_t b)
  {
    if (a == 0 || b == 0)
      return 0;
    // Compute the lcp between phrases a and b
    auto a_in_sa = isaD[select_b_d(a)]; // position of the phrase a in saD
    auto b_in_sa = isaD[select_b_d(b)]; // position of the phrase b in saD

    auto lcp_left = std::min(a_in_sa, b_in_sa) + 1;
    auto lcp_right = max(a_in_sa, b_in_sa);

    size_t lcp_a_b_i = rmq_lcp_D(lcp_left, lcp_right);
    return lcpD[lcp_a_b_i];
  }

  // Serialize to a stream.
  size_type serialize(std::ostream &out, sdsl::structure_tree_node *v = nullptr, std::string name = "") const
  {
    sdsl::structure_tree_node *child = sdsl::structure_tree::add_child(v, name, sdsl::util::class_name(*this));
    size_type written_bytes = 0;

    written_bytes += my_serialize(d, out, child, "dictionary");
    written_bytes += my_serialize(saD, out, child, "saD");
    written_bytes += my_serialize(isaD, out, child, "isaD");
    written_bytes += my_serialize(daD, out, child, "daD");
    written_bytes += my_serialize(lcpD, out, child, "lcpD");
    written_bytes += rmq_lcp_D.serialize(out, child, "rmq_lcp_D");
    written_bytes += b_d.serialize(out, child, "b_d");
    written_bytes += rank_b_d.serialize(out, child, "rank_b_d");
    written_bytes += select_b_d.serialize(out, child, "select_b_d");
    written_bytes += my_serialize(colex_daD, out, child, "colex_daD");
    written_bytes += rmq_colex_daD.serialize(out, child, "rmq_colex_daD");
    written_bytes += rMq_colex_daD.serialize(out, child, "rMq_colex_daD");
    written_bytes += my_serialize(colex_id, out, child, "colex_id");
    written_bytes += my_serialize(lcps, out, child, "lcps");
    written_bytes += rmq_lcps.serialize(out, child, "rmq_lcps");
    // written_bytes += sdsl::serialize(d, out, child, "dictionary");
    // written_bytes += sdsl::serialize(saD, out, child, "saD");
    // written_bytes += sdsl::serialize(isaD, out, child, "isaD");
    // written_bytes += sdsl::serialize(daD, out, child, "daD");
    // written_bytes += sdsl::serialize(lcpD, out, child, "lcpD");
    // written_bytes += rmq_lcp_D.serialize(out, child, "rmq_lcp_D");
    // written_bytes += b_d.serialize(out, child, "b_d");
    // written_bytes += rank_b_d.serialize(out, child, "rank_b_d");
    // written_bytes += select_b_d.serialize(out, child, "select_b_d");
    // written_bytes += sdsl::serialize(colex_daD, out, child, "colex_daD");
    // written_bytes += rmq_colex_daD.serialize(out, child, "rmq_colex_daD");
    // written_bytes += rMq_colex_daD.serialize(out, child, "rMq_colex_daD");
    // written_bytes += sdsl::serialize(colex_id, out, child, "colex_id");

    sdsl::structure_tree::add_size(child, written_bytes);
    return written_bytes;

  }

  //! Load from a stream.
  void load(std::istream &in)
  {
    my_load(d, in);
    my_load(saD, in);
    my_load(isaD, in);
    my_load(daD, in);
    my_load(lcpD, in);
    rmq_lcp_D.load(in);
    b_d.load(in);
    rank_b_d.load(in, &b_d);
    select_b_d.load(in, &b_d);
    my_load(colex_daD, in);
    rmq_colex_daD.load(in);
    rMq_colex_daD.load(in);
    my_load(colex_id, in);
    my_load(lcps,in);
    rmq_lcps.load(in);
    // sdsl::load(d, in);
    // sdsl::load(saD, in);
    // sdsl::load(isaD, in);
    // sdsl::load(daD, in);
    // sdsl::load(lcpD, in);
    // rmq_lcp_D.load(in);
    // b_d.load(in);
    // rank_b_d.load(in, &b_d);
    // select_b_d.load(in, &b_d);
    // sdsl::load(colex_daD, in);
    // rmq_colex_daD.load(in);
    // rMq_colex_daD.load(in);
    // sdsl::load(colex_id, in);
  }
};





#endif /* end of include guard: _PFP_DICTIONARY_HH */
