package com.belong.ds.graph_w;
/*
 * 
 * 通过邻接矩阵对图进行搜和广搜
 */
public class DFSBFS {
	private char[] mVexs;       // 顶点集合
	private int[][] mMatrix;    // 邻接矩阵
	/*
	 * 创建图(用已提供的矩阵)
	 *
	 * 参数说明：
	 *     vexs  -- 顶点数组
	 *     edges -- 边数组
	 */
	public DFSBFS(char[] vexs, char[][] edges) {

		// 得到顶点个数和边数
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
			mMatrix[p1][p2] = 1;//A到B的边即存在，值都暂定为1
		}
	}
	/*
     * 返回顶点v的第一个邻接顶点的索引，失败则返回-1
     */
    private int firstVertex(int v) {

        if (v<0 || v>(mVexs.length-1))
            return -1;

        for (int i = 0; i < mVexs.length; i++){
            if (mMatrix[v][i] == 1){
                return i;//返回第一个邻接顶点的索引
            }
        }

        return -1;
    }

    /*
     * 返回顶点v相对于w的下一个邻接顶点的索引，失败则返回-1
     */
    private int nextVertex(int v, int w) {

        if (v<0 || v>(mVexs.length-1) || w<0 || w>(mVexs.length-1)){
            return -1;
        }
        //i=w+1 下个索引号
        for (int i = w + 1; i < mVexs.length; i++){
            if (mMatrix[v][i] == 1){//看看与哪个顶点相连
                return i;//返回顶点v相对于w的下一个邻接顶点的索引，失败则返回-1
            }
        }

        return -1;
    }

    
	 /*
     * 深度优先搜索遍历图的递归实现
     */
    private void DFS(int i, boolean[] visited) {
        visited[i] = true;//已经访问了
        System.out.printf("%c ", mVexs[i]);
        // 遍历该顶点的所有邻接顶点。若是没有访问过，那么继续往下走
        int w = firstVertex(i);
        while( w >= 0 ) {//
            if (visited[w]==false){   //访问的点，之前是否已经访问了，      	
                DFS(w, visited);               
            }
            //行和列需要颠倒，，是按列扫描，扫描该元素后，在另起下一行
            w = nextVertex(i, w);//如果已经被访问了，方向下个顶点索引
        }
    }
    /*
     * 深度优先搜索遍历图
     */
    public void DFS() {
        boolean[] visited = new boolean[mVexs.length];       // 顶点访问标记

        // 初始化所有顶点都没有被访问
        for (int i = 0; i < mVexs.length; i++){
            visited[i] = false;
        }

        System.out.printf("DFS: ");
        for (int i = 0; i < mVexs.length; i++) {
            if (visited[i]==false){
                DFS(i, visited);
            }
        }
        System.out.printf("\n");
    }
    /*
     * 广度优先搜索（类似于树的层次遍历）
     */
    public void BFS() {
        int head = 0;//队列的头
        int rear = 0;//队列的尾
        int[] queue = new int[mVexs.length];            // 辅组队列
        boolean[] visited = new boolean[mVexs.length];  // 顶点访问标记

        for (int i = 0; i < mVexs.length; i++){//初始化访问标记
            visited[i] = false;
        }

        System.out.printf("BFS: ");
        for (int i = 0; i < mVexs.length; i++) {
            if (visited[i]==false) {
                visited[i] = true;
                System.out.printf("%c ", mVexs[i]);
                queue[rear++] = i;  // 所有顶点，入队列，
            }

            while (head != rear) {
                int j = queue[head++];  // 顶点出队列
                int k = firstVertex(j);// 返回顶点v的第一个邻接顶点的索引，失败则返回-1
                while( k >= 0) { //k是为访问的邻接顶点,找到和定点所有关联的邻接点，并且设标记
                    if (visited[k]==false) {//访问的点，之前是否已经访问了，
                        visited[k] = true;
                        System.out.printf("%c ", mVexs[k]);
                        queue[rear++] = k;//已经访问了，邻接点入队列
                    }
                    //行就是行，列就是列，是扫描完一行的每个列，在扫下一行，不需要颠倒，
                    k = nextVertex(j, k);//返回顶点v相对于w的下一个邻接顶点的索引，失败则返回-1
                }
            }
        }
        System.out.printf("\n");
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
		System.out.printf("邻接矩阵图的遍历:\n");
		for (int i = 0; i < mVexs.length; i++) {
			for (int j = 0; j < mVexs.length; j++){
				System.out.printf("%d ", mMatrix[i][j]);
			}
			System.out.printf("\n");
		}
	}

	public static void main(String[] args) {
		/*
		 *        图形见PPT 
		 */
		 char[] vexs = {'A', 'B', 'C', 'D','E','F','G','H','I'};
		 char[][] edges = new char[][]{//边是个二维数组
					{'A', 'B'},
					{'A', 'F'},
					{'B', 'G'},
					{'B', 'C'},
					{'B', 'I'},
					{'C', 'B'},
					{'C', 'I'},
					{'C', 'D'},
					{'D', 'C'},
					{'D', 'I'},
					{'D', 'G'},
					{'D', 'H'},
					{'D', 'E'},
					{'E', 'H'},
					{'E', 'F'},
					{'F', 'G'},
					{'F', 'A'},
					{'F', 'E'},
					{'G', 'H'},
					{'G', 'D'},
					{'G', 'B'},
					{'H', 'G'},
					{'H', 'D'},					
					{'H', 'E'},
					{'I', 'B'},
					{'I', 'C'}
	
			}; 
	        DFSBFS pG;

	        // 自定义"图"(输入矩阵队列)
	        //pG = new MatrixDG();
	        // 采用已有的"图"
	        pG = new DFSBFS(vexs, edges);

	        pG.print();   // 打印图
	        pG.DFS();     // 深度优先遍历
	        pG.BFS();     // 广度优先遍历
	}
}
