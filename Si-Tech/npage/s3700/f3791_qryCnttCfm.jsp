<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">   
<!-------------------------------------------->
<!---����   2008-7-7                     	---->
<!---����   zhouzy                        ---->
<!---����   f1500_qryCnttCfm           		---->
<!---����   �ͻ�ͳһ�Ӵ���ѯ          		---->
<!-------------------------------------------->  	
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	String sContactId  = request.getParameter("sContactId");
	String beginDateStr=request.getParameter("beginDateStr");
	String endDateStr=request.getParameter("endDateStr");
	if(!beginDateStr.equals("")||beginDateStr!=null){
	beginDateStr=beginDateStr.substring(0,4)+beginDateStr.substring(5,7)+beginDateStr.substring(8);
	}
	if(!endDateStr.equals("")||endDateStr!=null){
	endDateStr=endDateStr.substring(0,4)+endDateStr.substring(5,7)+endDateStr.substring(8);
	}
	String opCode = "3791";
	String opName="�Ӵ��켣��ѯ";	
%>
<wtc:service name="sQryCnttTrack" outnum="9" >
  	<wtc:param value="<%=sContactId%>"/>	
  	<wtc:param value="<%=beginDateStr%>"/>	
  	<wtc:param value="<%=endDateStr%>"/>	
	</wtc:service>
	<wtc:array id="result" scope="end"/>	
<%	
	if(!retCode.equals("000000")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=retMsg%>!",0);
	history.go(-1);
</script>
<%
return;	
}
if (result.length==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("û�з�������������!",0);
	history.go(-1);
</script>
<%
return;
}
%>
<HTML><HEAD><TITLE>�ͻ�ͳһ�Ӵ���ѯ</TITLE>
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp" %>
    <TABLE cellSpacing=0>
       <tr align="center">
        <th>�Ӵ�ID</th>
        <th>ҵ����ˮ��ʶ</th>
        <th>�켣��ʶ</th>
        <th>�Ӵ��켣����</th>
        <th>�Ӵ��켣����</th>
        <th>IVR�ڵ���</th>
        <th>�û�����ʱ��</th>
        <th>�û������켣��Ҫ</th>
        <th>��ע</th>
     	</tr>
     	<%for(int i=0;i<result.length;i++){%>
     		<tr>
     		<td class="Grey"><%=result[i][0]%></td>
				<td class="Grey"><%=result[i][1]%></td>
				<td class="Grey"><%=result[i][2]%></td>
				<td class="Grey"><%=result[i][3]%></td>
				<td class="Grey"><%=result[i][4]%></td>
				<td class="Grey"><%=result[i][5]%></td>
				<td class="Grey"><%=result[i][6]%></td>
				<td class="Grey"><%=result[i][7]%></td>
				<td class="Grey"><%=result[i][8]%></td>
     			

    	</tr>	
     	<%}%>	
     	</table>
     	<TABLE cellSpacing=0>
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
      </table>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

