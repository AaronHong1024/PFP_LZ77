//
// Created by yu hong on 2/1/22.
//

#ifndef PFP_CST_LZ_77_HPP
#define PFP_CST_LZ_77_HPP

 //PFP_CST_LZ_77_HPP

//lz _factor (PFP position i)
//lz_factorization(PFP)-> LZ77

#include <common.hpp>
#include <pfp.hpp>
#include <kd_tree_support.hpp>
#include <lce_support.hpp>
#include <sa_support.hpp>

template<class wt_t = pfp_wt_wm>
class lz_77{
protected:
//    pfp_lce_support<wt_t> _lce;
//    pfp_sa_support<wt_t> _sa;
    typedef point<uint64_t , 3> point3d;
    typedef kdtree<uint64_t, 3> tree3d;

public:

    //check other place used those things make it private or protected
    pf_parsing<wt_t> &pfp;

  //  typedef point<uint32_t, 3> point3d;
//change the name of tree3d
  //  typedef kdtree<uint32_t, 3> tree3d;
  //  tree3d tree;

    lz_77(){

    };

    lz_77(pf_parsing<wt_t>& pfp_) : pfp(pfp_){

    }

    void compute_lz_77(){
        //i is the starting position of the lz_77's factor. Starting from 0. each time can add the factor's length to compute the next one factor.

        //define the tree this place.
        //use const kdtree<<>>& tree there. We dont need the tree again.

        const size_t n = pfp.n;
        tree3d tree;



        tree = pfp.tree;
        //the limitation for the x,y,z is the position in grid.
        size_t i = 0;
       // typedef point<uint32_t , 3> point3d;
        while(i < n) {
            //add the comment to all the variable
            uint64_t z1 = pfp.rank_b_p(i + 1);
            size_t offset = 0;
            if (i != 0){
               offset = i - pfp.select_b_p(z1);
            }
            // start from 1.
            uint64_t q = pfp.pars.p[z1 - 1]; // map the x inside the D
            size_t d = pfp.dict.select_b_d(q) + offset;
            // r is the
            size_t r = pfp.dict.isaD[d + 1]; // #1s in b_pps[1..i_in_saD] counting from 0
            r = pfp.b_pps_rank_1(r);



            uint_t x1 = pfp.pars.isaP[z1];
            uint y1 = pfp.M[r].left;    // M_entry is [len, left, right]
            uint y2 = pfp.M[r].right;
            //TODO: to check the two x dimension. to the PSV, matrix is smaller than x1. To NSV, matrix is larger than x1.



            point3d* psv = pfp.tree.query_PSV(x1, y1, y2, z1);
            point3d* nsv = pfp.tree.query_NSV(x1, y1, y2, z1);
            // check the length of the suffix is the same as the M length
            size_t offset_prime = pfp.select_b_p(z1 + 1) - i;

            size_t p_psv;
            size_t l_psv;
            size_t p_nsv;
            size_t l_nsv;
            size_t f;
            size_t l;

            //psv is not a pointer. check it
            if (psv != nullptr){
                // rmq_s_lcp_t(i,j) will return the min(lcp[i,...,j])
                p_psv = pfp.rmq_s_lcp_T(psv->get(0)+1, x1);
                //s_lcp_T[i] will return longest common prefix of S[SA[i-1]] and S[SA[i]];
                l_psv = pfp.s_lcp_T_array[p_psv];

                if (nsv != nullptr){
                    p_nsv = pfp.rmq_s_lcp_T(x1+1, nsv->get(0));
                    l_nsv = pfp.s_lcp_T_array[p_nsv];

                    if (l_psv > l_nsv){
                        f = pfp.select_b_p(pfp.pars.saP[psv->get(0)]) - offset_prime;
                        l = l_psv;
                    } else{
                        f = (pfp.select_b_p(pfp.pars.saP[nsv->get(0)]) - offset_prime) %n;
                        l = l_nsv;
                    }

                } else{
                    f = pfp.select_b_p(pfp.pars.saP[psv->get(0)]) - offset_prime;
                    l = l_psv;
                }

            } else if(nsv != nullptr){
                p_nsv = pfp.rmq_s_lcp_T(x1+1, nsv->get(0));
                l_nsv = pfp.s_lcp_T_array[p_nsv];
                f = pfp.select_b_p(pfp.pars.saP[nsv->get(0)]) - offset_prime;
                l = l_nsv;
            } else{
                // Neither the PSV nor NSV exist. We need to use the kkp algorithm
// the PSV and NSV used unsigned.
                int64_t pps_psv = pfp.PPS_PSV[r];
                int64_t pps_nsv = pfp.PPS_NSV[r];
                if (pps_psv == -1){
                    l_psv = 0;
                }else{
                    l_psv = pfp.dict.lcpD[pfp.dict.rmq_lcp_D(pps_psv + 1, r)];
                }
                if (pps_nsv == -1){
                    l_nsv = 0;
                }else{
                    l_nsv = pfp.dict.lcpD[pfp.dict.rmq_lcp_D(r + 1, pps_nsv)];
                }

                if (l_psv >= l_nsv){

                    //get a new name for the PPS array.
                    f = pfp.proper_phrase_suffix[pps_psv];
                    l = l_psv;
                } else{
                    f = pfp.proper_phrase_suffix[pps_nsv];
                    l = l_nsv;
                }
                if (l == 0){
                    uint8_t factor = pfp.dict.d[d];
                    cout <<"("<<factor<<","<<0<<")"<<endl;
                    i += 1;
                }else{
                    i+=l;
                }
            }
            //write it to file
           // cout<<"f is: "<<f<<" l is: "<<l<<endl;
        }

    }

};
#endif