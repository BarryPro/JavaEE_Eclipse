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
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	String regionCode = (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String region_code = request.getParameter("region_code");
 	
 	String errCode="";
    String errMsg="";
 	
 	//获取所有的优惠信息
    String sqlStr="";

	sqlStr = "select favour_type,half_rate from tMidBillHalfFav where login_accept="+login_accept;

	//retList = callView.sPubSelect("2",sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%	
    errCode=code1;   
	errMsg=msg1; 
 String favour_type="",half_rate="";
	String[][] result = new String[][]{};
	if(result_t1.length>0&&code1.equals("000000"))
	{
	result = result_t1;
	
	favour_type = result[0][0];
	half_rate = result[0][1];

}
	//得到资费名称
	String sqlStr2="";
	
	sqlStr2 = "select mode_name from tMidBillModeCode where login_accept="+login_accept;
	//retList2 = callView.sPubSelect("1",sqlStr2);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr2%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%	

	String[][] result2 = new String[][]{};
	
	String mode_name="";
		if(result_t2.length>0&&code1.equals("000000"))
	{
	result2 = result_t2;
    mode_name=result2[0][0];
    }

%>

<html>
<head>
<base target="_self">
<title>底线半月收配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
onload=function()
{
    document.form1.favour_type.value="<%=favour_type%>";
}
//-----提交配置月租优惠配置-----
function doSubmit()
{	
	document.form1.action="f5238_opHalfFav_submit.jsp"; 
	document.form1.submit();
}

</script>
</head>

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	

	  <form name="form1"  method="post">
	  	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">产品（<%=mode_code%>）底线半月收配置</div>
	</div>

	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  		  	<TABLE  id="mainOne"  cellspacing="0" >
	            <TBODY>
	  				<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;资费代码</TD>
	  					<TD width="80%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="资费代码" name="mode_code" maxlength=4 value="<%=mode_code%>" readonly></input>
	  					</TD>
	  				</tr>
					<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;资费名称</TD>
	  					<TD width="80%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="资费名称" name="mode_name" maxlength=4 value="<%=mode_name%>" size="20" readonly></input>
	  					</TD>
	  				</tr>
	  				<tr  >
	  					<TD height="22" class="blue">&nbsp;&nbsp;优惠类型</TD>
	  					<TD>
	  						<select  name="favour_type">
							    <option value="2">2-入网</option>
								<option value="4">4-申请</option>
								<option value="6">6-入网+申请</option>
							</select>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;优惠比率</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="优惠比率" name="half_rate" maxlength=4 value="<%=half_rate%>" ></input>&nbsp;(0-1)
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="nextButton" type="button" class="b_foot" value="确定" onClick="if (check(form1)) doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="b_foot_long"  value="取消返回" onClick="window.close();" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
 
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
 
</body>
</html>

