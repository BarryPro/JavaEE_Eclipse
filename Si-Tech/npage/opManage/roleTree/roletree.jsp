<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>

<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String loginNo = (String)session.getAttribute("workNo");	
	String powerCode= (String)session.getAttribute("powerCode");	
	String regionCode =  (String)session.getAttribute("regCode");

		
	String dataJsp = "roleTreeXml.jsp?isRoot=true";	
	String grouptype = request.getParameter("formFlag")==null?"frm":request.getParameter("formFlag");
	System.out.println("roletree.jsp");

	String roleCode = request.getParameter("CodeType");
	String roleName = request.getParameter("NameType");
	
 %>
<html>
<head>
<title>角色结构树</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
	a:link,a:visited { text-decoration: none; color: #111111 }
	font { font-family: 宋体; font-size: 13px; }
</style>
<script language="JavaScript"> 
var treenode1;
//-----返回组织节点-------	
function saveTo(retRoleId,retRoleName,retRoleTypeName,retPowerDes)
{
	window.opener.setRolefunc(retRoleId,retRoleName,retRoleTypeName,retPowerDes);     //将信息返回到调用的页面去
	window.close();
}
</script>
</head>
<body>
<form name="frm" method="post" action="">

    <!-- modified by hanfa 20061113 -->	
    
	<div id="POP_Title_block">
		<table cellspacing="0">
			<tr>
				  <td width="40%"  class="shadow"><span id="titlename">
				  	<script language="javascript">document.write(document.title);</script></span>
				  </td>
				  <td width="60%"  class="shadow">&nbsp;
				   </td>
			</tr>
		</table>
	</div>  <%-- added by hanfa 20061113 --%>
	    
	<table  cellspacing="0">
  	<tr> 
  		<TD width="20" >
  		</TD>
		<td nowrap>
			<script>loader();</script>
				<div id="xtree"  XmlSrc="<%=dataJsp%>"></div>
				<script language="JavaScript">
				<!--
				document.all.xtree.className="xtree";
				//-->
			</script>
		</td>
		</tr>
	</table>

</body>
</html>
