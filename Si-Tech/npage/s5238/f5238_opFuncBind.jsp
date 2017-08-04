<%
   /*
   * 功能: 特服绑定配置
　 * 版本: v1.0
　 * 日期: 2007/01/15
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
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
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String sm_code = request.getParameter("sm_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	
 	int errCode=0;
  String errMsg="";
 	
 	//获取所有的优惠绑定信息
 	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList retArray = new ArrayList();
	String[] paramsIn=new String[2];
	paramsIn[0]="9002";
	paramsIn[1]=login_accept;

 	String op_name ="产品（"+mode_code+"）特服绑定配置";
	 	
	retArray=callView.callFXService("sDynSqlCfm",paramsIn,"3");	
	callView.printRetValue();
	errCode = callView.getErrCode();
	errMsg = callView.getErrMsg();
	
	
	String[][]sOut_func_code=(String[][])retArray.get(0);
	String[][]sOut_func_name=(String[][])retArray.get(1);
	String[][]sOut_off_flag=(String[][])retArray.get(2);	
	
	System.out.println("sOut_off_flag="+sOut_off_flag[0][0]);
	
	
	if(errCode != 0)
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	} 
%>

<html>
<head>
<base target="_self">
<title>特服绑定配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript"> 

//-----提交配置月租优惠配置-----
function doSubmit()
{	
	document.form1.action="f5238_opFuncBind_submit.jsp"; 
	document.form1.submit();
}


//选择特服代码
function queryFuncCode()
{
	var retToField = "func_code|func_name|";
	var url = "f5238_queryFuncCode.jsp?region_code=<%=region_code%>&sm_code=<%=sm_code%>&retToField="+retToField;
	window.open(url,"","height=600,width=400,scrollbars=yes");
}


</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	  <form name="form1"  method="post">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td background="../../images/jl_background_1.gif">
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="../../images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
             
          <td width="55%" align="right"><img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=baseInfo[0][2]%>
          <img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=baseInfo[0][3]%> 
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="../../images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../../images/jl_logo.gif"></td>
                <td align="right"><img src="../../images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
	  <table align="center" width="98%"  bgcolor="#ffffff">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>特服绑定配置</strong></font></td>
                      <td><img src="/images/jl_ico_3.gif" width="240" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%">
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
	  <TABLE width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="sm_code" value="<%=sm_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  	<TR >
	  		<TD >
	  		  	<TABLE width="100%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	            <TBODY>
	  				<tr bgcolor="#F5F5F5">
	  					<TD width="20%" height="22">&nbsp;&nbsp;优惠代码：</TD>
	  					<TD width="80%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5" >
	  					<TD height="22">&nbsp;&nbsp;优惠描述：</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;开关标识：</TD>
	  					<TD>
	  						<input type="radio" v_must="1" v_name="开关标识" name="off_flag" value="1"  <%=sOut_off_flag[0][0].equals("1")==true?"checked":""%> <%=sOut_off_flag[0][0].trim().equals("")==true?"checked":""%> >开通
	  						<input type="radio" v_must="1" v_name="开关标识" name="off_flag" value="0"  <%=sOut_off_flag[0][0].equals("0")==true?"checked":""%>  >关闭
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;特服代码：</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=5 v_name="特服代码" name=func_code maxlength=5 size="5" value="<%=sOut_func_code[0][0]%>" readonly></input>
	  						<input type=text  v_name="特服代码" name=func_name maxlength=40 value="<%=sOut_func_name[0][0]%>" readonly></input>
	  						<input class="button" type="button" name="queryFuncCodeBtn" onclick="queryFuncCode()" value="选择">
	  					</TD>
	  				</tr>
	        </TBODY>
	         </TABLE>
	         <TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
	  			  	<TR bgcolor="#F5F5F5">
	  						<TD height="30" align="center">
	          	 	    <input name="nextButton" type="button" class="button" value="确定" onClick="if (check(form1)) doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="button" value="取消返回" onClick="window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;window.close()" >
	          	 	    &nbsp;
	  						</TD>
	  			  	</TR>
	  	    </TABLE>
				</TD>
	  			  	</TR>
	  	    </TABLE>	  	    
<%@ include file="../public/foot.jsp" %>
	  </form>
	  
</body>
</html>

