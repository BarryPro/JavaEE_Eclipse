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
 <html>
 	 <head>
 	 <title>�û�ҵ��ע��ѯ</title>
	 </head>
<%
	 String opCode = "1500";
   String opName = "�ۺ���Ϣ��ѯ֮�û�ҵ��ע��Ϣ";
   String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
   String id_no=WtcUtil.repStr(request.getParameter("id_no"),"50120013758601");
   String sql_str="select a.OP_CODE, b.function_name, c.login_no, c.login_name,to_char(a.OP_TIME,'yyyymmdd hh24:mi:ss'),a.notes from dcustAssure a,sFuncCode b,dloginmsg c where a.id_no="+id_no+" and a.op_code=b.function_code(+) and a.login_no=c.login_no";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
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
	}
%>


<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�û�ҵ��ע��Ϣ</div>
		</div>
    <table cellspacing="0">
      <tbody>
          <tr align="center"> 
            <th>��������</th>
            <th>��������</th>
            <th>������</th>
          	<th>������</th>
            <th>����ʱ��</th>
            <th>��ע��Ϣ</th>
        </tr>
		<%					  
		  String tbClass="";
			for(int i=0;i<result.length;i++){
				if(i%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
        <tr align="center">
          <td class="<%=tbClass%>"><%=result[i][0].trim()%></td>
          <td class="<%=tbClass%>"><%=result[i][1].trim()%></td>
          <td class="<%=tbClass%>"><%=result[i][2].trim()%></td>
          <td class="<%=tbClass%>"><%=result[i][3].trim()%></td>
          <td class="<%=tbClass%>"><%=result[i][4].trim()%></td>
          <td class="<%=tbClass%>"><%=result[i][5].trim()%></td>
        </tr>
	    <%
	     }
	    %>
	</table>
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