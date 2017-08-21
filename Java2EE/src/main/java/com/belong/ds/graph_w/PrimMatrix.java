package com.belong.ds.graph_w;


public class PrimMatrix {
	/**
	 * Java: prim算法生成最小生成树(邻接矩阵)
	 * @author weilkun
	 * @date 2015/12/17
	 */
	private char[] mVexs;       // 顶点集合
	private int[][] mMatrix;    // 邻接矩阵
	private static final int INF = Integer.MAX_VALUE;   // 最大值,也就是在邻接矩阵中，两个点如果没有边，就标记最大值
	/*
	 * 创建图(用已提供的矩阵)
	 *
	 * 参数说明：
	 *     vexs  -- 顶点数组
	 *     matrix-- 矩阵(数据)
	 */
	public PrimMatrix(char[] tops, int[][] matrix) {
		// 初始化"顶点数"和"边数"
		int vlen = tops.length;
		// 初始化"顶点"
		mVexs = new char[vlen];
		for (int i = 0; i < vlen; i++){
			mVexs[i] = tops[i];
		}
		// 初始化"边"
		mMatrix = new int[vlen][vlen];
		for (int i = 0; i < vlen; i++){
			for (int j = 0; j < vlen; j++){
				mMatrix[i][j] = matrix[i][j];
			}
		}
	}
	/*
	 * 返回ch在顶点数组中的位置
	 */
	private int getPosition(char ch) {
		for(int i=0; i<mVexs.length; i++){
			if(mVexs[i]==ch){
				return i;
			}
		}
		return -1;
	}
	/*
	 * prim最小生成树，找到当前节点的所有点的最小，
	 *
	 * 参数说明：
	 *   start -- 从图中的第start个元素开始，生成最小树
	 */
	public void prim(int start) {
		int count = mVexs.length;         // 顶点个数
		int index=0;                    // prim最小树的索引，即prims数组的索引
		char[] prims  = new char[count];  // prim最小树的结果数组
		int[] weights = new int[count];   // 顶点间 边的权值
		// prim最小生成树中第一个数是"图中第start个顶点"，因为是从start开始的。
		prims[index++] = mVexs[start];//A
		// 初始化"顶点的权值数组"，
		// 将每个顶点的权值初始化为"第start个顶点"到"该顶点"的权值。
 		for (int i = 0; i < count; i++ ){//分配当前顶点A的权值
			weights[i] = mMatrix[start][i];
		}
		// 将第start个顶点的权值初始化为0。
		// 可以理解为"第start个顶点到它自身的距离为0"。
		weights[start] = 0;//第一个权值，也就是每个点到自身的权值为0，
		for (int i = 0; i < count; i++) {
			// 由于从start开始的，因此不需要再对第start个顶点进行处理。
			if(start == i){
				continue;
			}
			int j = 0;
			int k = 0;
			int min = INF;
			// 在未被加入到最小生成树的顶点中，找出权值最小的顶点。
			while (j < count) {
				// 若weights[j]=0，意味着"第j个节点已经被排序过"(或者说已经加入了最小生成树中)。
				if (weights[j] != 0 && weights[j] < min) {
					min = weights[j];
					k = j;
				}
				j++;
			}
			// 经过上面的处理后，在未被加入到最小生成树的顶点中，权值最小的顶点是第k个顶点。
			// 将第k个顶点加入到最小生成树的结果数组中
			prims[index++] = mVexs[k];
			// 将"第k个顶点的权值"标记为0，意味着第k个顶点已经排序过了(或者说已经加入了最小树结果中)。
			weights[k] = 0;//也意味着，此时之前的所有已经访问的点可以看做一个虚拟点，比较该点到其他点的权值
			// 因为权值，是一维数组，只能存一行，顶点从A已经变为B，所以，当第k个顶点被加入到最小生成树的结果数组中之后，
			//更新从这点到其它顶点的权值。需要注意的是，当第一个点
			for (j = 0 ; j < count; j++) {
				// 当第j个节点没有被处理，并且需要更新时才被更新。//已经访问过的节点看成一个点，与该节点同时相邻的那个点的权重，留最小的
				
				if (weights[j] != 0 && mMatrix[k][j] < weights[j]){//k既是现在权值最小的种子号，之后再它的位置在把权值重新更新
					//也就是把该点的权值准备好，权值找小的，一旦出现大的不动
					weights[j] = mMatrix[k][j];//到每个点，就要把权值附到位置
					
				}
			}
		}
		// 计算最小生成树的权值
		int sum = 0;
		for (int i = 1; i < index; i++) {
			int min = INF;
			// 获取prims[i]在mMatrix中的位置
			int n = getPosition(prims[i]);
			// 找出所有在vexs[0...i]中邻接点中，找出到j的权值最小的顶点。
			for (int j = 0; j < i; j++) {
				int m = getPosition(prims[j]);
				if (mMatrix[m][n]<min){
					min = mMatrix[m][n];
					
				}
			}
			System.out.println(min);
			sum += min;
		}
		// 打印最小生成树
		System.out.printf("PRIM权值和(%c)=%d: ", mVexs[start], sum);
		for (int i = 0; i < index; i++){
			System.out.printf("%c ", prims[i]);
		}
		System.out.printf("\n");		
	}
	public static void main(String[] args) {
		//顶点
		char[] tops = {'A', 'B', 'C', 'D', 'E', 'F', 'G'};
		//INF最大值,也就是在邻接矩阵中，两个点如果没有边，就标记最大值
		 //0 是自己到自己的点的标记
		
		int matrix1[][] = {
                /*A*//*B*//*C*//*D*//*E*//*F*//*G*/
         /*A*/ {   0,  12, INF, INF, INF,  16,  14},
         /*B*/ {  12,   0,  10, INF, INF,   7, INF},
         /*C*/ { INF,  10,   0,   3,   5,   6, INF},
         /*D*/ { INF, INF,   3,   0,   4, INF, INF},
         /*E*/ { INF, INF,   5,   4,   0,   2,   8},
         /*F*/ {  16,   7,   6, INF,   2,   0,   9},
         /*G*/ {  14, INF, INF, INF,   8,   9,   0}
         };
		
		
		 
//		int matrix2[][] = {
//                  /*A*//*B*//*C*//*D*//*E*//*F*//*G*/
//         /*A*/ {   0,    7, INF,  5,   INF, INF, INF},
//         /*B*/ {  7,   0,    8,   9,   7,   INF, INF},
//         /*C*/ { INF,  8,    0,  INF,  5,   INF, INF},
//         /*D*/ {   5,  9,  INF,    0, 15,     6, INF},
//         /*E*/ { INF,  7,    5,   15,  0,     8,   9},
//         /*F*/ {  16,INF,  INF,    6,  8,     0,  11},
//         /*G*/ { INF,INF,  INF,  INF,  9,    11,   0}
//         };
		
		
		
		
		// 采用已有的"图"
		PrimMatrix pG = new PrimMatrix(tops, matrix1);
		pG.prim(0);   // prim算法生成最小生成树
	}

}
