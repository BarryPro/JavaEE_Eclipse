
<%
/********************
 version v2.0
 开发商 si-tech
 update haoyy@2010-8-20
********************/
%>


<%
  	String opCode = "b465";
	String opName = "地市级角色批量赋权";
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gb2312"%>
<%
	String loginNo = (String)session.getAttribute("workNo");

	String grouptype = request.getParameter("grouptype")==null?"form1":request.getParameter("grouptype");

	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色名称
	String roleTypeCode = request.getParameter("roleTypeCode");
	String roles = request.getParameter("roles");	//所有所选的角色代码

	String dataJsp = "funcTreeXml.jsp?isRoot=true&roleCode="+roleCode+"&roleTypeCode="+roleTypeCode;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>[<%=loginNo%>]权限树</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript" src="xtreeFunc/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtreeFunc/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: 宋体; font-size: 13px; }
</style>
<script language="JavaScript">
var treenode1;
//-----返回组织节点-------
function saveTo(retPopeDomCode,retPopeDomName,roleTypeCode)
{
	parent.rightFrame.location="funclist.jsp?popeDomCode="+retPopeDomCode+"&popeDomName="+retPopeDomName
		+"&roles="+"<%=roles%>"+"&roleName="+"<%=roleName%>"+"&roleTypeCode="+roleTypeCode;
}

</SCRIPT>
</head>
<body>
	<form name="frm" method="post" action="">
		<div id="POP_Title_block">
			<table width="98%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="40%" align="left" class="shadow">
						<span id="titlename">
							<script language="javascript">
								document.write(document.title);
							</script>
						</span>
					</td>
					<td width="60%" align="right" class="shadow">&nbsp;</td>
				</tr>
			</table>
		</div>

		<table  cellspacing="0">
 			<tr>
				<TD width="20" ></TD>
				<td height="300" valign="top" nowrap>
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
		<br>
		<br>
		</td>
	</tr>
</table>
</body>
</html>