<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:�һ���Ʊ1321
   * �汾: 1.0
   * ����: 2009/1/16
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
 
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String groupId = (String)session.getAttribute("groupId");
	String workno = (String)session.getAttribute("workNo");				//��������
	String opCode = (String)request.getParameter("opCode");					//��������
	String opName = (String)request.getParameter("opName");					//ģ����
	String regionCode = (String)session.getAttribute("regCode");			//����
	String i_contract_no = request.getParameter("contract_no");				//�˻�����
    String i_login_accept = request.getParameter("login_accept");			//�ɷ���ˮ
	String i_year_month = request.getParameter("year_month");				//�ɷ��·�
   
    // xl add for ��Ʊ���� begin
	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";//bill_accept

	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	//inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from WLOGININVOICE where LOGIN_NO = :workNo";
	//inParam2[1]="workNo="+workno;
	


	String[] inParas = new String[4];
	inParas[0] = i_contract_no;
	inParas[1] = i_login_accept;
	inParas[2] = i_year_month;
	inParas[3] = workno;

%>
	<wtc:service name="s1321Init" routerKey="region" routerValue="<%=regionCode%>" outnum="24" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String return_code = retCode;
	String return_msg  = retMsg;
	if (!return_code.equals("000000")) {%>
	  <script language="JavaScript">
		    rdShowMessageDialog("�վݶһ��ȶƱ��ѯʧ��!(<%=return_msg%>)",0);
		    window.location="s1321_1.jsp";
	  </script>
	<% } else { %>


<!--xl add ��ƱԤռ-->
	<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=result[0][2]%>"  outnum="8" >
			 
			<wtc:param value="<%=i_login_accept%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value=""/><!--op_time-->
			<wtc:param value="<%=result[0][2].trim()%>"/>
			<wtc:param value="0"/><!--id_no-->
			<wtc:param value="<%=i_contract_no%>"/>
			<wtc:param value=""/><!--s_check_num-->
			<wtc:param value=""/><!--��Ʊ���� ��һ�ε���ʱ ���� ���ڷ�����tpcallBASD�Ľӿ�ȡ��-->
			<wtc:param value=""/><!--��Ʊ���� ��-->
			<wtc:param value=""/><!--sm_code-->
			<wtc:param value="<%=result[0][6].trim()%>"/><!--Сд���-->
			<wtc:param value=""/><!--��д���-->
			<wtc:param value=""/><!--��ע-->
		 
			<wtc:param value="6"/><!--Ԥռ��6 ȡ����5��δ��ӡ-->
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/><!--����-->
			<wtc:param value="<%=result[0][1].trim()%>"/><!--����ģ�-->
			<wtc:param value="0"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=regionCode%>"/>
			<wtc:param value="<%=groupId%>"/>	
			<wtc:param value="3"/>
	</wtc:service>
		
	<wtc:array id="bill_opy" scope="end" />
	<%
		if(bill_opy!=null&&bill_opy.length>0)
		{
			return_flag=bill_opy[0][0];
			if(return_flag.equals("000000"))
			{
				 ocpy_begin_no=bill_opy[0][2];
				 ocpy_end_no=bill_opy[0][3];
				 ocpy_num=bill_opy[0][4];
				 res_code=bill_opy[0][5];
				 bill_code=bill_opy[0][6];
				 bill_accept=bill_opy[0][7];
			}
			else
			{
				return_note=bill_opy[0][1];
				%>
					<script language="javascript">
						alert("��ƱԤռʧ��!����ԭ��:"+"<%=return_note%>");
						history.go(-1);
					</script>
				<%
			}
		}
	%>
	
 

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-�һ���Ʊ</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT LANGUAGE="JavaScript">

function doPrintSubmit() {
	getAfterPrompt();
		if(rdShowConfirmDialog("��ǰ��Ʊ������"+"<%=ocpy_begin_no%>"+",�Ƿ��ӡ��Ʊ?")==1)
		{
		document.form.action="s1321_1print.jsp?check_seq="+"<%=ocpy_begin_no%>"+"&s_flag="+"N"+"&bill_code="+"<%=bill_code%>";
		document.form.submit();
		}
    else
		{
			return false;
		}
}

</SCRIPT>

</HEAD>
<BODY>
<FORM action="" method=post name=form>
  <INPUT TYPE="hidden" name="contract_no" value="<%=i_contract_no%>">
  <INPUT TYPE="hidden" name="login_accept" value="<%=i_login_accept%>">
  <INPUT TYPE="hidden" name="year_month" value="<%=i_year_month%>">
  <%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�һ���Ʊ</div>
	</div>
<table cellspacing="0">
	<tr> 
		<th width=20%>�һ�����</th>
		<th colspan="3">�վݶһ��ȶƱ</th>
	</tr>
	<tr align="center"> 
		<td bgcolor="orange" colspan="4"><font size="4"><b>�վݶһ��ȶƱ</b></font></td>
	</tr>
	<tr> 
		<td class="blue" nowrap width=20%>�ͻ�����</td>
		<td nowrap colspan="3"><%=result[0][1]%></td>
	</tr>
            
	<tr> 
		<td class="blue" nowrap width=20%>�ֻ�����</td>
		<td nowrap colspan="3"><%=result[0][2]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>�ʻ�����</td>
		<td colspan="3" nowrap><%=result[0][3]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>֧Ʊ����</td>
		<td colspan="3" nowrap><%=result[0][4]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>��д���</td>
		<td colspan="3" nowrap><%=result[0][5]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>Сд���</td>
		<td colspan="3" nowrap><%=result[0][6]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>�ֽ�</td>
		<td nowrap><%=result[0][7]%></td>
		<td class="blue" nowrap>֧Ʊ</td>
		<td nowrap><%=result[0][8]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap>��Ϣ�� </td>
		<td colspan="3" nowrap><%=result[0][9]%></td>
	</tr>

	<tr> 
		<td class="blue" nowrap width=20%>�տ�Ա </td>
		<td colspan="3" nowrap><%=result[0][10]%></td>
    </tr> 
    
    <tr>
    	<td id="footer" align="center" colspan="4">           
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