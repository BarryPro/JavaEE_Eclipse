<%
    /*************************************
    * 功  能: 领取网上选号SIM卡 e964
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
  <TITLE>领取网上选号SIM卡</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
  
function queryInfo(){
  if(!check(frm)) return false;
  var phoneNo = $("#phoneNo").val();
  
  frm.action="fe964_queryInfo.jsp";
  frm.submit();
}

function clearInfo(){
  window.location.href="fe964_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}

</SCRIPT>
 
<FORM method=post name="frm" >
  <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
  <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
  
  <input type="hidden" name="card_flag" value="">  <!--身份证几代标志-->
  <input type="hidden" name="m_flag" value="">   <!--扫描或者读取标志，用于确定上传图片时候的图片名-->
  <input type="hidden" name="sf_flag" value="">   <!--扫描是否成功标志-->
  <input type="hidden" name="pic_name" value="">   <!--标识上传文件的名称-->
	<input type="hidden" name="up_flag" value="0">
	<input type="hidden" name="but_flag" value="0"> <!--按钮点击标志-->
	<input type="hidden" name="upbut_flag" value="0"> <!--上传按钮点击标志-->
	<input type="hidden" name="custId" value="0">
	
	<input type="hidden" name="custName" value="0">
	<input type="hidden" name="idAddr" value="0">
	<input type="hidden" name="idAddrH" value="哈尔滨">
	<input type="hidden" name="birthDay" value="0">
	<input type="hidden" name="birthDayH" value="20090625">
	<input type="hidden" name="idValidDate" value="">
	<input type="hidden" name="custSex" value="">
	<input type="hidden" name="idSexH" value="1">
	
	
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">领取网上选号SIM卡</div>
</div>
	<TABLE cellSpacing=0>
        <tr id="deliveryTr"> 
          <td class='blue' nowrap width="20%">手机号码</td>
          <td colspan="3" width="80%">
          	<input type="text" name="phoneNo" id="phoneNo" v_type="mobphone" size="20" value="" />
          </td>
        </tr>
        <tr>
        	<td colspan="4"><font color="red">注:订单超过15天用户不领取SIM卡，系统自动销户，钱退到银行卡中</font></td>
        </tr>
        <tr>
          <td colspan="4" align="center" id="footer">
              <input type="button" id="queryBtn" name="queryBtn" class="b_foot" value="确认" onClick="queryInfo()" />   
              <input type="button" id="queryBtn" name="queryBtn" class="b_foot" value="清除" onClick="clearInfo()" />   
              <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
          </td>
        </tr>
    </TABLE>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
<%@ include file="/npage/public/hwObject.jsp" %> 
<%@ include file="interface_provider1238.jsp" %> 
</HTML>
