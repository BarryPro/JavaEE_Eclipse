<%
/********************
 version v2.0
������: si-tech
����:�ʻ���ʷ��Ϣ
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//������� �û�ID���ֻ����롢�������š�����Ա����ɫ������
	 String opCode = "1500";
	 String opName = "�ۺ���Ϣ��ѯ֮�ʻ���ʷ��Ϣ";
	 
	String contract_no  = request.getParameter("contract_no");
	String update_accept  = request.getParameter("update_accept");
	String work_no=request.getParameter("work_no");
	String work_name=request.getParameter("work_name");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	 
	//String sql_str="select nvl(b.bank_code,'NULL'),nvl(b.bank_name,'NULL'),nvl(c.bank_code,'NULL'),nvl(c.bank_name,'NULL'),to_char(a.contract_no),bank_cust,oddment,a.belong_code,prepay_fee,to_char(prepay_time,'yyyymmdd hh24 mi ss'),account_type,status,to_char(status_time,'yyyymmdd hh24 mi ss'),post_flag,deposit,min_ym,owe_fee,to_char(account_mark),account_limit,pay_name from dConMsgHis a,sBankCode b,sBankCode c,sPayCode d where a.bank_code=b.bank_code(+) and substr(a.belong_code,1,2)=b.region_code(+) and substr(a.belong_code,3,2)=b.district_code(+) and a.post_bank_code=c.bank_code(+) and substr(a.belong_code,1,2)=c.region_code(+) and substr(a.belong_code,3,2)=c.district_code(+) and a.pay_code=d.pay_code and substr(a.belong_code,1,2)=d.region_code and a.contract_no="+contract_no;
	String pwdcheck = request.getParameter("pwdcheck");
	String inLoginAccept="0";
	String inChnSource="01";
	String inOpCode="1500";
	String inLoginNo=work_no;
	String inLoginPwd = (String)session.getAttribute("password"); 
	String inPhoneNo = "";
	String inUserPwd="";
	
 
	String inOpNote="�ʺ�"+contract_no+"����1500���ʻ���ʷ��Ϣ��ѯ2";
	String s_flag="4";
%>
<wtc:service name="sCustTypeQryJ" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="20">
	<wtc:param value="<%=inLoginAccept%>"/>
	<wtc:param value="<%=inChnSource%>"/>	
	<wtc:param value="<%=inOpCode%>"/>
	<wtc:param value="<%=inLoginNo%>"/>
	<wtc:param value="<%=inLoginPwd%>"/>
	<wtc:param value="<%=inPhoneNo%>"/>
	<wtc:param value="<%=inUserPwd%>"/>
	
	<wtc:param value="<%=contract_no%>"/>
	<wtc:param value="<%=s_flag%>"/>
	<wtc:param value="<%=inOpNote%>"/>
	</wtc:service>
<wtc:array id="result" scope="end" />
		
<%	
	if(!retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("����δ�ܳɹ�,�������<%=retCode1%><br>������Ϣ<%=retMsg1%>!");
			history.go(-1);
		</script>
<%
		return;
	}


	if (result==null||result.length==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("<br>û�з�������������",1);
	history.go(-1);
</script>
<%	}
%>
<HTML><HEAD><TITLE>�ʻ���ʷ��Ϣ</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dConMsgHis02">
		<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�ʻ���ʷ��Ϣ</div>
			</div>
            <TABLE cellSpacing="0">
              <TBODY>
                <TR>
                  <td>�� �� �� </td>
                  <td><%=result[0][4]%></td>
                  <td>�ʻ�����</td>
				  <%
					if(pwdcheck=="Y" ||pwdcheck.equals("Y"))
					{
						%>
						<td><%=result[0][5]%></td>
						<%
					}
					else
					{
						%>
						<td><%=result[0][5].substring(0,1)%>XX</td>
						<%
					}
				  %>	
                  
                </TR>
                <TR>
                  <td>���д���</td>
                  <td><%=result[0][0]%></td>
                  <td>�������� </td>
                  <td><%=result[0][1]%></td>
                </TR>
                <TR>
                  <td>�ַ�����</td>
                  <td><%=result[0][2]%></td>
                  <td>�������� </td>
                  <td><%=result[0][3]%></td>
                </TR>
              </TBODY>
	    </TABLE>
            <TABLE cellSpacing="0">
              <TBODY>
                <TR>
                  <td>�ʻ���ͷ</td>
                  <td><%=result[0][6]%></td>
                  <td>�ʻ�����</td>
                  <td><%=result[0][7]%></td>
                  <td>Ԥ �� �� </td>
                  <td><%=result[0][8]%></td>      
                </TR>
                <TR>
                 
                  
                   <td>Ԥ��ʱ��</td>
                  <td><%=result[0][9]%></td>
                  <td>�ʺ�����</td>
                  <td><%=result[0][10]%></td>
                  <td>Ƿ�ѱ�־</td>
                  <td><%=result[0][11]%></td>    
                  
                  
                </TR>
                <TR>
                   <td>״̬�ı�ʱ��</td>
                  <td><%=result[0][12]%></td>
                  <td>�ʼı�־</td>
                  <td><%=result[0][13]%></td>
                  <td>Ѻ&nbsp&nbsp&nbsp&nbsp��</td>
                  <td><%=result[0][14]%></td>    
                  
                </TR>
                <TR>
                  
                   <td>��СǷ������</td>
                  <td><%=result[0][15]%></td>
                  <td>Ƿ&nbsp&nbsp&nbsp&nbsp��</td>
                  <td><%=result[0][16]%></td>
                  <td>��&nbsp&nbsp&nbsp&nbsp�� </td>
                  <td><%=result[0][17]%></td>    
                  
                </TR>
                <TR>
                   <td>�ʻ�������</td>
                  <td><%=result[0][18]%></td>
                  <td>���ʽ</td>
                  <td><%=result[0][19]%></td>
                  <td>&nbsp</td>
                  <td>&nbsp</td>    
                </TR>
              </TBODY>
	    </TABLE>
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id=footer>
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
        <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
