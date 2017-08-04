<%
   /*
   * 功能: 功能代码树。
　 * 版本: v1.0
　 * 日期: 2007/03/31
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
 　*/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String loginNo = baseInfoSession[0][2];
	String loginName = baseInfoSession[0][3];
	String powerCode= otherInfoSession[0][4];
	String orgCode = baseInfoSession[0][16];
	String ip_Addr = request.getRemoteAddr();
	String regionCode = orgCode.substring(0,2);
	String regionName = otherInfoSession[0][5];
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
		
	String grouptype = request.getParameter("grouptype")==null?"form1":request.getParameter("grouptype");
	
	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色名称
	String dataJsp = "funcTreeXml.jsp?isRoot=true&roleCode="+roleCode;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>[<%=loginNo%>]功能树</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="xtreeFunc/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtreeFunc/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: 宋体; font-size: 13px; }
</style>
<script language="JavaScript"> 
var treenode1;
//-----返回组织节点-------	
function saveTo(retPopeDomCode,retPopeDomName)
{
	parent.rightFrame.location="funclist.jsp?popeDomCode="+retPopeDomCode+"&popeDomName="+retPopeDomName+"&roleCode="+"<%=roleCode%>"+"&roleName="+"<%=roleName%>";
}

</SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name="frm" method="post" action="">
		<div id="POP_Title_block">
			<table width="98%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="40%" align="left" class="shadow"><span id="titlename"><script language="javascript">document.write(document.title);</script></span></td>
					<td width="60%" align="right" class="shadow">&nbsp;</td>
				</tr>
			</table>
		</div> 
	    
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
	</form>
</body>
</html>