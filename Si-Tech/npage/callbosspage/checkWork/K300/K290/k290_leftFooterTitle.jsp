<%
  /**
   * ����: �ʼ�Ȩ�޹���->�����ʼ�Ȩ��->��̬���select�е���option
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<HTML>
		<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css"
			type=text/css rel=STYLESHEET>
	</HEAD>
	<BODY>
		<TABLE width="100%" height="20" cellSpacing="0" valign="center">
			<TR id="Operation_Title">
				<TD width="100%"  valign="center" align="left" >
				<select name="checkLoginNoList" id="checkLoginNoList" size=""  style="width:216px;height:30000px;"  multiple>
				</select>
				
				</TD>
			</TR>
		</TABLE>
	</BODY>
</html>
<script language=javascript>
// ��̬���select�е���option:  
 function addOption(strlist){
 	var strdata= new Array();
  	delOption('');
 	if(strlist!=null&&strlist!=''){
 	strdata=strlist;
 	//alert(strdata);	 		
 	for(var i=0;i<strdata.length;i++){
 	    document.getElementById("checkLoginNoList").options.add(new Option(strdata[i],strdata[i]));  
 	}	
 	}
 	

 }
// addOption();
 function delOption(indx){
		// ��̬ɾ��select�е�ĳһ��option��
		if(indx!=''){
			document.getElementById("checkLoginNoList").options.remove(indx); 
	  }else{
	  		 // ��̬ɾ��select�е�����options��  
      document.getElementById("checkLoginNoList").options.length=0;  
	  	}
 }	
//��ȡֵ���ı�
 function getvalue(obj){ 
         var m=obj.options[obj.selectedIndex].value 
        //��ȡvalue 
         var n=obj.options[obj.selectedIndex].text 
        //��ȡ�ı� 
  }	
	
</script>