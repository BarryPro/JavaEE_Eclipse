package com.belong.ds.graph_w;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class DijkstraPath {
	/*
	 * Node对象用于封装节点信息，包括名字和子节点
	 */
	public class Node {
		private String name;
		private Map<Node,Integer> child=new HashMap<Node,Integer>();
		public Node(String name){
			this.name=name;
		}
		public String getName() {
			return name;
		}
		
		public Map<Node, Integer> getChild() {
			return child;
		}
		
	}
	/*
	 * MapBuilder用于初始化数据源，返回图的起始节点
	 */
	public class MapBuilder {
		public Node build(Set<Node> open, Set<Node> close){
			Node nodeA=new Node("A");
			Node nodeB=new Node("B");
			Node nodeC=new Node("C");
			Node nodeD=new Node("D");
			Node nodeE=new Node("E");
			Node nodeF=new Node("F");
			Node nodeG=new Node("G");
			Node nodeH=new Node("H");
			nodeA.getChild().put(nodeB, 1);
			nodeA.getChild().put(nodeC, 1);
			nodeA.getChild().put(nodeD, 4);
			nodeA.getChild().put(nodeG, 5);
			nodeA.getChild().put(nodeF, 2);
			nodeB.getChild().put(nodeA, 1);
			nodeB.getChild().put(nodeF, 2);
			nodeB.getChild().put(nodeH, 4);
			nodeC.getChild().put(nodeA, 1);
			nodeC.getChild().put(nodeG, 3);
			nodeD.getChild().put(nodeA, 4);
			nodeD.getChild().put(nodeE, 1);
			nodeE.getChild().put(nodeD, 1);
			nodeE.getChild().put(nodeF, 1);
			nodeF.getChild().put(nodeE, 1);
			nodeF.getChild().put(nodeB, 2);
			nodeF.getChild().put(nodeA, 2);
			nodeG.getChild().put(nodeC, 3);
			nodeG.getChild().put(nodeA, 5);
			nodeG.getChild().put(nodeH, 1);
			nodeH.getChild().put(nodeB, 4);
			nodeH.getChild().put(nodeG, 1);
			open.add(nodeB);
			open.add(nodeC);
			open.add(nodeD);
			open.add(nodeE);
			open.add(nodeF);
			open.add(nodeG);
			open.add(nodeH);
			
			close.add(nodeA);
			return nodeA;
		}
		
		public Node build1(Set<Node> open, Set<Node> close){
			Node node0=new Node("V0");
			Node node1=new Node("V1");
			Node node2=new Node("V2");
			Node node3=new Node("V3");
			Node node4=new Node("V4");
			Node node5=new Node("V5");
			Node node6=new Node("V6");
			Node node7=new Node("V7");
			Node node8=new Node("V8");
			
			node0.getChild().put(node1, 1);//V0--V1
			node0.getChild().put(node2, 5);//V0--V2
			
			node1.getChild().put(node0, 1);
			node1.getChild().put(node2, 3);
			node1.getChild().put(node3, 7);
			node1.getChild().put(node4, 5);
			
			node2.getChild().put(node0, 5);
			node2.getChild().put(node1, 3);
			node2.getChild().put(node4, 1);
			node2.getChild().put(node5, 7);
			
			node3.getChild().put(node1, 7);
			node3.getChild().put(node4, 2);
			node3.getChild().put(node6, 3);
			
			node4.getChild().put(node1, 5);
			node4.getChild().put(node2, 1);
			node4.getChild().put(node3, 2);
			node4.getChild().put(node5, 3);
			node4.getChild().put(node6, 6);
			node4.getChild().put(node7, 9);
			
			node5.getChild().put(node2, 7);
			node5.getChild().put(node4, 3);
			node5.getChild().put(node7, 5);
			
			
			node6.getChild().put(node3, 3);
			node6.getChild().put(node4, 6);
			node6.getChild().put(node7, 2);
			node6.getChild().put(node8, 7);
			
			
			node7.getChild().put(node4, 9);
			node7.getChild().put(node6, 2);
			node7.getChild().put(node8, 4);
			
			node8.getChild().put(node6, 7);
			node8.getChild().put(node7, 4);
			////初始节点放入close 其他节点放入open
			open.add(node1);
			open.add(node2);
			open.add(node3);
			open.add(node4);
			open.add(node5);
			open.add(node6);
			open.add(node7);
			open.add(node8);
			close.add(node0);//初始节点放入close
			return node0;
			
		}
	}
	/*
	 * Dijkstra对象用于计算起始节点到所有其他节点的最短路径
	 */
	private Set<Node> open=new HashSet<Node>();//open用于存储未遍历的点
	private Set<Node> close=new HashSet<Node>();//close用来存储已遍历的节点
	private Map<String,Integer> path=new HashMap<String,Integer>();//封装路径距离
	private Map<String,String> pathInfo=new HashMap<String,String>();//封装路径信息
	public Node init(){
		//计算A到H的最短距离
		//初始路径,因没有A->E这条路径,所以path(E)设置为Integer.MAX_VALUE
		path.put("B", 1);
		pathInfo.put("B", "A->B["+1+"]=1");//键，从哪里到哪里+权值
		
		path.put("C", 1);
		pathInfo.put("C", "A->C["+1+"]=1");
		
		path.put("D", 4);
		pathInfo.put("D", "A->D["+4+"]=4");
		
		path.put("E", Integer.MAX_VALUE);		
		pathInfo.put("E", "A");
		
		path.put("F", 2);
		pathInfo.put("F", "A->F["+2+"]=2");
		
		path.put("G", 5);
		pathInfo.put("G", "A->G["+5+"]=5");
		
		path.put("H", Integer.MAX_VALUE);
		pathInfo.put("H", "A");
		//将初始节点放入close,其他节点放入open
		Node start=new MapBuilder().build(open,close);
		return start;
	}
	
	
	public Node init1(){
		//计算出V0-V8的最短距离，需要设置V0节点和所有其他所有节点的关系
		path.put("V1", 1);
		pathInfo.put("V1", "V0->V1["+1+"]=1");
		
		path.put("V2", 5);
		pathInfo.put("V2", "V0->V2["+5+"]=5");
		
		//初始路径,因没有V3->V0这条路径,所以path(E)设置为Integer.MAX_VALUE
		path.put("V3",Integer.MAX_VALUE);
		pathInfo.put("V3", "V0");
		
		path.put("V4", Integer.MAX_VALUE);
		pathInfo.put("V4", "V0");
		
		path.put("V5", Integer.MAX_VALUE);
		pathInfo.put("V5", "V0");
		
		path.put("V6", Integer.MAX_VALUE);
		pathInfo.put("V6", "V0");
		
		path.put("V7", Integer.MAX_VALUE);
		pathInfo.put("V7", "V0");
		
		
		path.put("V8", Integer.MAX_VALUE);
		pathInfo.put("V8", "V0");
		
		//将初始节点放入close,其他节点放入open
		Node start=new MapBuilder().build1(open,close);
		return start;
	}
	//计算最短路径之后把信息加入到info中
	public void computePath(Node start){
		Node nearest=getShortestPath(start);//取距离start节点最近的子节点,放入close
		if(nearest==null){
			return;
		}
		close.add(nearest);//最近的临近子节点，放入close集合，他已经遍历了
		open.remove(nearest);//已经遍历过了，就从open中去除
		System.out.print(start.getName()+"---->");
		Map<Node,Integer> childs=nearest.getChild();//最近节点的所有儿子
		
		for(Node child:childs.keySet()){
			
			if(open.contains(child)){//如果子节点在open中，说明涵盖此子节点
				System.out.print(nearest.getName()+"--->"+child.getName());
				Integer newCompute=path.get(nearest.getName())+childs.get(child);
				System.out.println("--="+newCompute);
				if(path.get(child.getName())>newCompute){//之前设置的距离大于新计算出来的距离
					path.put(child.getName(), newCompute);//用新的替换之前设置的
					//封装最新的路径信息
					pathInfo.put(child.getName(),                                   
							//最短路径到儿子的距离							
							""+newCompute);
				}
			}
		}
		System.out.println("again----------");
		computePath(start);//重复执行自己,确保和自己有关的所有从自己到子节点的距离都被遍历
		System.out.println("nearest----------");
		//执行完毕一个点例如A，之后执行离他最近的点B，依次递归
		computePath(nearest);//向外一层层递归,直至所有顶点被遍历
	}
	public void printPathInfo(){
		Set<Map.Entry<String, String>> pathInfos=pathInfo.entrySet();		
		for(Map.Entry<String, String> pathInfo:pathInfos){
			System.out.println(pathInfo.getKey()+":"+pathInfo.getValue());
		}
	}
	/**
	 * 获取与node最近的子节点
	 */
	private Node getShortestPath(Node node){
		Node res=null;
		int minDis=Integer.MAX_VALUE;
		Map<Node,Integer> childs=node.getChild();
		for(Node child:childs.keySet()){
			if(open.contains(child)){//open用于存储未遍历的点
				int distance=childs.get(child);
				if(distance<minDis){//第一次肯定执行
					minDis=distance;
					res=child;
				}
			}
		}
		return res;//返回最近的节点
	}

	public static void main(String[] args) {
		DijkstraPath test=new DijkstraPath();
		Node start=test.init();
		test.computePath(start);
		System.out.println();
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>");
		test.printPathInfo();
	}



}
