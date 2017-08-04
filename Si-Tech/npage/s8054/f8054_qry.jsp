   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-25
********************/
%>
              
<%
  String opCode = "8054";
  String opName = "角色权限管理";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String opLogin = baseInfoSession[0][2];
	String ip_Addr = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);
	String nopass  = pass[0][0];
	String orgCode = baseInfoSession[0][16];
	String regionCode=orgCode.substring(0,2);
%>

<%
	Logger logger   = Logger.getLogger("f8054_qry.jsp");
	String roleCode = request.getParameter("roleCode");
	String roleName = request.getParameter("roleName");
	
	System.out.println(">>>>>["+roleCode+"]");
	String strSql = "select reflect_code, popedom_name "
		+ "from sRolePdomRelation a, sPopedomCode b "
		+ "where a.popedom_code = b.popedom_code "
		+ "and a.role_code = '" + roleCode + "' "
		+ "and b.use_flag = 'Y' and b.leaf_flag = 'Y' "
		+ "order by reflect_code";
	System.out.println("++++++++"+strSql+"++++++++");
	comImpl comResult = new comImpl();
	ArrayList acceptList = comResult.spubqry32("2",strSql);
	
	/********************* 输出参数 ***********************************/
 	String[][] sFuncCode  = (String[][])acceptList.get(0);
	/******************************************************************/
	if(sFuncCode.length==0)
	{
%>
	<script language='jscript'>
		rdShowMessageDialog("没有查到相关记录！");
		//parent.location="f8002.jsp?returnFlag=3";
		window.close();
	</script>
<%  
	}
%>	

<html>
<head>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>

<body>

<form name="frm" method="post" action="">	
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">角色<%=roleName + "(" + roleCode + ")"%>的权限信息</div>
	</div>
 
		<table cellspacing="0">
			<tr>
				<th nowrap align='center'><b>操作代码</b></th>
				<th nowrap align='center'><b>权限名称</b></th>
			</tr>
	<%
	
	String class_str="";	
		for(int i = 0; i < sFuncCode.length; i++)
		{
		if(i%2==0)
			class_str="Grey";
		else
			class_str="";
	%>			
			<tr>
				<td nowrap align='center' class=<%=class_str%>><%=sFuncCode[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center' class=<%=class_str%>><%=sFuncCode[i][1].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>
		</table>
		<table cellspacing=0 >
			<tr>
				<td align="center" height="60" id="footer">
					<input class="b_foot" type="button" name="Return" onclick="window.close()" value="关闭">
				</td>
			</tr>
		</table>
	<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
