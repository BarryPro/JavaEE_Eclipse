<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-------------------------------------------->
<!---����   2003-10-24                    ---->
<!---����   HYZ                           ---->
<!---����   f1500_Main                    ---->
<!---����   �ۺ���Ϣ��ѯ                  ---->
<!---�޸�   dengyuan @2008-05-19          ---->
<!-------------------------------------------->
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="java.io.*" %>

<% 	
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String powerName = (String)session.getAttribute("powerCode");
	String orgCode = (String)session.getAttribute("orgCode");
	
	String regionCode = orgCode.substring(0,2);
  //������� ��ѯ���ͣ���ѯ�������������룬���ţ�Ȩ�޴��롣 
	String inStr  = request.getParameter("condText")==null?"":request.getParameter("condText");//�õ��������

	String opCode = "3792";
	String opName="�Ӵ���Ϣά��";
	
		String sContactId=  request.getParameter("sContactId")==null?"":request.getParameter("sContactId");
		String sCallersPhone=  request.getParameter("sCallersPhone")==null?"":request.getParameter("sCallersPhone");
		String sRecipientPhone=  request.getParameter("sRecipientPhone")==null?"":request.getParameter("sRecipientPhone");
		String sPhoneNo=  request.getParameter("sPhoneNo")==null?"":request.getParameter("sPhoneNo");
		String sChnCode=  request.getParameter("sChnCode")==null?"":request.getParameter("sChnCode");
		String sInterfaceCode=  request.getParameter("sInterfaceCode")==null?"":request.getParameter("sInterfaceCode");
		String sInteractiveCode=  request.getParameter("sInteractiveCode")==null?"":request.getParameter("sInteractiveCode");
		String sContactStatus=  request.getParameter("sContactStatus")==null?"":request.getParameter("sContactStatus");
		String sContactIdOld=  request.getParameter("sContactIdOld")==null?"":request.getParameter("sContactIdOld");
		String sLoginAccept=  request.getParameter("sLoginAccept")==null?"":request.getParameter("sLoginAccept");
		String sLoginNo=  request.getParameter("sLoginNo")==null?"":request.getParameter("sLoginNo");
		String sNote=  request.getParameter("sNote")==null?"":request.getParameter("sNote");
		String sOpCode=  request.getParameter("sOpCode")==null?"":request.getParameter("sOpCode");
		
		System.out.println("____________________________________________________________________________________");
		System.out.println(sContactId);
		System.out.println(sCallersPhone);
		System.out.println(sRecipientPhone);
		System.out.println(sPhoneNo);
		System.out.println(sChnCode);
		System.out.println(sInterfaceCode);
		System.out.println(sInteractiveCode);
		System.out.println(sContactStatus);
		System.out.println(sContactIdOld);
		System.out.println(sLoginAccept);
		System.out.println(sLoginNo);
		System.out.println(sNote);
		System.out.println(sOpCode);
		System.out.println("____________________________________________________________________________________");
		
 %>                    
	<wtc:service name="sUpdateCntt" outnum="3">
		<wtc:param value="<%=sContactId%>"/>
		<wtc:param value="<%=sCallersPhone%>"/>
		<wtc:param value="<%=sRecipientPhone%>"/>
		<wtc:param value="<%=sPhoneNo%>"/>
		<wtc:param value="<%=sChnCode%>"/>
		<wtc:param value="<%=sInterfaceCode%>"/>
		<wtc:param value="<%=sInteractiveCode%>"/>
		<wtc:param value="<%=sContactStatus%>"/>
		<wtc:param value="<%=sContactIdOld%>"/>
		<wtc:param value="<%=sOpCode%>"/>
		<wtc:param value="<%=sLoginAccept%>"/>
		<wtc:param value="<%=sLoginNo%>"/>
		<wtc:param value="<%=sNote%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%    
System.out.println("_________________________________________________________________________");
	    for(int i=0;i<result.length;i++){
	      for(int j=0;j<result[i].length;j++){
	      System.out.println("############################result["+i+"]["+j+"]"+"   "+result[i][j]);
	      
	      }
	    
	    
	    }
System.out.println("_________________________________________________________________________");
	if (!retCode.equals("000000")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=retMsg%><br>������� '<%=retCode%>'��",0);
	history.go(-1);
</script>
<%
}else{
	%>
<script language="JavaScript">
	rdShowMessageDialog("�޸ĳɹ�!",2);
	document.location.href= 'f3792_11.jsp';
</script>
<%
	}
%>
