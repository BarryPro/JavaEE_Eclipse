<%
  /**
   * 功能: 质检权限管理->分配质检权限->动态添加select中的项option
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
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
// 动态添加select中的项option:  
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
		// 动态删除select中的某一项option：
		if(indx!=''){
			document.getElementById("checkLoginNoList").options.remove(indx); 
	  }else{
	  		 // 动态删除select中的所有options：  
      document.getElementById("checkLoginNoList").options.length=0;  
	  	}
 }	
//获取值或文本
 function getvalue(obj){ 
         var m=obj.options[obj.selectedIndex].value 
        //获取value 
         var n=obj.options[obj.selectedIndex].text 
        //获取文本 
  }	
	
</script>