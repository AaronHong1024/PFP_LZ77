/* pfp - prefix free parsing 
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
   \file pfp.hpp
   \brief pfp.hpp define and build the prefix-free parsing data structures.
   \author Massimiliano Rossi
   \date 03/04/2020
*/

/*!
 \file pfp.hpp
 \brief added kd_tree and build_PPS functions for constructing the LZ_77
 \author Aaron Hong

 */

#ifndef _PFP_HH
#define _PFP_HH

#include <common.hpp>

#include <sdsl/rmq_support.hpp>
#include <sdsl/int_vector.hpp>
#include <sdsl/wavelet_trees.hpp>
#include <sdsl/sd_vector.hpp>

#include<dictionary.hpp>
#include<parse.hpp>
#include <wt.hpp>
#include <wm.hpp>
#include <kd_tree_support.hpp>
#include <PPS_support.hpp>

using namespace std;

extern "C" {
    #include<gsacak.h>
}


template< class wt_t = pfp_wt_wm>//sdsl::sd_vector<>>
class pf_parsing{
public:

  struct M_entry_t{
    uint_t len;
    uint_t left; // left and right are the extreemes of the range
    uint_t right;
  };

  typedef sdsl::sd_vector<> bv_t;

  dictionary dict;
  parse pars;
  std::vector<uint32_t> freq;
  size_t n; // Size of the text
  size_t w; // Size of the window

  bv_t b_bwt;
  typename bv_t::rank_1_type b_bwt_rank_1;
  typename bv_t::select_1_type b_bwt_select_1;
  std::vector<M_entry_t> M;

  bv_t b_pps; // Bitvector witrh a 1 in correspondence of the 1s in b_bwt in saD order.
  typename bv_t::rank_1_type b_pps_rank_1;
  typename bv_t::select_1_type b_pps_select_1;

  wt_t w_wt;

  bv_t b_p;
  typename bv_t::rank_1_type rank_b_p;
  typename bv_t::select_1_type select_b_p;

  wm_t<> s_lcp_T; // LCP array of T sampled in corrispondence of the beginning of each phrase.

  sdsl::rmq_succinct_sct<> rmq_s_lcp_T;

  wm_t<> lcp_M; // LCP of the unique reverse of the phrases

  typedef size_t size_type;

  typedef point<uint64_t, 3> point3d;

  typedef kdtree<uint64_t, 3> tree3d;
  tree3d tree;
//  point3d *points = new point3d [pars.p.size() - 1];
  vector<int64_t> PPS_PSV;
  vector<int64_t> PPS_NSV;
  vector<int64_t> first_PPS;
  sdsl::int_vector<> s_lcp_T_array;
 // std::vector<uint32_t> bwt_p;


  // Default constructor for load
  pf_parsing() {}

  pf_parsing(std::vector<uint8_t> &d_,
             std::vector<uint32_t> &p_,
             std::vector<uint32_t> &freq_,
             size_t w_) : 
            dict(d_, w_),
            pars(p_, dict.n_phrases() + 1),
            freq(freq_),
            w(w_)
  {
    // Uploading the frequency file
    assert(freq[0] == 0);

    // Compute the length of the string;
    compute_n();

    verbose("Computing b_p");
    _elapsed_time(compute_b_p());

    verbose("Computing b_bwt, b_pps, and M of the parsing");
    _elapsed_time(build_b_bwt__b_pps_and_M());

    verbose("Computing S_LCP_T");
    _elapsed_time(build_s_lcp_T());


    verbose("create lz77");
    _elapsed_time(compute_lz_77());

    // Clear unnecessary elements
    clear_unnecessary_elements();
  }

  pf_parsing( std::string filename, size_t w_):
              dict(filename, w_),
              pars(filename,dict.n_phrases()+1),
              freq(1,0),
              w(w_)
  {
    // Uploading the frequency file
    uint32_t *occ;
    size_t d_words;
    std::string tmp_filename = filename + std::string(".occ");
    read_file<uint32_t> (tmp_filename.c_str(), occ, d_words);
    freq.insert(freq.end(),occ, occ + d_words);


    // Compute the length of the string;
    compute_n();

    // b_p(pfp.n,0);
    verbose("Computing b_p");
    _elapsed_time(compute_b_p());

    //Aaron Hong yu.hong@ufl.edu extended this function
    //Compute the PSV and NSV in this function.
    verbose("Computing b_bwt, b_pps, and M of the parsing");
    _elapsed_time(build_b_bwt__b_pps_and_M());

    verbose("Computing S_LCP_T");
    _elapsed_time(build_s_lcp_T());

    //Aaron Hong yu.hong@ufl.edu added this function
//    verbose("kd_tree_test");
//    _elapsed_time(kd_tree());

    verbose("create lz77");
    _elapsed_time(compute_lz_77());

    // Clear unnecessary elements
    clear_unnecessary_elements();
  }

  void compute_b_p() {
    // Build the bitvector storing the position of the beginning of each phrase.
    std::vector<size_t> onset;
    onset.push_back(0); //b_p[0] = true;    // phrase_0 becomes phrase 1

    size_t i = 0;
    for (int j = 0; j < pars.p.size() - 2; ++j)
    { // -2 because the beginning of the last phrase is in position 0
      // p[i]: phrase_id
      assert(pars.p[j] != 0);
      // phrase_length: select_b_d(p[i]+1)-select_b_d(p[i]);
      i += dict.length_of_phrase(pars.p[j]) - w;
      onset.push_back(i); //b_p[i] = true;
    }

    sdsl::sd_vector_builder builder(n, onset.size());
    for (auto idx : onset)
      builder.set(idx);
    b_p = bv_t(builder);
    rank_b_p = typename bv_t::rank_1_type(&b_p);
    select_b_p = typename bv_t::select_1_type(&b_p);

  }

  void compute_n(){
    // Compute the length of the string;
    n = 0;
    for (int j = 0; j < pars.p.size() - 1; ++j)
    {
      // parse.p[j]: phrase_id
      assert(pars.p[j] != 0);
      n += dict.length_of_phrase(pars.p[j]) - w;
    }
    //cout<<n<<endl;
   // n += w; // + w because n is the length including the last w markers
    //n += w - 1; // Changed after changind b_d in dict // -1 is for the first dollar + w because n is the length including the last w markers
  }

// Aaron Hong yu.hong@ufl.edu
// extend it to compute the proper phrase suffix start position.
  void build_b_bwt__b_pps_and_M()
  {
      //check the length ,maybe not int
      const int pars_size = pars.p.size();

      //first occurance in the text.
      // int start_position[dict.n_phrases()];

      //use std vector
      //phrase starts from 1.
      vector<size_t> end_position(dict.n_phrases() + 1);

      for (size_t i = 0; i < pars_size - 1; ++i)
      {
          size_t phrase_id = pars.p[i];

           if (end_position[phrase_id] <= 0){
              end_position[phrase_id] = select_b_p(i+1) + dict.length_of_phrase(phrase_id);
          }
      }


    // Build the bitvector storing the position of the beginning of each phrase.
    // b_bwt.resize(n);
    // for (size_t i = 0; i < b_bwt.size(); ++i)
    //   b_bwt[i] = false; // bug in resize
    std::vector<size_t> onset;
    std::vector<size_t> onset_b_pps;
    std::vector<int_t> lcp_M_;
    assert(dict.d[dict.saD[0]] == EndOfDict);
    size_t i = 1; // This should be safe since the first entry of sa is always the dollarsign used to compute the sa
    size_t j = 0;
    while (i < dict.saD.size())
    {
      size_t left = i;

      auto sn = dict.saD[i];
      // Check if the suffix has length at least w and is not the complete phrase.
      auto phrase = dict.daD[i] + 1;
      assert(phrase > 0 && phrase < freq.size()); // + 1 because daD is 0-based
      size_t suffix_length = dict.select_b_d(dict.rank_b_d(sn + 1) + 1) - sn - 1;
      if (dict.b_d[sn] || suffix_length < w)
      {
        ++i; // Skip
       // first_PPS.push_back(-1);
      }
      else
      {
        // use the RMQ data structure to find ho
        //
        //
        // tor (so they're the same suffix but in different phrases)
        // use the document array and the table of phrase frequencies to find the phrases frequencies and sum them up
        onset.push_back(j++); //b_bwt[j++] = true;
        onset_b_pps.push_back(i);
       // size_t length = dict.length_of_phrase(phrase);
        j += freq[phrase] - 1; // the next bits are 0s
        i++;

        //compute the start position for the proper suffix
          size_t position = (end_position[phrase] - suffix_length) % n;
          first_PPS.push_back(position);
        if (i < dict.saD.size())
        {
            // here to check the next phrase
          auto new_sn = dict.saD[i];
          auto new_phrase = dict.daD[i] + 1;
          assert(new_phrase > 0 && new_phrase < freq.size()); // + 1 because daD is 0-based
          size_t new_suffix_length = dict.select_b_d(dict.rank_b_d(new_sn + 1) + 1) - new_sn - 1;

          // if current suffix is the same as next phrase then we keep computing
          while (i < dict.saD.size() && (dict.lcpD[i] >= suffix_length) && (suffix_length == new_suffix_length))
          {
              // in this situation we will have same suffix. we need to choose the smaller position.
              size_t new_position = (end_position[new_phrase] - new_suffix_length) % n;
              if (position > new_position){
                  position = new_position;
                  first_PPS.back() = position;
                //  first_PPS.push_back(-1);
              }

            j += freq[new_phrase];
            ++i;
            // keep updating the new_suffix.
            if (i < dict.saD.size())
            {
              new_sn = dict.saD[i];
              new_phrase = dict.daD[i] + 1;
              assert(new_phrase > 0 && new_phrase < freq.size()); // + 1 because daD is 0-based
              new_suffix_length = dict.select_b_d(dict.rank_b_d(new_sn + 1) + 1) - new_sn - 1;
            }
          }
        }

        // Computing M
        size_t right = i - 1;
        M_entry_t m;
        m.len = suffix_length;
        m.left = dict.colex_daD[dict.rmq_colex_daD(left, right)];
        m.right = dict.colex_daD[dict.rMq_colex_daD(left, right)];

        // Computing LCP M
        if(M.empty())
          lcp_M_.push_back(0);
        else
        {
            // const auto& m_ = M.back();
            // if ((m_.left <= m.right && m.right <= m_.right) or
            //     (m_.left <= m.left && m.left <= m_.right) or 
            //     (m.left <= m_.right && m_.right <= m.right) or
            //     (m.left <= m_.left && m_.left <= m.right))
            //   // The two suffixes are suffixes of the same phrase
            //   lcp_M_.push_back(std::min(m.len, m_.len)); 
            // else
            // {
            //   size_t left, right;
            //   if(m.right != m_.right)
            //   {
            //     left = std::min(m.right, m_.right)+1;
            //     right = max(m.right, m_.right);
            //   }
            //   else
            //   {
            //     assert(m.right != m_.left);
            //     left = std::min(m.right, m_.left)+1;
            //     right = max(m.right, m_.left);
            //   }
              const size_t left = onset_b_pps[onset_b_pps.size()-2] +1;
              const size_t right = onset_b_pps[onset_b_pps.size()-1];
              const size_t idx = dict.rmq_lcp_D(left,right);
              lcp_M_.push_back(dict.lcpD[idx]);
              // const size_t idx = dict.rmq_lcps(left,right);
              // lcp_M_.push_back(dict.lcps[idx]);
            // }
        }


        M.push_back(m);
      }
    }

    sdsl::int_vector<> lcp_M__(lcp_M_.size());
    for(size_t i = 0; i < lcp_M_.size(); ++i)
      lcp_M__[i] = lcp_M_[i];

    lcp_M_.clear();

    sdsl::construct_im(lcp_M,lcp_M__);
    lcp_M_.resize(0);

    sdsl::sd_vector_builder builder(n,onset.size());
    for(auto idx: onset)
      builder.set(idx);
    b_bwt = bv_t(builder);
    // rank & select support for b_bwt
    b_bwt_rank_1 = typename bv_t::rank_1_type(&b_bwt);
    b_bwt_select_1 = typename bv_t::select_1_type(&b_bwt);

    sdsl::sd_vector_builder builder_b_pps(dict.saD.size(),onset_b_pps.size());
    for (auto idx : onset_b_pps)
      builder_b_pps.set(idx);
    b_pps = bv_t(builder_b_pps);
    // rank & select support for b_pps
    b_pps_rank_1 = typename bv_t::rank_1_type(&b_pps);
    b_pps_select_1 = typename bv_t::select_1_type(&b_pps);

    //compute PSV and NSV
    //now we stored the location for PSV or NSV.
    PPS_PSV = PSV(first_PPS);
    PPS_NSV = NSV(first_PPS);

  }



  //Aaron Hong yu.hong@ufl.edu
  // this is not used in this version code
  void build_W() {
    // create alphabet (phrases)
    //y dimension
    std::vector<uint32_t> alphabet(dict.n_phrases());
    for (size_t i = 0; i < dict.n_phrases(); ++i) {
      alphabet[i] = dict.colex_id[i] + 1;
    }

    // create BWT(P)
    //x dimension
    std::vector<uint32_t> bwt_p(pars.p.size() - 1, 0);
    for (size_t i = 1; i < pars.saP.size(); ++i)
    {
      if (pars.saP[i] > 0)
        bwt_p[i - 1] = pars.p[pars.saP[i] - 1];
      else
        bwt_p[i - 1] = pars.p[pars.p.size() - 2]; // TODO: this should be -1 only if 0 stay in pars
    }

    //p is the z dimension
    //pars.p
    w_wt.construct(alphabet, bwt_p);

  }


    void compute_lz_77(){
        std::vector<uint32_t> bwt_p(pars.p.size() - 1, 0);
        for (size_t i = 1; i < pars.saP.size(); ++i)
        {
            if (pars.saP[i] > 0)
                bwt_p[i - 1] = pars.p[pars.saP[i] - 1];
            else
                bwt_p[i - 1] = pars.p[pars.p.size() - 2];

        }


        //y dimension for the kd_tree
        std::vector<uint32_t> alphabet(dict.n_phrases());
        for (size_t i = 0; i < dict.n_phrases(); ++i) {
            alphabet[i] = dict.colex_id[i] + 1;
        }

        //change the cout to verbose or info or other things
        size_t n_phrase = dict.n_phrases();


        // connect x and y
        sdsl::int_vector<> parse_x(bwt_p.size(), 0);
        vector<uint32_t> translate;
        translate.resize(alphabet.size(), 0);

        for (size_type i = 0; i < alphabet.size(); ++i) {
            translate[alphabet[i] - 1] = i;
        }

        // parse_x: x location in y dimension. Pair should be (bwt_p[i], parse_x[i], z[i])
        //don need store this can save some space
        size_t bwt_p_size = bwt_p.size();
        for (size_type i = 0; i < bwt_p_size; ++i) {
            parse_x[i] = translate[bwt_p[i] - 1];
        }

        // connect x and z, Z[i] = isa_P[bwt_p[i] - 1]

        point3d *points = new point3d [bwt_p_size];

        for (size_type i = 0; i < bwt_p_size; ++i) {
            // shoule be the uint64_t
            // define a parameter
            uint64_t x = i;
            uint64_t y = parse_x[i];
            //
            uint64_t z = (pars.saP[i+1] + bwt_p_size - 1)%bwt_p_size;
            points[i] = {x,y,z};
        }

        // construct the kd_tree
        tree3d test_tree(points, points + bwt_p_size);
        tree = test_tree;
        verbose("tree size: ", tree.size());

        delete points;

       translate.clear();
       translate.shrink_to_fit();
        //i is the starting position of the lz_77's factor. Starting from 0. each time can add the factor's length to compute the next one factor.

        //define the tree this place.
        //use const kdtree<<>>& tree there. We dont need the tree again.
//        FILE *file;
//        file = fopen("/blue/boucher/yu.hong/CST_LZ77/data/result.dat","wb");
//        int test = 0;
//        if (file == NULL){
//           verbose("FILE OPEN FAIL");
//        }else{
//            verbose("OPEN SUCCESS");
//        }
        //the limitation for the x,y,z is the position in grid.
        size_t i = w;
        size_t p_psv;
        size_t l_psv;
        size_t p_nsv;
        size_t l_nsv;
        size_t f;
        size_t l;
        auto lz_out = sdsl::int_vector_buffer<>("/blue/boucher/yu.hong/CST_LZ77/data/result_test.dat", std::ios::out, 1024*1024, log(n));
        while(i < n) {
            uint64_t z1 = 0;
            z1 = rank_b_p(i);
            size_t offset = 0;
            if (i != 0) {
                offset = i - select_b_p(z1);
            }else if (z1 > 1){
                offset = i - select_b_p(z1) + w;
            }
            // start from 1.
            uint64_t q = pars.p[z1 - 1]; // map the x inside the D
            size_t d = dict.select_b_d(q) + offset;
            // r is the
            size_t r = dict.isaD[d]; // #1s in b_pps[1..i_in_saD] counting from 0
            r = b_pps_rank_1(r);


            // start from 1. So we do not need to plus 1. And the X dimension is 0 based. So we need to minus 1.
            // if we reach the last parse. We cannot use kd_tree anymore.
             if (z1 < pars.p.size() - 1){

            uint_t x1 = pars.isaP[z1] - 1;
            uint y1 = M[r].left;    // M_entry is [len, left, right]
            uint y2 = M[r].right;
            //TODO: to check the two x dimension. to the PSV, matrix is smaller than x1. To NSV, matrix is larger than x1.



            point3d *psv = test_tree.query_PSV(x1, y1, y2, z1);
            point3d *nsv = test_tree.query_NSV(x1, y1, y2, z1);
            // check the length of the suffix is the same as the M length
            size_t offset_prime = select_b_p(z1 + 1) - i;

            //psv is not a pointer. check it
            if (psv != nullptr) {
                // rmq_s_lcp_t(i,j) will return the min(lcp[i,...,j])
                p_psv = rmq_s_lcp_T(psv->get(0) + 1, x1);
                //s_lcp_T[i] will return longest common prefix of S[SA[i-1]] and S[SA[i]];
                l_psv = s_lcp_T_array[p_psv];

                if (nsv != nullptr) {
                    p_nsv = rmq_s_lcp_T(x1 + 1, nsv->get(0));
                    l_nsv = s_lcp_T_array[p_nsv];

                    if (l_psv > l_nsv) {
                        f = select_b_p(pars.saP[psv->get(0)]) - offset_prime;
                        l = l_psv;
                    } else {
                        f = (select_b_p(pars.saP[nsv->get(0)]) - offset_prime) % n;
                        l = l_nsv;
                    }

                } else {
                    f = select_b_p(pars.saP[psv->get(0)]) - offset_prime;
                    l = l_psv;
                }

            } else if (nsv != nullptr) {

                p_nsv = rmq_s_lcp_T(x1 + 1, nsv->get(0));
                l_nsv = s_lcp_T_array[p_nsv];
                f = select_b_p(pars.saP[nsv->get(0)]) - offset_prime;
                l = l_nsv;
            } else {
                if (i == 0) {
                    l = 0;
                } else {
                    std::pair<size_t, size_t> tmp = KKP(r, d);
                    f = tmp.first;
                    l = tmp.second;
                }
            }
        }else{
                 std::pair<size_t, size_t> tmp = KKP(r, d);
                 f = tmp.first;
                 l = tmp.second;
             }

            //write it to file
            if (l == 0){
                i += 1;
//                uint8_t factor = dict.d[d];
//                fwrite(&factor, 8, 1, file);
//                fwrite(&l, 8, 1, file);
//                cout<<"("<<factor<<",0)"<<endl;
                f = dict.d[d];
                lz_out.push_back(f);
                lz_out.push_back(0);


            } else{
                i += l;
//                fwrite(&f, 8, 1, file);
//                fwrite(&l, 8, 1, file);
//                cout<<"("<<f<<","<<l<<")"<<endl;
                lz_out.push_back(f);
                lz_out.push_back(l);
            }
        }

    }

  std::pair<size_t, size_t> KKP(size_t r, size_t d){
      // Neither the PSV nor NSV exist. We need to use the kkp algorithm
      // the PSV and NSV used unsigned.
      //the pps_psv and pps_nsv should be value rather than the position.
     // vector<size_t> res;
      int64_t pps_psv = PPS_PSV[r];
      int64_t pps_nsv = PPS_NSV[r];
      size_t l_psv;
      size_t l_nsv;
      size_t f;
      size_t l;
      if (pps_psv == -1) {
          l_psv = 0;
      } else {
          //the r should be the ISA_D[d]. input should be (ISA_D(pps_psv) + 1,ISA_D(d))
          // l_psv = dict.lcpD[dict.rmq_lcp_D(dict.isaD[first_PPS[pps_psv]] + 1, dict.isaD[d])];
          l_psv = dict.lcpD[dict.rmq_lcp_D(b_pps_select_1(pps_psv + 1) + 1, dict.isaD[d])];
      }
      if (pps_nsv == -1) {
          l_nsv = 0;
      } else {
          l_nsv = dict.lcpD[dict.rmq_lcp_D(dict.isaD[d] + 1, b_pps_select_1(pps_nsv + 1))];
      }

      if (l_psv >= l_nsv) {

          //get a new name for the PPS array.
          f = first_PPS[pps_psv];
          l = l_psv;
      } else {
          f = first_PPS[pps_nsv];
          l = l_nsv;
      }
      std::pair<size_t, size_t> res (f, l);
//      res.push_back(f);
//      res.push_back(l);
      return res;
  }
// change this file make it to array

  void build_s_lcp_T()
  {
    size_t n = pars.saP.size();
    sdsl::int_vector<> s_lcp_T_(n, 0);


    size_t l = 0;
    size_t lt = 0;
    for (size_t i = 0; i < n; ++i)
    {
      // if i is the last character LCP is not defined
      size_t k = pars.isaP[i];
      if (k > 0)
      {
        size_t j = pars.saP[k - 1];
        // I find the longest common prefix of the i-th suffix and the j-th suffix.
        while (pars.p[i + l] == pars.p[j + l])
        {
          lt += dict.length_of_phrase(pars.p[i + l]) - w; // I remove the last w overlapping characters
          l++;
        }
        size_t lcpp = dict.longest_common_phrase_prefix(pars.p[i + l], pars.p[j + l]);

        // l stores the length of the longest common prefix between the i-th suffix and the j-th suffix
        s_lcp_T_[k] = lt + lcpp;
        if (l > 0)
        {
          l--;
          lt -= dict.length_of_phrase(pars.p[i]) - w; // I have to remove the length of the first matching phrase
        }
      }
    }

    rmq_s_lcp_T = sdsl::rmq_succinct_sct<>(&s_lcp_T_);
    s_lcp_T_array = s_lcp_T_;
   // cout<<s_lcp_T_array.size()<<endl;
//      for (int i = 0; i < s_lcp_T_array.size(); ++i) {
//          cout<<"s_lcp_T: "<<s_lcp_T_array[i]<<endl;
//      }

// change the s_lcp_T to array
    sdsl::construct_im(s_lcp_T, s_lcp_T_);
  }

  void clear_unnecessary_elements(){
    dict.daD.clear();
    dict.colex_daD.clear();
    dict.colex_id.clear();
    // pars.saP.clear(); // It is needed in sa_support
    //    dict.rmq_colex_daD.clear();
    //    dict.rMq_colex_daD.clear();
  }

  void print_sizes()
  {

    verbose("Parse");
    verbose("Size of pars.p: ", pars.p.size() * sizeof(pars.p[0]));
    verbose("Size of pars.saP: ", pars.saP.size() * sizeof(pars.saP[0]));
    verbose("Size of pars.isaP: ", pars.isaP.size() * sizeof(pars.isaP[0]));


    verbose("Dictionary");
    verbose("Size of dict.d: ", dict.d.size() * sizeof(dict.d[0]));
    verbose("Size of dict.saD: ", dict.saD.size() * sizeof(dict.saD[0]));
    verbose("Size of dict.isaD: ", dict.isaD.size() * sizeof(dict.isaD[0]));
    verbose("Size of dict.lcpD: ", dict.lcpD.size() * sizeof(dict.lcpD[0]));
    verbose("Size of dict.rmq_lcp_D: ", sdsl::size_in_bytes(dict.rmq_lcp_D));

    verbose("Size of dict.b_d: ", sdsl::size_in_bytes(dict.b_d));
    verbose("Size of dict.rank_b_d: ", sdsl::size_in_bytes(dict.rank_b_d));
    verbose("Size of dict.select_b_d: ", sdsl::size_in_bytes(dict.select_b_d));

    verbose("PFP");
    verbose("Size of s_lcp_T: ", s_lcp_T.size() * sizeof(s_lcp_T[0]));
    verbose("Size of rmq_s_lcp_T: ", sdsl::size_in_bytes(rmq_s_lcp_T));
  }

  // Serialize to a stream.
  size_type serialize(std::ostream &out, sdsl::structure_tree_node *v = nullptr, std::string name = "") const
  {
    sdsl::structure_tree_node *child = sdsl::structure_tree::add_child(v, name, sdsl::util::class_name(*this));
    size_type written_bytes = 0;

    written_bytes += dict.serialize(out, child, "dictionary");
    written_bytes += pars.serialize(out, child, "parse");
    written_bytes += my_serialize(freq, out, child, "frequencies");
    written_bytes += sdsl::write_member(n, out, child, "n");
    written_bytes += sdsl::write_member(w, out, child, "w");
    written_bytes += b_bwt.serialize(out, child, "b_bwt");
    written_bytes += b_bwt_rank_1.serialize(out, child, "b_bwt_rank_1");
    written_bytes += b_bwt_select_1.serialize(out, child, "b_bwt_select_1");
    written_bytes += sdsl::serialize(M, out, child, "M");
    written_bytes += b_pps.serialize(out, child, "b_pps");
    written_bytes += b_pps_rank_1.serialize(out, child, "b_pps_rank_1");
    written_bytes += b_pps_select_1.serialize(out, child, "b_pps_select_1");
    written_bytes += w_wt.serialize(out, child, "w_wt");
    written_bytes += b_p.serialize(out, child, "b_p");
    written_bytes += rank_b_p.serialize(out, child, "rank_b_p");
    written_bytes += select_b_p.serialize(out, child, "select_b_p");
    written_bytes += s_lcp_T.serialize(out, child, "s_lcp_T");
    written_bytes += rmq_s_lcp_T.serialize(out, child, "rmq_s_lcp_T");
    written_bytes += lcp_M.serialize(out, child, "s_lcp_T");
    // written_bytes += dict.serialize(out, child, "dictionary");
    // written_bytes += pars.serialize(out, child, "parse");
    // written_bytes += sdsl::serialize(freq, out, child, "frequencies");
    // written_bytes += sdsl::write_member(n, out, child, "n");
    // written_bytes += sdsl::write_member(w, out, child, "w");
    // written_bytes += b_bwt.serialize(out, child, "b_bwt");
    // written_bytes += b_bwt_rank_1.serialize(out, child, "b_bwt_rank_1");
    // written_bytes += b_bwt_select_1.serialize(out, child, "b_bwt_select_1");
    // written_bytes += sdsl::serialize(M, out, child, "M");
    // written_bytes += w_wt.serialize(out, child, "w_wt");
    // written_bytes += b_p.serialize(out, child, "b_p");
    // written_bytes += rank_b_p.serialize(out, child, "rank_b_p");
    // written_bytes += select_b_p.serialize(out, child, "select_b_p");

    sdsl::structure_tree::add_size(child, written_bytes);
    return written_bytes;
  }

  //! Load from a stream.
  void load(std::istream &in)
  {
    dict.load(in);
    pars.load(in);
    my_load(freq, in);
    sdsl::read_member(n, in);
    sdsl::read_member(w, in);
    b_bwt.load(in);
    b_bwt_rank_1.load(in, &b_bwt);
    b_bwt_select_1.load(in, &b_bwt);
    sdsl::load(M, in);
    b_pps.load(in);
    b_pps_rank_1.load(in, &b_pps);
    b_pps_select_1.load(in, &b_pps);
    w_wt.load(in);
    b_p.load(in);
    rank_b_p.load(in, &b_p);
    select_b_p.load(in, &b_p);
    s_lcp_T.load(in);
    rmq_s_lcp_T.load(in);
    lcp_M.load(in);
    // dict.load(in);
    // pars.load(in);
    // sdsl::load(freq, in);
    // sdsl::read_member(n, in);
    // sdsl::read_member(w, in);
    // b_bwt.load(in);
    // b_bwt_rank_1.load(in, &b_bwt);
    // b_bwt_select_1.load(in, &b_bwt);
    // sdsl::load(M, in);
    // w_wt.load(in);
    // b_p.load(in);
    // rank_b_p.load(in, &b_p);
    // select_b_p.load(in, &b_p);
  }

  std::string filesuffix() const
  {
    return ".pf.ds.other";
  }

};


// Specialization for pfp_wt_custom
template <>
std::string pf_parsing<pfp_wt_custom>::filesuffix() const
{
  return ".pf.ds";
}

// Specialization for pfp_wt_sdsl
template <>
std::string pf_parsing<pfp_wt_sdsl>::filesuffix() const
{
  return ".pf.wt_sdsl.ds";
}

// Specialization for pfp_wt_sdsl_2
template <>
std::string pf_parsing<pfp_wt_sdsl_2>::filesuffix() const
{
  return ".pf.wt_sdsl_2.ds";
}

// Specialization for pfp_wt_wm
template <>
std::string pf_parsing<pfp_wt_wm>::filesuffix() const
{
  return ".pf.wt_wm.ds";
}

  using pf_parsing_custom = pf_parsing<pfp_wt_custom>;
  using pf_parsing_sdsl = pf_parsing<pfp_wt_sdsl>;
  using pf_parsing_wm = pf_parsing<pfp_wt_wm>;

#endif /* end of include guard: _PFP_HH */
