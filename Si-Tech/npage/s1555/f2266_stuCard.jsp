<%
/********************
 version v2.0
������: si-tech
add by wanglma 20110526
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "����Ʒͳһ����";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	
	
	String showName = request.getParameter("showName");
	String studentNo = request.getParameter("studentNo");
	String cardNo = request.getParameter("cardNo");
%>
<html>
	<head>
		<title>����Ʒͳһ����</title>
	</head>
<script type="text/javascript">

function reValue()
{
	var cardNo=document.all.cardNo.value;
	if(isNaN(cardNo))
	{
			rdShowMessageDialog("��������ͨ���Ų�������,����������!",0);
	 		return false;
	}
  if(cardNo.trim().length!=12)
  {
  	rdShowConfirmDialog("��������ͨ���ű�����12λ,����������!",0);
		return false;
  }
 		var retvalue=cardNo;
    window.returnValue = retvalue+"~"+$("#stuCardNo").val();
    window.close();
}

function checkStuCardNo(){
   var 	stuCardNoLen = $("#stuCardNo").val().length ;
   if(stuCardNoLen < 6){
   	  	rdShowConfirmDialog("һ��ͨ�˺ű�����6λ,����������!",0);
		return false;
   }
   var chkPacket = new AJAXPacket("f2266_ajaxCheckStuCardNo.jsp","��ȴ�������");
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
			rdShowConfirmDialog("һ��ͨ�˺�ƥ�䲻��ȷ�����������룡",0);
			$("#confirm").attr("disabled",true);
			return false;
		}else if(flag == "1"){
			rdShowConfirmDialog("һ��ͨ�˺�ƥ����ȷ��",2);
			$("#confirm").attr("disabled",false);
		}else if(flag == "2"){
			rdShowConfirmDialog("һ��ͨ�˺��ѱ�ʹ�ã����������룡",0);
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
			<td class="blue" >һ��ͨ�˺�</td>
			<td colspan="3">
				<input type="text" name="stuCardNo" id="stuCardNo" maxlength="6" value="<%=studentNo%>" />
				<input type="button" class="b_text" value="У��" onclick="checkStuCardNo()" />
				<font color="orange">*</font> 
			</td>
    </tr>
  	<tr>
			<td class="blue">��������ͨ����</td>
			<td colspan="3">
				<input type="text" name="cardNo" maxlength="12" value="<%=cardNo%>" />
				<font color="orange">*</font> 
    </tr>
    
    </table>
   
    <table cellspacing="0">
    <tr>
    	<td colspan="4" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="ȷ��" onClick="reValue()" disabled />
					&nbsp;
				<input name="reset" class="b_foot" type="button" value="�ر�" onClick="window.close();">
					&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>

<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
