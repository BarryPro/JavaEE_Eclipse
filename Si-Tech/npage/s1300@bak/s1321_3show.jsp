<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:�һ���Ʊ1321
   * �汾: 1.0
   * ����: 2009/2/16
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%@ page import="java.text.*" %>

 <%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	MoneyUtil mon = new MoneyUtil();
	String workno = (String)session.getAttribute("workNo");				//��������
	String regionCode = (String)session.getAttribute("regCode");		//����

	//����ϵͳ��ˮ
	String sql_accept = "SELECT to_char(ltrim(rtrim(sMaxSysAccept.nextval))) FROM Dual";
	%>
	<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
			<wtc:sql><%=sql_accept%></wtc:sql>
			</wtc:pubselect>
	<wtc:array id="count1_new" scope="end" />	
	<%
		String i_login_accept = "";
		if(count1_new.length>0)
		{
			i_login_accept = count1_new[0][0].trim();
		}

	String i_contract_no = request.getParameter("contract_no");
    String i_begin_ym = request.getParameter("begin_ym");
	String i_end_ym = request.getParameter("end_ym");

	String i_cust_name = request.getParameter("cust_name");
	String i_phone_no = request.getParameter("phone_no");
	String i_bill_no = request.getParameter("bill_no");
	String i_bill_money = request.getParameter("bill_money");
	String i_money_total = request.getParameter("money_total");

	if (i_bill_money.equals("")) {
	   i_bill_money = "0.00";
	}

	if (i_money_total.equals("")) {
	   i_money_total = "0.00";
	}

//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
//    ArrayList retList = new ArrayList();
%>

<%
	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";
	String paySeq=i_login_accept;
	String s_flag="N";
%>	
 
<%
	 
 
	 
	
	
	String[] inParas = new String[4];
    inParas[0] = i_contract_no;
		inParas[1] = i_begin_ym;
    inParas[2] = i_end_ym;
    inParas[3] = workno;
%>
	<wtc:service name="s1323Init" routerKey="region" routerValue="<%=regionCode%>" outnum="7" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result0" start="0" length="1" scope="end"/>
	<wtc:array id="result1" start="1" length="1" scope="end"/>
	<wtc:array id="result2" start="2" length="1" scope="end"/>
	<wtc:array id="result3" start="3" length="1" scope="end"/>
	<wtc:array id="result4" start="4" length="1" scope="end"/>
	<wtc:array id="result5" start="5" length="1" scope="end"/>
	<wtc:array id="result6" start="6" length="1" scope="end"/>
<%
/*	String[][] result0 = new String[][]{};
	String[][] result1 = new String[][]{};
	String[][] result2 = new String[][]{};
	String[][] result3 = new String[][]{};
	String[][] result4 = new String[][]{};
	String[][] result5 = new String[][]{};
	String[][] result6 = new String[][]{};
*/
	System.out.println("xxxxxxxxxxx===="+retCode);
	System.out.println("xxxxxxxxxxx===="+result0[0][0]);
	String return_code = "0";
	String return_msg = retMsg;
	return_code = result0[0][0];
	if (retCode.equals("0") && result0.length >0) {
	    return_code = result0[0][0];
	}

		double shoudPay = 0.00;
    double yingsou = 0.00;
    shoudPay = Double.parseDouble(i_bill_money.trim()) +  Double.parseDouble(i_money_total.trim());
	if (return_code.equals("000000")) {
/*	   result1 = (String[][])retList.get(1);
	   result2 = (String[][])retList.get(2);
       result3 = (String[][])retList.get(3);
	   result4 = (String[][])retList.get(4);
	   result5 = (String[][])retList.get(5);
	   result6 = (String[][])retList.get(6);
*/
	   yingsou = 0.00;
	   for (int i = 0; i < result1.length; i++) {
	       yingsou += Double.parseDouble(result6[i][0]);
	   }
	}
%>
<% if (!return_code.equals("000000")) {%>
  <script language="JavaScript">
    rdShowMessageDialog("�ȶƱ�һ������ѷ�Ʊ��ѯʧ��!<%=return_msg%> ",0);
    window.location="s1321_3.jsp";
  </script>
<% } else if ((shoudPay - yingsou) < 0) { %>
  <script language="JavaScript">

    //rdShowMessageDialog("��ѯ��ʼ�·�ͬ��ѯ�����·�ʱ����̫������������!");
    rdShowMessageDialog("��ѯ�·����ѽ��Ϊ"+<%=yingsou%>+"Ԫ������¼����"+<%=shoudPay%>+"Ԫ�������϶һ�Ҫ���޷��һ���Ʊ!");
    window.location="s1321_3.jsp";
  </script>
<% } else { %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-�һ���Ʊ</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT LANGUAGE="JavaScript">
<!--
function doPrintSubmit() {
	/*getAfterPrompt()
    if(rdShowConfirmDialog("��ǰ��Ʊ������"+"<%=ocpy_begin_no%>"+",�Ƿ��ӡ��Ʊ?")==1)
	{
		document.all.check_seq.value="<%=ocpy_begin_no%>";
		document.all.bill_accept.value="<%=bill_accept%>";
		document.all.s_flag.value="first";//��һ�δ�ӡ ����Ԥռ��
		document.form.submit();
	}
	else
	{
		alert("����ȡ���ӿ� ȡ��Ԥռ");
		return false;
	}*/
	//alert("a");
	document.form.submit();
	//alert("b");
}
//-->
</SCRIPT>
</HEAD>
<BODY>
<FORM action="s1321_3print.jsp" method=post name=form>

<INPUT TYPE="hidden" name="bill_accept" value="<%=bill_accept%>">
  <INPUT TYPE="hidden" name="contract_no" value="<%=i_contract_no%>">
  <INPUT TYPE="hidden" name="begin_ym" value="<%=i_begin_ym%>">
  <INPUT TYPE="hidden" name="end_ym" value="<%=i_end_ym%>">
  <INPUT TYPE="hidden" name="cust_name" value="<%=i_cust_name%>">
  <INPUT TYPE="hidden" name="phone_no" value="<%=i_phone_no%>">
  <INPUT TYPE="hidden" name="bill_no" value="<%=i_bill_no%>">
  <INPUT TYPE="hidden" name="bill_money" value="<%=i_bill_money%>">
  <INPUT TYPE="hidden" name="money_total" value="<%=i_money_total%>">
  <INPUT TYPE="hidden" name="s_flag" value="<%=s_flag%>">	
  
    <%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�һ���Ʊ</div>
	</div>
<table cellspacing="0">
	<tr>
		<th colspan="2" class="blue">�һ�����</th>
		<th colspan="2" class="blue">�վݶһ������ѷ�Ʊ</th>
	</tr>
	
	<tr align="center">
		<td colspan="4" class="blue"><font size="4"><b>�վݶһ��ȶƱ</b></font></td>
	</tr>
	
	<tr>
		<td class="blue" nowrap>�ͻ�����</td>
		<td width="45%" nowrap><%=i_cust_name%></td>
		<td class="blue" nowrap>�ֻ�����</td>
        <td width="45%" nowrap><%=i_phone_no%></td>
	</tr>

	<tr>
		<td class="blue" nowrap>�ʻ�����</td>
		<td width="45%" nowrap><%=i_contract_no%></td>
		<td class="blue" nowrap>֧Ʊ����</td>
		<td width="45%" nowrap><%=i_bill_no%></td>
	</tr>
	
	<tr>
		<td class="blue" nowrap>��д���</td>
		<td width="45%" nowrap><%=mon.NumToRMBStr(Double.parseDouble(i_bill_money.trim()) +  Double.parseDouble(i_money_total.trim()))%></td>
		<td class="blue" nowrap>Сд���</td>
		<td width="45%" nowrap><%=Double.parseDouble(i_bill_money.trim()) +  Double.parseDouble(i_money_total.trim())%></td>
	</tr>
	
	<tr>
		<td class="blue" nowrap>�ֽ�</td>
		<td width="45%" nowrap><%=i_money_total%></td>
		<td class="blue" nowrap>֧Ʊ</td>
		<td width="45%" nowrap><%=i_bill_money%></td>
	</tr>
</table>

</div>
<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">��Ϣ��</div>
	</div>
<table>	
    <tr>
		<th width="22%" nowrap align="center">����������</th>
		<th width="11%" nowrap align="center">Ӧ��</th>
		<th width="22%" nowrap align="center">�Ż�</th>
		<th width="11%" nowrap align="center">���ɽ�</th>
		<th width="22%" nowrap align="center">��������</th>
		<th width="22%" nowrap align="center">ʵ��</th>
	</tr>

      <%
	      for (int i = 0;i < result1.length; i++) {
	      	String tdClass = ((i%2)==1)?"Grey":"";
	  %>
      <tr>
	        <td width="22%" nowrap class="<%=tdClass%>"><%=result1[i][0]%>
	        </td>
			<td width="22%" nowrap class="<%=tdClass%>"><%=result2[i][0]%>
	        </td>
			<td width="22%" nowrap class="<%=tdClass%>"><%=result3[i][0]%>
	        </td>
			<td width="22%" nowrap class="<%=tdClass%>"><%=result4[i][0]%>
	        </td>
			<td width="22%" nowrap class="<%=tdClass%>"><%=result5[i][0]%>
	        </td>
			<td width="22%" nowrap class="<%=tdClass%>"><%=result6[i][0]%>
	        </td>
      </tr>
	  <% } %>

	<tr>
		<td class="blue" nowrap>�տ�Ա</td>
		<td width="45%" nowrap><%=workno%></td>
		<td width="5%" nowrap class="blue">��Ʊ���</td>
		<td width="45%" nowrap colspan="3"><%=(new DecimalFormat("0.00")).format(shoudPay - yingsou)%></td>
	</tr>
<input type="hidden" name="check_seq">
	<tr>
    	<td align="center" id="footer" colspan="6">   
	        <input class="b_foot" name=sure type=button value=��ӡ onclick="doPrintSubmit()">
			&nbsp;
	        <input class="b_foot" name=reset type=reset value=���� onclick="history.go(-1)">
		</td>
	</tr>
</table>
     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<% } %>