<%
   /*
   * 功能: 个人产品综合信息查询
　 * 版本: v1.0
　 * 日期: 2007/03/29
　 * 作者: hexy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
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
	
	int errCode=0;
  String errMsg="";
  
  //获取从上页得到的信息
	String product_code = request.getParameter("product_code");
	String option_type  = request.getParameter("option_type");
	String public_flag  = request.getParameter("public_flag");
	String district_code  = request.getParameter("district_code");
	String region_code = request.getParameter("region_code");
	
	//查询显示信息
	String[][] sOut_product_code	= new String[][]{};
	String[][] sOut_product_name	= new String[][]{};
  String[][] sOut_product_brand	= new String[][]{};
  String[][] sOut_product_level	= new String[][]{};
  String[][] sOut_product_type	= new String[][]{};
  String[][] sOut_login_no			= new String[][]{};
  String[][] sOut_login_accept	= new String[][]{};
  String[][] sOut_op_code				= new String[][]{};
  String[][] sOut_op_date				= new String[][]{};
  
  String server_code  = "";
  String return_num		=	"0";
  
  if(option_type.equals("1")){
		if(public_flag.equals("0")){//批价历史信息查询
			server_code="612";
			return_num="7";
		}else if(public_flag.equals("1")){//月租历史信息查询
			server_code="613";
			return_num="20";
		}else if(public_flag.equals("2")){//帐单优惠历史信息查询
			server_code="614";
			return_num="10";
		}else if(public_flag.equals("3")){
		
		}else if(public_flag.equals("4")){//特服优惠历史信息查询
			server_code="615";
			return_num="10";
		}else if(public_flag.equals("a")){//特服绑定历史信息查询
			server_code="616";
			return_num="10";
		}
	}else if(option_type.equals("2")){
		if(public_flag.equals("0")){
			server_code="610";
			return_num="10";
		}else if(public_flag.equals("1")){
			server_code="611";
			return_num="10";
		}
	}
  
	//获取所有的显示信息
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
  if(option_type.equals("0")){
		
		ArrayList acceptList = new ArrayList();
	 	String paramsIn[] = new String[3];
	  paramsIn[0] = "600";					//服务编号
	  paramsIn[1] = product_code;		//服务代码
	  paramsIn[2] = regionCode;			//区域编码
	  
		acceptList = impl.callFXService("sDynSqlCfm",paramsIn,"9");
		errCode=impl.getErrCode();
		errMsg=impl.getErrMsg();
		if(errCode != 0)
	  {
	%>
	    <script language='javascript'>
	    	rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>");
	    </script>
	<%}
		else
		{
			sOut_product_code	=(String[][])acceptList.get(0);
			sOut_product_name	=(String[][])acceptList.get(1);
			sOut_product_brand=(String[][])acceptList.get(2);
			sOut_product_level=(String[][])acceptList.get(3);
			sOut_product_type	=(String[][])acceptList.get(4);
			sOut_login_no			=(String[][])acceptList.get(5);
			sOut_login_accept	=(String[][])acceptList.get(6);
			sOut_op_code			=(String[][])acceptList.get(7);
			sOut_op_date =(String[][])acceptList.get(8);
		}
	}else if(option_type.equals("1")){
		ArrayList acceptList1 = new ArrayList();
	 	String paramsIn1[] = new String[3];
	  paramsIn1[0] = server_code;		//服务编号
	  paramsIn1[1] = product_code;	//资费代码
	  paramsIn1[2] = regionCode;	  //区域代码
	  
		acceptList1 = impl.callFXService("sDynSqlCfm",paramsIn1,"6");
		errCode=impl.getErrCode();
		errMsg=impl.getErrMsg();
		if(errCode != 0)
	  {
	%>
	    <script language='javascript'>
	    	rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>");
	    </script>
	<%}
		else
		{
			sOut_product_code	=(String[][])acceptList1.get(0);
			sOut_product_name	=(String[][])acceptList1.get(1);
			sOut_product_type	=(String[][])acceptList1.get(2);
			sOut_login_no			=(String[][])acceptList1.get(3);
			sOut_login_accept	=(String[][])acceptList1.get(4);
			sOut_op_code			=(String[][])acceptList1.get(5);
		}
	}else if(option_type.equals("2")){
		ArrayList acceptList2 = new ArrayList();
	 	String paramsIn2[] = new String[4];
	  paramsIn2[0] = server_code;		//服务编号
	  paramsIn2[1] = product_code;	//资费代码
	  paramsIn2[2] = regionCode;	  //区域代码
	  paramsIn2[3] = district_code;	//区县代码
	  
		acceptList2 = impl.callFXService("sDynSqlCfm",paramsIn2,"8");
		errCode=impl.getErrCode();
		errMsg=impl.getErrMsg();
		if(errCode != 0)
	  {
	%>
	    <script language='javascript'>
	    	rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>");
	    </script>
	<%}
		else
		{
			sOut_product_code	=(String[][])acceptList2.get(0);
			sOut_product_name	=(String[][])acceptList2.get(1);
			sOut_product_brand=(String[][])acceptList2.get(2);
			sOut_product_level=(String[][])acceptList2.get(3);
			sOut_product_type	=(String[][])acceptList2.get(4);
			sOut_login_no			=(String[][])acceptList2.get(5);
			sOut_login_accept	=(String[][])acceptList2.get(6);
			sOut_op_code			=(String[][])acceptList2.get(7);
		}
	}%>
<html>
<head>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script>
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form target="middle3" action="" method="post" name="form2">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      	<table width="100%"  border="0" id="mainFive" align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">
      		<%if(option_type.equals("0")){%>
      		<tr height="24" bgcolor="#649ECC">
						<TD width="10%" align="center">产品代码</TD>
						<TD width="20%" align="center">产品名称</TD>
						<TD width="10%" align="center">品牌</TD>
						<!--<TD width="10%" align="center">层次</TD> -->
						<TD width="10%" align="center">受理权限</TD>
						<TD width="10%" align="center">操作工号</TD>
						<TD width="10%" align="center">操作时间</TD>
						<TD width="10%" align="center">操作模块</TD>
						<TD width="10%" align="center">产品描述</TD>
						<TD width="10%" align="center">电子免填单</TD>
					</tr>
					<%for(int i=0;i<sOut_product_code.length;i++){%>
					<tr bgcolor="F5F5F5" height="20" >
        		<td align="center" width="90" height="20"><%=sOut_product_code[i][0]%></td>
        		<td align="left" width="120" height="20"><%=sOut_product_name[i][0]%></td>
        		<td align="center" width="90" height="20"><%=sOut_product_brand[i][0]%></td>
        		<!--<td align="center" width="90" height="20"><%=sOut_product_level[i][0]%></td> -->
        		<td align="center" width="90" height="20"><%=sOut_product_type[i][0]%></td>
        		<td align="center" width="90" height="20"><%=sOut_login_no[i][0]%></td>
        		<!--<td align="center" width="90" height="20"><%=sOut_login_accept[i][0]%></td> -->
        		
						<td align="center" width="90" height="20"><%=sOut_op_date[i][0]%></td>

        		<td align="center" width="90" height="20"><%=sOut_op_code[i][0]%></td>
        		<td align="center" width="90" height="20"><a href="f5252_prodNoteList.jsp?region_code=<%=region_code%>&product_code=<%=sOut_product_code[i][0]%>&type=0">查看</a></td>
		    		<td align="center" width="90" height="20"><a href="f5252_dianziNote.jsp?region_code=<%=region_code%>&product_code=<%=sOut_product_code[i][0]%>&type=1">查看</a></td>

		    	</tr>
		    	<%}
		    }else if(option_type.equals("1")){%>
		    	<tr height="24" bgcolor="#649ECC">
						<TD width="10%" align="center">产品代码</TD>
						<TD width="20%" align="center">产品名称</TD>
						<TD width="10%" align="center">类型</TD>
						<TD width="10%" align="center">操作工号</TD>
						<TD width="10%" align="center">操作流水</TD>
						<TD width="10%" align="center">操作模块</TD>
					</tr>
					<%for(int i=0;i<sOut_product_code.length;i++){%>
					<tr bgcolor="F5F5F5" height="20" >
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>" ><%=sOut_product_code[i][0]%></a></td>
        		<td align="center" width="120" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>" ><%=sOut_product_name[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>" ><%=sOut_product_type[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>" ><%=sOut_login_no[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>" ><%=sOut_login_accept[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>" ><%=sOut_op_code[i][0]%></a></td>
		    	</tr>
		    	<%}
		    }else if(option_type.equals("2")){%>
		    	<tr height="24" bgcolor="#649ECC">
						<TD width="10%" align="center">产品代码</TD>
						<TD width="20%" align="center">产品名称</TD>
						<TD width="10%" align="center">品牌</TD>
						<TD width="10%" align="center">层次</TD>
						<TD width="10%" align="center">类型</TD>
						<TD width="10%" align="center">操作工号</TD>
						<TD width="10%" align="center">操作流水</TD>
						<TD width="10%" align="center">操作模块</TD>
					</tr>
					<%for(int i=0;i<sOut_product_code.length;i++){%>
					<tr bgcolor="F5F5F5" height="20" >
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>&district_code=<%=district_code%>&login_accept=<%=sOut_login_accept[i][0]%>" ><%=sOut_product_code[i][0]%></a></td>
        		<td align="center" width="120" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>&district_code=<%=district_code%>&login_accept=<%=sOut_login_accept[i][0]%>" ><%=sOut_product_name[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>&district_code=<%=district_code%>&login_accept=<%=sOut_login_accept[i][0]%>" ><%=sOut_product_brand[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>&district_code=<%=district_code%>&login_accept=<%=sOut_login_accept[i][0]%>" ><%=sOut_product_level[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>&district_code=<%=district_code%>&login_accept=<%=sOut_login_accept[i][0]%>" ><%=sOut_product_type[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>&district_code=<%=district_code%>&login_accept=<%=sOut_login_accept[i][0]%>" ><%=sOut_login_no[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>&district_code=<%=district_code%>&login_accept=<%=sOut_login_accept[i][0]%>" ><%=sOut_login_accept[i][0]%></a></td>
        		<td align="center" width="90" height="20"><a href="f5252_DetailList.jsp?product_code=<%=sOut_product_code[i][0]%>&option_type=<%=option_type%>&public_flag=<%=public_flag%>&district_code=<%=district_code%>&login_accept=<%=sOut_login_accept[i][0]%>" ><%=sOut_op_code[i][0]%></a></td>
		    	</tr>
		    	<%}
		    }%>
	    </table>
		</td>
  	</tr>
</table>
</form>
</body>
</html>  
