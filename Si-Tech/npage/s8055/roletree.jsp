<%
   /*
   * ����: ��ʾ��ɫ�ṹ��������ѡ�еĽ�ɫ�ڵ㷵�ص����õ�ҳ�档
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
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String loginNo = baseInfoSession[0][2];
	String loginName = baseInfoSession[0][3];
	String powerCode = otherInfoSession[0][4];
	String orgCode = baseInfoSession[0][16];
	String ip_Addr = request.getRemoteAddr();
	String regionCode = orgCode.substring(0,2);
	String regionName = otherInfoSession[0][5];
	String[][] pass = (String[][])arrSession.get(4);
	String nopass  = pass[0][0]; //��½����
	String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
		
	String dataJsp = "roleTreeXml.jsp?isRoot=true";
	
	String grouptype = request.getParameter("formFlag")==null?"form1":request.getParameter("formFlag");
	
	System.out.println("roletree.jsp");	
	
	
	//�鿴�Ƿ��и��ڵ�,�еĻ�������,�޵Ļ��رմ��� add by hanfa 20070627
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	
	String	strSql = "select a.power_code, a.power_name, b.ROLETYPE_NAME,a.POWER_DESCRIBE "+
				     " from sPowerCode a, sRoleTypeCode b,dLoginMsg c "+    
				     " where c.login_no='"+loginNo+"'"+
				     "   and a.roletype_code=b.roletype_code"+
				     "   and a.power_code=(select min(d.power_code) from dpowerobjrelation d where Trim(d.object_id) = Trim(c.group_id))";
	acceptList = callView.sPubSelect("4",strSql,"region",regionCode);					
	int errCode=callView.getErrCode();		  
	String errMsg=callView.getErrMsg();
	
	if(errCode !=0)
	{
%>
		<script language='jscript'>
	       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	       window.close();
       </script> 
<%	
	} else {
		String[][] rootList = (String[][])acceptList.get(0);
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>��ɫ�ṹ��</title>
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
function saveTo(retRoleId,retRoleName,retRoleTypeName,retPowerDes)
{
	window.opener.<%=grouptype%>.power_code.value=retRoleId;     //����Ϣ���ص����õ�ҳ��ȥ
	window.opener.<%=grouptype%>.power_name.value=retRoleName;
	//window.opener.<%=grouptype%>.roleTypeName.value=retRoleTypeName;
	//window.opener.<%=grouptype%>.roleDiscribe.value=retPowerDes;
  window.close();
}
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000" background="../../images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="frm" method="post" action="">

    <%-- modified by hanfa 20061113 --%>	
    
      	<div style="background-color:#EEEEEE;border: 1px  solid #82A2B9;width: 98%;margin-top: 10px;margin-bottom: 10px;">
	      <table width="98%" border="0" cellspacing="0" cellpadding="0">
			 <tr>
	          <td width="40%" align="left" style="font-size: 12px"><span id="titlename"><script language="javascript">document.write(document.title);</script></span></td>
	          <td width="60%" align="right" style="font-size: 12px">&nbsp;
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