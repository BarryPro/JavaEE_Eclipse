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
	String phoneNo  = request.getParameter("phoneNo");
	String workNo  = request.getParameter("workNo");
	String orgCode=request.getParameter("orgCode");
	String chnCode  = "01";
	String querylogin  = "aaaaxp";
	//String op_code=request.getParameter("op_code");
	//String beginDateStr=request.getParameter("beginDateStr");
	//String endDateStr=request.getParameter("endDateStr");
	String cSubmitFlag = request.getParameter("cSubmitFlag") == null ? "" : request.getParameter("cSubmitFlag");
  String cFuncCode = request.getParameter("cFuncCode")==null?"":request.getParameter("cFuncCode");
  String cPhoneNo = request.getParameter("cPhoneNo")==null?"":request.getParameter("cPhoneNo");
  String cApplyWorkId = request.getParameter("cApplyWorkId")==null?"":request.getParameter("cApplyWorkId");
  String cApproveWorkId = request.getParameter("cApproveWorkId")==null?"":request.getParameter("cApproveWorkId");
  String cAproveTimeB = request.getParameter("cAproveTimeB")==null?"":request.getParameter("cAproveTimeB");
  String cAproveTimeE = request.getParameter("cAproveTimeE")==null?"":request.getParameter("cAproveTimeE");
  String cApplyTimeB = request.getParameter("cApplyTimeB")==null?"":request.getParameter("cApplyTimeB");
  String cApplyTimeE = request.getParameter("cApplyTimeE")==null?"":request.getParameter("cApplyTimeE");
  String cApplyNo = request.getParameter("cApplyNo")==null?"":request.getParameter("cApplyNo");
  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
  //int iStartPos = (iPageNumber-1)*iPageSize;
  //int iEndPos = iPageNumber*iPageSize;

	
   String opCode = "3792";
	String opName="�Ӵ�������Ϣ��ѯ";
%>
<wtc:service name="sQryCnttOpr" outnum="8" >
  	<wtc:param value="<%=cApplyWorkId%>"/>
  	<wtc:param value="<%=cApproveWorkId%>"/>
 	<wtc:param value="<%=cApplyNo%>"/>
	<wtc:param value="<%=cApplyTimeB%>"/>
	<wtc:param value="<%=cApplyTimeE%>"/>
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
System.out.println("_________________________________________________________________________");
	    for(int i=0;i<result.length;i++){
	      for(int j=0;j<result[i].length;j++){
	      System.out.println("############################result["+i+"]["+j+"]"+"   "+result[i][j]);
	      
	      }
	    
	    
	    }
System.out.println("_________________________________________________________________________");
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
<HTML><HEAD><TITLE>�Ӵ���Ϣά����־��ѯ</TITLE>
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp" %>
 <div class="title"><div id="title_zi">�Ӵ���Ϣά����־��ѯ</div></div>
    <TABLE cellSpacing=0>
       <tr align="center">
        <th>������ˮ</th>
        <th>�Ӵ��������ʹ���</th>
        <th>�Ӵ�������������</th>
        <th>��������</th>
        <th>������ʶ����</th>
        <th>��������</th>
        <th>����ʱ��</th>
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
				<% if(result[i][7]==null ||result[i][7].equals("") ){%>
				<td class="Grey">&nbsp;</td>
				<%}else{%>
				<td class="Grey"><%=result[i][7]%></td>
				<%}%>
				
				
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

