<%
/********************
version v2.0
������: si-tech
����:�ۺ���Ϣ��ѯ֮�ʻ�Ѻ����ϸ
update:zhanghonga@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//������� �û�ID���ֻ����롢�������š�����Ա����ɫ�����š�
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no = request.getParameter("workNo");
	String work_name = request.getParameter("workName");
	
	
	 String opCode = "1500";
	String opName = "�ۺ���Ϣ��ѯ֮�ʻ�Ѻ����ϸ";
	String cust_name=request.getParameter("custName");
	
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String deptCode = baseInfo[0][16];
	String regionCode = deptCode.substring(0,2);
	
	String sql_str="select a.pay_type,a.deposit,a.every_fee,to_char(a.begin_time,'yyyymmdd hh24 mi ss'),to_char(a.end_time,'yyyymmdd hh24 mi ss'),a.deposit_status,to_char(a.should_num),to_char(a.payed_num),a.payed_deposit,a.current_deposit,nvl(b.pay_type,'NULL'),nvl(b.deposit,0) from dDepositMsg a,dDepositPay b where b.contract_no(+)=a.contract_no and b.pay_type(+)=a.pay_type and a.contract_no="+contract_no;
	
	/**
	ArrayList arlist = new ArrayList();
	try{
	 	S1100View callView = new S1100View();
		arlist = callView.view_spubqry32("12",sql_str);
	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	String [][] result = new String[][]{{"0","1","2","3","4","5","6","7","8","9","10","11"}};
	int result_row = Integer.parseInt((String)arlist.get(1));
	**/
%>

	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="12">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%	
	if(!retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>");
			history.go(-1);
		</script>
<%
		return;
	}

	if (result==null||result.length==0){
%>
		<script language="JavaScript">
			rdShowMessageDialog("û�з�������������!");
			history.go(-1);
		</script>
<%	
	return;
	}
%>

<HTML><HEAD><TITLE>�ʻ�Ѻ����ϸ</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dDepositQry">
	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�ʻ�Ѻ����ϸ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ͻ�����:<%=cust_name%></div>
			</div>
      <TABLE cellSpacing="0">
        <TBODY>
          <TR>
            <TD class="blue">�ʻ����� <input class="InputGrey" value="<%=bank_cust%>" maxlength="58" size=58 readonly></TD>
            <TD class="blue">Ѻ������ <input class="InputGrey" value="<%=result[0][0]%>" maxlength="10" size=10 readonly></TD>
            <TD class="blue">Ѻ�� <input class="InputGrey" value="<%=result[0][1]%>" maxlength="10" size=10 readonly></TD>
          </TR>
        </TBODY>
	    </TABLE>

      <TABLE cellSpacing="0">
        <TBODY>
          <TR>
            <TD class="blue">ÿ��ת�� <input class="InputGrey" value="<%=result[0][2]%>" maxlength="15" size=15 readonly></TD>
            <TD class="blue">��ʼʱ�� <input class="InputGrey" value="<%=result[0][3]%>" maxlength="19" size=19 readonly></TD>
            <TD class="blue">����ʱ�� <input class="InputGrey" value="<%=result[0][4]%>" maxlength="19" size=19 readonly></TD>
            <TD class="blue">Ѻ��״̬ <input class="InputGrey" value="<%=result[0][5]%>" maxlength="10" size=10 readonly></TD>
          </TR>
          <TR>
            <TD class="blue">ת����� <input class="InputGrey" value="<%=result[0][6]%>" maxlength="15" size=15 readonly></TD>
            <TD class="blue">��ת����� <input class="InputGrey" value="<%=result[0][7]%>" maxlength="17" size=17 readonly></TD>
            <TD class="blue">��ת��� <input class="InputGrey" value="<%=result[0][8]%>" maxlength="19" size=19 readonly></TD>
            <TD class="blue">��ǰ��� <input class="InputGrey" value="<%=result[0][9]%>" maxlength="10" size=10 readonly></TD>
          </TR>
        </TBODY>
	    </TABLE>
      <TABLE cellspacing="0">
        <TBODY>
          <TR>
            <th>Ѻ������ </th>
            <th>Ѻ���� </th>
          </TR>
<%	      

			String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
%>
	        <tr align="center">
<%    	
				for(int j=10;j<12;j++){
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%	        }
%>
	        </tr>
<%
              }
%>
        </TBODY>
	    </TABLE>
         
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
			</FORM>
		</BODY>
	</HTML>
