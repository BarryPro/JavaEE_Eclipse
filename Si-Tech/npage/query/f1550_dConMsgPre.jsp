<%
/********************
 version v2.0
������: si-tech
����:�ۺ���Ϣ��ѯ֮Ԥ�������Ϣ
update:anln@2009-1-12
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
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String opCode = "1550";
	String opName = "�ۺ���ʷ��Ϣ��ѯ֮Ԥ�������Ϣ";
	String org_Code = (String)session.getAttribute("orgCode");  //��������		
	String sql_str="select pay_name,prepay_fee,last_prepay,add_prepay,live_flag,allow_pay,begin_dt,end_dt from dConMsgPreDead a,sPayType b where a.pay_type=b.pay_type and a.contract_no="+contract_no;
	
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_Code%>"  retcode="retCode1" retmsg="retMsg1" outnum="8">
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
		<TITLE>Ԥ�������Ϣ</TITLE>	
	</HEAD>
<body>
<FORM method=post name="f1550_dConMsgPre">
	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">Ԥ�������Ϣ</div>
			</div>
  
      <table cellspacing="0" >        
              <TBODY>
                <TR>
                  <th>�ʻ���Ŀ</th>
                  <th>Ԥ���</th>
                  <th>�ϴ�Ԥ��</th>
                  <th>���ڷ���</th>
                  <th>���־</th>
                  <th>������ </th>
                  <th>��ʼ����</th>
                  <th>��������</th>
                </TR>
<%	      for(int y=0;y<result.length;y++){
%>
	        <tr>
<%    	        for(int j=0;j<result[0].length;j++){
%>
	          <td><%= result[y][j]%></td>
<%	        }
%>
	          </tr>
<%	      }
%>
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
</BODY></HTML>
