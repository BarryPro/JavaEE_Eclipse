<%!
	/*
	*���ݸ��ڵ�·������ǰ��ͼƬ����Ҫ�Ǿ�������black.jpg��I.jpg
	*·�ɵĸ�ʽΪ�ö��ŷָ���0��1�ַ�����ÿһλ��ʾ�Ӹ��ڵ����ÿһ������ڵ�,����Ϣ��¼��ҳ��span��lastChildRoute������
	*�ֱ�����˸ýڵ�������λ����Ϣ��0������Ϊ�丸�ڵ�����һ�������ڵ����ϢΪ0
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
	//���ݽڵ��ۺ���Ϣ���ɸýڵ���ļ�html
	public StringBuffer getNodeHtml(StringBuffer res_,String[] node,String nodeLevel,String isLast,String lastChildRoute,String hasSelectOption,String isRoot,String gobal_check_str){
			String node_id = node[0];
			String par_id = node[1];
			String node_name = node[2];
			String is_Leaf = node[3];
			String typeid = node[4];
			String ttansfercode = node[5];
			String digitcode = node[6];
			String usertype = node[8];
			
			
			//ƴ�ӷ����ַ�����buffer
			//StringBuffer res_ = new StringBuffer();
			
			//ƴ���ɸ��ڵ�λ�þ�����ǰ��ͼƬhtml
	    res_.append("<span><nobr>"+parentLine(lastChildRoute));
	    
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
      
      String[]  gobalstr = gobal_check_str.split(",");
     	for(int i=0;i<gobalstr.length;i++){
     		if(node_id.equals(gobalstr[i])){
     		 	is_checked=" checked ";
     		 	break;
     		}
     	}	

     	//�ж��Ƿ�ΪҶ��㣬�����Ҷ�ӽڵ㣬���Ҷ�ڵ��ͼ�꣬onclick�¼�û��
     	
     	
     	if(is_Leaf.equals("0")){
     	   //����Ҷ��
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
      //�����Ҷ�ӽڵ����������ӽڵ��div����
      if(is_Leaf.equals("0")){
      	res_.append("<DIV traceName='"+node_name+"->' class=child  id='m"+node_id+"Child' ></DIV>");
      }
      return res_;
	}
%>