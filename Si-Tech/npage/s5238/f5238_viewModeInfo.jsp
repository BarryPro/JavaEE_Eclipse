<%
   /*
   * 功能: 产品发布
　 * 版本: v1.0
　 * 日期: 2007/01/30
　 * 作者: wangqh
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2007/01/30    shibo      
 　*/
%>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>

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
	
	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date d1=new Date();
	String sysdate=df.format(d1);
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
%>

<html>
<head>
<base target="_self">
<title>产品信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript"> 
core.loadUnit("rpccore");
onload=function()
{
	core.rpc.onreceive = doProcess;//为function()函数设立监听器
}
//选择地区代码
function queryRegionCode()
{
	
	if(document.form1.region_code.value!="")
	{
	    window.open("f5240_queryRegionCode.jsp","","height=600,width=400,scrollbars=yes");
	}
	else
	{
		rdShowMessageDialog("请先选择产品代码！");
		document.form1.mode_code.focus();
	}
}

//选择品牌代码
function querySmCode()
{
	if(document.form1.region_code.value!="")
	{
	    var url = "f5240_querySmCode.jsp?region_code="+document.form1.region_code.value;
		window.open(url,'','height=600,width=400,scrollbars=yes');
	}
	else
	{
		rdShowMessageDialog("请先选择产品代码！");
		document.form1.mode_code.focus();
	}
}

//选择产品代码
function queryModeCode()
{
	var url = "f5238_queryModeCode2.jsp?mode_code="+document.all.mode_code.value+"&login_accept="+document.all.login_accept.value+"&region_code="+document.all.region_code.value;
	escape(url);
	window.open(url,"","height=600,width=600,scrollbars=yes");
}

//选择产品目录
function queryDirectId()
{
	var url = "productTree.jsp?productType=2"
	escape(url);
	window.open(url,"","height=600,width=400,scrollbars=yes");
}

//产品审核
function f5239_show()
{
	var url = "f5239_show.jsp?mode_code="+document.all.mode_code.value
	+"&login_accept="+document.all.login_accept.value
	+"&region_code="+document.all.region_code.value
	+"&sm_code="+document.all.sm_code.value
	+"&mode_name="+document.all.mode_name.value
	+"&begin_time="+document.all.mode_begin_time.value
	+"&end_time="+document.all.mode_end_time.value;
	escape(url);
	window.open(url,"","height=650,width=1000,scrollbars=yes");
}

/*--------- 提交 -------------*/
function submitRelease()
{
	var myPacket = new RPCPacket("f5240_release_rpc.jsp?note="+document.all.note.value,"正在提交信息，请稍候......");		
	myPacket.data.add("mode_code",document.all.mode_code.value);
	myPacket.data.add("group_id",document.all.group_id.value);
	myPacket.data.add("sm_code",document.all.sm_code.value);
	myPacket.data.add("direct_id",document.all.direct_id.value);
	myPacket.data.add("op_code",document.all.op_code.value);
	myPacket.data.add("before_ctrl_code",document.all.before_ctrl_code.value);
	myPacket.data.add("end_ctrl_code",document.all.end_ctrl_code.value);
	myPacket.data.add("begin_time",document.all.begin_time.value);
	myPacket.data.add("end_time",document.all.end_time.value);
	myPacket.data.add("power_right",document.all.power_right.value);
	myPacket.data.add("region_code",document.all.region_code.value);
	core.rpc.sendPacket(myPacket);
	delete(myPacket);	
}
//---------------------------获取rpc返回的用户信息--------------------------------
function doProcess(myPacket)
{
	var errCode    = myPacket.data.findValueByName("errCode");
	var retMessage = myPacket.data.findValueByName("errMsg");//声明返回的信息		
	var retFlag    = myPacket.data.findValueByName("retFlag");	
	self.status="";
	//操作成功
	if(retFlag=="submit")
	{
		if (errCode==000000)
		{
			
			rdShowMessageDialog("操作成功！");	
			self.status="操作成功！";
		}
		else
		{
			rdShowMessageDialog("操作失败！错误代码："+errCode+"。错误信息："+retMessage);
		}
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
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>产品信息查询</strong></font></td>
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
	  <input type="hidden" name="region_code" value="<%=regionCode%>">
	  <input type="hidden" name="sm_code" value="">
	  <input type="hidden" name="mode_begin_time" value="">
	  <input type="hidden" name="mode_end_time" value="">
	  	<TR >
	  		<TD >
				<table width="100%" align="center" bgcolor="#FFFFFF" cellspacing="1" border="0">
					<tr bgcolor="#F5F5F5" height="22">
	  					<TD width="15%">&nbsp;&nbsp;产品代码：</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="产品代码"  name=mode_code maxlength=8 readonly>
	  					</TD>
					    <TD  width="15%">&nbsp;&nbsp;产品名称：</TD>
				      <TD width="35%"><input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="产品名称"  name=mode_name maxlength=20 size="20"></TD>
				        </TD>
				    </tr>
					<tr bgcolor="#F5F5F5" height="22">
					<TD width="15%">
					    	&nbsp;&nbsp;配置流水：</TD>
				        <TD width="35%">
				        	<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=12 v_name="配置流水"  name=login_accept maxlength=12 readonly>
				        </TD>
					    <TD colspan=2 aligh="left">
					    	&nbsp;&nbsp;
				        	<input class="button" type="button" name="query_mode"  value="查询" onclick="queryModeCode()">
						</TD>
				    </tr>
					<tr bgcolor="#F5F5F5" height="22">
					  <TD colspan="4"> &nbsp;&nbsp;<font color="bule">点击 － &gt; </font><input name="add_info" type="button" class="button" value="察看资费配置信息" onClick="f5239_show()">
				      <font color="bule">！ </font></TD>
				  </tr>
				</table>
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

