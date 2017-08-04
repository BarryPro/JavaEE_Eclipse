<%
 		Map map = request.getParameterMap();
		String pageTitle = request.getParameter("pageTitle");
		String pageSize = request.getParameter("pageSize");		
    String fieldName = request.getParameter("filed_name");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage") ;
		int iStartPos = (Integer.parseInt(currentPage)-1)*Integer.parseInt(pageSize);
	  int iEndPos = Integer.parseInt(currentPage)*Integer.parseInt(pageSize);
		//selType�����б����ͣ�SΪ��ѡ��MΪ��ѡ����Ϊ�б�
		if(selType.equals("S")){
			selType = "radio";    
		}
		else if(selType.equals("M")){
			selType = "checkbox";   
		}
		else
		{   
			selType = "";   
		}
		
		String[] nameList = fieldName.split("\\|");
    int colNum = nameList.length;	
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all" />
	<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
	<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
	<link href="/nresources/default/css/portalet.css" rel="stylesheet" type="text/css"></link>
	<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
	<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
	<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
	<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
	<style type="text/css">
	body
	{
		margin-left: 0px;
		padding-left: 0px;
	}
	</style>
	
	<script type=text/javascript>
		function saveTo(){
			var rIndex;        //ѡ�������
			var retValue = ""; //����ֵ
			var obj;
			var retQuence = "<%=retQuence%>";  //�����ֶ��������
			var retQuenceArray =retQuence.split("\|");
			//���ص�����¼
			var fPubSimpSels = document.getElementsByName("List");
			for(var i=0;i<fPubSimpSels.length;i++){ 
			   //�ж��Ƿ�ѡ��
			   if (fPubSimpSels[i].checked==true){
			         rIndex = fPubSimpSels[i].RIndex;
			         
			         for(n=0;n<retQuenceArray.length;n++){   
			            obj = "Rinput" + rIndex + "_" + (n);
			            retValue += document.all(obj).value + "|";
			         }
					 //parent.window.returnValue= retValue;
					 //alert(retValue);     
					 parent.parent.selectRow(retValue);
			   }
			}
			if(retValue == ""){
			    rdShowMessageDialog("��ѡ����Ϣ�",0);
			    return false;
			}
			window.close(); 
		}
		
		function allSel(obj){   
			//��ѡ��ȫ��ѡ��
			if(obj.checked == true){
				flag=true;
			}else{
				flag=false;
			}
			
		    for(i=0;i<document.fPubSimpSel.elements.length;i++){ 
		        if(document.fPubSimpSel.elements[i].type=="checkbox"){    //�ж��Ƿ��ǵ�ѡ��ѡ��
		            document.fPubSimpSel.elements[i].checked = flag;
		        }
		    }  
		}
		
		onload=function()
		{
			window.document.title="<%=pageTitle%>";
		}
</script>

<script language="javascript">
	function gotoPage(pageId)
	{
		document.form2.currentPage.value= pageId;
		document.form2.submit();
		return true;
		
	}
</script>
</head>
<body>
	
 
	<form name="fPubSimpSel">
 
	<div id="operation_table">
	<div class="list" >
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		<%
		    if(selType.equals("checkbox"))
		    { 
		  %>          
		  
		<th><input type="checkbox" name="allSelBut" onclick="allSel(this)"><span class="orange">ȫѡ</span></th>
		  <%
		    }
			else if(selType.equals("radio")){
		  %> 
		<th>&nbsp;</th>
		  <%
		    }
		  %>
		  	
		<%
		  for(int i=0;i<colNum;i++){
		%>
		    
		    <th><%=nameList[i]%></th>
		<%
		  }
		%>
		  </tr>
		  
		<%
		for(int i=0;(i<rows.length) && (i<iEndPos);i++){
     if (i < iStartPos) 
          continue;
		%>
		<tr>
		<%
		String classes;
		if(i%2==0){
		classes="grey";
		}
		else{
		classes="";
		}
		if(!selType.equals("")){
		%>
		<td align="center" class="<%=classes%>"><input type="<%=selType%>" name='List' id='List' value="<%=rows[i][0]%>" style='cursor:hand' RIndex=<%=i%> onkeydown="if(event.keyCode==13) saveTo()" onclick="saveTo()" ></td>
		<%
		}					
		for(int j=0;j<colNum;j++){
		%>		
		<td class="<%=classes%>"><%=rows[i][j]%><input type="hidden" id="Rinput<%=i%>_<%=j%>" value="<%=rows[i][j]%>" readonly></td> 
		<%		
		}
		%>
		</tr>
		<%
		}
		%>
		</table>
	</div>
</div>  <div id="operation_pagination">
	<%=PageListNav.pageNav(String.valueOf(rowsCount),pageSize,currentPage)%><a>�ܼ�<B class="orange"><%=rowsCount%></B>����¼</a></div>
	</form>
	<form name="form2" method="post">
	    
  <%=PageListNav.writeRequestString(map,currentPage)%>
	</form>
</body>
</html>