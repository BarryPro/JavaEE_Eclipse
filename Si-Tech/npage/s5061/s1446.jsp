<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-------------------------------------------->
<!---日期:  2005-06-02                    ---->
<!---作者:  Doucm                         ---->
<!---代码:  s1446_integral                ---->
<!---功能：改号通知                       ---->
<!---修改：                               ---->
<!-------------------------------------------->
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.09
 模块:改号通知
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../include/title_name.jsp" %>
<%
	String phoneNo = (String)request.getParameter("activePhone");
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	
	String loginName = (String)session.getAttribute("workName");
	String accountType = (String)session.getAttribute("accountType");
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<%@ include file="../../npage/s5061/head_1446_javascript.htm" %>
</head>
<script language=javascript>
function showWorldMsg()
{
     if( document.all.r_cus[0].checked){}
}
$(document).ready(function(){
	$("#op_type").bind("change",function(){
		var opTypeValue = $("#op_type").val();
		if(opTypeValue == "申请"){
			document.all.vHandFee.value = "10.00";     //huangrong add 2011-5-26 修改“改号通知(1446)”业务,功能费由默认是10改为10.00元		
			document.all.vRealFee.value = "10.00";	//huangrong add 2011-5-23 修改“改号通知(1446)”业务,实收金额默认是10.00元		
		}else{
			document.all.vHandFee.value = "0";
		}
	});
});
//如果为客服工号则直接展现页面   hejwa add 2013年10月15日15:57:56         
$(document).ready(function(){
	if("<%=accountType%>"=="2"){
		$("#qryId_No").hide();
		simChk();
	}
});
 
</script>
<body onload="doLoad();">
<form action="1446BackCfm.jsp" method="POST" name="s1446"  onKeyUp="chgFocus(s1446)">
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	
	<input type="hidden" name="idNo" value="">
	<input type="hidden" name="smCode" value="">
	<input type="hidden" name="belongCode" value="">
	<input type="hidden" name="userPassword" value="">
	<input type="hidden" name="runCode" value="">
	<input type="hidden" name="idName" value="">
	<input type="hidden" name="idIccid" value="">
	<input type="hidden" name="ownerGrade" value="">
	<input type="hidden" name="card_name" value="">
	<input type="hidden" name="totalOwe" value="">
	<input type="hidden" name="loginAccept" value="">
	<input type="hidden" name="opCode" value="1446">
	<input type="hidden" name="op_code" value="1446">
	<%@ include file="../../include/remark.htm" %>
        <table cellspacing="0">
          <tr> 
            <td class="blue">用户号码</td>
            <td> 
              <input class="InputGrey"  type="text" name="phoneno" value="<%=phoneNo%>" maxlength=11 v_must="1" v_type="mobphone2"  readOnly >  <%--芦学琛20060310把mobphone改为mobphone2用于兼容联通号码--%>        
              <input class="b_text" type="button" name="qryId_No"  id="qryId_No" value="查询"  onClick="simChk()" >            
			</td>

               <%--芦学琛20060522 add --%>

			<td class="blue">操作类型</td>
			<td>
				<select name="op_type" id="op_type" onchange="getBefore();">
				</select>
			</td>
             <%--芦学琛20060522 end --%>


          </tr>
          <tr> 
            <td class="blue">用户名称</td>
            <td> 
                <input name="custName" type="text" class="InputGrey" index="6" readonly >
            </td>
            <td class="blue">业务类型</td>
            <td> 
             <input name="smName" type="text" class="InputGrey" index="6" readonly >
            </td>
          </tr>
          <tr> 
            <td class="blue">运行状态</td>
            <td> 
              <input type="text" class="InputGrey" name="runName" value="" tabindex="0" readonly >
            </td>
            <td class="blue">客户属性</td>
            <td> 
             <input type="text" class="InputGrey" name="gradeName" value="" tabindex="0" readonly >
            </td>
          </tr>
          <tr> 
			<td class="blue">预存款</td>
            <td>
              <input class="InputGrey" type="test" name="totalPrepay" value="" readonly >
            </td>
            
            <td class="blue">变更号码</td>
            <td> 
            <input type="text" name="transPhone" value="" onfocus="selType()" v_must=1  v_type=mobphone v_mixlength=1  tabindex="0" >
            </td>
          </tr>
		  <tr id="ywlb" name="ywlb" style="display:none"><%--芦学琛20060526 让其不可见--%>
			<td class="blue">业务类别</td>
            <td> 
              <input class="InputGrey" type="text" name="opName" value="" tabindex="0" readonly onclick="dochang()">
            </td>
          </tr>
          <tr> 
            <td colspan="4"><font color="red"><b>请注意变更号码的准确性!</b></font></td>
          </tr>
          <!--
		  <tr id="note1" name="note1" style="display:none"> 
            <td colspan="4"><font color="red"><b>请注意手续费标准资费为30元，但最低不能小于10元; 联通客户免费!</b></font></td>
          </tr>
          -->
          <input type="hidden" id="note1" name="note1" />
           <tr id="note2"  name="note2" style="display:none"> 
            <td class="blue"> 
              <div align="left">功能费</div>
            </td>
            <td colspan="3"> 
            <input id=Text2 type=text size=17 index="3" name="vHandFee" value="0.00" v_type=float>
              实收： 
                <input name="vRealFee" type="text" value="0.00" index="24">
              找零： 
                <input colspan="2" name="vPayChange" type="text" class="InputGrey" value="0" readonly="true">
            </td>
          </tr>
		  <tr id="note3" name="note3" style="display:none"> 
            <td class="blue">退功能费</td>
			<td colspan="4">
			  <input class="InputGrey" type="test" name="paymoney" value="" readonly>
			</td>
          </tr>
		  <tr> 
            <td class="blue"> 
              <div align="left">备注</div>
            </td>
            <td colspan="4"> 
              <input type="text" class="InputGrey" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
            </td>
          </tr>
          <tr style="display:none">
            <td class="blue"> 
              <div align="left">用户备注</div>
            </td>
            <td colspan="4"> 
            <input type="text" class="InputGrey" name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  readOnly index="28" maxlength=60> 
            </td>
          </tr>
         
          <tr> 
            <td colspan="4" id="footer"> 
              <div align="center"> 
                <input class="b_foot" type="button" name="confirm" value="打印&确认"  onClick="printCommit()" index="26" disabled >
                <input class="b_foot" type=reset name=back value="清除" onClick="document.all.confirm.disabled=true;" >
                <input class="b_foot" type="button" name="b_back" value="关闭"  onClick="removeCurrentTab()" index="28">
              </div>
            </td>
          </tr>
        </table>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>             
</DIV>        
   <%@ include file="/npage/include/footer_simple.jsp" %>   
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 

</html>
