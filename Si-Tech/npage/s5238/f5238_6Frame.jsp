<% 
  /*
   * 功能: 显示优惠代码信息列表
　 * 版本: v1.00
　 * 日期: 2007/01/19
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
	String sm_code = request.getParameter("sm_code");
	String region_code = request.getParameter("region_code");
	String mode_code = request.getParameter("mode_code");
	System.out.println("#############mode_code="+mode_code);	

	int errCode=0;
    String errMsg="";
	//获取所有的优惠信息
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
 	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
/**
 	sqlStr1 ="SELECT detail_code,a.detail_type,fav_order,mode_time,time_flag,time_cycle,time_unit,note,to_char(begin_time,'yyyymmdd'),to_char(end_time,'yyyymmdd'),b.type_name,a.region_code FROM sBillModedetail a ,sbilldetname b WHERE a.detail_type=b.detail_type and a.region_code='"+region_code+"' and a.mode_code='"+mode_code+"' order by a.detail_code asc";
**/
 	sqlStr1 ="SELECT detail_code,a.detail_type,fav_order,mode_time,time_flag,time_cycle,time_unit,note,to_char(sysdate,'yyyymmdd'),to_char(sysdate,'yyyymmdd'),b.type_name,a.region_code FROM sBillModedetail a ,sbilldetname b WHERE a.detail_type=b.detail_type and a.region_code='"+region_code+"' and a.mode_code='"+mode_code+"' order by a.detail_code asc";
 	retList1 = impl.sPubSelect("12",sqlStr1,"region",regionCode);
 	String[][] retListString1 = (String[][])retList1.get(0);

%>
<html>
<head>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script>
	
function showDetailCode(apply_flag,detail_type,detail_code,note,typeButtonNum,region_code)
{
	var apply_flag =apply_flag;
	var detail_type =detail_type;
	var detail_code =detail_code;
	var note =note;
	var typeButtonNum=typeButtonNum;
	var region_code=region_code;
	
	if(detail_type=='0')
	{
		var url = "f5238_showRateCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');                                     
	}                                                             
	else if(detail_type=='1'||detail_type=='9')                                     
	{                                                             
		var url = "f5238_showMonthCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='2'||detail_type=='b')
	{
		var url = "f5238_showTotCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code + "&totCode=0";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='4')
	{
		var url = "f5238_showFuncFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='3')
	{
		var url = "f5238_showBillFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}else if(detail_type=='a')
	{
		var url = "f5238_showFuncBind.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
		
	
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form target="middle" action="" method="post" name="form2">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      		<table width="553"  border="0" id="mainThree" align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">
	  			<%  
	  				for(int i=0;i < retListString1.length;i ++)
					{
	  			%>
	  					<tr bgcolor="#F5F5F5" height="22" >
	  						<TD width="71" align="center"><%=retListString1[i][0]%></TD>
	  						<TD width="76" align="center"><%=retListString1[i][10]%></TD>
	  						<TD width="70" align="center"><%=retListString1[i][8]%></TD>
	  						<TD width="70" align="center"><%=retListString1[i][9]%></TD>
	  						<TD width="202"><input type="text" value="<%=retListString1[i][7]%>" size="30" readonly></input></TD>
	  						<TD width="52"><input type="button" name="typeButton<%=i%>" value="资费信息" class="button" onclick="showDetailCode('<%=retListString1[i][10]%>','<%=retListString1[i][1]%>','<%=retListString1[i][0]%>','<%=retListString1[i][7]%>','<%=i%>','<%=retListString1[i][11]%>')"></TD>
	  					</tr>
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
