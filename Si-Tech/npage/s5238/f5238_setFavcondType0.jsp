<%
   /*
   * 功能: 帐单优惠配置-本月话费为条件
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
	String favcond_type = request.getParameter("favcond_type");                                
	String detail_code = request.getParameter("detail_code");
	String region_code = request.getParameter("region_code");
	String favcond_coder_code = request.getParameter("favcond_coder_code");
	String condetion_coder = request.getParameter("condetion_coder");
	String local_expr = request.getParameter("local_expr");
	
	
 	int errCode=0;
    String errMsg="";
 	
 	
%>

<html>
<head>
<base target="_self">
<title>帐单优惠配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript"> 

//-----提交配置月租优惠配置-----
function doSubmit()
{	
	if(!document.form1.favour_condition.checked)
	{
		if(document.form1.first_favour_object.value=="")
		{
			rdShowMessageDialog("优惠帐目项不能为空！");
			return;
		}
	}
	document.form1.nextButton.disabled=true;
	document.form1.action="f5238_setFavcondType_submit.jsp"; 
	document.form1.submit();
}

//帐目项选择全部与否
function onClickFavourObject()
{
	if(document.form1.favour_condition.checked)
	{
		document.form1.query_FirstFeeCode.disabled=true;
		document.form1.query_SecondFeeCode.disabled=true;
		document.form1.first_favour_object.v_must="0";
	}
	else
	{
		document.form1.query_FirstFeeCode.disabled=false;
		document.form1.query_SecondFeeCode.disabled=false;
		document.form1.first_favour_object.v_must="1";
	}
}

//查询一级帐目项
function queryFirstFeeCode()
{
	var url = "f5238_queryFirstFeeCode.jsp?second_favour_object=1";
	window.open(url,'','height=600,width=400,left=50,scrollbars=yes');
}

//查询二级帐目项
function querySecondFeeCode()
{
	if(document.form1.first_favour_object.value!="")
	{
	    var url = "f5238_querySecondFeeCode.jsp?first_favour_object="+document.form1.first_favour_object.value;
		window.open(url,'','height=600,width=500,left=100,scrollbars=yes');
	}
	else
	{
		rdShowMessageDialog("请先选择一级帐目项！");
		document.form1.query_regioncode.focus();
	}
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
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>优惠条件设置-本月话费为条件</strong></font></td>
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
	  <input type="hidden" name="total_code" value="<%=detail_code%>">
	  <input type="hidden" name="favcond_type" value="<%=favcond_type%>">
	  <input type="hidden" name="favcond_coder_code" value="<%=favcond_coder_code%>">
	  <input type="hidden" name="condetion_coder" value="<%=condetion_coder%>">
	  <input type="hidden" name="local_expr" value="<%=local_expr%>">
	  	<TR >
	  		<TD >
	  		  	<TABLE width="100%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	            <TBODY>
	  				<tr bgcolor="#F5F5F5">
	  					<TD width="15%" height="22">&nbsp;&nbsp;优惠代码：</TD>
	  					<TD width="85%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5" >
	  					<TD height="22">&nbsp;&nbsp;优惠条件类型：</TD>
	  					<TD>
	  						本月话费为条件
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD valign="top" height="25">&nbsp;&nbsp;优惠帐目项：</TD>
	  					<TD >
	  						<input type="checkbox" name="favour_condition" value="*" onclick="onClickFavourObject()">全部<br>
	  						一级帐目项：<input type=text  v_type="string" v_must=0 v_minlength=0 v_maxlength=246 v_name="一级帐目项" name=first_favour_object maxlength=246 size="80" readonly></input>
	  									<input class="button" type="button" name="query_FirstFeeCode" onclick="queryFirstFeeCode()" value="选择"><br>
	  						二级账目项：<input type=text  v_type="string" v_must=0 v_minlength=0 v_maxlength=246 v_name="二级账目项" name=second_favour_object maxlength=246 size="80" readonly></input>
	  									<input class="button" type="button" name="query_SecondFeeCode" onclick="querySecondFeeCode()" value="选择">
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;条件属性:</TD>
	  					<TD>
	  						<input type="radio" name="cond_attr" value="0" checked>本月优惠
	  						<input type="radio" name="cond_attr" value="1" >本月通话次数
	  						<input type="radio" name="cond_attr" value="2" >本月通话时长
	  					</TD>
	  				</tr>
					<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;关系表达式：</TD>
	  					<TD>
	  						<select name="relation_expr" v_name="关系表达式">
    		        			<option value="=">等于(=)</option>
    		        			<option value=">">大于(>)</option>
    		        			<option value="<">小于(<)</option>
    		        			<option value=">=">大于等于(>=)</option>
    		        			<option value="<=">小于等于(<=)</option>
	  						</select>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;条件阀值：</TD>
	  					<TD>
	  						<input type=text  v_type="money" v_must=1 v_minlength=1 v_maxlength=19 v_name="条件阀值" name=condition_step maxlength=19 value="0"></input>
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
	  			  <TR bgcolor="#F5F5F5">
	  				<TD height="30" align="center">
	          	 	    <input name="nextButton" type="button" class="button" value="确定" onClick="if (check(form1)) doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="button" value="取消返回" onClick="window.close()" >
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

