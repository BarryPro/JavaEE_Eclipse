   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-27
********************/
%>
            
<%
  String opCode = "8054";
  String opName = "角色权限管理";
%>              

<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>


<%
	String dataJsp = "roleTreeXml.jsp?isRoot=true";
	String grouptype = request.getParameter("grouptype")==null?"form1":request.getParameter("grouptype");
	System.out.println("roletree.jsp");
 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>角色结构树</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../js/xtree.js"></script>
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: 宋体; font-size: 13px; }
</style>
<script language="JavaScript">
var treenode1;
//-----返回组织节点-------
function saveTo(retRoleId,retRoleName,retRoleTypeName,retPowerDes,roleTypeCode)
{
	window.opener.form1.roleCode.value=retRoleId;     //将信息返回到调用的页面去
	window.opener.form1.roleName.value=retRoleName;
	window.opener.setValue();
	window.close();
}

</SCRIPT>
</head>
<body>
<form name="frm" method="post" action="">

    <%-- modified by hanfa 20061113 --%>

      	<div id="POP_Title_block">
	      <table width="98%" border="0" cellspacing="0" cellpadding="0">
			 <tr>
	          <td width="40%" align="left" class="shadow"><span id="titlename"><script language="javascript">document.write(document.title);</script></span></td>
	          <td width="60%" align="right" class="shadow">&nbsp;
			  </td>
	        </tr>
	      </table>
	    </div>  <%-- added by hanfa 20061113 --%>

			<table  width="98%" align="center" bgcolor="#EEEEEE" cellspacing="1" border="0" >
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
<%System.out.println("---------------------------OK------------------reletree.jsp---------------------");%>