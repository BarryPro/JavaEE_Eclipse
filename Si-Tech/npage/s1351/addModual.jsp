<%
   /*
   * 功能: 个性帐单模板
　 * 版本: v1.0
　 * 日期: 2006/09/21
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               //工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	
	String op_name = "";

	String mode_name = request.getParameter("mode_name");     //模版名称
	String show_mode = request.getParameter("show_mode");     //模版编号
  String modetype = request.getParameter("modetype");				//模版类型
  
  String action=request.getParameter("action");//提交到本页面

	if (action!=null&&action.equals("select")){     
	
		SPubCallSvrImpl impl = new SPubCallSvrImpl();
	    
	  String paraArr[] = new String[7];
		
		paraArr[0]= workNo;     
		paraArr[1]= nopass;     
		paraArr[2]= org_code;     
		paraArr[3]= "2763";     
		paraArr[4]= show_mode;     
		paraArr[5]= mode_name;     
		paraArr[6]= modetype; 
		            
		impl.callFXService("sAddModeNew",paraArr,"2");
		impl.printRetValue();
		int errCode=impl.getErrCode();   
		String errMsg=impl.getErrMsg();	
		
		if(errCode==0)
		{%>
			<script language=javascript>
				window.close();
			</script>
		<%
		}
	else
		{
		%>
			<script language=javascript>
				 rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
				 window.close();
			</script>
		<%
		}
	}
%>
<html>
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language=javascript>
function doSubmit()
	{		
		document.form1.action = "/npage/s1351/addModual.jsp?action=select&show_mode=<%=show_mode%>&modetype=<%=modetype%>";
		document.form1.submit(); 
	}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<form action="" name="form1"  method="post">
<div id="Operation_Table">
 <TABLE width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#F5F5F5">
	<TR>
	 <TD>
		<TABLE width="100%" align="center" id="mainOne" bgcolor="#F5F5F5" cellspacing="1" border="0" >
			<TR bgcolor="#F5F5F5" id="line_1" align="center"> 
				<td colspan=5>
					&nbsp;
				</td>
			</tr>
			<TR bgcolor="#F5F5F5" id="line_1" align="center"> 
					<td colspan=5>
						&nbsp;
				</td>
			</tr>
		  <TR bgcolor="#F5F5F5" id="line_1" align="center"> 
	  		<td width="13%">请输入模版名称:</td>
     		<td width="35%"> 
	             <input type="text" name="mode_name" maxlength="11" class="button">
	             <input class="button" name=sure22 type=button value="确 定" onClick="doSubmit();" >
        </td>
      </TR>
      	<TR bgcolor="#F5F5F5" id="line_1" align="center"> 
				<td colspan=5>
					&nbsp;
				</td>
			</tr>
			<TR bgcolor="#F5F5F5" id="line_1" align="center"> 
					<td colspan=5>
						&nbsp;
				</td>
			</tr>
				<TR bgcolor="#F5F5F5" id="line_1" align="center"> 
					<td colspan=5>
						&nbsp;
				</td>
			</tr>
      </TABLE>
  </TD>
 </TR>
</TABLE>
 </div>
</form>
</body>
</html>
   
