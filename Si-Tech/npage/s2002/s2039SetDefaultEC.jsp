<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>

<%@ include file="/npage/include/public_title_name.jsp"%>


<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");	
	String[][] baseInfo = (String[][])arrSession.get(0);   
  String workNo   = baseInfo[0][2];                 
	String workName = baseInfo[0][3]; 
  String op_name = "设置缺省资费";
  String opName = op_name;
  String opCode = "";
	String mode_code="";
  String mode_name="";  
  String org_code = baseInfo[0][16];
  String regionCode=org_code.substring(0,2);
  String region_code="";   
  
  
  
  String pospec_number= request.getParameter("spCode");
  String productspec_number= request.getParameter("bizCode");
  String default_flag = request.getParameter("default_flag");
  /* 接收输入参数 */ 
%>



<HTML xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<link href="/css/jl.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>

<script language="JavaScript"> 
	



function querySpCode()
{
	if(document.all.spCode.value == "")
 	 	{ 
 	 		rdShowMessageDialog("请输入商品规格编码！");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	var spCode = document.all.spCode.value;
	window.open("s2039_qrySpCode.jsp?spCode="+spCode+"","","height=600,width=400,scrollbars=yes");
	
}
	
function queryBizCode()
{
	if((document.all.spCode.value == ""))
 	 	{
 	 		rdShowMessageDialog("请输入商品规格编码！");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	if((document.all.spName.value==""))
 	{
 		rdShowMessageDialog("请选择一个商品规格编码！");
 	 	document.all.spCode.focus();
 	 	return;
 	}
 	       var spCode = document.all.spCode.value;    
 	       var bizCode = document.all.bizCode.value; 
	window.open("s2039_qryBizCode.jsp?spCode="+spCode+"&bizCode="+bizCode+"","","height=600,width=500,scrollbars=yes");
}

function doQuery()
{	
	if(!check(form1)){
		return;
	}
	if( (document.all.PospecType.value=="2")&&(document.all.bizCode.value==""))
	{
		rdShowMessageDialog("请选择一个产品规格编码！");
		return;
	}
	var spCode = document.all.spCode.value;    
 	var bizCode = document.all.bizCode.value;
	document.middle.location="s2039getDefaultEC.jsp?sPOSpecNumber=" + spCode
		+ "&sProductSpecNumber=" + bizCode;
		
		
		
	
		// document.form1.action="#"; 
    
	 // document.form1.submit();
	
}

function doSubmit(){
	
	var spCode = document.all.spCode.value;    
 	var bizCode = document.all.bizCode.value;
 	var default_flags = document.middle.document.all.default_flag;
	

	
	if(default_flags.type=='radio'){
		if(default_flags.checked==true){
			document.all.default_flag.value=default_flags.value;
	  }
	}
	else{
		for(var i = 0;i<default_flags.length;i++){
		
		  if(default_flags[i].checked==true){
			
			document.all.default_flag.value=default_flags[i].value;
			
		  }
	  }
  }
	
	document.form1.action="#"; 
    
	document.form1.submit();
	
	
}

function doSmCode(vSmCode,vSmName){
    return;
}

</script>

</head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<body>
	<%if(pospec_number!=null&&!pospec_number.equals("")&&productspec_number!=null&&!productspec_number.equals("")&&default_flag!=null&&!default_flag.equals("")){%>

<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="Code1" retmsg="Msg1">
		<wtc:param value="203905"/>
		<wtc:param value="<%=pospec_number%>"/>
	  <wtc:param value="<%=productspec_number%>"/>
    <wtc:param value="<%=default_flag%>"/>
</wtc:service>
<wtc:array id="result1"  scope="end" />

	<script language="JavaScript">
	rdShowMessageDialog("<%=Msg1%>",1);
	</script>
	
<%}%>
	
	
	
	
	<%@ include file="/npage/include/header_pop.jsp" %> 
	
<form name="form1"  method="post">
	     <input type="hidden" name="mode_region" value="<%=region_code%>" > 
	     <input type="hidden" name="PospecType" value="1">

	  <TABLE width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	  	<TR >
	  		<TD class="blue">
	  		  	<TABLE width="100%"  id="mainOne" cellspacing="1" border="0">

	            	
	          <tr>	
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;商品规格编码： </TD>
	  					<TD width="60%" class="blue">
	  						<input type=text  name=spCode   v_must=1 v_type="string" v_name="商品规格编码"  /> 
								<font class="orange">*</font>
								<input class="b_text" type="button" name="qrySpCode" onclick="querySpCode()" value="查询">
							  &nbsp;&nbsp;商品规格名称： 
	  						<input type=text name=spName readonly size=40/>
							</TD>
						
						</tr>
					

						<tr>	
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;产品规格编码：</TD>
	  					<TD class="blue" width="80%">
	  						<input type="hidden"  name="hidProdCode"/><input type=text  name=bizCode   v_name="产品规格编码"  v_type="string"  size=20 readonly/> 
	  						<font class="orange">*</font>
								<input class="b_text" type="button" name="qryBizCode" onclick="queryBizCode()" value="查询">
							  &nbsp;&nbsp;产品规格名称： 
	  						<input type=text name=bizName readonly size=40/>
							</TD>
							
						</tr>		
	        </TABLE>
	          	<input type = hidden name=default_flag />
	        <TABLE width="100%" border=0 align="center" cellSpacing=1 >
	  			  <TR>
	  					<TD class="blue" height="30" align="center" id="footer">
	          	 	    <input name="nextButton" class="b_foot" type="button"  value="确  定" onClick="doQuery()" >
	          	 	    &nbsp;
		         	    	<input name="" type="button" class="b_foot" value="重  置" onclick="javascript:location.reload();">
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot" value="关  闭" onClick="window.close()" >
	          	 	    &nbsp;
	  					</TD>
	  			  </TR>
	  	    </TABLE>
	  		</TD>
	  	</TR>
	  </TABLE>
<div style="height:300px;overflow: auto">
 	<IFRAME frameBorder=0 id=middle name=middle scrolling="no"  
	 style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
	</IFRAME>
</div>
 </form>
</body>
</html>

