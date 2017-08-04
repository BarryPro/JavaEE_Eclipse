package com.datastructure.graph_w;
/**
 * Java prim算法生成最小生成树(邻接表)
 *
 * @author belong
 * @date 2015/12/18
 */
public class PrimeList {
	private static int INF = Integer.MAX_VALUE;

	// 邻接表中表对应的链表的顶点
	private class ENode {
		int top;       // 该边所指向的顶点的位置
		int weight;     // 该边的权
		ENode nextEdge; // 指向下一条弧的指针
	}

	// 邻接表中表的顶点
	private class VNode {
		char data;          // 顶点信息
		ENode firstEdge;    // 指向第一条依附该顶点的弧
	}

    private VNode[] mVexs;  // 顶点数组
	/*
	 * 创建图(用已提供的矩阵)
	 *
	 * 参数说明：
	 *     vexs  -- 顶点数组
	 *     edges -- 边
	 */
	public PrimeList(char[] vexs, EData[] edges) {
		// 初始化"顶点数"和"边数"
		int vlen = vexs.length;
		int elen = edges.length;

		// 初始化"顶点"
		mVexs = new VNode[vlen];
		for (int i = 0; i < mVexs.length; i++) {
			mVexs[i] = new VNode();
			mVexs[i].data = vexs[i];
			mVexs[i].firstEdge = null;
		}

		// 初始化"边"
		for (int i = 0; i < elen; i++) {
			// 读取边的起始顶点和结束顶点
			char c1 = edges[i].start;
			char c2 = edges[i].end;
			int weight = edges[i].weight;

			// 读取边的起始顶点和结束顶点
			int p1 = getPosition(c1);
			int p2 = getPosition(c2);
			// 初始化node1
			ENode node1 = new ENode();
			node1.top = p2;
			node1.weight = weight;
			// 将node1链接到"p1所在链表的末尾"
			if(mVexs[p1].firstEdge == null){
				mVexs[p1].firstEdge = node1;
			}else{
				linkLast(mVexs[p1].firstEdge, node1);
			}
			// 初始化node2
			ENode node2 = new ENode();
			node2.top = p1;
			node2.weight = weight;
			// 将node2链接到"p2所在链表的末尾"
			if(mVexs[p2].firstEdge == null){
				mVexs[p2].firstEdge = node2;
			}else{
				linkLast(mVexs[p2].firstEdge, node2);
			}
		}
	}

	/*
	 * 将node节点链接到list的最后
	 */
	private void linkLast(ENode list, ENode node) {
		ENode p = list;

		while(p.nextEdge!=null){
			p = p.nextEdge;
		}
		p.nextEdge = node;
	}

	/*
	 * 返回ch位置
	 */
	private int getPosition(char ch) {
		for(int i=0; i<mVexs.length; i++){
			if(mVexs[i].data==ch){
				return i;
			}
		}
		return -1;
	}
	/*
	 * 打印矩阵队列图
	 */
	public void print() {
		System.out.printf("List Graph:\n");
		for (int i = 0; i < mVexs.length; i++) {
			System.out.printf("%d(%c): ", i, mVexs[i].data);
			ENode node = mVexs[i].firstEdge;
			while (node != null) {
				System.out.printf("%d(%c) ", node.top, mVexs[node.top].data);
				node = node.nextEdge;
			}
			System.out.printf("\n");
		}
	}
	/*
	 * 获取边<start, end>的权值；若start和end不是连通的，则返回无穷大。
	 */
	private int getWeight(int start, int end) {

		if (start==end)
			return 0;

		ENode node = mVexs[start].firstEdge;
		while (node!=null) {
			if (end==node.top){
				return node.weight;
			}
			node = node.nextEdge;
		}

		return INF;
	}
	/*
	 * prim最小生成树
	 *
	 * 参数说明：
	 *   start -- 从图中的第start个元素开始，生成最小树
	 */
	public void prim(int start) {
		int min,i,j,k,m,n,tmp,sum;
		int num = mVexs.length;
		int index=0;                   // prim最小树的索引，即prims数组的索引
		char[] prims = new char[num];  // prim最小树的结果数组
		int[] weights = new int[num];  // 顶点间边的权值
		// prim最小生成树中第一个数是"图中第start个顶点"，因为是从start开始的。
		prims[index++] = mVexs[start].data;
		// 初始化"顶点的权值数组"，
		// 将每个顶点的权值初始化为"第start个顶点"到"该顶点"的权值。
		for (i = 0; i < num; i++ ){
			weights[i] = getWeight(start, i);
		}
		for (i = 0; i < num; i++) {
			// 由于从start开始的，因此不需要再对第start个顶点进行处理。
			if(start == i){
				continue;
			}
			j = 0;
			k = 0;
			min = INF;
			// 在未被加入到最小生成树的顶点中，找出权值最小的顶点。
			while (j < num) {
				// 若weights[j]=0，意味着"第j个节点已经被排序过"(或者说已经加入了最小生成树中)。
				if (weights[j] != 0 && weights[j] < min) {
					min = weights[j];
					k = j;
				}
				j++;
			}

			// 经过上面的处理后，在未被加入到最小生成树的顶点中，权值最小的顶点是第k个顶点。
			// 将第k个顶点加入到最小生成树的结果数组中
			prims[index++] = mVexs[k].data;
			// 将"第k个顶点的权值"标记为0，意味着第k个顶点已经排序过了(或者说已经加入了最小树结果中)。
			weights[k] = 0;
			// 当第k个顶点被加入到最小生成树的结果数组中之后，更新其它顶点的权值。
			for (j = 0 ; j < num; j++) {
				// 获取第k个顶点到第j个顶点的权值
				tmp = getWeight(k, j);
				// 当第j个节点没有被处理，并且需要更新时才被更新。
				if (weights[j] != 0 && tmp < weights[j]){
					weights[j] = tmp;
				}
			}
		}

		// 计算最小生成树的权值
		sum = 0;
		for (i = 1; i < index; i++) {
			min = INF;
			// 获取prims[i]在矩阵表中的位置
			n = getPosition(prims[i]);
			// 在vexs[0...i]中，找出到j的权值最小的顶点。
			for (j = 0; j < i; j++) {
				m = getPosition(prims[j]);
				tmp = getWeight(m, n);
				if (tmp < min){
					min = tmp;
				}
			}
			sum += min;
		}
		// 打印最小生成树
		System.out.printf("PRIM权值和(%c)=%d: ", mVexs[start].data, sum);
		for (i = 0; i < index; i++){
			System.out.printf("%c ", prims[i]);
		}
		System.out.printf("\n");
	}


	// 示例类：边的结构体(用来演示)
	private static class EData {
		char start; // 边的起点
		char end;   // 边的终点
		int weight; // 边的权重

		public EData(char start, char end, int weight) {
			this.start = start;
			this.end = end;
			this.weight = weight;
		}
	}

    public static void main(String[] args) {
		char[] vexs = {'A', 'B', 'C', 'D', 'E', 'F', 'G'};
		EData[] edges = {
				// 起点 终点 权
				new EData('A', 'B', 12), 
				new EData('A', 'F', 16), 
				new EData('A', 'G', 14), 
				new EData('B', 'C', 10), 
				new EData('B', 'F',  7), 
				new EData('C', 'D',  3), 
				new EData('C', 'E',  5), 
				new EData('C', 'F',  6), 
				new EData('D', 'E',  4), 
				new EData('E', 'F',  2), 
				new EData('E', 'G',  8), 
				new EData('F', 'G',  9), 
		};
		PrimeList pG;

		// 采用已有的"图"
		pG = new PrimeList(vexs, edges);

		
		pG.prim(0);   // prim算法生成最小生成树
	}

}
