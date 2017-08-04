<%!
	/*
	*根据父节点路由生成前部图片，主要是决定生成black.jpg或I.jpg
	*路由的根式为用逗号分个的0、1字符串，每一位表示从根节点起的每一个先祖节点,此信息记录在页面span的lastChildRoute属性中
	*分别代表了该节点的先祖的位置信息，0：代表为其父节点的最后一个，根节点的信息为0
	*/
  public String parentLine(String lastChildRoute){
		if(lastChildRoute==null||lastChildRoute.equals("")){
		  	return "";
		}
		StringBuffer res_ = new StringBuffer();
		String[] pars = lastChildRoute.split(",");
		for(int i=0;i<pars.length-1;i++){
			if(pars[i].equals("1")){				
	  		res_.append("<img src=/npage/callbosspage/k170/tree/images/white.gif align=absmiddle border='0'>");					
			}
			if(pars[i].equals("0")){
				res_.append("<img src=/npage/callbosspage/k170/tree/images/I.gif align=absmiddle border='0'>");	
			}
  	}
  	return res_.toString();
	}
	//根据节点综合信息生成该节点的文件html
	public StringBuffer getNodeHtml(StringBuffer res_,String[] node,String nodeLevel,String isLast,String lastChildRoute,String hasSelectOption,String isRoot,String gobal_check_str){
			String node_id = node[0];
			String par_id = node[1];
			String node_name = node[2];
			String is_Leaf = node[3];
			String typeid = node[4];
			String ttansfercode = node[5];
			String digitcode = node[6];
			String usertype = node[8];
			
			
			//拼接返回字符串的buffer
			//StringBuffer res_ = new StringBuffer();
			
			//拼接由父节点位置决定的前部图片html
	    res_.append("<span><nobr>"+parentLine(lastChildRoute));
	    
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
      
      String[]  gobalstr = gobal_check_str.split(",");
     	for(int i=0;i<gobalstr.length;i++){
     		if(node_id.equals(gobalstr[i])){
     		 	is_checked=" checked ";
     		 	break;
     		}
     	}	

     	//判断是否为叶结点，如果是叶子节点，变成叶节点的图标，onclick事件没有
     	
     	
     	if(is_Leaf.equals("0")){
     	   //不是叶子
       	 is_leaf_img="/npage/callbosspage/k170/tree/images/foldericon.gif";

      }else{
     	   is_leaf_img="/npage/callbosspage/k170/tree/images/icon-page.gif";
      }   
      if("1".equals(hasSelectOption)&&"0".equals(isRoot)){
     	   	 is_checkbox="<input type='checkbox' "+is_checked+is_leaf_check_onclick+" value='"+node_id+"' id ='chk"+node_id+"'>";
     	   }   
      res_.append("<IMG style='cursor:hand' "+is_img1_onclick+" src='"+img_plus_src+"'  align='absMiddle' border=0 name='m"+node_id+"Tree'>");
      res_.append("<IMG style='cursor:hand' "+is_img2_onclick+" src='"+is_leaf_img+"' align='absMiddle' border=0 name='m"+node_id+"Folder'>");
      res_.append(is_checkbox);   
      res_.append("<span  class='item' style='cursor:hand' "+is_span_onclick+is_span_ondblclick+" id='m"+node_id+"span' ");
      res_.append(" nodeLevel='"+nodeLevel+"' lastChildRoute='"+lastChildRoute+"' is_Leaf='"+is_Leaf+"' isLast='"+isLast+"' isOpen='0' hasLoad='0' ");
      res_.append(" typeid='"+typeid+"' servicename='"+node_name+"' ttansfercode='"+ttansfercode+"' digitcode='"+digitcode+"' usertype='"+usertype+"' ");
      res_.append(">"+node_name);
      res_.append("</span></nobr></span>");
      res_.append("<BR>"); 
      //如果非叶子节点则生成其子节点的div容器
      if(is_Leaf.equals("0")){
      	res_.append("<DIV traceName='"+node_name+"->' class=child  id='m"+node_id+"Child' ></DIV>");
      }
      return res_;
	}
%>