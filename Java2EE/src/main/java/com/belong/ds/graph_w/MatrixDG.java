package com.belong.ds.graph_w;

import java.io.IOException;
import java.util.Scanner;

public class MatrixDG {

    private char[] mVexs;       // 顶点集合
    private int[][] mMatrix;    // 邻接矩阵

//    /* 
//     * 创建图(自己输入数据)
//     */
//    public MatrixDG() {
//
//        // 输入"顶点数"和"边数"
//        System.out.printf("input 顶点 number: ");
//        int vlen = readInt();
//        System.out.printf("input 边  number: ");
//        int elen = readInt();
//        if ( vlen < 1 || elen < 1 || (elen > (vlen*(vlen - 1)))) {
//            System.out.printf("input error: invalid parameters!\n");
//            return ;
//        }
//        
//        // 初始化"顶点"
//        mVexs = new char[vlen];
//        for (int i = 0; i < mVexs.length; i++) {
//            System.out.printf("vertex(%d): ", i);
//            mVexs[i] = readChar();
//        }
//
//        // 初始化"边"
//        mMatrix = new int[vlen][vlen];
//        for (int i = 0; i < elen; i++) {
//            // 读取边的起始顶点和结束顶点
//            System.out.printf("edge(%d):", i);
//            char c1 = readChar();
//            char c2 = readChar();
//            int p1 = getPosition(c1);
//            int p2 = getPosition(c2);
//
//            if (p1==-1 || p2==-1) {
//                System.out.printf("input error: invalid edge!\n");
//                return ;
//            }
//
//            mMatrix[p1][p2] = 1;
//        }
//    }
    /*
//   * 读取一个输入字符
//   */
//  private char readChar() {
//      char ch='0';
//
//      do {
//          try {
//              ch = (char)System.in.read();
//          } catch (IOException e) {
//              e.printStackTrace();
//          }
//      } while(!((ch>='a'&&ch<='z') || (ch>='A'&&ch<='Z')));
//
//      return ch;
//  }
//
//  /*
//   * 读取一个输入字符
//   */
//  private int readInt() {
//      Scanner scanner = new Scanner(System.in);
//      return scanner.nextInt();
//  }


    /*
     * 创建图(用已提供的矩阵)
     *
     * 参数说明：
     *     vexs  -- 顶点数组
     *     edges -- 边数组
     */
    public MatrixDG(char[] vexs, char[][] edges) {
        
        // 初始化"顶点数"和"边数"
        int vlen = vexs.length;
        int elen = edges.length;

        // 初始化"顶点"
        mVexs = new char[vlen];
        for (int i = 0; i < mVexs.length; i++){
            mVexs[i] = vexs[i];
        }

        // 初始化"边"
        mMatrix = new int[vlen][vlen];
        for (int i = 0; i < elen; i++) {
            // 读取边的起始顶点和结束顶点
            int p1 = getPosition(edges[i][0]);//以顶点找到A点
            int p2 = getPosition(edges[i][1]);//以顶点找到B点
            mMatrix[p1][p2] = 1;//A到B的边即存在
        }
    }
    /*
     * 返回ch位置
     */
    private int getPosition(char ch) {
        for(int i=0; i<mVexs.length; i++){
            if(mVexs[i]==ch){//顶点的值和
                return i;
            }
        }
        return -1;
    }

//   
    /*
     * 打印矩阵队列图
     */
    public void print() {
        System.out.printf("有向Martix Graph:\n");
        for (int i = 0; i < mVexs.length; i++) {
            for (int j = 0; j < mVexs.length; j++){
                System.out.printf("%d ", mMatrix[i][j]);
            }
            System.out.printf("\n");
        }
    }
   
    public static void main(String[] args) {
        char[] vexs = {'A', 'B', 'C', 'D'};
        //
        	//有向图是
        
        
        char[][] edges = new char[][]{//边是个二维数组
        		{'A', 'D'},
        		{'B','A'},
        		{'C', 'A'}, {'C', 'B'},
        		{'B', 'C'}
        		
            }; 
        	//无向图是,无向图和有向图代码一致，只不过无向图AB两个顶点，边表示是A->B B->A
//        char[][] edges = new char[][]{//边是个二维数组
//        		{'A', 'B'},{'B','A'},
//        		{'B', 'C'}, {'C', 'B'},
//        		{'C', 'D'},{'D', 'C'},
//        		{'A', 'D'},{'D','A'},
//        		{'A', 'C'},{'C', 'A'}
//        		
//            }; 
        // 自定义"图"(输入矩阵队列)
        //pG = new MatrixDG();
        // 采用已有的"图"
        MatrixDG pG = new MatrixDG(vexs, edges);

        pG.print();   // 打印图
    }
}
