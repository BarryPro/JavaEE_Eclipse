<%!
	/*
	*���ݸ��ڵ�·������ǰ��ͼƬ����Ҫ�Ǿ�������black.jpg��I.jpg
	*·�ɵĸ�ʽΪ�ö��ŷָ���0��1�ַ�����ÿһλ��ʾ�Ӹ��ڵ����ÿһ������ڵ�,����Ϣ��¼��ҳ��span��lastChildRoute������
	*�ֱ�����˸ýڵ�������λ����Ϣ��0������Ϊ�丸�ڵ�����һ�������ڵ����ϢΪ0
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
	//���ݽڵ��ۺ���Ϣ���ɸýڵ���ļ�html
	public StringBuffer getNodeHtml(StringBuffer res_,String[] node,String nodeLevel,String isLast,String lastChildRoute,String gobal_check_str,String hasSelectOption,boolean flag){
			String node_id = node[0];
			String par_id = node[1];
			String node_name = node[2];
			String is_Leaf = node[3];
			String fullname = node[4];
			
			
			//ƴ�ӷ����ַ�����buffer
			//StringBuffer res_ = new StringBuffer();
			
			//ƴ���ɸ��ڵ�λ�þ�����ǰ��ͼƬhtml
	    res_.append("<span><nobr>"+parentLine(lastChildRoute,node_id));
	    
	    //�ڵ��һ��ͼƬ����
	    String img_plus_src="";  
	    //�ڵ�ڶ���ͼƬ����
	    String is_leaf_img="";
	    //�ڵ��һ��ͼƬ����¼�
     	String is_img1_onclick=" onclick=\\\"img1Click('"+node_id+"');return false;\\\" ";
     	//�ڵ�ڶ���ͼƬ����¼�
     	String is_img2_onclick=" onclick=\\\"img2Click('"+node_id+"');return false;\\\" ";
     	//�ڵ�span����¼�
     	String is_span_onclick=" onclick=\\\"spanClick('"+node_id+"');return false;\\\" ";
     	//�ڵ�span˫���¼�
     	String is_span_ondblclick=" ondblclick=\\\"spandblClick('"+node_id+"');return false;\\\" ";
     	if(is_Leaf.equals("1")){
     			is_span_ondblclick="";
     	}
     	//checkbox����
      String is_checkbox="";
      //�Ƿ���ѡ
      String is_checked="";
      //checkboxѡ���¼�
      String is_leaf_check_onclick=" onclick=\\\"checkBoxClick('"+node_id+"');\\\" ";
	    
	    //��ȡ�ڵ��һ��ͼƬ����
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
      
      	

     	//�ж��Ƿ�ΪҶ��㣬�����Ҷ�ӽڵ㣬���Ҷ�ڵ��ͼ�꣬onclick�¼�û��
     	
     	//��ȡ�Ƿ���ѡ
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
     	   //����Ҷ��
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
      //�����Ҷ�ӽڵ����������ӽڵ��div����
      if(is_Leaf.equals("0")){
      	res_.append("<DIV traceName='"+node_name+"->' class=child  id='m"+node_id+"Child' ></DIV>");
      }
      return res_;
	}
	//����Ԥ�ȴ򿪵���
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
	        if(node_next[0].length()==node[0].length()+3&&node_next[0].indexOf(node[0])==0){ /*modify wangyongjl 20090818 ��ԭ��2�����޸�Ϊ3*/
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
	    
			
			
			
			//ƴ�ӷ����ַ�����buffer
			//StringBuffer res_ = new StringBuffer();
			
			//ƴ���ɸ��ڵ�λ�þ�����ǰ��ͼƬhtml
	    res_.append("<span><nobr>"+parentLine(lastChildRoute,node_id));
	    
	    //�ڵ��һ��ͼƬ����
	    String img_plus_src="";  
	    //�ڵ�ڶ���ͼƬ����
	    String is_leaf_img="";
	    //�ڵ��һ��ͼƬ����¼�
     	String is_img1_onclick=" onclick=\\\"img1Click('"+node_id+"');return false;\\\" ";
     	//�ڵ�ڶ���ͼƬ����¼�
     	String is_img2_onclick=" onclick=\\\"img2Click('"+node_id+"');return false;\\\" ";
     	//�ڵ�span����¼�
     	String is_span_onclick=" onclick=\\\"spanClick('"+node_id+"');return false;\\\" ";
     	//�ڵ�span˫���¼�
     	String is_span_ondblclick=" ondblclick=\\\"spandblClick('"+node_id+"');return false;\\\" ";
     	if(is_Leaf.equals("1")){
     			is_span_ondblclick="";
     	}
     	//checkbox����
      String is_checkbox="";
      //�Ƿ���ѡ
      String is_checked="";
      //checkboxѡ���¼�
      String is_leaf_check_onclick=" onclick=\\\"checkBoxClick('"+node_id+"');\\\" ";
	    
	    //��ȡ�ڵ��һ��ͼƬ����
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
      
      	

     	//�ж��Ƿ�ΪҶ��㣬�����Ҷ�ӽڵ㣬���Ҷ�ڵ��ͼ�꣬onclick�¼�û��
     	
     	//��ȡ�Ƿ���ѡ
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
     	   //����Ҷ��
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
      //�����Ҷ�ӽڵ����������ӽڵ��div����
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
	        if(node_next[0].length()==node[0].length()+3&&node_next[0].indexOf(node[0])==0){ /*modify wangyongjl 20090818 ��ԭ��2�����޸�Ϊ3*/
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