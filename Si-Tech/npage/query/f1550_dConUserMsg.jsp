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
  	String opName = "�ۺ���ʷ��Ϣ��ѯ֮�û�-�ʻ���Ӧ��ϵ";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String idNo=request.getParameter("idNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	
	String sql_str="select b.phone_no,a.contract_no,bill_order,pay_order,begin_ymd,begin_tm,end_ymd,end_tm,limit_pay,rate_flag,stop_flag from dConUserMsg a,dCustMsg b where a.id_no=b.id_no and a.id_no="+idNo;
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
		rdShowMessageDialog("��ѯ���Ϊ��,���Ѽƻ���Ϣ������!");
	</script>
<%
		return;
	}
%>

<HTML><HEAD><TITLE>�û�-�ʻ���Ӧ��ϵ</TITLE>
</HEAD>
<body>
<FORM method=post name="f1550_dConUserMsg">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�û�-�ʻ���Ӧ��ϵ</div>
		</div>
    <table cellspacing="0">
      <tbody>
      	<tr align="center">
          <th>�ֻ�����</th>
          <th>�ʻ���</th>
          <th>�ʵ�˳��</th>
          <th>����˳��</th>
          <th>��ʼ������</th>
          <th>��ʼʱ��</th>
          <th>����������</th>
          <th>����ʱ��</th>
          <th>�ʵ��޶�</th>
          <th>���ʱ�־</th>
          <th>ͣ����־</th>
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
			for(int j=0;j<result[y].length;j++)
		{
%>
		  <td class="<%=tbClass%>"><%= result[y][j]%> </td>
<%		}
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
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=�ر�>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
