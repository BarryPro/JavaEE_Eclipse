<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/1/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		String workno = (String)session.getAttribute("workNo");
		String opCode = "zg17";
		String opName = "月结发票打印";
		//String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String[] mon = new String[]{"","","","","",""};

		Calendar cal = Calendar.getInstance(Locale.getDefault());
		cal.set(Integer.parseInt(dateStr.substring(0,4)),
						  (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
		for(int i=0;i<=5;i++)
		  {
				  if(i!=5)
				  {
					mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
					cal.add(Calendar.MONTH,-1);
				  }
				  else
					mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
		  }
		 activePhone = request.getParameter("activePhone");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
function docheck() {
   if (document.mainForm.contract_no.value.length == 0) {
      rdShowMessageDialog("手机号码不能为空，请重新输入 !!")
      document.mainForm.contract_no.focus();
      return false;
   } else if (document.mainForm.contract_no.value.length < 11) {
      rdShowMessageDialog("手机号码不能小于11位，请重新输入 !!")
      document.mainForm.contract_no.focus();
      return false;
   } 
 
   if (document.mainForm.begin_ym.value.length == 0) {
      rdShowMessageDialog("缴费月份不能为空，请重新输入 !!")
      document.mainForm.begin_ym.focus();
      return false;
   } else if (document.mainForm.begin_ym.value.length < 6) {
      rdShowMessageDialog("缴费月份不能小于6位，请重新输入 !!")
      document.mainForm.begin_ym.focus();
      return false;
   }
   
   // 20140701后才可以兑换 if(document.mainForm.begin_ym.value<"201407") if(document.mainForm.begin_ym.value<"201307")
   
   if(document.mainForm.begin_ym.value<"201406")
   {
	   rdShowMessageDialog("新版月结发票需在201407后才可办理!")
       return false;
   }
   else
   {
	 /*
	 if(document.mainForm.cus_pass.value=="")
	 {
		rdShowMessageDialog("请输入用户密码!");
	 	return false;
	 }
	 else
	 {
		document.mainForm.password.value=document.mainForm.cus_pass.value;
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
		//dcustmsgdead的密码校验 这个页面可能得换
		checkPwd_Packet.data.add("custType", "01");						//01:手机号码 02 客户密码校验 03帐户密码校验
		checkPwd_Packet.data.add("phoneNo", document.mainForm.contract_no.value);		//移动号码,客户id,帐户id
		checkPwd_Packet.data.add("custPaswd", document.getElementById("cus_pass").value);//用户.客户.帐户密码
		checkPwd_Packet.data.add("idType", "");							//en 密码为密文，其它情况 密码为明文
		checkPwd_Packet.data.add("idNum", "");							//传空
		checkPwd_Packet.data.add("loginNo", "<%=workno%>");				//工号
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	 }
	 */ 
	document.mainForm.action="zg17_2.jsp";		 
   }	
   
	document.mainForm.submit();
} 

 function sel1()
{
    window.location.href='s1321_1.jsp';
 }

 function sel2() {
    window.location.href='s1321_2.jsp';
 }

 function sel3(){
     window.location.href='s1321_3.jsp';
 }
 
 function doclear(){
 	 mainForm.reset();
 }
-->
 </script> 
 
<title>黑龙江BOSS-兑换发票</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="mainForm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="password"/>
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">月结发票打印</div>
	</div>
<table cellspacing="0">
  
                
	<tr> 
		<td class="blue" nowrap>手机号码</td>
		<td  >
			<input class="button"type="text" value="<%=activePhone%>" readonly name="contract_no" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange">*</font>
		</td>
		<!--
		<td class="blue"><div id="pass_msg">用户密码</div></td>
		<td>
			<jsp:include page="/npage/common/pwd_one.jsp">
			<jsp:param name="width1" value="16%"  />
			<jsp:param name="width2" value="34%"  />
			<jsp:param name="pname" value="cus_pass"  />
			<jsp:param name="pwd" value="12345"  />
			</jsp:include>
		</td>
		-->
	</tr>

	<tr> 
		<td class="blue" nowrap>打印账期</td>
		<td colspan=3> 
			<input class="button"type="text" name="begin_ym" size="20" maxlength="6"  onKeyPress="return isKeyNumberdot(0)"  value="<%=mon[1]%>">(YYYYMM)
			<font color="orange">*</font>
		</td>
		 
	</tr>
				
	

	<TR> 
		<TD align="center" id="footer" colspan="4"> 
			<input type="button" name="query"  class="b_foot" value="查询" onclick="docheck()" index="9">
			&nbsp;
			<input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" index="10">
			&nbsp;
			<input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" index="13">
		</TD>
	</TR>
</table>
	 <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
 </BODY>
</HTML>