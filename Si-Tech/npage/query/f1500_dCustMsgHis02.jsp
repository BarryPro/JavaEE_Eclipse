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
  String opName = "�û���ʷ��Ϣ";
  
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("id_no");
	String update_accept  = request.getParameter("update_accept");
	String work_no=request.getParameter("work_no");
	String work_name=request.getParameter("work_name");
	
	String sql_str="select phone_no,to_char(open_time,'yyyymmdd hh24 mi ss'),sm_name,service_name,attr_code,nvl(credit_name,a.credit_code),to_char(credit_value),run_name,to_char(run_time,'yyyymmdd hh24 mi ss'),to_char(bill_date,'yyyymmdd hh24 mi ss'),to_char(bill_unit) from dCustMsgHis a,sSmCode b,sServiceType c,sCreditCode d,sRunCode e,sBillType f,sRegionCode g where a.sm_code=b.sm_code and b.region_code=g.region_code and a.service_type=c.service_type and a.credit_code=d.credit_code and substr(a.belong_code,1,2)=d.region_code(+) and substr(a.run_code,2,1)=e.run_code and e.region_code=g.region_code and a.bill_type=f.bill_type and f.region_code=g.region_code and a.id_no="+id_no+" and update_accept="+update_accept+" and g.login_region=substr('"+work_no+"',1,1)";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="11">
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
		rdShowMessageDialog("��ѯ���Ϊ��,�û���ʷ��Ϣ������!");
	</script>
<%
		return;
	}
%>

<HTML><HEAD><TITLE>�û���ʷ��Ϣ</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dCustMsgHis02">
    <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">������¼��Ϣ</div>
		</div>
    <table cellspacing="0">
      <tbody>
        <tr>
          <TD class="blue">�������</td>
          <td><%=result[0][0]%></TD>
          <TD class="blue">��������</td>
          <td><%=result[0][1]%></TD>
          <TD class="blue">ҵ������</td>
          <td><%=result[0][2]%></TD>
        </TR>
        <TR>
          <TD class="blue">��������</td>
          <td><%=result[0][3]%></TD>
          <TD class="blue">�û�����</td>
          <td><%=result[0][4]%></TD>
          <TD class="blue">���öȵȼ�</td>
          <td><%=result[0][5]%></TD>
        </TR>
        <TR>
          <TD class="blue">���ö�</td>
          <td><%=result[0][6]%></TD>
          <TD class="blue">�û�״̬</td>
          <td><%=result[0][7]%></TD>
          <TD class="blue">״̬�޸�ʱ��</td>
          <td><%=result[0][8]%></TD>
        </TR>
        <TR>
          <TD class="blue">����ʱ��</td>
          <td><%=result[0][9]%></TD>
          <TD class="blue">��������</td>
          <td colspan="3"><%=result[0][10]%></TD>
        </TR>
      </TBODY>
		</TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=�ر�>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>

