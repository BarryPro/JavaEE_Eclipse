<%

/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/

%>

<%@ page contentType= "text/html;charset=gb2312" %>

<%@ page import="com.sitech.boss.RoleManage.ejb.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="java.util.ArrayList"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<base target="_self">
<html>
</head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<body bgcolor="#649ECC" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
	String password = (String)session.getAttribute("password");
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String form = request.getParameter("form");

	String giftclasscode = "";
	String groupIdSql = "select gift_class_code, father_code, gift_class_name, is_leafage, login_no, op_time, op_note from smarkgiftclass start with gift_class_code = '1000' connect by prior gift_class_code=father_code";
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList retArray = new ArrayList();
	retArray = callView.sPubSelect("7",groupIdSql);
	String[][] rows = (String[][])retArray.get(0);
%>

<%
	if(rows[0][0]!=null&&!rows[0][0].equals("")){
		giftclasscode = rows[0][0].trim();
	}
 
%>

<%

//生成树
	StringBuffer treeStr=new StringBuffer("");
	StringBuffer inputStr=new StringBuffer("");
	StringBuffer inpStr=new StringBuffer("");
		String root = "";
		
	      for(int i=0;i<rows.length;i++){
			   
					treeStr.append("o"  +rows[i][0]+ "=new TreeNode('"  +rows[i][0]+"','<img src=\"../../images/folderOpen.gif\" id=image"+rows[i][0]+"><a href=javascript:getGroupId(\""+rows[i][0]+"\",trimAll(\""+rows[i][2].replaceAll("\\s","")+"\"));>"+rows[i][2].replaceAll("\\s","")+"</a>')\n");
	      }	   
		  treeStr.append("o19800917.add(o"+giftclasscode+")\n");
	      for(int j = 1; j < rows.length; j++){
	         		treeStr.append("o"+rows[j][1]+".add(o"+rows[j][0]+");\n");
	      }      
%>

<head>
<script type="text/javascript" src="../../js/login/tree2.js"></script>
<script type="text/javascript" src="../../js/common/common_util.js"></script>
<link rel="stylesheet" href="../../css/jl.css" type="text/css">
<script type="text/javascript" src="../../js/rpc/src/core_c.js"></script> 
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: 宋体; font-size: 13px; }
</style>

<script language="javascript">


function getGroupId(code,name){
	<%if(form.equals("form5")){%>
		window.opener.form3.giftclass.value=code+"->"+name;
	<%}else{%>
	window.opener.<%=form%>.giftclasscode.value=code;
	window.opener.<%=form%>.giftclassname.value=name;
	<%}%>
	<%if(form.equals("form2")){%>
		window.opener.getgiftclass();
	<%}else if(form.equals("form3")){%>
		window.opener.getgiftclass1();
	<%}%>
	window.opener.chg_giftclasscode();
	window.close();
}

//截掉字符串所有空格
function trimAll(args){
  if(args.length==0)
  {
    return '';
  }
  var returnStr = '';
  var beforeStr='';
  for(var i=0;i<args.length;i++)
  {
     beforeStr=args.charAt(i);
     if(beforeStr!=' '||!beforeStr!='　')
        returnStr =returnStr+beforeStr;
  }
  return returnStr;
}
</script>
<div id=div1 >
loading...
</div>
<script language="javascript">

o19800917=new TreeNode('19800917','<img src="../../images/folderOpen.gif" id=image19800917>根节点');

<%=treeStr.toString()%>
newMenu=new TreeMenu("newMenu");
newMenu.imgFolderOpen="../../images/folderOpen.gif";
newMenu.imgFolderClose="../../images/folderClosed.gif";
newMenu.imgPlus="../../images/icon/icPlus22.gif";
newMenu.imgMinus="../../images/icon/icMinus22.gif";
newMenu.imgBlank="../../images/icon/pixel.gif";
newMenu.imgVerticalLine="../../images/icon/icVLine22.gif";
newMenu.imgCross="../../images/icon/icCross322.gif";
newMenu.imgLastCross="../../images/icon/icCross222.gif";
newMenu.load(o19800917);
newMenu.draw();
//CloseAllChildAndFather(o<%=giftclasscode%>,newMenu);
loadDiv.style.display='none';
div1.style.display="none";
bodyDiv.style.display='block';

</script>
</body>

</html>