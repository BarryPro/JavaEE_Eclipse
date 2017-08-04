<%@page contentType="text/html;charset=GBK"%>


<%

   response.setHeader("Pragma", "No-cache");   

   response.setHeader("Cache-Control", "no-cache");

   response.setHeader("Expires", "0"); 

   String vop_code = request.getParameter("op_code");

   String service_name = new String();

   int int_op_code = Integer.parseInt(vop_code.substring(1,4));

   switch(int_op_code){

   		case 240:service_name = "sK240Qry";break;

   		case 250:service_name = "sK250Qry";break;

   		case 260:service_name = "sK260Qry";break;

   		case 270:service_name = "sK270Qry";break;
   		
			//add by hucw,20100531
			case 271:service_name = "sK271Qry";break;
   }

	String op_code = request.getParameter("op_code");

%>


<html>

	<head>

		<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
		<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
		<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>

		<script language="javascript">

			var tree =null;
	
			function iniTree(){
				  //��div id = baseTree�г�ʼ��һ�������������ĸ��ڵ�IDΪ0000
					tree=new dhtmlXTreeObject("baseTree","100%","100%",'0000');
					//����ͼƬ��
					tree.setImagePath("<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
					//�����Զ������ӽڵ㣬�ô��ڵ���ʱ���Զ����Ӳ���&id=?����ҳ�����ջ�
	    		tree.setXMLAutoLoading("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K240/fK240toK270_tree_child_xml.jsp?op_code=<%=vop_code%>");
	    		//������굥���¼�
	    		tree.setOnClickHandler(onNodeClick);
	    		//���ó�ʼ�������ַ�����������ϴ򿪵�һ���ڵ�
	    		tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K240/fK240toK270_tree_child_xml.jsp?op_code=<%=vop_code%>",openFirst);

	    }
	    
	    function openFirst(){
	    	 tree._HideShow(tree._globalIdStorageFind('0'),2);
	    }
	    
	    function onNodeClick(id){
	       tree._HideShow(tree._globalIdStorageFind(id),2);
	       window.parent.frames.rightFrame.document.getElementById("tdata"+id).click();
	    }
	    //�޸�ȥ��jquery����0502
	    /*$("body").ready(function(){
					iniTree();
	     });
      */
		</script>

	</head>

	<body onload = iniTree()>

		<TABLE width="800" height="1000" >
			<TR>
				<TD vAlign=top width="800" height="100%">
					<DIV id="baseTree"></DIV>
				</TD>
			</TR>
		</TABLE>

	</body>

</html>