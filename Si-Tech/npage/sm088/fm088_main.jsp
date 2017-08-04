<%
/********************
 version v2.0
 开发商: si-tech
 *
 *update:zhanghonga@2008-09-06 页面改造,修改样式
 *
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
		
    String opCode = "m088";
    String opName = "电子工单补打";
    
		String workno = (String)session.getAttribute("workNo");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1= new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		String regCode = (String)session.getAttribute("regCode");
		
		String nowDate  = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<HTML>
	<HEAD>
<script language="JavaScript">
<!--
	onload=function(){
		
	}

 function printtypechange() {
	if (document.mainForm.print_type.value == 1) {
	   IList1.style.display = "";
	   IList2.style.display = "none";
	} 
	else if (document.mainForm.print_type.value == 2) {
	   IList1.style.display = "none";
	   IList2.style.display = "";
	}
}

 function docheck() {
 	
 	 if(!forDate(document.mainForm.begin_date)){
 	 		return false;
 	 }
 	 
 	 if(!forDate(document.mainForm.end_date)){
 	 		return false;	
 	 }
 	 var begin_date = $.trim(document.mainForm.begin_date.value);
 	 var end_date = $.trim(document.mainForm.end_date.value);
 	 
 	 if(begin_date.length == 0 || end_date.length == 0 ){
 	 		rdShowMessageDialog("请填写开始时间和结束时间！");
    	return false;
 	 }
 	 
 	 if (document.mainForm.begin_date.value> document.mainForm.end_date.value) {
      rdShowMessageDialog("开始时间不能大于结束时间，请重新输入！");
      document.mainForm.begin_date.focus();
    	return false;
   }
	 
   if (document.mainForm.begin_date.value.substr(0,6) != document.mainForm.end_date.value.substr(0,6) ) {
      rdShowMessageDialog("只能查询一个月的信息，请重新输入！");
      document.mainForm.begin_date.focus();
    	return false;
   }
   return true;
 }
		function docheck1() {

			if(!docheck()){
				return false;	
			};
			var phone_no = $.trim($("#phone_no").val());
			var login_accept = $.trim($("#login_accept").val());
			if(phone_no.length == 0 && login_accept.length == 0){
				rdShowMessageDialog("手机号码和业务流水至少输入一项！");
				return false;
			}
			document.mainForm.sel_type.value="1";
			document.mainForm.opCode.value="m088";
			document.mainForm.action="fm088show.jsp";
		  document.mainForm.submit();
		}
		
	function doClear(){
		document.all.begin_date.value="";
		document.all.end_date.value="";	
	}
		

-->
 </script>

<title>电子工单打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<FORM action="" method="post" name="mainForm">
	<input type="hidden" name="sel_type"  value="">
	<input type="hidden" name="opCode"  value="">
		<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">电子工单打印</div>
			</div>
       <table cellspacing="0">
				<tr>
					<td class="blue">服务号码</td>
					<td>
						<input type="text" value=""  name="phone_no" id="phone_no" size="20" maxlength="11" >
					</td>
          <td class="blue">业务流水</td>
					<td>
						<input type="text" value=""  name="login_accept" id="login_accept" size="20"  >
					</td>
        </tr>
        <tr>
          <td class="blue">工号</td>
          <td colspan="3">
            <input type="text" value="<%=workno%>" class="InputGrey" name="work_no" size="20" maxlength="11" readonly>
          </td>
        </tr>
				 <tr>
            <td class="blue">开始日期</td>
            <td>
              <input type="text" value="<%=dateStr%>" v_format="yyyyMMdd" name="begin_date" size="20" maxlength="8" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13)docheck1()">
							<font class="orange"> * YYYYMMDD</font>
            </td>
            <td class="blue">结束日期</td>
            <td>
				     	<input type="text" value="<%=dateStr%>" v_format="yyyyMMdd" name="end_date" size="20" maxlength="8" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13)docheck1()">
					 		<font class="orange"> * YYYYMMDD</font>
            </td>
 				</tr>
        </table>
        <TABLE cellSpacing="0">
          <TR >
            <TD id="footer">
              <div align="center">
                <input class="b_foot" type="button" name="query1"  value="查询" onclick="docheck1()"  >
                &nbsp;
                <input class="b_foot" type="button" name="return1" value="清除" onclick="doClear()" >
                &nbsp;
                <input class="b_foot" type="button" name="return2" value="关闭" onClick="parent.removeTab('<%=opCode%>')"  >
              </div>
            </TD>
          </TR>
        </TABLE>
     <%@ include file="/npage/include/footer_simple.jsp" %>
		</FORM>
</BODY>
</HTML>
