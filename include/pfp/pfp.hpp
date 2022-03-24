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

  typedef point<uint32_t, 3> point3d;

  typedef kdtree<uint32_t, 3> tree3d;
  tree3d tree;
  vector<size_t> PPS_PSV;
  vector<size_t> PPS_NSV;
  vector<size_t> proper_phrase_suffix;


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

    verbose("kd_tree_test");
    _elapsed_time(kd_tree());

    verbose("Computing W of BWT(P)");
    _elapsed_time(build_W());

    verbose("Computing S_LCP_T");
    _elapsed_time(build_s_lcp_T());

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

    verbose("Computing b_bwt, b_pps, and M of the parsing");
    _elapsed_time(build_b_bwt__b_pps_and_M());

    verbose("kd_tree_test");
    _elapsed_time(kd_tree());

    verbose("PPS_test");
    _elapsed_time(build_PPS());

    verbose("Computing W of BWT(P)");
    _elapsed_time(build_W());

    verbose("Computing S_LCP_T");
    _elapsed_time(build_s_lcp_T());

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
      cout<<"size: "<< n << endl;
      cout<<"first p: " << pars.p[0]<<endl;
      cout<<"dict size: "<< dict.d.size()<<endl;
      cout << "first p dic: "<<dict.d[1]<<endl;
      cout<<"onset first: "<< onset[0]<<endl;
     // cout << "first b_p : "<< b_p[0]<<endl;
    // Build rank and select on Sp
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
    //n += w; // + w because n is the length including the last w markers
    //n += w - 1; // Changed after changind b_d in dict // -1 is for the first dollar + w because n is the length including the last w markers
  }

  void build_b_bwt__b_pps_and_M()
  {
    // Build the bitvector storing the position of the beginning of each phrase.
    // b_bwt.resize(n);
    // for (size_t i = 0; i < b_bwt.size(); ++i)
    //   b_bwt[i] = false; // bug in resize
    std::vector<size_t> onset;
    std::vector<size_t> onset_b_pps;
    std::vector<int_t> lcp_M_;
    size_t max = 0;
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
  }

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
    for (size_t i = 1; i < pars.saP.size(); ++i) // TODO: shoud we count end symbol in this?
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

  void kd_tree(){
      //x dimension for the kd_tree
      std::vector<uint32_t> bwt_p(pars.p.size() - 1, 0);
      for (size_t i = 1; i < pars.saP.size(); ++i) // TODO: shoud we count end symbol in this?
      {
              if (pars.saP[i] > 0)
                  bwt_p[i - 1] = pars.p[pars.saP[i] - 1];
              else
                  bwt_p[i - 1] = pars.p[pars.p.size() - 2]; // TODO: this should be -1 only if 0 stay in pars
      }

      //y dimension for the kd_tree
      std::vector<uint32_t> alphabet(dict.n_phrases());
      for (size_t i = 0; i < dict.n_phrases(); ++i) {
          alphabet[i] = dict.colex_id[i] + 1;
      }
      cout<< "y dimension size" <<dict.n_phrases() << endl;

    //  z dimension for the kd_tree
      vector<uint32_t> p = pars.p;
      cout<< "z dimension size" <<pars.p.size() << endl;

    // connect x and y
    sdsl::int_vector<> parse_x(bwt_p.size(), 0);
    vector<uint32_t> translate;
    translate.resize(alphabet.size(), 0);

      for (size_type i = 0; i < alphabet.size(); ++i) {
          translate[alphabet[i] - 1] = i;
      }

      // parse_x: x location in y dimension. Pair should be (bwt_p[i], parse_x[i], z[i])
      //don need store this can save some space
      for (size_type i = 0; i < bwt_p.size(); ++i) {
          parse_x[i] = translate[bwt_p[i] - 1];
      }

      // connect x and z, Z[i] = isa_P[bwt_p[i] - 1]


     point3d *points = new point3d [bwt_p.size()];

      size_t bwt_p_size = bwt_p.size();
      for (size_type i = 0; i < bwt_p.size(); ++i) {
          uint32_t x = i;
          uint32_t y = parse_x[i];
          //
          uint32_t z = (pars.saP[i] - 1)%bwt_p_size;
          points[i] = {x,y,z};
      }
      // construct the kd_tree
      tree = tree3d(points, points + bwt_p.size());
     // tree3d tree(points, points + bwt_p.size());
      cout<< "tree size: "<< tree.size() << endl;
    //  cout <<"p test: "<< pars.p[0]<<endl;
    //  cout << "bp_rank size: " << rank_b_p.size()<< endl;
      // create the x1, y1, y2, z1 for the matrix.


  }


  // compute the PSV and NSV for proper phrase suffix
  void build_PPS(){
    // find each phrase(in Dict) start position in string S first.
    // test the b_d and b_p size first.
    /* We use the pars to calculate the D phrase start position first. Each time
     * (previous start position + length of current length - w) % n = next pars phrase start position in S.
     * Then we map the result to the D.
     * */
    int pars_size = pars.p.size();
    cout<<"n_ phrase: "<<dict.n_phrases()<<endl;
    cout<<"p size:"<<pars_size<<endl;
//    for (int i = 0; i < pars.p.size(); ++i) {
//        cout<<"p[i]:" << pars.p[i]<<endl;
//    }

    cout <<"daD_size: "<<dict.daD.size()<<endl;
    cout<<"d_size: "<<dict.n_phrases()<<endl;
    int start_position[dict.n_phrases()];
      for (int i = 0; i < pars.p.size() - 1; ++i)
      {
          // parse.p[j]: phrase_id
          assert(pars.p[i] != 0);
          size_t phrase_id = pars.p[i];
          start_position[phrase_id] = (select_b_p(i+1) + dict.length_of_phrase(phrase_id) - w) % n;
         // cout<<"phrase_id: "<<phrase_id<<" start_position: "<< start_position[phrase_id]<<endl;
      }
      // not sure what's the daD. And the phrase is the phrase number in dict?
      /* We can use the position = (phrase length - suffix length) to get the position of suffix in the pharse
       * Then the phrase start position in S: [start_position[phrase] + (phrase length - suffix length)] % n is the proper phrase
       * suffix start position in S.
       */
     // vector<size_t> proper_phrase_suffix;
      assert(dict.d[dict.saD[0]] == EndOfDict);
      size_t i = 1;
      size_t j = 0;
      while(i < dict.saD.size()){
          auto sn = dict.saD[i];
          auto phrase = dict.daD[i] + 1;
          assert(phrase > 0 && phrase < freq.size());
          size_t suffix_length = dict.select_b_d(dict.rank_b_d(sn + 1) + 1) - sn - 1;
          if (dict.b_d[sn] || suffix_length < w){
              ++i;
          } else{
              size_t position = (dict.length_of_phrase(phrase) - suffix_length + start_position[phrase]) % n;
              proper_phrase_suffix.push_back(position);
              j += freq[phrase];
              i++;
              if (i < dict.saD.size()){
                  auto new_sn = dict.saD[i];
                  auto new_phrase = dict.daD[i] + 1;
                  assert(new_phrase > 0 && new_phrase < freq.size());
                  size_t new_suffix_length = dict.select_b_d(dict.rank_b_d(new_sn + 1) + 1) - new_sn - 1;
                  while (i < dict.saD.size() && (dict.lcpD[i] >= suffix_length) && (suffix_length == new_suffix_length)){
                      j += freq[new_phrase];
                      ++i;

                      size_t new_position = (dict.length_of_phrase(new_phrase) - new_suffix_length + start_position[new_phrase]) % n;
                      if(position > new_position){
                          position = new_position;
                          proper_phrase_suffix.back() = position;
                      }
                      if (i < dict.saD.size()){
                          new_sn = dict.saD[i];
                          new_phrase = dict.daD[i] + 1;
                          assert(new_phrase > 0 && new_phrase < freq.size());
                          new_suffix_length = dict.select_b_d(dict.rank_b_d(new_sn + 1) + 1) - new_sn - 1;

                      }
                  }
              }
          }
      }

      //start compute PSV and NSV for proper_phrase_suffix.
      cout <<"bwt_p size "<<b_bwt.size()<<endl;
      cout<<"b_pps size: "<<b_pps.size()<<endl;
     // cout << "M size: "<<M.size()<<endl;
      PPS_PSV = PSV(proper_phrase_suffix);
      PPS_NSV = NSV(proper_phrase_suffix);
      for (int k = 0; k < proper_phrase_suffix.size(); ++k) {
          cout <<"PPS: "<< proper_phrase_suffix[i] <<endl;
      }

  }



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
