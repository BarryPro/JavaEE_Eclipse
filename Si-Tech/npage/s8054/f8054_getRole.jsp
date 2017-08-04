<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page errorPage="/page/common/error.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String workName = baseInfoSession[0][3];
	String orgCode = baseInfoSession[0][16];
	String workNo = baseInfoSession[0][2];
	String ip_Addr = request.getRemoteAddr();
	String org_code = baseInfoSession[0][16];
	String[][] pass = (String[][])arrSession.get(4);
	String nopass  = pass[0][0];
	String regionCode=org_code.substring(0,2);

 	String roleCode 	= request.getParameter("roleCode");   
  String roleName 	= request.getParameter("roleName");   
	String sqlFilter 	= "";
	
	if(roleCode.trim().length() > 0)
	{
		sqlFilter 	= " a.power_code  = '"+roleCode+"'";
	}
	if(roleName.trim().length() > 0)
	{
		sqlFilter 	= sqlFilter + " a.POWER_NAME like '%" + roleName + "%'";
	}
	if((roleCode.trim().length() > 0)&&(roleName.trim().length() > 0))
	{
	sqlFilter 	= " a.power_code  = '"+roleCode+"' and  a.POWER_NAME like '%" + roleName + "%'";
	}
	
	System.out.println("sqlFilter="+sqlFilter);
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList1 = new ArrayList();  
	String sqlStr1 ="select a.power_code, a.power_name, b.ROLETYPE_NAME,a.POWER_DESCRIBE from sPowerCode a, sRoleTypeCode b "+
									"where " + sqlFilter+" and a.roletype_code = b.ROLETYPE_CODE and a.use_flag='Y' and rownum < 11 "+
									"order by a.power_code ";
	retList1 = impl.sPubSelect("4",sqlStr1,"region",regionCode);
	String[][] retListString1 = (String[][])retList1.get(0);
	
		if(retListString1.length==1)
	{
	%>
	<script language='jscript'>
					window.opener.form1.roleCode.value="<%=retListString1[0][0]%>";
					window.opener.form1.roleName.value="<%=retListString1[0][1]%>";
					window.opener.form1.roleTypeName.value="<%=retListString1[0][2]%>";
					window.opener.form1.roleDiscribe.value="<%=retListString1[0][3]%>";
					
					window.opener.form1.roleCode.readOnly=true;
					window.opener.form1.roleName.readOnly=true;
					
					window.opener.form1.setPdButton.disabled=false;
					window.opener.form1.qryButton.disabled=false;
					window.close();
	</script>
	<%
	}
%>	

<html>
<head>
<title>角色列表</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_image.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<link href="<%=request.getContextPath()%>/css/jl.css"  rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablabel.css">
</head>
<body>
<form name="frm" method="POST" >
<table width="99%" id="tab1" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr bgColor="#eeeeee">
		<td height="26" align="center">
			选择
		</td>
		<td  align="center">
			角色代码
		</td>
		<td align="center">
			角色名称
		</td>
	</tr>
</table>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<td>
				<div align="center">
			      <input type="button" name="commit" onClick="doCommit();" value=" 确定 ">
			      &nbsp;
			      <input type="button" name="back" onClick="doClose();" value=" 关闭 ">
		    </div>
		</td>
	</tr>
</table>
</form>
</body>
</html>

<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="roleCode" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="roleName" value="<%=retListString1[i][1]%>">';
			str+='<input type="hidden" name="roleTypeName" value="<%=retListString1[i][2]%>">';
			str+='<input type="hidden" name="roleDiscribe" value="<%=retListString1[i][3]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="left";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		<%}%>

		function doCommit()
		{
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("您没有选择角色代码！");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.form1.roleCode.value=document.all.roleCode.value;
					window.opener.form1.roleName.value=document.all.roleName.value;
					window.opener.form1.roleTypeName.value=document.all.roleTypeName.value;
					window.opener.form1.roleDiscribe.value=document.all.roleDiscribe.value;
					
					window.opener.form1.roleCode.readOnly=true;
					window.opener.form1.roleName.readOnly=true;
					window.opener.form1.setPdButton.disabled=false;
					window.opener.form1.qryButton.disabled=false;
					
					//window.close();
				}
				else{
					rdShowMessageDialog("您没有选择角色代码！");
					return false;
				}
			}
			else{//值为多条时需要用数组
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){
						a=i;
						break;
					}
				}
				if(a!=-1){
					window.opener.form1.roleCode.value=document.all.roleCode[a].value;
					window.opener.form1.roleName.value=document.all.roleName[a].value;
					window.opener.form1.roleTypeName.value=document.all.roleTypeName[a].value;
					window.opener.form1.roleDiscribe.value=document.all.roleDiscribe[a].value;
					
					window.opener.form1.roleCode.readOnly=true;
					window.opener.form1.roleName.readOnly=true;
					window.opener.form1.setPdButton.disabled=false;
					window.opener.form1.qryButton.disabled=false;
					//window.close();
				}
				else{
					rdShowMessageDialog("您没有选择角色代码！");
					return false;
				}
			}
			
			window.close();
		}
	
	function doClose()
	{
		
		window.close();
	}
</script>