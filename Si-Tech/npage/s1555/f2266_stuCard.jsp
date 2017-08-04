<%
/********************
 version v2.0
开发商: si-tech
add by wanglma 20110526
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "促销品统一付奖";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	
	
	String showName = request.getParameter("showName");
	String studentNo = request.getParameter("studentNo");
	String cardNo = request.getParameter("cardNo");
%>
<html>
	<head>
		<title>促销品统一付奖</title>
	</head>
<script type="text/javascript">

function reValue()
{
	var cardNo=document.all.cardNo.value;
	if(isNaN(cardNo))
	{
			rdShowMessageDialog("获赠城市通卡号不是数字,请重新输入!",0);
	 		return false;
	}
  if(cardNo.trim().length!=12)
  {
  	rdShowConfirmDialog("获赠城市通卡号必须是12位,请重新输入!",0);
		return false;
  }
 		var retvalue=cardNo;
    window.returnValue = retvalue+"~"+$("#stuCardNo").val();
    window.close();
}

function checkStuCardNo(){
   var 	stuCardNoLen = $("#stuCardNo").val().length ;
   if(stuCardNoLen < 6){
   	  	rdShowConfirmDialog("一卡通账号必须是6位,请重新输入!",0);
		return false;
   }
   var chkPacket = new AJAXPacket("f2266_ajaxCheckStuCardNo.jsp","请等待。。。");
   chkPacket.data.add("stuCardNo" , $("#stuCardNo").val());
   core.ajax.sendPacket(chkPacket,docheckStuCardNo);
   chkPacket =null; 
}
function docheckStuCardNo(packet){
	var retMsg=packet.data.findValueByName("retMsg");
	var retCode=packet.data.findValueByName("retCode");
	var flag=packet.data.findValueByName("flag");
	if(retCode == "000000" ){
		if(flag == "0"){
			rdShowConfirmDialog("一卡通账号匹配不正确！请重新输入！",0);
			$("#confirm").attr("disabled",true);
			return false;
		}else if(flag == "1"){
			rdShowConfirmDialog("一卡通账号匹配正确！",2);
			$("#confirm").attr("disabled",false);
		}else if(flag == "2"){
			rdShowConfirmDialog("一卡通账号已被使用！请重新输入！",0);
			$("#confirm").attr("disabled",true);
			return false;
		}
	}else{
	  	rdShowConfirmDialog("errCode :"+retCode+"   errMsg: "+retMsg ,0 );
		return false;
	}
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi"><%=showName%></div>
	</div>
  <table cellspacing="0">
  	<tr>
			<td class="blue" >一卡通账号</td>
			<td colspan="3">
				<input type="text" name="stuCardNo" id="stuCardNo" maxlength="6" value="<%=studentNo%>" />
				<input type="button" class="b_text" value="校验" onclick="checkStuCardNo()" />
				<font color="orange">*</font> 
			</td>
    </tr>
  	<tr>
			<td class="blue">获赠城市通卡号</td>
			<td colspan="3">
				<input type="text" name="cardNo" maxlength="12" value="<%=cardNo%>" />
				<font color="orange">*</font> 
    </tr>
    
    </table>
   
    <table cellspacing="0">
    <tr>
    	<td colspan="4" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="确认" onClick="reValue()" disabled />
					&nbsp;
				<input name="reset" class="b_foot" type="button" value="关闭" onClick="window.close();">
					&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>

<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
