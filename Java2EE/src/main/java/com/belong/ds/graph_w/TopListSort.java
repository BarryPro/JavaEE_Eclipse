package com.belong.ds.graph_w;
/**
 * Java: 无回路有向图(Directed Acyclic Graph)的拓扑排序
 *       该DAG图是通过邻接表实现的。   *
 * @author belong
 * @date 2015/12/20
 */     
import java.util.List;
import java.util.ArrayList;
import java.util.Queue;
import java.util.LinkedList;
public class TopListSort {
	 // 邻接表中表对应的链表的顶点
    private class ENode {
        int itop;       // 该边所指向的顶点的位置
        ENode next; // 指向下一条弧的指针
    }

    // 邻接表中表的顶点
    private class VNode {
        char data;          // 顶点信息
        ENode firstEdge;    // 指向第一条依附该顶点的弧
    }

    private List<VNode> mVexs;  // 顶点数组
    /*
     * 创建图(用已提供的矩阵)
     *
     * 参数说明：
     *     vexs  -- 顶点数组
     *     edges -- 边数组
     */
    public TopListSort(char[] vexs, char[][] edges) {//做成邻接表
        
        // 初始化"顶点数"和"边数"
        int vlen = vexs.length;//顶点数
        int elen = edges.length;//边数

        // 初始化"顶点"
        mVexs = new ArrayList<VNode>();
        for (int i = 0; i < vlen; i++) {
            // 新建VNode
            VNode vnode = new VNode();// 邻接表中表的顶点
            vnode.data = vexs[i];
            vnode.firstEdge = null;//初始化顶点时，都没有指向该顶点的弧
            // 将vnode添加到数组mVexs中
            mVexs.add(vnode);
        }
        // 初始化"边"
        for (int i = 0; i < elen; i++) {//elem:边数
            // 读取边的起始顶点和结束顶点
            char c1 = edges[i][0];
            char c2 = edges[i][1];
            // 读取边的起始顶点和结束顶点
            int p1 = getPosition(c1);//返回起始顶点在顶点数组中的位置
            int p2 = getPosition(c2);//返回结束顶点在顶点数组中的位置

            // 初始化node1
            ENode node1 = new ENode();
            node1.itop = p2;//itop：顶点位置
            // 将node1链接到"p1所在链表的末尾"
            if(mVexs.get(p1).firstEdge == null){
                mVexs.get(p1).firstEdge = node1;
            }else{//将node节点链接到list的最后
                linkLast(mVexs.get(p1).firstEdge, node1);
            }
        }
    }

    /*
     * 将node节点链接到list的最后
     */
    private void linkLast(ENode list, ENode node) {
        ENode p = list;

        while(p.next!=null){
            p = p.next;
        }
        p.next = node;
    }

    /*
     * 返回ch在顶点数组中的位置
     */
    private int getPosition(char ch) {
        for(int i=0; i<mVexs.size(); i++){
            if(mVexs.get(i).data==ch){
                return i;
            }
        }
        return -1;
    }
    /*
     * 打印矩阵队列图
     */
    public void print() {
        System.out.printf("== List Graph:\n");
        for (int i = 0; i < mVexs.size(); i++) {
            System.out.printf("%d(%c): ", i, mVexs.get(i).data);
            ENode node = mVexs.get(i).firstEdge;
            while (node != null) {
                System.out.printf("%d(%c) ", node.itop, mVexs.get(node.itop).data);
                node = node.next;
            }
            System.out.printf("\n");
        }
    }

    /*
     * 拓扑排序
     *
     * 返回值：
     *     -1 -- 失败(由于内存不足等原因导致)
     *      0 -- 成功排序，并输入结果
     *      1 -- 失败(该有向图是有环的)
     */
    public int topologicalSort() {
        int index = 0;
        int num = mVexs.size();//顶点数组的个数

        int[] in   = new int[num];//// 入度数组
        char[] results  = new char[num];// 拓扑排序结果数组，记录每个节点的排序后的序号。
        Queue<Integer> queue = new LinkedList<Integer>();// 辅助队列

        // 统计每个顶点的入度数
        for(int i = 0; i < num; i++) {
            ENode node = mVexs.get(i).firstEdge;
            while (node != null) {
                in[node.itop]++;
                node = node.next;
            }
        }

        // 将所有入度为0的顶点入队列,
        for(int i = 0; i < num; i ++){
            if(in[i] == 0){
                queue.offer(i);                 // 入队列
            }
        }

        while (!queue.isEmpty()) {              // 队列非空
            int j = queue.poll().intValue();    // 出队列。j是顶点的序号
            results[index++] = mVexs.get(j).data;  // 将该顶点添加到results中，results是排序结果
            ENode node = mVexs.get(j).firstEdge;// 获取以该顶点为起点的出边队列

            // 将与"node"关联的节点的入度减1；
            // 若减1之后，该节点的入度为0；则将该节点添加到队列中。
            while(node != null) {
                // 将节点(序号为node.ivex)的入度减1。
                in[node.itop]--;
                // 若节点的入度为0，则将其"入队列"
                if(in[node.itop] == 0){
                    queue.offer(node.itop);    // 入队列
                }

                node = node.next;
            }
        }

        if(index != num) {
            System.out.printf("图是个环！\n");
            return 1;
        }

        // 打印拓扑排序结果
        System.out.printf("== TopSort: ");
        for(int i = 0; i < num; i ++){
            System.out.printf("%c ", results[i]);
        }
        System.out.printf("\n");

        return 0;
    }

    public static void main(String[] args) {
        char[] vexs = {'A', 'B', 'C', 'D', 'E', 'F', 'G'};//顶点数组
        char[][] edges = new char[][]{//边数组，例如A->G B->A等
            {'A', 'G'}, 
            {'B', 'A'}, 
            {'B', 'D'}, 
            {'C', 'F'}, 
            {'C', 'G'}, 
            {'D', 'E'}, 
            {'D', 'F'}}; 
        

        // 自定义"图"(输入矩阵队列)
        //pG = new ListDG();
        // 采用已有的"图"
        TopListSort pG = new TopListSort(vexs, edges);

        pG.print();   // 打印图
        
        pG.topologicalSort();     // 拓扑排序
    }
}
