<%
   /*
   * ����: ��ʾ��֯������������ѡ�еĽ�ɫ�ڵ㷵�ص����õ�ҳ�档
   *       ���ص�ҳ������Ҫ��roleCode,roleName�����ֶ�
�� * �汾: v1.0
�� * ����: 2007/03/26
�� * ����: 
�� * ��Ȩ: sitech
   * �޸���ʷ
 ��*/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	System.out.println("===================== sb901/grouptree.jsp================");
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String dataJsp = "groupTreeXml.jsp?isRoot=true";
	System.out.println(request.getParameter("grouptype"));
	String grouptype = request.getParameter("grouptype")==null?"form1":request.getParameter("grouptype");
	String grpType = request.getParameter("grpType")==null?"0":request.getParameter("grpType");
	String grpId = request.getParameter("grpId")==null?"groupId":request.getParameter("grpId");
	String grpName = request.getParameter("grpName")==null?"groupName":request.getParameter("grpName");
	String groupId = "groupId";
	String groupName = "groupName";
	if(grpType != "0")
	{
		groupId = grpId;
		groupName = grpName;
	}
	
	System.out.println("grouptree.jsp");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>��֯������</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="../../js/xtree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
a:link,a:visited { text-decoration: none; color: #111111 }
font { font-family: ����; font-size: 13px; }
</style>
<script language="JavaScript"> 
var treenode1;
//-----������֯�ڵ�-------	
function saveTo(retGroupId,retGroupName)
{
	var retGroupId=retGroupId;
	var retGroupName=retGroupName;
	window.opener.<%=grouptype%>.<%=groupId%>.value=retGroupId;     //����Ϣ���ص����õ�ҳ��ȥ
	window.opener.<%=grouptype%>.<%=groupName%>.value=retGroupName;
	//"rpt_f1640upg"
	window.close();
}

</SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000" background="../../images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
								document.all.xtree.className="xtree";


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