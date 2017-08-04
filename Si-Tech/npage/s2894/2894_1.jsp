<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	//读取用户session信息	
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                   //登陆密码	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("2894_1.jsp");
	String op_name="SI/EC业务产品关系维护";
	String opCode = "2894";
	String opName = op_name;

%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	onload=function(){
	changebizType();
	}
	
	function queryEC()
	{		
		
		var bizCode 	= document.all.bizCode.value;
		var spCode 	= document.all.spCode.value;
		var bizType 	= document.all.bizType.value;
		document.middle.location="s2894QueryEC.jsp?a=1"
			+ "&bizType=" + bizType
			+ "&spCode=" + spCode
			+ "&bizCode=" + bizCode;


	}	
function addEC()
{
	window.open("s2894AddEC.jsp?height=600,width=400,scrollbars=yes");

}

	function queryEC1()
	{		
		
		var bizCode 	= document.all.bizCode.value;
		var spCode 	= document.all.spCode.value;
		var bizType 	= document.all.bizType.value;
		document.middle.location="f3052QueryList1.jsp?a=1"
			+ "&bizType=" + bizType
			+ "&spCode=" + spCode
			+ "&bizCode=" + bizCode;


	}	
function addEC1()
{
	window.open("s2894AddEC1.jsp?height=600,width=400,scrollbars=yes");
}

function changebizType()
{
	var rbiztype = document.form1.bizType.value;

		if(rbiztype=="0")
	{
		$("#biznameA").css("display","");
    $("#biznameM").css("display","none");
	}
	else{		
		$("#biznameA").css("display","none");
    $("#biznameM").css("display","");
	}
	
}
</script>

</head>

<body>
<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SI/EC业务产品关系维护</div>
</div>
<table cellspacing=0>
	  <tr>
	  <TD class='blue'>业务类型</TD>
        <TD colspan="3">
            <select id="bizType" name="bizType" onChange="changebizType()">
						    <option value="1">本地MAS</option> 
              	<option value="0">ADC</option> 
						</select> <font class='orange'>*</font>							
					</TD>	
				
	  </tr>	
    <tr>
        <TD  class='blue'><span id='biznameA' style='display:none;'>SI企业代码</span>
        	<span id='biznameM' style='display:none;'>集团编码</span></TD>
        <TD >
            <input type=text name=spCode v_type=int v_must=0 v_maxlength=6></input> 
            <font class='orange'>*</font>
        </TD>
        <TD  class='blue'>业务代码</TD>
        <TD >
            <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 name=bizCode maxlength=10 value="" />
            <font class='orange'>*</font>
        </TD>
    </tr>
</table>
		
<TABLE cellspacing="0">	    
    <TR id="footer"> 
     	<TD> 
     	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot_long" value="查询集团主资费" onClick="queryEC();">
     	    <input name="newAcBtn"   style="cursor:hand" type="button" class="b_foot_long" value="新增主资费" onClick="addEC();">
     	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot_long" value="查询成员资费" onClick="queryEC1();">
     	    <input name="newAcBtn"   style="cursor:hand" type="button" class="b_foot_long" value="新增成员资费" onClick="addEC1();">
     	    <input name="" type="button" style="cursor:hand" class="b_foot" value="关  闭" onClick="removeCurrentTab();" >
	 	  </TD>
   </TR>
</TABLE> 
<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"  
style="HEIGHT: 350px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
</IFRAME>

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
