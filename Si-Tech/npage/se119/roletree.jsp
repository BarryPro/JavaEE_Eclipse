   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
	String loginNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
		
	String dataJsp = "roleTreeXml.jsp?isRoot=true";
	
	String grouptype = request.getParameter("formFlag")==null?"form1":request.getParameter("formFlag");
	
	System.out.println("roletree.jsp");
	
	//查看是否有根节点,有的话进入树,无的话关闭窗口 add by hanfa 20070627
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
	
	String	strSql = "select a.power_code, a.power_name, b.ROLETYPE_NAME,a.POWER_DESCRIBE ,a.USE_FLAG,trim(a.OP_NOTE),a.CREATE_LOGIN,a.CREATE_DATE,c.login_Name,e.group_name "+
                     " from sPowerCode a, sRoleTypeCode b,dLoginMsg c ,dchngroupmsg e"+    
                     " where c.login_no='"+loginNo+"'"+
                     "   and c.group_id=e.group_id "+
                     "   and a.roletype_code=b.roletype_code"+
                     "   and a.power_code=(select min(d.power_code) from dpowerobjrelation d where Trim(d.object_id) = Trim(c.group_id))";
	//acceptList = callView.sPubSelect("10",strSql,"region",regionCode);
%>

	<wtc:pubselect name="sPubSelect" outnum="10" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	<wtc:sql><%=strSql%></wtc:sql>
 	    </wtc:pubselect>
	<wtc:array id="result_t3" scope="end"/>

<%	
	String errCode= code3;
	String errMsg= msg3;
	
	if(!errCode.equals("000000"))
	{
%>
		<script language='jscript'>
	       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	       window.close();
       </script> 

<%	
	} else {
		String[][] rootList = result_t3;
		
		if (rootList == null || rootList.length==0)
		{
			System.out.println("rootList.length = " + rootList.length);
%>
			<script language='jscript'>
		       rdShowMessageDialog("该组织结构下未发布任何角色！",0);
		       window.close();
           </script> 
<%	
		}
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>角色结构树</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: 宋体; font-size: 13px; }
</style>
<script language="JavaScript"> 
var treenode1;
//-----返回组织节点-------	
function saveTo(retRoleId,retRoleName,retRoleTypeCode,retPowerDes,retUseFlag,retOpNote,retCreatLogin,retCreatDate,retCreatName,retCreatGroup)
{
	window.opener.<%=grouptype%>.roleCode.value=retRoleId;
	window.opener.<%=grouptype%>.roleName.value=retRoleName;
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
	</div>
	<%-- added by hanfa 20061113 --%>
	
	<table  cellspacing="0" border="0" >
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