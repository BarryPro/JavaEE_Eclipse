<%
/********************
 version v2.0
������: si-tech
update:anln@2009-01-12 ҳ�����,�޸���ʽ
********************/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	//������� �û�ID���ֻ����롢�������š�����Ա����ɫ������
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String org_Code = (String)session.getAttribute("orgCode");  //��������	
		
	String opCode = "1550";
  	String opName = "�ۺ���ʷ��Ϣ��ѯ֮�û�������Ϣ";
	String sql_str="select to_char(open_time,'yyyymmdd hh24miss'),machine_code,to_char(hand_fee),to_char(choice_fee),to_char(machine_fee),to_char(sim_fee),to_char(cash_pay),to_char(check_pay),to_char(cash_pay+check_pay),OP_NOTE, b.login_no||'->'||b.login_name from dCustInnetDead a, dLoginMsg b where a.login_no = b.login_no and id_no="+id_no;
	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_Code%>"  retcode="retCode1" retmsg="retMsg1" outnum="11">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%	
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
	%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("��ѯ���Ϊ��,û�з�������������!");
	</script>
<%
		return;
	}
%>
<HTML>
	<HEAD>
		<TITLE>������Ϣ��</TITLE>
	</HEAD>
<body>
<FORM method=post name="f1550_dCustInnet">
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">������Ϣ��</div>
		</div> 	   
            	<table cellspacing="0">
		      <TBODY>
		        <TR>
		          <TD class="blue">����ʱ��</td>
		          <td><%=result[0][0]%>&nbsp;</TD>
		          <TD class="blue">��������</td>
		          <td><%=result[0][1]%>&nbsp;</TD>
		          <TD class="blue">��������</td>
		          <td><%=result[0][10]%>&nbsp;</TD>
		        </TR>
		        <TR>
		          <TD class="blue">�� �� ��</td>
		          <td><%=result[0][2]%>&nbsp;</TD>
		          <TD class="blue">ѡ �� ��</td>
		          <td><%=result[0][3]%>&nbsp;</TD>
		          <TD class="blue">�� �� ��</td>
		          <td><%=result[0][4]%>&nbsp;</TD>
		        </TR>
		        <TR>
		          <TD class="blue">SIM ����</td>
		          <td><%=result[0][5]%>&nbsp;</TD>
		          <TD class="blue">�ֽ𽻿�</td>
		          <td><%=result[0][6]%>&nbsp;</TD>
		          <TD class="blue">֧Ʊ����</td>
		          <td><%=result[0][7]%>&nbsp;</TD>
		        </TR>
		        <TR>
		          <TD class="blue">�����ܶ�</td>
		          <td><%=result[0][8]%>&nbsp;</TD>
		          <TD class="blue">�û���ע</td>
		          <td colspan="3"><%=result[0][9]%>&nbsp;</TD>
		        </TR>
		      </TBODY>
    		</TABLE>
      <table cellspacing="0">
	    <tr> 
	    	<td id="footer"> 
		    	<input class="b_foot" name=back onClick="history.go(-1)" type=button value="  ��  ��  ">
		        <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  ��  ��  ">
		        &nbsp; 
	   	</td>
	    </tr>
     </table>
  <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
