<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�ʻ�������Ϣ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no=request.getParameter("idNo");
	String cust_name=request.getParameter("custName");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	
	String sql_str="select to_char(a.contract_no),a.bank_cust,a.bank_code,nvl(c.bank_name,'NULL'),a.post_bank_code,d.bank_name,'NULL',account_no from dConMsg a,dConUserMsg b,sBankCode c,sPostCode d where a.contract_no=b.contract_no and a.bank_code=c.bank_code(+) and substr(a.belong_code,1,2)=c.region_code(+) and a.post_bank_code=d.post_bank_code(+) and substr(a.belong_code,1,2)=d.region_code(+) and a.pay_code='4' and b.serial_no='0' and b.id_no="+id_no;
	/*20070508 ��÷ �޸� ���������ʻ��������в�ѯȥ��district_code ������� 
	String sql_str="select to_char(a.contract_no),a.bank_cust,a.bank_code,nvl(c.bank_name,'NULL'),a.post_bank_code,d.bank_name,'NULL',account_no from dConMsg a,dConUserMsg b,sBankCode c,sPostCode d where a.contract_no=b.contract_no and a.bank_code=c.bank_code(+) and substr(a.belong_code,1,2)=c.region_code(+) and substr(a.belong_code,3,2)=c.district_code(+) and a.post_bank_code=d.post_bank_code(+) and substr(a.belong_code,1,2)=d.region_code(+) and a.pay_code='4' and b.serial_no='0' and b.id_no="+id_no;
	*/
%>
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="8">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />

<%
  if(!retCode1.equals("000000")){
%>
   <script language="javascript">
   	  rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>");
	<script>
<%	
   return;
		}
	if (result==null||result.length==0)
	{
%>
			<script language="JavaScript">
				rdShowMessageDialog("û�з�������������!");
				history.go(-1);
			</script>
<%
	return ;	
    }
%>

<HTML><HEAD><TITLE>������Ϣ</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dConMsg">
<%@ include file="/npage/include/header.jsp" %>   
			<div class="title">
				<div id="title_zi">������Ϣ</div>
			</div>  	
      <table cellSpacing="0">
        <TBODY>
          <TR>
            <TD class="blue">�� ͬ ��</td>
            <td><%=result[0][0]%>&nbsp;</TD>
            <TD class="blue">�ͻ�����</td>
            <td><%=result[0][1]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">���д���</td>
            <td><%=result[0][2]%>&nbsp;</TD>
            <TD class="blue">��������</td>
            <td><%=result[0][3]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">�ַ�����</td>
            <td><%=result[0][4]%>&nbsp;</TD>
            <TD class="blue">�ַ�����</td>
            <td><%=result[0][5]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">�� �� ��</td>
            <td><%=result[0][6]%>&nbsp;</TD>
            <TD class="blue">�����ʺ�</td>
            <td><%=result[0][7]%>&nbsp;</TD>
          </TR>
        </TBODY>
	    </TABLE>

      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>