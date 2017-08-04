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
	String nopass  	= pass[0][0];                     //登陆密码
	String regionCode=org_code.substring(0,2);
	
	int errCode=0;
  String errMsg="";
  
  //查询显示信息
  String[][] result_value = new String[][]{};
	String[][] result_value0 = new String[][]{};
	String[][] result_value1 = new String[][]{};
	String[][] result_value2 = new String[][]{};
	String[][] result_value3 = new String[][]{};
	String[][] result_value4 = new String[][]{};
	String[][] result_value5 = new String[][]{};
	String[][] result_value6 = new String[][]{};
	String[][] result_value7 = new String[][]{};
	String[][] result_value8 = new String[][]{};
	String[][] result_value9 = new String[][]{};
	String[][] result_value10 = new String[][]{};
	String[][] result_value11 = new String[][]{};
	String[][] result_value12 = new String[][]{};
	String[][] result_value13 = new String[][]{};
	String[][] result_value14 = new String[][]{};
	String[][] result_value15 = new String[][]{};
	String[][] result_value16 = new String[][]{};
	String[][] result_value17 = new String[][]{};
	String[][] result_value18 = new String[][]{};
	String[][] result_value19 = new String[][]{};
	String[][] result_value20 = new String[][]{};
	String[][] result_value21 = new String[][]{};
	String[][] result_value22 = new String[][]{};
	String[][] result_value23 = new String[][]{};
	String[][] result_value24 = new String[][]{};
	String[][] result_value25 = new String[][]{};
	String[][] result_value26 = new String[][]{};
	String[][] result_value27 = new String[][]{};
	String[][] result_value28 = new String[][]{};
	String[][] result_value29 = new String[][]{};
	String[][] result_value30 = new String[][]{};
	
  //获取从上页得到的信息
	String product_code = request.getParameter("product_code");
	String option_type  = request.getParameter("option_type");
	String server_code  = "";
	String public_flag 	= request.getParameter("public_flag");
	String login_accept	= request.getParameter("login_accept");
	String district_code= request.getParameter("district_code");
	String return_num		=	"0";
	if(option_type.equals("1")){
		if(public_flag.equals("0")){//批价历史信息查询
			server_code="601";
			return_num="7";
		}else if(public_flag.equals("1")){//月租历史信息查询
			server_code="602";
			return_num="11";
		}else if(public_flag.equals("2")){//帐单优惠历史信息查询
			server_code="603";
			return_num="21";
		}else if(public_flag.equals("3")){
		
		}else if(public_flag.equals("4")){//特服优惠历史信息查询
			server_code="606";
			return_num="9";
		}else if(public_flag.equals("a")){//特服绑定历史信息查询
			server_code="608";
			return_num="8";
		}
	}else if(option_type.equals("2")){
		if(public_flag.equals("0")){
			server_code="604";
			return_num="12";
		}else if(public_flag.equals("1")){
			server_code="605";
			return_num="9";
		}
	}
	int circle_number=Integer.parseInt(return_num);

  
	//获取所有的显示信息
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
  
	ArrayList acceptList = new ArrayList();
	if(option_type.equals("1")){
	 	String paramsIn[] = new String[3];
	  paramsIn[0] = server_code;			//服务编号
	  paramsIn[1] = product_code;			//产品代码
	  paramsIn[2] = regionCode;				//区域代码
	  
	  acceptList = impl.callFXService("sDynSqlCfm",paramsIn,return_num);
		errCode=impl.getErrCode();
		errMsg=impl.getErrMsg();
	}else if(option_type.equals("2")){
		String paramsIn1[] = new String[5];
	  paramsIn1[0] = server_code;			//服务编号
	  paramsIn1[1] = product_code;		//产品代码
	  paramsIn1[2] = regionCode;			//区域代码
	  paramsIn1[3] = login_accept;		//操作流水
	  paramsIn1[4] = district_code;		//区域代码
	  
	  acceptList = impl.callFXService("sDynSqlCfm",paramsIn1,return_num);
		errCode=impl.getErrCode();
		errMsg=impl.getErrMsg();
	}
	
	if(errCode != 0)
  {
%>
    <script language='javascript'>
    	rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>");
    </script>
<%}
	else
	{
		result_value	=(String[][])acceptList.get(0);
		
	}
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
<form target="middle3" action="" method="post" name="form2">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      	<table width="100%"  border="0" id="mainFive" align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">

      		<%if(option_type.equals("1")){%>
	      		<%for(int j=0;j<circle_number;j++){
							result_value0	=(String[][])acceptList.get(j);
						%>
	      			<td align="center" bgcolor="#649ECC" width="90" height="20"><%=result_value0[0][0]%></td>
	      		<%}%>
						<%for(int i=1;i<result_value.length;i++){%>
						<tr bgcolor="F5F5F5" height="20" >
							<%for(int j=0;j<circle_number;j++){
								result_value0	=(String[][])acceptList.get(j);
							%>
	        			<td align="center" width="90" height="20"><%=result_value0[i][0]%></td>
	        		<%}%>
			    	</tr>
			    	<%}
			    }else if(option_type.equals("2")){%>
			    	<%for(int j=0;j<circle_number;j++){
							result_value0	=(String[][])acceptList.get(j);
						%>
        			<td align="center" bgcolor="#649ECC" width="90" height="20"><%=result_value0[0][0]%></td>
        		<%}%>
			    	<%for(int i=1;i<result_value.length;i++){%>
							<tr bgcolor="F5F5F5" height="20" >
								<%for(int j=0;j<circle_number;j++){
									result_value0	=(String[][])acceptList.get(j);
								%>
		        			<td align="center" width="90" height="20"><%=result_value0[i][0]%></td>
		        		<%}%>
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
