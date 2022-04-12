#ifndef PFP_CST_KD_TREE_SUPPORT_HPP
#define PFP_CST_KD_TREE_SUPPORT_HPP

 //PFP_CST_KD_TREE_SUPPORT_HPP

// reference: https://rosettacode.org/wiki/K-d_tree#C.2B.2B


#include <iostream>
#include <algorithm>
#include <array>
#include <cmath>
#include <vector>
#include <cfloat>

using namespace std;
template<typename  coordinate_type, size_t dimensions>

class point {
public:
    point() {

    }

// coor_type is int, dims is 3
    point(array<coordinate_type, dimensions> c) : coords_(c){

    }

    point(initializer_list<coordinate_type> list){
        size_t n = min(dimensions, list.size());
        copy_n(list.begin(), n, coords_.begin());
    }

    //return the coordinate in the given dimension
    coordinate_type get(size_t index) const {
        return coords_[index];
    }

    //return the distance square from this point to another
    double distance(const point& pt) const {
        double dist = 0;
        for (size_t i = 0; i < dimensions; ++i) {
            double d = get(i) - pt.get(i);
            dist += d * d;
        }
        return dist;
    }

    bool isEmpty(){
        return coords_.empty();
    }
private:
    array<coordinate_type, dimensions> coords_;
};

template<typename  coordinate_type, size_t dimensions>
ostream& operator<<(ostream& out, const point<coordinate_type, dimensions>& pt){
    out<< '(';
    for (size_t i = 0; i < dimensions; ++i) {
        if (i > 0)
            out << ',';
        out << pt.get(i);
    }

    out << ')';
    return out;
}

//kd-tree implementation
// C++ k-d tree implementation, based on the C version at rosettacode.org.
//
template<typename  coordinate_type, size_t dimensions>
class kdtree{
public:
    typedef point<coordinate_type, dimensions> point_type;
private:
    struct node {
        node(const point_type& pt) : point_(pt), left_(nullptr), right_(nullptr) {}

        coordinate_type get(size_t index) const{
            return point_.get(index);
        }

        double distance(const point_type& pt) const {
            return point_.distance(pt);
        }


        point_type point_;
        node* left_;
        node* right_;
    };
    node* root_ = nullptr;
    node* best_ = nullptr;
    node* leftest_ = nullptr;
    node* rightest_ = nullptr;
    double best_dist_ = 0;
    double max_x_ = 0;
    double min_x_ = DBL_MAX;
    size_t visited_ = 0;
    vector<node> nodes_;

    struct node_cmp{
        node_cmp(size_t index) : index_(index) {}
        bool operator()(const node& n1, const node& n2) const {
            return n1.point_.get(index_) < n2.point_.get(index_);
        }
        size_t index_;
    };

    node* make_tree(size_t begin, size_t end, size_t index){
        if (end <= begin)
            return nullptr;
        size_t n = begin + (end - begin)/2;
        auto i = nodes_.begin();
        nth_element(i + begin, i + n, i + end, node_cmp(index));
        index = (index + 1) % dimensions;
        nodes_[n].left_ = make_tree(begin, n, index);
        nodes_[n].right_ = make_tree(n + 1, end, index);
        return &nodes_[n];
    }

    void nearest(node* root, const point_type& point, size_t index){
        if (root == nullptr)
            return;
        ++visited_;
        double d = root->distance(point);
        if (best_ == nullptr || d < best_dist_){
            best_dist_ = d;
            best_ = root;
        }

        if (best_dist_ == 0)
            return;
        //get current level's dimension and compare the distance
        double dx = root->get(index) - point.get(index);
        index = (index + 1) % dimensions;
        nearest(dx > 0 ? root->left_ : root->right_, point, index);
        if (dx * dx >= best_dist_)
            return;
        nearest(dx > 0 ? root->right_ : root->left_, point, index);
    }

//explain this function What's the x1..., also ...

//find the rightest node inside the matrix
//this matrix is x > x1, y1 < y < y2, z < z1
    void query_PSV(size_t x1, size_t y1, size_t y2, size_t z1, node* root, size_t index){
        //find the leftest
        if (root == nullptr)
            return;
        size_t x = root->get(0);
        size_t y = root->get(1);
        size_t z = root->get(2);


        if(x < x1 && y > y1 && y < y2 && z < z1){
            if (rightest_ == nullptr || x > max_x_){
                max_x_ = x;
                rightest_ = root;
                ++visited_;
            }
        }

        // cutting path
        if (index == 0){
            uint64_t dx = root->get(index) - x1;
            // size_t test = root->get(index);
            size_t visited = visited_;
            index = (index + 1) % dimensions;
            // if current node's x dimension is larger than matrix, then we go left node
            query_PSV(x1, y1, y2, z1, dx > 0 ? root_->left_ : root_->right_, index);
            if (dx < 0 && visited == visited_){
                query_PSV(x1, y1, y2, z1, root_->left_, index);
            }
        }else if (index == 1){
            //maybe go same subtree twice.
            uint64_t dy1 = root->get(index) - y1;
            uint64_t dy2 = root->get(index) - y2;
            index = (index + 1) % dimensions;
            if (dy1 < 0){
                // means y is smaller than y1. current point is on the left side of this matrix.
                //we only need to check the right side
                query_PSV(x1, y1, y2, z1, root -> right_, index);
            }else if(dy2 > 0){
                // y is larger than y2. Current node is on the right side of this matrix.
                //we only need to check the left side
                query_PSV(x1, y1, y2, z1, root -> left_, index);
            }else{
                // inside the matrix
                size_t visited = visited_;
                query_PSV(x1, y1, y2, z1, root -> left_, index);
                query_PSV(x1, y1, y2, z1, root -> right_, index);

            }

        } else{
            uint64_t dz = root->get(index) - z1;
            index = (index + 1) % dimensions;
            // if current node's z dimension is larger than matrix, then we go left node
            query_PSV(x1, y1, y2, z1, dz > 0 ? root->left_ : root->right_, index);
            if (dz <= 0){
                query_PSV(x1, y1, y2, z1, root->left_, index);
            }
        }

    }

    // find the leftest node inside the matrix

    // the matrix is x > x1, y1 < y < y2, z < z1
    void query_NSV(size_t x1, size_t y1, size_t y2, size_t z1, node* root, size_t index){
        //find the leftest
        if (root == nullptr)
            return;
        size_t x = root->get(0);
        size_t y = root->get(1);
        size_t z = root->get(2);


        if(x >= x1 && y > y1 && y < y2 && z < z1){
            if (leftest_ == nullptr || x < min_x_){
                min_x_ = x;
                leftest_ = root;
                ++visited_;
            }
        }

        // cutting path
        if (index == 0){
            uint64_t dx = root->get(index) - x1;
            // size_t test = root->get(index);
            size_t visited = visited_;
            index = (index + 1) % dimensions;
            // if current node's x dimension is smaller than matrix, then we go right node
            query_NSV(x1, y1, y2, z1, dx < 0 ? root_->right_ : root_->left_, index);
            if (dx > 0 && visited == visited_){
                query_NSV(x1, y1, y2, z1, root_->right_, index);
            }
        }else if (index == 1){
            //maybe go same subtree twice.
            uint64_t dy1 = root->get(index) - y1;
            uint64_t dy2 = root->get(index) - y2;
            index = (index + 1) % dimensions;
            if (dy1 < 0){
                // means y is smaller than y1. current point is on the left side of this matrix.
                // we only need to check the right side
                query_NSV(x1, y1, y2, z1, root -> right_, index);
            }else if(dy2 > 0){
                // y is larger than y2. Current node is on the right side of this matrix.
                //we only need to check the left side
                query_NSV(x1, y1, y2, z1, root -> left_, index);
            }else{
                // inside the matrix
                query_NSV(x1, y1, y2, z1, root -> right_, index);
                query_NSV(x1, y1, y2, z1, root -> left_, index);

            }

        } else{
            uint64_t dz = root->get(index) - z1;
            index = (index + 1) % dimensions;
            // if current node's z dimension is larger than matrix, then we go left node
            query_NSV(x1, y1, y2, z1, dz > 0 ? root->left_ : root->right_, index);
            if (dz <= 0){
                query_NSV(x1, y1, y2, z1, root->left_, index);
            }
        }

    }

public:
    kdtree(const kdtree&) = delete;

    kdtree(){

    };
   // kdtree& operator=(const kdtree&) = delete;

    // construct taking a pair of iteratiors
    template<typename  iterator>
    kdtree(iterator begin, iterator end) : nodes_(begin, end){
        root_ = make_tree(0, nodes_.size(), 0);
    }

    /**
    * Constructor taking a function object that generates
    * points. The function object will be called n times
    * to populate the tree.
    *
    * @param f function that returns a point
    * @param n number of points to add
    */
    template<typename func>
    kdtree(func&& f, size_t n){
        nodes_.reserve(n);
        for (size_t i = 0; i < n; ++i)
            nodes_.push_back(f());
        root_ = make_tree(0, nodes_.size(), 0);

    }

    bool empty() const {return nodes_.empty();}

    size_t visited() const {return visited_;};

    double distance() const {return sqrt(best_dist_); }

    const point_type& nearest(const point_type& pt) {
        if (root_ == nullptr)
            throw logic_error("tree is empty");
        best_ = nullptr;
        visited_ = 0;
        best_dist_ = 0;
        nearest(root_, pt, 0);
        return best_->point_;
    }

    const point_type& query_PSV(const size_t x1, const size_t y1, const size_t y2, const size_t z1) {
        if (root_ == nullptr)
            throw logic_error("tree is empty");
        rightest_= nullptr;
        max_x_ = 0;
        query_PSV(x1, y1, y2, z1, root_, 0);
        //Got the leftest and rightest node. Compare there to get the right node.

        //change the return to pointer
        return rightest_->point_;

    }

    const point_type & query_NSV(const size_t x1, const size_t y1, const size_t y2, const size_t z1) {
        if (root_ == nullptr)
            throw logic_error("tree is empty");
        leftest_ = nullptr;
        min_x_ = DBL_MAX;
        query_NSV(x1, y1, y2, z1, root_, 0);
        return leftest_ -> point_;
    }


    size_t size(){
        return nodes_.size();
    }


};
#endif