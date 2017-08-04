   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "产品发布";
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");               //工号
	String nopass  = (String)session.getAttribute("password");                 	//登陆密码
	String regionCode= (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	
 	String errCode="";
    String errMsg="";
 	
 	//获取所有的优惠信息
	String[] paramsIn=new String[6];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	
	//retArray=callView.callFXService("s5238_RateShw",paramsIn,"1");	
%>

    <wtc:service name="s5238_RateShw" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />					
		</wtc:service>
		<wtc:array id="result_t1" scope="end"/>

<%	
	errCode = code;
	errMsg = msg;
	System.out.println("----------errCode--------"+errCode);
	System.out.println("----------errMsg--------"+errMsg);
	String[][] sOut_note= result_t1;

%>

<html>
<head>
<base target="_self">
<title>二次批价优惠配置信息查看</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

//-----提交配置月租优惠配置-----
function doSubmit()
{	
	document.form1.action="f5238_opRateCode_submit.jsp"; 
	document.form1.submit();
}

</script>
</head>

<body   onMouseDown="hideEvent()" onKeyDown="hideEvent()">

 
	  <form name="form1"  method="post">
	  		<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">二次批价优惠配置信息查看</div>
	</div>
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  		  	<TABLE  id="mainOne" cellspacing="0" >
	            <TBODY>
	  				<tr >
	  					<TD width="30%" height="22" class="blue">&nbsp;&nbsp;优惠代码</TD>
	  					<TD width="70%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr  >
	  					<TD height="22" class="blue">&nbsp;&nbsp;优惠描述</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;优惠信息描述</TD>
	  					<TD height="22">
	  						<%=sOut_note[0][0]%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD height="22" colspan="2">&nbsp;&nbsp;<font class="orange">备注产品配置完成后，请通知计费系统配置批价规则！</font></TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="reset" type="button" class="b_foot" value="返回" onClick="window.close()" >
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>

