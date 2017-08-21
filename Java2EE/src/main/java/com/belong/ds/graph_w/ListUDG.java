package com.belong.ds.graph_w;

/**
 * Java: 邻接表表示的"无向图(List Undirected Graph)"
 *
 * @author belong
 * @date 2015/12/16
 */
public class ListUDG {
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
    public ListUDG(String[] vexs, String[][] edges) {        
        // 初始化"顶点数"和"边数"
        int vlen = vexs.length;//顶点数
        int elen = edges.length;//边数
        // 初始化"顶点"
        top = new VNode[vlen];
        for (int i = 0; i <vlen; i++) {
        	top[i] = new VNode();
        	top[i].data = vexs[i];//初始化数据，顶点给data
        	top[i].firstEdge = null;//并没有指向第一条依附该顶点的弧
        }
        // 初始化"边"
        for (int i = 0; i < elen; i++) {            
            // 读取边的起始顶点和结束顶点
            int p1 = getPosition(edges[i][0]);//起始顶点
            int p2 = getPosition(edges[i][1]);//结束顶点
            // 初始化node1
            ENode node1 = new ENode();
            node1.tp = p2;//该边指向顶点的位置
            
            // 将node1链接到"p1所在链表的末尾"，形成链表
            if(top[p1].firstEdge == null){
            	top[p1].firstEdge = node1;
            }else{
                linkLast(top[p1].firstEdge, node1);
            }
            // 初始化node2
            ENode node2 = new ENode();
            node2.tp = p1;
            // 将node2链接到"p2所在链表的末尾"
            if(top[p2].firstEdge == null){
            	top[p2].firstEdge = node2;
            } else{
                linkLast(top[p2].firstEdge, node2);
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
        for(int i=0; i<top.length; i++){//mVexs:顶点数组
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
            {"V0", "V1"}, 
            {"V0", "V2"}, 
            {"V0", "V3"},            
            {"V1", "V2"},           
            {"V3", "V2"}            
        };
        // 自定义"图"(输入矩阵队列)
        //pG = new ListUDG();
        // 采用已有的"图"
        ListUDG pG = new ListUDG(vexs, edges);

        pG.print();   // 打印图
    }
}
