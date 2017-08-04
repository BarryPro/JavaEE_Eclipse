<%!
	/*
	*根据父节点路由生成前部图片，主要是决定生成black.jpg或I.jpg
	*路由的根式为用逗号分个的0、1字符串，每一位表示从根节点起的每一个先祖节点,此信息记录在页面span的lastChildRoute属性中
	*分别代表了该节点的先祖的位置信息，0：代表为其父节点的最后一个，根节点的信息为0
	*/
  public String parentLine(String lastChildRoute,String node_id){
		if(lastChildRoute==null||lastChildRoute.equals("")){
		  	return "";
		}
		StringBuffer res_ = new StringBuffer();
		String[] pars = lastChildRoute.split(",");
		for(int i=0;i<pars.length-1;i++){
		  res_.append("<img src=/npage/callbosspage/k170/tree/images/");
			if(pars[i].equals("1")){				
	  		res_.append("white.gif");					
			}
			if(pars[i].equals("0")){
				res_.append("I.gif");	
			}
			if(i==0){
				res_.append(" id= 'img"+node_id+"f' ");
			}
			res_.append(" align=absmiddle border='0'>");
  	}
  	return res_.toString();
	}
	//根据节点综合信息生成该节点的文件html
	public StringBuffer getNodeHtml(StringBuffer res_,String[] node,String nodeLevel,String isLast,String lastChildRoute,String gobal_check_str,String hasSelectOption,boolean flag){
			String node_id = node[0];
			String par_id = node[1];
			String node_name = node[2];
			String is_Leaf = node[3];
			String fullname = node[4];
			
			
			//拼接返回字符串的buffer
			//StringBuffer res_ = new StringBuffer();
			
			//拼接由父节点位置决定的前部图片html
	    res_.append("<span><nobr>"+parentLine(lastChildRoute,node_id));
	    
	    //节点第一个图片内容
	    String img_plus_src="";  
	    //节点第二个图片内容
	    String is_leaf_img="";
	    //节点第一个图片点击事件
     	String is_img1_onclick=" onclick=\\\"img1Click('"+node_id+"');return false;\\\" ";
     	//节点第二个图片点击事件
     	String is_img2_onclick=" onclick=\\\"img2Click('"+node_id+"');return false;\\\" ";
     	//节点span点击事件
     	String is_span_onclick=" onclick=\\\"spanClick('"+node_id+"');return false;\\\" ";
     	//节点span双击事件
     	String is_span_ondblclick=" ondblclick=\\\"spandblClick('"+node_id+"');return false;\\\" ";
     	if(is_Leaf.equals("1")){
     			is_span_ondblclick="";
     	}
     	//checkbox内容
      String is_checkbox="";
      //是否已选
      String is_checked="";
      //checkbox选择事件
      String is_leaf_check_onclick=" onclick=\\\"checkBoxClick('"+node_id+"');\\\" ";
	    
	    //获取节点第一个图片内容
      if(is_Leaf.equals("0")){
      	if(isLast.equals("0")){ 
        	img_plus_src="/npage/callbosspage/k170/tree/images/Tplus.gif";
        }
        if(isLast.equals("1")){ 
        	img_plus_src="/npage/callbosspage/k170/tree/images/Lplus.gif";
        }
      }else if(isLast.equals("1")){
        img_plus_src="/npage/callbosspage/k170/tree/images/L.gif";
      }else{
       	img_plus_src="/npage/callbosspage/k170/tree/images/T.gif";
      }
      
      	

     	//判断是否为叶结点，如果是叶子节点，变成叶节点的图标，onclick事件没有
     	
     	//获取是否已选
     	if(gobal_check_str==null){
     		gobal_check_str = "";
     	}
     	String[]  gobalstr = gobal_check_str.split(",");
     	for(int i=0;i<gobalstr.length;i++){
     		if(node_id.equals(gobalstr[i])){
     		 	is_checked=" checked ";
     		 	break;
     		}
     	}
     	
     	if(is_Leaf.equals("0")){
     	   //不是叶子
       	 is_leaf_img="/npage/callbosspage/k170/tree/images/foldericon.gif";

      }else{
     	   is_leaf_img="/npage/callbosspage/k170/tree/images/icon-page.gif";
         if("1".equals(hasSelectOption)){
     	   	 is_checkbox="<input type='checkbox' "+is_checked+is_leaf_check_onclick+" value='"+node_id+"' id ='chk"+node_id+"'>";
     	   }
      }      
      res_.append("<IMG style='cursor:hand' "+is_img1_onclick+" src='"+img_plus_src+"'  align='absMiddle' border=0 name='m"+node_id+"Tree'>");
      res_.append("<IMG style='cursor:hand' "+is_img2_onclick+" src='"+is_leaf_img+"' align='absMiddle' border=0 name='m"+node_id+"Folder'>");
      res_.append(is_checkbox);   
      res_.append("<span  class='item' style='cursor:hand' "+is_span_onclick+is_span_ondblclick+" id='m"+node_id+"span' ");
      res_.append(" nodeLevel='"+nodeLevel+"' lastChildRoute='"+lastChildRoute+"' is_Leaf='"+is_Leaf+"' isLast='"+isLast+"' isOpen='0' hasLoad='0' fullName='"+fullname+"' ");
      res_.append(">"+node_name);
      if(flag){
      	res_.append("["+fullname+"]");
      }
      res_.append("</span></nobr></span>");
      res_.append("<BR>"); 
      //如果非叶子节点则生成其子节点的div容器
      if(is_Leaf.equals("0")){
      	res_.append("<DIV traceName='"+node_name+"->' class=child  id='m"+node_id+"Child' ></DIV>");
      }
      return res_;
	}
	//生成预先打开的树
	public int getNodeHtml_cur(StringBuffer res_,String[][] nodes,int cur,String nodeLevel,String lastChildRoute_,String gobal_check_str,String hasSelectOption,boolean flag){
	    String[] node = nodes[cur] ;
	    String node_id = node[0];
			String par_id = node[1];
			String node_name = node[2];
			String is_Leaf = node[3];
			String fullname = node[4];
	    String[] node_next = null ;
	    int nextcur = cur+1;
	    boolean hasNext = false;
	    if(nodes.length>nextcur){	
	    		hasNext = true;
	    		node_next = nodes[nextcur];
	    }
	    String isOpen = "0";
	    if(is_Leaf.equals("0")&&hasNext){	
	        if(node_next[0].length()==node[0].length()+3&&node_next[0].indexOf(node[0])==0){ /*modify wangyongjl 20090818 将原有2长度修改为3*/
	    				isOpen = "1";
	    		}
	    }
	    String isLast = "1";
	    for(int i = cur+1;i<nodes.length;i++){
	    	 if(nodes[i][0].length()==nodes[cur][0].length()){
	    	    isLast = "0";
	    	 		break;
	    	 }
	    	 else if(nodes[i][0].length()<nodes[cur][0].length()){
	    	 	  break;
	    	 }
	    }
	    String lastChildRoute = (lastChildRoute_.equals("")?lastChildRoute_:(lastChildRoute_+","))+isLast;
	    
			
			
			
			//拼接返回字符串的buffer
			//StringBuffer res_ = new StringBuffer();
			
			//拼接由父节点位置决定的前部图片html
	    res_.append("<span><nobr>"+parentLine(lastChildRoute,node_id));
	    
	    //节点第一个图片内容
	    String img_plus_src="";  
	    //节点第二个图片内容
	    String is_leaf_img="";
	    //节点第一个图片点击事件
     	String is_img1_onclick=" onclick=\\\"img1Click('"+node_id+"');return false;\\\" ";
     	//节点第二个图片点击事件
     	String is_img2_onclick=" onclick=\\\"img2Click('"+node_id+"');return false;\\\" ";
     	//节点span点击事件
     	String is_span_onclick=" onclick=\\\"spanClick('"+node_id+"');return false;\\\" ";
     	//节点span双击事件
     	String is_span_ondblclick=" ondblclick=\\\"spandblClick('"+node_id+"');return false;\\\" ";
     	if(is_Leaf.equals("1")){
     			is_span_ondblclick="";
     	}
     	//checkbox内容
      String is_checkbox="";
      //是否已选
      String is_checked="";
      //checkbox选择事件
      String is_leaf_check_onclick=" onclick=\\\"checkBoxClick('"+node_id+"');\\\" ";
	    
	    //获取节点第一个图片内容
      if(is_Leaf.equals("0")){
      	if(isLast.equals("0")){ 
      		if(isOpen.equals("1")){
        		img_plus_src="/npage/callbosspage/k170/tree/images/Tminus.gif";
        	}else{
        		img_plus_src="/npage/callbosspage/k170/tree/images/Tplus.gif";
        	}
        }
        if(isLast.equals("1")){ 
          if(isOpen.equals("1")){
        		img_plus_src="/npage/callbosspage/k170/tree/images/Lminus.gif";
        	}else{
        		img_plus_src="/npage/callbosspage/k170/tree/images/Lplus.gif";
        	}
        }
      }else if(isLast.equals("1")){
        img_plus_src="/npage/callbosspage/k170/tree/images/L.gif";
      }else{
       	img_plus_src="/npage/callbosspage/k170/tree/images/T.gif";
      }
      
      	

     	//判断是否为叶结点，如果是叶子节点，变成叶节点的图标，onclick事件没有
     	
     	//获取是否已选
     	if(gobal_check_str==null){
     		gobal_check_str = "";
     	}
     	String[]  gobalstr = gobal_check_str.split(",");
     	for(int i=0;i<gobalstr.length;i++){
     		if(node_id.equals(gobalstr[i])){
     		 	is_checked=" checked ";
     		 	break;
     		}
     	}
     	
     	if(is_Leaf.equals("0")){
     	   //不是叶子
				 if(isOpen.equals("1")){
        		is_leaf_img="/npage/callbosspage/k170/tree/images/openfoldericon.gif";
        	}else{
        		is_leaf_img="/npage/callbosspage/k170/tree/images/foldericon.gif";
        	}
      }else{
     	   is_leaf_img="/npage/callbosspage/k170/tree/images/icon-page.gif";
         if("1".equals(hasSelectOption)){
     	   	 is_checkbox="<input type='checkbox' "+is_checked+is_leaf_check_onclick+" value='"+node_id+"' id ='chk"+node_id+"'>";
     	   }
      }      
      res_.append("<IMG style='cursor:hand' "+is_img1_onclick+" src='"+img_plus_src+"'  align='absMiddle' border=0 name='m"+node_id+"Tree'>");
      res_.append("<IMG style='cursor:hand' "+is_img2_onclick+" src='"+is_leaf_img+"' align='absMiddle' border=0 name='m"+node_id+"Folder'>");
      res_.append(is_checkbox);   
      res_.append("<span class='item' style='cursor:hand' "+is_span_onclick+is_span_ondblclick+" id='m"+node_id+"span' ");
      res_.append(" nodeLevel='"+nodeLevel+"' lastChildRoute='"+lastChildRoute+"' is_Leaf='"+is_Leaf+"' isLast='"+isLast+"' isOpen='"+isOpen+"' hasLoad='"+isOpen+"' fullName='"+fullname+"' ");
      res_.append(">"+node_name);
      if(flag){
      	res_.append("["+fullname+"]");
      }
      res_.append("</span></nobr></span>");
      res_.append("<BR>"); 
      //如果非叶子节点则生成其子节点的div容器
      if(is_Leaf.equals("0")){
      	res_.append("<DIV traceName='"+node_name+"->' class="+(isOpen.equals("0")?"child":"child_show")+"  id='m"+node_id+"Child' >");
      }
      
      while(isOpen.equals("1")){		
      	nextcur = getNodeHtml_cur(res_,nodes,nextcur,nodeLevel+1,lastChildRoute,gobal_check_str,hasSelectOption,flag);
      	isOpen = "0";
      	hasNext = false;
	    	if(nodes.length>nextcur){	
	    		hasNext = true;
	    		node_next = nodes[nextcur];
	    	}
	      if(is_Leaf.equals("0")&&hasNext){	
	        if(node_next[0].length()==node[0].length()+3&&node_next[0].indexOf(node[0])==0){ /*modify wangyongjl 20090818 将原有2长度修改为3*/
	    				isOpen = "1";
	    		}
	      } 
      }
      if(is_Leaf.equals("0")){
      	res_.append("</DIV>");
      }
      return nextcur;
	}
%>