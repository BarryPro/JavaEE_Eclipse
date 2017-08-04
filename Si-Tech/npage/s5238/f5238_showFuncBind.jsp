   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "产品发布";
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
	String sm_code = request.getParameter("sm_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	
 	String errCode="";
  String errMsg="";
 	
 	//获取所有的优惠绑定信息
	String[] paramsIn=new String[4];
	paramsIn[0]="9102";
	paramsIn[1]=region_code;
	paramsIn[2]=sm_code;
	paramsIn[3]=detail_code;

 	String op_name ="产品（"+mode_code+"）特服绑定配置";
	 	
	//retArray=callView.callFXService("sDynSqlCfm",paramsIn,"3");	
%>

    <wtc:service name="sDynSqlCfm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%	
	errCode = code;
	errMsg = msg;
	
	if(!errCode.equals("000000"))
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
<title>特服绑定信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	  <form name="form1"  method="post">
	  	
<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">特服绑定信息</div>
	</div>
 
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="sm_code" value="<%=sm_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  
	  		  	<TABLE id="mainOne"  cellspacing="0" >
	            <TBODY>
	  				<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;优惠代码</TD>
	  					<TD width="80%">
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
	  					<TD class="blue">&nbsp;&nbsp;开关标识</TD>
	  					<TD>
	  						<input type="radio" v_must="1" v_name="开关标识" name="off_flag" value="1"  <%=result_t[0][2].equals("1")==true?"checked":""%> <%=result_t[0][2].trim().equals("")==true?"checked":""%> >开通
	  						<input type="radio" v_must="1" v_name="开关标识" name="off_flag" value="0"  <%=result_t[0][2].equals("0")==true?"checked":""%>  >关闭
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;特服代码</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=5 v_name="特服代码" name=func_code maxlength=5 size="5" value="<%=result_t[0][0]%>" readonly Class="InputGrey"></input>
	  						<input type=text  v_name="特服代码" name=func_name maxlength=40 value="<%=result_t[0][1]%>" readonly Class="InputGrey"></input>
	  					</TD>
	  				</tr>
	        </TBODY>
	         </TABLE>
	         <TABLE  cellSpacing= "0">
	  			  	<TR >
	  						<TD height="30" align="center" id="footer">
 
	          	 	    <input name="reset" type="button" class="b_foot" value="返回" onClick="window.close()" >
	          	 	    &nbsp;
	  						</TD>
	  			  	</TR>
	  	    </TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
	  
</body>
</html>

