   
<%
/********************
 version v2.0
 开发商 si-tech
 update anln@2009-2-19
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String loginNo = (String)session.getAttribute("workNo");
	String powerCode=  (String)session.getAttribute("powerCode");
	String regionCode = (String)session.getAttribute("regCode");
	String dataJsp = "roleTreeXml.jsp?isRoot=true";
	
	String grouptype = request.getParameter("formFlag")==null?"form1":request.getParameter("formFlag");
	
	System.out.println("roletree.jsp");

	//查看是否有根节点,有的话进入树,无的话关闭窗口 add by hanfa 20070627
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
	
	String	strSql = "select a.power_code, a.power_name, b.ROLETYPE_NAME,a.POWER_DESCRIBE "+
                     " from sPowerCode a, sRoleTypeCode b,dLoginMsg c "+    
                     " where c.login_no='"+loginNo+"'"+
                     "   and a.roletype_code=b.roletype_code"+
                     "   and a.power_code=(select min(d.power_code) from dpowerobjrelation d where Trim(d.object_id) = Trim(c.group_id))";
	//acceptList = callView.sPubSelect("4",strSql,"region",regionCode);
	%>
	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
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
%>
			<script language='jscript'>
		       rdShowMessageDialog("该组织结构下未发布任何角色！");
		       window.close();

           </script> 
<%	
		}
	}
%>


<html>
<head>
<title>角色结构树</title>
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
	window.opener.<%=grouptype%>.role_code.value=retRoleId;     //将信息返回到调用的页面去
	window.opener.<%=grouptype%>.role_name.value=retRoleName;	
  	window.close();
}
</SCRIPT>
</head>
<body>
<form name="frm" method="post" action="">
    <%-- modified by hanfa 20061113 --%>	    
	<div id="POP_Title_block">
		<table cellspacing="0">
			<tr>
				<td width="40%" align="left" class="shadow"><span id="titlename">
					<script language="javascript">document.write(document.title);</script></span></td>
				<td width="60%" align="right" class="shadow">&nbsp;
				</td>
			</tr>
		</table>
	</div>  
	    <%-- added by hanfa 20061113 --%>	    
		<table  cellspacing="0" >
			<tr> 
			<TD width="20" >
			</TD>							
			<td  nowrap>
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

