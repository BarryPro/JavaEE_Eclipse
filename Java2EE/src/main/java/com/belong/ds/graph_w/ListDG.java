package com.belong.ds.graph_w;

/**
 * Java: 邻接矩阵图
 *
 * @author belong
 * @date 2015/12/16
 */


public class ListDG {
    // 邻接表中表对应的链表的顶点
    private class ENode {
        int tp;       // 该边所指向的顶点的位置
        ENode nextEdge; // 指向下一条弧的指针
    }

    // 邻接表中表的顶点
    private class VNode {
        String data;          // 顶点信息
        ENode firstEdge;    // 指向第一条依附该顶点的弧
    }

    private VNode[] top;  // 顶点数组


   
    /*
     * 创建图(用已提供的矩阵)
     *
     * 参数说明：
     *     vexs  -- 顶点数组
     *     edges -- 边数组
     */
    public ListDG(String[] vexs, String[][] edges) {
        
        // 初始化"顶点数"和"边数"
        int vlen = vexs.length;
        int elen = edges.length;

        // 初始化"顶点"
        top = new VNode[vlen];
        for (int i = 0; i < vlen; i++) {
        	top[i] = new VNode();
        	top[i].data = vexs[i];
        	top[i].firstEdge = null;
        }

        // 初始化"边"
        for (int i = 0; i < elen; i++) {
            // 读取边的起始顶点和结束顶点
            int p1 = getPosition(edges[i][0]);
            int p2 = getPosition(edges[i][1]);

            // 初始化node1,有向图关键，它是有方向性的，p2在p1的后面，也就是[0])的位置放的是起始端，[1]是尾端，
            ENode node1 = new ENode();
            node1.tp = p2;
            // 将node1链接到"p1所在链表的末尾"
            if(top[p1].firstEdge == null){
            	top[p1].firstEdge = node1;
            }else{
                linkLast(top[p1].firstEdge, node1);
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
    private int getPosition(String ch) {
        for(int i=0; i<top.length; i++){
            if(top[i].data.equals(ch)){
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
        for (int i = 0; i < top.length; i++) {
            System.out.printf("%d(%s): ", i, top[i].data);
            ENode node = top[i].firstEdge;
            while (node != null) {
                System.out.printf("%d(%s) ", node.tp, top[node.tp].data);
                node = node.nextEdge;
            }
            System.out.printf("\n");
        }
    }

    public static void main(String[] args) {
    	String[] vexs = {"V0", "V1", "V2", "V3"};
        String[][] edges = new String[][]{//无向图，全部表示节点之间的关系即可
            {"V0", "V3"}, 
            {"V1", "V0"}, 
            {"V1", "V2"},            
            {"V2", "V0"},           
            {"V2", "V1"}            
        };
        ListDG pG;

        // 自定义"图"(输入矩阵队列)
        //pG = new ListDG();
        // 采用已有的"图"
        pG = new ListDG(vexs, edges);

        pG.print();   // 打印图
    }
}
