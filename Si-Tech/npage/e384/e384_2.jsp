<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-18 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
    
    String opCode = "e384";
	String opName="���ͳ�ֵ����ֵ";
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String cardNo_old = request.getParameter("cardNo");
	String phoneNo = request.getParameter("phoneNo");
	String rownum = request.getParameter("rowId");
	String cardNo = cardNo_old+rownum;
	String cardNoNew = request.getParameter("cardNoNew");
	String counts="0";
	int count1=0;
	//String sql_count="select to_char(count(phone_no)) from wchargecardmsgnew where phone_no='?' and card_no='?' ";
	String mz = request.getParameter("kmz");
 %>
	
<HTML>
<HEAD>
<script language="javascript">
	function doCfms()
	{
		if(document.frm2.pass.value=="")
		{
			rdShowMessageDialog("�����뿨��!");
			return false;
		}
		else
		{
			var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ����ֵ��");
			if (prtFlag==1)
			{
				var phone_no = document.frm2.phone_no.value;
				
				var actions = "e384_3.jsp?phone_no="+phone_no+"&ppsCardPin="+document.all.pass.value+"&cardNo="+document.frm2.cardNo.value+"&rownum="+"<%=rownum%>";
				//alert("rownum is "+"<%=rownum%>");
				document.all.frm2.action=actions;
				document.all.frm2.submit();
				 
			}
		}
		
	}
	
</script>
<TITLE>��ֵ���ֹ���ֵ</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</head>

<BODY>
<form name="frm2" method="post" action="">      
  <%@ include file="/npage/include/header.jsp" %>   
  <div class="title">
			<div id="title_zi">���ͳ�ֵ����ֵ����</div>
  </div>
<input type="hidden" name="phone_no" value="<%=phoneNo%>">
  <table cellspacing="0">
      <tr align="center"> 
        <th>����</th>
		 
		<th>����</th>
	  </tr>
	  <tr>
		<th><input type="text" name="cardNo" readOnly value="<%=cardNoNew%>"></th>
		 
		<th><input type="password" name="pass"   maxlength="18" size="40"></th>
	  </tr>
	  <tr> 
	  <input type="hidden" name="mz" value="<%=mz%>">
      <td id="footer" colspan="6"> 
		  <input class="b_foot" type="button" name="cfm" value="��ֵ" onClick="doCfms()">
          <input class="b_foot" type="button" name="return" value="����" onClick="window.location='e384_1.jsp?activePhone='+'<%=phoneNo%>'+'&opCode=e384&opName=���ͳ�ֵ����ֵ&final_flag=1'">
      </td>
    </tr>
  </table>
</DIV>
</DIV>
</form>
</body>
</html>
