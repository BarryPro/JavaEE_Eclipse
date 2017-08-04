<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");	
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	   						String[] paramsIn=new String[7];
				paramsIn[0]=workNo;
				paramsIn[1]=nopass;
				paramsIn[2]="5238";
				paramsIn[3]=login_accept;
				paramsIn[4]=mode_code;
				paramsIn[5]=mode_name;
				paramsIn[6]=region_code;			 
%>

<html>
<head>
<base target="_self">
<title>产品变更规则配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
function modeTransOther()
{
	document.form1.modeTransOtherButton.disabled=true;
	var url = "f5238_modeTrans.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>&trans_type=0";
	window.open(url,'','height=700,width=900,left=60,top=60,scrollbars=yes');
}

function otherTransMode()
{
	document.form1.otherTransModeButton.disabled=true;
	var url = "f5238_modeTrans2.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>&trans_type=1";
	window.open(url,'','height=700,width=900,left=60,top=60,scrollbars=yes');
}

//关闭此页面并调用f5238_5.jsp页面中的queryRelationFlag()服务查询关系规则的状态
function closewindow()
{
    window.opener.document.form1.changeButton.disabled=false;
    window.opener.queryRelationFlag();
	window.close();
}
</script>
</head>

<body   onMouseDown="hideEvent()" onKeyDown="hideEvent()">


	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">产品变更规则配置</div>
	</div>
	  		  	<TABLE  id="mainOne"  cellspacing="0"  >
	  				<tr  height="22">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;产品代码</TD>
	  					<TD width="35%">
	  						<%=mode_code%>
	  					</TD>
	  					<TD width="15%" class="blue">&nbsp;&nbsp;当前配置流水号</TD>
	  					<TD width="35%"><font class="orange"><%=login_accept%></font></TD>
	  				</tr>
	  				<tr  height="22">
	  					<TD class="blue">&nbsp;&nbsp;产品名称</TD>
	  					<TD colspan="3">
	  						<%=mode_name%>
	  					</TD>
	  				</tr>
	  				<tr  height="22">
	  					<TD colspan="4" class="blue">
	  						&nbsp;&nbsp;配置产品【<%=mode_code%>】到其他产品的转换关系－》
	  						<input name="modeTransOtherButton" type="button" class="b_text" value="配置" onClick="modeTransOther();">
	  					</TD>
	  				</tr>
	  				<tr  height="22">
	  					<TD colspan="4" class="blue">
	  						&nbsp;&nbsp;配置其他产品到产品【<%=mode_code%>】的转换关系－》
	  						<input name="otherTransModeButton" type="button" class="b_text" value="配置" onClick="otherTransMode();">
	  					</TD>
	  				</tr>
	  			</table>
	  			<table  id="mainThree" cellspacing="0" >
	  				<tr height="24" >
      		    <Th width="10%" align="center">产品代码</Th>
	  					<Th width="25%" align="center">产品名称</Th>
	  					<Th width="10%" align="center">关系</Th>
	  					<Th width="10%" align="center">产品代码</Th>
	  					<Th width="25%" align="center">产品名称</Th>
	  					<Th width="10%" align="center">生效方式</Th>
							<Th width="10%" align="center">操作权限</Th>
      		  		</tr>
      		  		<%
      		  		String errCode="";
      		  		%>
 	    <wtc:service name="s5238_BBChgQry" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />
			<%
			if(code.equals("000000")){
				for(int i=0;i<result_t.length;i++)
					{
				%> 
					<tr bgcolor="F5F5F5" height="20" >
                		<td align="center" width="70" height="20"><%=result_t[i][0]%></td>
                		<td align="center" width="200" height="20"><%=result_t[i][1]%></td>
                		<td align="center" width="74" height="20">->></td>
                		<td align="center" width="73" height="20"><%=result_t[i][3]%></td>
                		<td align="center" width="201" height="20"><%=result_t[i][4]%></td>
                		<td align="center" width="56" height="20"><%=result_t[i][5]%></td>
						<td align="center" width="56" height="20"><%=result_t[i][6]%></td>
			    	</tr>
			    	<%
					}	}
					%>
	          	</TABLE>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="lastButton" type="button" class="b_foot" value="返回" onClick="closewindow();">
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>

