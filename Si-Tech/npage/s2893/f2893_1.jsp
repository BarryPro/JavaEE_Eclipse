<%
	/*
	 * 功能: 黑白名单查询 - 主界面
	 * 版本: v1.0
	 * 日期: 2007/10/25
	 * 作者: sunzg
	 * 版权: sitech
	 * 修改历史
	 * 修改日期      修改人      修改目的
	 * 2009-09-07   qidp       集团新版产品改造
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	//读取用户session信息	
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("f2893_1.jsp");
	String op_name="黑白名单查询";
	
	String opCode = "2893";
	String opName = "黑白名单查询";
%>	
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
	
	
function queryBWInfo()
{
	var flag="0";
	
	if($("#spCode").val()=="" && $("#bizCode").val()=="" && $("#phoneNo").val()==""){
	    rdShowMessageDialog("企业代码、业务代码、手机号码请至少输入一个查询条件！",0);
	    return false;
	}
	/*
	if(!checkElement(document.form1.oprDate)){
		return false;
	}	
	*/
	if(($("#phoneNo").val()!="") && !forMobil(document.all.phoneNo)){
	    return false;
	}
	if(check(form1)){
		var spCode = document.all.spCode.value;
		var bizCode = document.all.bizCode.value;
		var phoneNo = document.all.phoneNo.value;
		//liujian 2012-8-30 14:36:09 添加操作时间 begin
		var oprDate = $.trim($('#oprDate').val());
		//liujian 2012-8-30 14:36:09 添加操作时间 begin
		//wuxy alter 暂时用9开头
		//if(document.all.spCode.value.substr(0,1)=='9'&& spCode.length<=8)
		//{
		//	flag="1";
	  //  }
	  //liujian 2012-8-30 14:37:22 添加操作时间
		document.middle.location="f2893info.jsp?spCode="+spCode+"&bizCode=" + bizCode+"&phoneNo="+phoneNo+"&flag="+flag + "&oprDate=" + oprDate;
		//tabBusi.style.display="";
    loading("正在加载查询信息，请稍候······");
   }
}	
function UnLoad(){
	unLoading();
}
	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">黑白名单查询</div>
</div>
	<table cellspacing="0" >
		<tr>
			<td class='blue' nowrap>企业代码</TD>
			<TD>
				<input name="spCode" id="spCode" align="left" type="text" v_maxlength=18 v_type="string" maxlength="18"> 
			</TD>
			<td class='blue' nowrap>业务代码</TD>
			<TD height=20>
				<input name ="bizCode" id="bizCode" type="text" v_maxlength=14 v_type="string" maxlength="14">
			</TD>	
		</TR>
			<TR>
				<td class='blue' nowrap>手机号码</TD>
				<TD>
					<input name="phoneNo" id="phoneNo" type="text" v_maxlength=11 v_type="phone" maxlength="11">
				</TD>
				<td class='blue' nowrap>操作时间</TD>
				<TD>
					<input name="oprDate" id="oprDate" type="text" v_type="date" v_maxlength="8" maxlength="8">
					(yyyyMMdd)
				</TD>
			</TR>	
		</TABLE>
		
		<TABLE id="tabBtn" style="display:''" id="mainOne" cellspacing="0" >	    
			    <TR id="footer"> 
		         	<TD colspan = "4" align="center"> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="查  询" onClick="queryBWInfo()">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="重  置" onclick="javascript:location.reload();">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="关  闭" onClick="removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 
	      
					<IFRAME frameBorder=0 id=middle name=middle 
					 style="HEIGHT: 306px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

