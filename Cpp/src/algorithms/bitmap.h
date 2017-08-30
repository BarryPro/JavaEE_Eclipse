#include "algorithms.h"
/*
 * BitMap.cpp
 *  位图算法
 *  Created on: 2017年8月24日
 *      Author: belong
 */
void setbit(int *bitmap, int i){
    bitmap[i >> SHIFT] |= (1 << (i & MASK));
}

bool getbit(int *bitmap1, int i){
    return bitmap1[i >> SHIFT] & (1 << (i & MASK));
}

size_t getFileSize(ifstream &in, size_t &size){
    in.seekg(0, ios::end);
    size = in.tellg();
    in.seekg(0, ios::beg);
    return size;
}

char * fillBuf(const char *filename){
    size_t size = 0;
    ifstream in(filename);
    if(in.fail()){
        cerr<< "open " << filename << " failed!" << endl;
        exit(1);
    }
    getFileSize(in, size);

    char *buf = (char *)malloc(sizeof(char) * size + 1);
    if(buf == NULL){
        cerr << "malloc buf error!" << endl;
        exit(1);
    }

    in.read(buf, size);
    in.close();
    buf[size] = '\0';
    return buf;
}
void setBitMask(const char *filename, int *bit){
    char *buf, *temp;
    temp = buf = fillBuf(filename);
    char *p = new char[11];
    int len = 0;
    while(*temp){
        if(*temp == '\n'){
            p[len] = '\0';
            len = 0;
            //cout<<p<<endl;
            setbit(bit, atoi(p));
        }else{
            p[len++] = *temp;
        }
        temp++;
    }
    delete buf;
}

void compareBit(const char *filename, int *bit, vector<int> &result){
    char *buf, *temp;
    temp = buf = fillBuf(filename);
    char *p = new char[11];
    int len = 0;
    while(*temp){
        if(*temp == '\n'){
            p[len] = '\0';
            len = 0;
            if(getbit(bit, atoi(p))){
                result.push_back(atoi(p));
            }
        }else{
            p[len++] = *temp;
        }
        temp++;
    }
    delete buf;
}

int bitMapTest(){
    vector<int> result;
    unsigned int MAX = (unsigned int)(1 << 31);
    unsigned int size = MAX >> 5;
    int *bit1;

    bit1 = (int *)malloc(sizeof(int) * (size + 1));
    if(bit1 == NULL){
        cerr<<"Malloc bit1 error!"<<endl;
        exit(1);
    }

    memset(bit1, 0, size + 1);
    setBitMask("file1", bit1);
    compareBit("file2", bit1, result);
    delete bit1;

    cout<<result.size();
    sort(result.begin(), result.end());
    vector< int >::iterator   it = unique(result.begin(), result.end());

    ofstream    of("result");
    ostream_iterator<int> output(of, "\n");
    copy(result.begin(), it, output);

    return 0;
}



