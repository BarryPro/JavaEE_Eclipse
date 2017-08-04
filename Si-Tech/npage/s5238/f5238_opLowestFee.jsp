<%
   /*
   * 功能: 底线半月收配置
　 * 版本: v1.0
　 * 日期: 2007/01/25
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
	String total_code = request.getParameter("total_code");
	String region_code = request.getParameter("region_code");
	String tot_order = request.getParameter("tot_order");
 	
 	int errCode=0;
    String errMsg="";
 	
 	//获取所有的优惠信息
 	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList();
    String sqlStr="";

	sqlStr = "select new_feeCode,new_detCode from tMidLowestFeeCode where login_accept="+login_accept+" and region_code='"+region_code+"' and total_code='"+total_code+"' and tot_order='"+tot_order+"'";

	retList = callView.sPubSelect("2",sqlStr);
    errCode=callView.getErrCode();   
	errMsg=callView.getErrMsg(); 
	String[][] result = (String[][])retList.get(0);

	String new_feeCode="",new_detCode="";
	new_feeCode = result[0][0];
	new_detCode = result[0][1];

	System.out.println("new_feeCode=-----"+new_feeCode);
%>

<html>
<head>
<base target="_self">
<title>底线帐目项配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript"> 
onload=function()
{
}
//-----提交配置月租优惠配置-----
function doSubmit()
{	
	document.form1.action="f5238_opLowestFee_submit.jsp"; 
	document.form1.submit();
}
//选择一级账目代码
function queryFeeCode()
{
	var retToField = "new_feeCode|new_feeName|";
	var url = "f5238_queryFeeCode.jsp?retToField="+retToField;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
}
//选择二级账目代码
function queryDetailCode()
{
	if(!checkElement("new_feeCode")) 
    {
        document.all.new_feeCode.focus();
	    return;
    }
	var retToField = "new_detCode|new_detName|";
	var url = "f5238_queryFeeDetailCode.jsp?fee_code="+document.all.new_feeCode.value+"&retToField="+retToField;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
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
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>底线账目项配置</strong></font></td>
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
	  <form name="form1"  method="post">
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  	<TR >
	  		<TD >
	  		  	<TABLE width="100%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	            <TBODY>
	  				<tr bgcolor="#F5F5F5">
	  					<TD width="20%" height="22">&nbsp;&nbsp;帐单优惠代码：</TD>
	  					<TD width="80%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="帐单优惠代码" name="total_code" maxlength=4 value="<%=total_code%>" readonly></input>
	  					</TD>
	  				</tr>
					<tr bgcolor="#F5F5F5">
	  					<TD width="20%" height="22">&nbsp;&nbsp;优惠顺序：</TD>
	  					<TD width="80%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="优惠顺序" name="tot_order" maxlength=4 value="<%=tot_order%>" size="20" readonly></input>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5" >
	  					<TD height="22">&nbsp;&nbsp;一级账目：</TD>
	  					<TD>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=4 v_name="一级账目"  name=new_feeCode value="<%=new_feeCode%>" maxlength=10 size="10" readonly>
	  						<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=20 v_name="账目名称"  name=new_feeName value="" maxlength=20 readonly>
							<input class="button" type="button" name="query_feecode" onclick="queryFeeCode()" value="选择">
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;二级账目：</TD>
	  					<TD>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=5 v_name="二级账目"  name=new_detCode maxlength=5 size="10" value="<%=new_detCode%>" readonly>
						    </input>
							<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=20 v_name="明细名称"  name=new_detName value="" maxlength=20 readonly>
							<input class="button" type="button" name="query_detailcode" onclick="queryDetailCode()" value="选择">
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
	  			  <TR bgcolor="#F5F5F5">
	  				<TD height="30" align="center">
	          	 	    <input name="nextButton" type="button" class="button" value="确定" onClick="if (check(form1)) doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="button" value="取消返回" onClick="window.close();" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  			<BR>
	  			<BR>		
	  		</TD>
	  	</TR>
	  </form>
	  </TABLE>
	</TD>
  </TR>
</TABLE>
</body>
</html>

