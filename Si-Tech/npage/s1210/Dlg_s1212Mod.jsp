<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> <html 
xmlns="http://www.w3.org/1999/xhtml"> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<%
	String opCode = "1212";
	String opName = "������ϸ���";
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
  String billOrder=WtcUtil.repNull(request.getParameter("billOrder"));
  String feeCode=WtcUtil.repNull(request.getParameter("feeCode"));
  String detailCode=WtcUtil.repNull(request.getParameter("detailCode"));
  String feeName=WtcUtil.repNull(request.getParameter("feeName"));
  String per=WtcUtil.repNull(request.getParameter("per"));
%>

<head>
<TITLE><%=opName%></TITLE>
<script>
 function ret()
 {
   if(check(frm))
   {
     if(parseFloat(document.all.per.value)>1)
	 {
        rdShowMessageDialog("���ñ��ʲ��ܴ���1��");
		document.all.per.value="";
		document.all.per.focus();
        return;
	 }

     window.returnValue=document.all.billOrder.value+"#"+document.all.per.value;
     window.close();
   }
   else
	   return;
 }
</script>
<body>
	<form action="" method=post name="frm">
		<%@ include file="/npage/include/header_pop.jsp" %> 
		<div class="title">
<div id="title_zi"><%=opName%></div>
</div>
		<table>               
      <tr> 
        <td align="center" nowrap> 
           ���ô���
        </td>
				<td align="center" nowrap> 
           ��ϸ����
        </td>
        <td align="center" nowrap> 
           ��������
        </td>
        <td align="center" nowrap> 
           ����˳��
        </td>
        <td align="center" nowrap> 
           ���ñ���
        </td>
      </tr>
      <tr> 
        <td  nowrap> 
          <input type="text" name="feeCode" value="<%=feeCode%>" readonly>
        </td>
        <td align="center" nowrap> 
          <input type="text" name="feeCode" value="<%=detailCode%>" readonly>
        </td>
				<td align="center" nowrap> 
					<input type="text" name="feeName"  value="<%=feeName%>" readonly>
				</td>
				<td align="center" nowrap> 
					<input type="text" name="billOrder" size="5" value=<%=billOrder%> v_minlength=1 v_maxlength=3 v_type=0_9 maxlength="3">
				</td>
				<td align="center" nowrap>  
					<input type="text" name="per" size="7" value=<%=per%> v_minlength=1 v_maxlength=7 v_type=cfloat> 
				</td>
			</tr>
			<tr>
				<td id="footer" nowrap align="center" colspan="5">
					<input type="button" class="b_foot" value="ȷ��" onclick="ret()">
				</td>
			</tr>
		</table>
		<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>
</body>
</html>
