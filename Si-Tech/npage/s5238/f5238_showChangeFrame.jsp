<% 
  /*
   * 功能: 显示产品关系配置信息
　 * 版本: v1.00
　 * 日期: 2007/01/17
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               	//工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//登陆密码
	String regionCode=org_code.substring(0,2);
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_name = request.getParameter("mode_name");
	String mode_code = request.getParameter("mode_code");
	String region_code = request.getParameter("region_code");
	String trans_type = request.getParameter("trans_type");
	
	int errCode=0;
    String errMsg="";
	
%>
<html>
<head>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script>
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form target="middle" action="" method="post" name="form2">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      		<table width="100%"  border="0" id="mainThree" align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">
      		  	<%
			
				SPubCallSvrImpl callView = new SPubCallSvrImpl();
				ArrayList retArray = new ArrayList();
				String[] paramsIn=new String[7];
				paramsIn[0]=workNo;
				paramsIn[1]=nopass;
				paramsIn[2]="5238";
				paramsIn[3]=login_accept;
				paramsIn[4]=mode_code;
				paramsIn[5]=mode_name;
				paramsIn[6]=region_code;
				
				retArray=callView.callFXService("s5238_BBChgShw",paramsIn,"6");	
				callView.printRetValue();
				errCode = callView.getErrCode();
				errMsg = callView.getErrMsg();
				if(errCode==0)
				{
					String[][]old_code=(String[][])retArray.get(0);
					String[][]old_name=(String[][])retArray.get(1);
					String[][]relation_type=(String[][])retArray.get(2);
					String[][]new_code=(String[][])retArray.get(3);
					String[][]new_name=(String[][])retArray.get(4);
					String[][]send_flag=(String[][])retArray.get(5);
	
					for(int i=0;i<old_code.length;i++)
					{
				%> 
					<tr bgcolor="F5F5F5" height="20">
                		<td align="center" width="70"  height="20"><%=old_code[i][0]%></td>
                		<td align="center" width="228" height="20"><%=old_name[i][0]%></td>
                		<td align="center" width="74"  height="20">->></td>
                		<td align="center" width="73"  height="20"><%=new_code[i][0]%></td>
                		<td align="center" width="229" height="20"><%=new_name[i][0]%></td>
                		<td align="center" width="56"  height="20"><%=send_flag[i][0]%></td>	
			    	</tr>
			    	<%
					}	
				}
				else
				{	
				%>        
					<script language="javascript">
						rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>");
					</script>       
				<%            
				}
			
				%>               	
      		</table>
		</td>
  	</tr>
</table>
</form>	
</body>
</html>  
