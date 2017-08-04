package com.datastructure.graph_w;
/**
 * Java prim算法生成最小生成树(邻接表)
 *
 * @author belong
 * @date 2015/12/19
 */

public class KruskalList {

	private static int INF = Integer.MAX_VALUE;
	// 邻接表中表对应的链表的顶点
	private class ENode {
		int ivex;       /** 该边所指向的顶点的位置*/
		int weight;     // 该边的权
		ENode nextEdge; // 指向下一条弧的指针
	}
	// 邻接表中表的顶点
	private class VNode {
		char data;          // 顶点信息
		ENode firstEdge;    // 指向第一条依附该顶点的弧
	}

	private int mEdgNum;    // 边的数量
	private VNode[] tops;  // 顶点数组	
	/*
	 * 创建图(用已提供的矩阵)
	 *
	 * 参数说明：
	 *     vexs  -- 顶点数组
	 *     edges -- 边
	 */
	public KruskalList(char[] vexs, EData[] edges) {

		// 初始化"顶点数"和"边数"
		int vlen = vexs.length;
		int elen = edges.length;
		// 初始化"顶点"
		tops = new VNode[vlen];
		for (int i = 0; i < tops.length; i++) {
			tops[i] = new VNode();
			tops[i].data = vexs[i];
			tops[i].firstEdge = null;
		}
		// 初始化"边"
		mEdgNum = elen;
		//将所有的顶点和所有其邻接点连成链表
		for (int i = 0; i < elen; i++) {
			// 读取边的起始顶点和结束顶点
			char c1 = edges[i].start;
			char c2 = edges[i].end;
			int weight = edges[i].weight;

			// 读取边的起始顶点和结束顶点在tops的位置
			int p1 = getPosition(c1);
			int p2 = getPosition(c2);
			// 初始化node1
			ENode node1 = new ENode();
			node1.ivex = p2;/** 该边所指向的顶点的位置*/
			node1.weight = weight;
			// 将node1链接到"p1所在链表的末尾"
			if(tops[p1].firstEdge == null){
				tops[p1].firstEdge = node1;
			}else{
				linkLast(tops[p1].firstEdge, node1);
			}
			// 初始化node2
			ENode node2 = new ENode();
			node2.ivex = p1;
			node2.weight = weight;
			// 将node2链接到"p2所在链表的末尾"，形成链表  tops顶点数组
			if(tops[p2].firstEdge == null){
				tops[p2].firstEdge = node2;
			}else{
				linkLast(tops[p2].firstEdge, node2);
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
		for(int i=0; i<tops.length; i++){
			if(tops[i].data==ch){
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
		for (int i = 0; i < tops.length; i++) {
			System.out.printf("%d(%c): ", i, tops[i].data);
			ENode node = tops[i].firstEdge;
			while (node != null) {
				System.out.printf("%d(%c) ", node.ivex, tops[node.ivex].data);
				node = node.nextEdge;
			}
			System.out.printf("\n");
		}
	}
	/*
     * 克鲁斯卡尔（Kruskal)最小生成树
     */
    public void kruskal() {
        int index = 0;                      // rets数组的索引
        int[] vends = new int[mEdgNum];     // 用于保存"已有最小生成树"中每个顶点在该最小树中的终点。
        EData[] rets = new EData[mEdgNum];  // 结果数组，保存kruskal最小生成树的边
        EData[] edges;                      // 图对应的所有边

        // 获取"图中所有的边"
        edges = getEdges();
        // 将边按照"权"的大小进行排序(从小到大)
        sortEdges(edges, mEdgNum);

        for (int i=0; i<mEdgNum; i++) {
            int p1 = getPosition(edges[i].start);      // 获取第i条边的"起点"的序号
            int p2 = getPosition(edges[i].end);        // 获取第i条边的"终点"的序号

            int m = getEnd(vends, p1);                 // 获取p1在"已有的最小生成树"中的终点
            int n = getEnd(vends, p2);                 // 获取p2在"已有的最小生成树"中的终点
            // 如果m!=n，意味着"边i"与"已经添加到最小生成树中的顶点"没有形成环路
            if (m != n) {
                vends[m] = n;                       // 设置m在"已有的最小生成树"中的终点为n
                rets[index++] = edges[i];           // 保存结果
            }
        }

        // 统计并打印"kruskal最小生成树"的信息
        int length = 0;
        for (int i = 0; i < index; i++){
            length += rets[i].weight;
        }
        System.out.printf("Kruskal=%d: ", length);
        for (int i = 0; i < index; i++){
            System.out.printf("(%c,%c) ", rets[i].start, rets[i].end);
        }
        System.out.printf("\n");
    }

    /* 
     * 获取图中的所有边
     */
    private EData[] getEdges() {
        int index=0;
        EData[] edges;
        edges = new EData[mEdgNum];
        for (int i=0; i < tops.length; i++) {
            ENode node = tops[i].firstEdge;
            while (node != null) {
                if (node.ivex > i) {
                    edges[index++] = new EData(tops[i].data, tops[node.ivex].data, node.weight);
                }
                node = node.nextEdge;
            }
        }

        return edges;
    }

    /* 
     * 对边按照权值大小进行排序(由小到大)
     */
    private void sortEdges(EData[] edges, int elen) {

        for (int i=0; i<elen; i++) {
            for (int j=i+1; j<elen; j++) {

                if (edges[i].weight > edges[j].weight) {
                    // 交换"边i"和"边j"
                    EData tmp = edges[i];
                    edges[i] = edges[j];
                    edges[j] = tmp;
                }
            }
        }
    }

    /*
     * 获取i的终点
     */
    private int getEnd(int[] vends, int i) {
        while (vends[i] != 0)
            i = vends[i];
        return i;
    }
	// 边的结构体
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
		

		// 自定义"图"(输入矩阵队列)
		//pG = new ListUDG();
		// 采用已有的"图"
		KruskalList pG = new KruskalList(vexs, edges);
		pG.kruskal(); 
		
	}


}
