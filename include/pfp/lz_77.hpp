//
// Created by yu hong on 2/1/22.
//

#ifndef PFP_CST_LZ_77_HPP
#define PFP_CST_LZ_77_HPP

#endif //PFP_CST_LZ_77_HPP

//lz _factor (PFP position i)
//lz_factorization(PFP)-> LZ77

#include <common.hpp>
#include <pfp.hpp>
#include <kd_tree_support.hpp>
#include<lce_support.hpp>
#include<sa_support.hpp>

template<class wt_t = pfp_wt_wm>

class lz_77{
protected:
    pfp_lce_support<wt_t> _lce;
    pfp_sa_support<wt_t> _sa;

public:
    pf_parsing<wt_t> &pfp;
    typedef point<uint32_t, 3> point3d;

    typedef kdtree<uint32_t, 3> tree3d;
    tree3d tree;

    lz_77(){

    };

    lz_77(pf_parsing<wt_t>& pfp_){

    }

    void compute_lz_77(){
        //i is the starting position of the lz_77's factor. Starting from 0. each time can add the factor's length to compute the next one factor.
        tree = pfp.tree;
        size_t n = pfp.n;
        //the limitation for the x,y,z is the position in grid.
        for (int i = 0; i < n; ++i) {
            uint_t z1 = pfp.rank_b_p(i);
            size_t offset = i - pfp.select_b_p(z1);
            uint32_t q = pfp.pars.p[z1]; // map the x inside the D
            size_t d = pfp.dict.select_b_d(q) + offset;
            uint_t r = pfp.dict.isaD[d];
            uint_t x1 = pfp.pars.isaP[z1+1];
            M_entry_t y_set = pfp.M[r]; // M_entry is [len, left, right]
            uint y1 = y_set[1];
            uint y2 = y_set[2];
            //TODO: to check the two x dimension. to the PSV, matrix is smaller than x1. To NSV, matrix is larger than x1.
            point3d psv = tree.query_PSV(x1, y1, y2, z1);
            point3d nsv = tree.query_NSV(x1, y1, y2, z1);
            size_t offset_prime = pfp.select_b_p(z1 + 1) - 1;

            size_t p_psv;
            size_t l_psv;
            size_t p_nsv;
            size_t l_nsv;
            size_t f;
            size_t l;
            if (psv != nullptr){
                p_psv = pfp.rmq_s_lcp_T(psv.get(0)+1, i);
                l_psv = pfp.s_lcp_T[p_psv];

                if (nsv != nullptr){
                    p_nsv = pfp.rmq_s_lcp_T(i+1, nsv.get(0));
                    l_nsv = pfp.s_lcp_T[p_nsv];

                    if (l_psv > l_nsv){
                        f = pfp.select_b_p(pfp.pars.saP[psv.get(0)]) - offset_prime;
                        l = l_psv;
                    } else{
                        f = pfp.select_b_p(pfp.pars.saP[nsv.get(0)]) - offset_prime;
                        l = l_nsv;
                    }

                } else{
                    f = pfp.select_b_p(pfp.pars.saP[psv.get(0)]) - offset_prime;
                    l = l_psv;
                }

            } else if(nsv != nullptr){
                p_nsv = pfp.rmq_s_lcp_T(i+1, nsv.get(0));
                l_nsv = pfp.s_lcp_T[p_nsv];
                f = pfp.select_b_p(pfp.pars.saP[nsv.get(0)]) - offset_prime;
                l = l_nsv;
            } else{

            }
        }
        //find the phrase it belongs to



    }
};