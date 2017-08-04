<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 String caption=request.getParameter("caption");
 String strFlag =request.getParameter("strFlag");
 String contactId =request.getParameter("contactId");
 String contactMonth =request.getParameter("contactMonth");
 String sqlStr ="";
 if(caption!=null&&!caption.equals("")){
    sqlStr="select t.callcause_id,t.caption,t.fullname,t.is_leaf from DCALLCAUSECFG t where t.caption like '%'||:vcaption||'%' and t.is_del='N' and visible='1'  order by t.callcause_id";
    myParams="vcaption="+caption;
  }
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
   <wtc:param value="<%=sqlStr%>"/>
   <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<title>无标题文档</title>

<script type="text/javascript" src="/njs/extend/prototype/prototype.js"></script>	
<!--modify wangyong 20090817 修改引入js，替换成吉林本地使用-->
<script src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>  
<script src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js" type="text/javascript"></script>
<!--script type="text/javascript" src="/njs/si/core_sitech_pack_new.js"></script-->	
<script type="text/javascript" language="javascript" src="/njs/si/base.js"></script>
<SCRIPT type="text/javascript" language=javascript src="/njs/si/ajax.js"></SCRIPT>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script language=javascript>
	var caption='<%=caption%>';
	var strFlag='<%=strFlag%>';
	var contactId='<%=contactId%>';
	var contactMonth='<%=contactMonth%>';
	
	var contact = new Array();
	var tmpArr;
  <%for(int i = 0; i < queryList.length; i++){%>
    tmpArr = new Array();
	<%for(int j = 0; j < queryList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=queryList[i][j]%>';
	<%}%>
	contact[<%=i%>] = tmpArr;
 <%}%>
	
	function doSearchNode(){
		var tempid="";
  for(var i=0;i<contact.length;i++){
   var tableid= document.getElementById("dataTable");
   var tr=tableid.insertRow();
   tr.id = contact[i][0];
   for(var j=0;j<3;j++){
      //增加表格
      if(j==1){
      	  if(contact[i][3]=='1'){
      	  	  var td = tr.insertCell();
      	  	  td.innerHTML="<div href='#' value='"+contact[i][j]+"' id='"+contact[i][0]+"' onclick='showItsPath(this.id);'>"+contact[i][j]+"(<font color=red>节点</font>)&nbsp;</a>";	
      	  }else{
      	  		var td = tr.insertCell();
      	  	  td.innerHTML="<div href='#' value='"+contact[i][j]+"' id='"+contact[i][0]+"' onclick='showItsPath(this.id);'>"+contact[i][j]+"(<font color=red>目录</font>)&nbsp;</a>";	
      	  		//td.click = showItsPath(contact[i][0]);
      	  }
      	}
      else{
      var td = tr.insertCell();
      td.innerHTML="<div href='#' value='"+contact[i][j]+"' id='"+contact[i][0]+"' onclick='showItsPath(this.id);'>"+contact[i][j]+"&nbsp;</a>";	
      //td.click = showItsPath(contact[i][0]);
      }
      
    }
    tr.onclick=function(){
	   if(this.x!="1"){
	    this.x="1";//本来打算直接用背景色判断，FF获取到的背景是RGB值，不好判断
	    
	    showItsPath(this.id);
	   }
	  }
    
    tr.onmouseover=function(){
       if(this.x!="1"){
       	var td = this.cells;
   			for(var g=0;g<td.length;g++){
   			td[g].style.backgroundColor="blue";
   		
   			}
   		 }
   	}	 
		tr.onmouseout=function(){
	   	 if(this.x!="1"){
       	var td = this.cells;
   			for(var g=0;g<td.length;g++){
   			td[g].style.backgroundColor="";
   			}
   		 }
	  }
		
    }
    
}	
window.onload = function(){
 		doSearchNode();
 	}
function showItsPath(id){
	parent.parent.document.getElementById("treeId").style.display="";
  parent.parent.document.getElementById("causeId").style.display="none";
  window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseTree_new.jsp?strId="+id+"&strFlag="+strFlag+"&contactId="+contactId+"&contactMonth="+contactMonth,"myFrame2");
}

</script>
</head>

<body>
<div id="Operation_Table">
	<table  width="100%" height="295px" border="0" cellpadding="0" cellspacing="0">
		<tr>
	  	<td valign="top">
  			<table id="dataTable" cellspacing="0">
 	 				<tr>
    				<td align="center">ID</td>   				
    				<td align="center">节点名称(类型)</td>
    				<td align="center">全路径</td>
  				</tr>
  			</table>
  		</td>
	   </tr>
	</table>	
</div>
<script>

</script>
</body>
</html>
