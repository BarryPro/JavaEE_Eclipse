<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-25 ҳ�����,�޸���ʽ
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
	
	System.out.println(">>>>>>>>"+roleCode+">>>>>>>>>"+roleName);
	
	//�鿴�Ƿ��и��ڵ�,�еĻ�������,�޵Ļ��رմ��� add by hanfa 20070627	
	String	strSql = "select a.power_code, a.power_name, b.ROLETYPE_NAME,a.POWER_DESCRIBE "+
                     " from sPowerCode a, sRoleTypeCode b,dLoginMsg c "+    
                     " where c.login_no='"+loginNo+"'"+
                     "   and a.roletype_code=b.roletype_code"+
                     "   and a.power_code=(select min(d.power_code) from dpowerobjrelation d where Trim(d.object_id) = Trim(c.group_id))";
	//acceptList = callView.sPubSelect("4",strSql,"region",regionCode);					
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=strSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
	<%
	String errCode=retCode1;	  
	String errMsg=retMsg1;
	
	if(!errCode.equals("000000"))
	{
%>
		<script language='jscript'>
			rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			window.close();
		</script> 

<%	
	}
	else
	{
		String[][] rootList = result;
		if (rootList == null || rootList.length==0)
		{
%>
			<script language='jscript'>
				rdShowMessageDialog("����֯�ṹ��δ�����κν�ɫ��");
				window.close();			
			</script> 
<%	
		}
	}
%>

<html>
<head>
<title>��ɫ�ṹ��</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
	a:link,a:visited { text-decoration: none; color: #111111 }
	font { font-family: ����; font-size: 13px; }
</style>
<script language="JavaScript"> 
var treenode1;
//-----������֯�ڵ�-------	
function saveTo(retRoleId,retRoleName,retRoleTypeName,retPowerDes)
{
	window.opener.<%=grouptype%>.<%=roleCode%>.value=retRoleId;     //����Ϣ���ص����õ�ҳ��ȥ
	window.opener.<%=grouptype%>.<%=roleName%>.value=retRoleName;
	//f8002.jspҳ����
	<%if(grouptype.equals("frm") && roleCode.equals("pdRoleCode"))
	{%> 
		window.opener.eval("javascript:chgRoleName()");
	<%}%>
	//end
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
