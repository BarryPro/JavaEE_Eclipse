<%
   /*
   * 功能: 个人产品发布，产品审核页面
　 * 版本: v1.0
　 * 日期: 2007/01/31
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
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");
	String sm_code = request.getParameter("sm_code");
	String begin_time = request.getParameter("begin_time");	
	String end_time = request.getParameter("end_time");	 
     					 
%>

<html>
<head>
<base target="_self">
<title>个人产品信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript"> 

function showChange()
{
	var url = "<%=request.getContextPath()%>/page/s5238/f5238_showChange.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

function showDepend()
{
	var url = "<%=request.getContextPath()%>/page/s5238/f5238_showDepend.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
}

function showLimit()
{
	var url = "<%=request.getContextPath()%>/page/s5238/f5238_showLimit.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=600,width=800,left=30,top=30,scrollbars=yes');
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
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>个人产品信息查询</strong></font></td>
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
	  	<TR >
	  		<TD >
	  		  	<TABLE width="100%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	            <TBODY>
	  	        	<TR bgcolor="#F5F5F5">
	  					<TD width="100%" valign="top">
	  						<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD colspan="4">【产品定义信息】</TD>
	  							</tr>
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD width="15%">&nbsp;&nbsp;产品代码：</TD>
	  								<TD width="35%">
	  									<%=mode_code%>
	  								</TD>
	  								<TD width="15%">&nbsp;&nbsp;产品名称：</TD>
	  								<TD width="35%">
	  									<%=mode_name%>
	  								</TD>
	  							</tr>
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD>&nbsp;&nbsp;开始时间：</TD>
	  								<TD>
	  									<%=begin_time%>
	  								</TD>
	  								<TD>&nbsp;&nbsp;结束时间：</TD>
	  								<TD>
	  									<%=end_time%>
	  								</TD>
	  							</tr>
	  						</table>
	  						<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD colspan="6">【产品组合信息】</TD>
	  							</tr>
	  							<tr bgcolor="#649ECC" height="22">
	  								<TD align="center" width="12%"><b>优惠代码<b></TD>
	  								<TD align="center" width="12%"><b>优惠类型<b></TD>
	  								<TD align="center" width="12%"><b>开始时间<b></TD>
	  								<TD align="center" width="12%"><b>结束时间<b></TD>
	  								<TD align="center" width="36%"><b>优惠描述<b></TD>
	  								<TD align="center" width="16%"><b>资费规则<b></TD>
	  							</tr>
	  							<tr bgcolor="#F5F5F5" height="22" >
	  								<td colspan="6">
	  									<IFRAME src="/page/s5240/f5240_showFrame.jsp?login_accept=<%=login_accept%>&sm_code=<%=sm_code%>&region_code=<%=region_code%>&mode_code=<%=mode_code%>" frameBorder=0 id=middle name=middle scrolling="yes" style="HEIGHT: 160; VISIBILITY: inherit; WIDTH: 743; Z-INDEX: 1">
      		  	  						</IFRAME>
      		  	  					</td>
	  							</tr>
	  							
	  						</table>
	  						<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD colspan="2">【开关机信息】</TD>
	  							</tr>
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD width="50%">&nbsp;&nbsp;HLE开关机</TD>
	  								<TD width="50%">&nbsp;&nbsp;智能网开关机</TD>
	  							</tr>
	  						</table>
	  						<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD colspan="3">【产品关系信息】</TD>
	  							</tr>
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD>
	  									<input name="lastButton" type="button" class="button" value="配置产品变更规则" onClick="showChange();">
	  								</TD>
	  								<TD>
	  									<input name="lastButton" type="button" class="button" value="配置产品依赖规则" onClick="showDepend();">
	  								</TD>
	  								<TD>
	  									<input name="lastButton" type="button" class="button" value="配置产品互斥规则" onClick="showLimit();">
	  								</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  	        	</TR> 
	            </TBODY>
	          	</TABLE>
	          	<TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
	  			  	<TR bgcolor="#F5F5F5">
	  					<TD height="30" align="center">
	          	 		    <input name="lastButton" type="button" class="button" value="关闭" onClick="window.close()">
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

