<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">   
<!-------------------------------------------->
<!---日期   2008-7-7                     	---->
<!---作者   zhouzy                        ---->
<!---代码   f1500_qryCnttCfm           		---->
<!---功能   客户统一接触查询          		---->
<!-------------------------------------------->  	
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String phoneNo  = request.getParameter("phoneNo");
	String workNo  = request.getParameter("workNo");
	String orgCode=request.getParameter("orgCode");
	String chnCode  = request.getParameter("chnCode");
	String activeCode  = request.getParameter("activeCode");
	String op_code=request.getParameter("op_code");
	String beginDateStr=request.getParameter("beginDateStr");
	String endDateStr=request.getParameter("endDateStr");
	if(!beginDateStr.equals("")||beginDateStr!=null){
	beginDateStr=beginDateStr.substring(0,4)+beginDateStr.substring(5,7)+beginDateStr.substring(8);
	}
	if(!endDateStr.equals("")||endDateStr!=null){
	endDateStr=endDateStr.substring(0,4)+endDateStr.substring(5,7)+endDateStr.substring(8);
	}
   String opCode = "3793";
	String opName="接触信息维护";
%>
<wtc:service name="sQryCntt" outnum="27" >
		<wtc:param value="0"/>
  	<wtc:param value="<%=phoneNo%>"/>
  	<wtc:param value="<%=chnCode%>"/>
  	<wtc:param value="<%=activeCode%>"/>
  	<wtc:param value="<%=op_code%>"/>		
  	<wtc:param value="<%=beginDateStr%>"/>	
  	<wtc:param value="<%=endDateStr%>"/>
  	<wtc:param value="01"/>		
  	<wtc:param value="<%=workNo%>"/>			
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
	rdShowMessageDialog("没有符合条件的数据!",0);
	history.go(-1);
</script>
<%
return;
}
%>
<HTML><HEAD><TITLE>查询客户统一接触信息</TITLE>
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp" %>
 <div class="title"><div id="title_zi">客户统一接触信息展示</div></div>
    <TABLE cellSpacing=0>
       <tr align="center">
        <th>客户标识类型</th>
        <th>客户标识</th>
        <th>接触渠道</th>
        <th>员工编码</th>
        <th>接触开始时间</th>
        <th>接触结束时间</th>
        <th>业务名称</th>
        <th>业务流水</th>
        <th>业务操作结果</th>
     	</tr>
     	<%for(int i=0;i<result.length;i++){%>
     		<tr>
     	<%if(i%2==0){%>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][3].equals("")?"&nbsp;":result[i][3]%></a></td>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][4].equals("")?"&nbsp;":result[i][4]%></a></td>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][6].equals("")?"&nbsp;":result[i][6]%></a></td>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][11].equals("")?"&nbsp;":result[i][11]%></a></td>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][12].equals("")?"&nbsp;":result[i][12]%></a></td>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][13].equals("")?"&nbsp;":result[i][13]%></a></td>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][21].equals("")?"&nbsp;":result[i][21]%></a></td>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][22].equals("")?"&nbsp;":result[i][22]%></a></td>
				<td class="Grey"><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][23].equals("")?"&nbsp;":result[i][23]%></a></td>
				<%}else{%>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][3].equals("")?"&nbsp;":result[i][3]%></a></td>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][4].equals("")?"&nbsp;":result[i][4]%></a></td>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][6].equals("")?"&nbsp;":result[i][6]%></a></td>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][11].equals("")?"&nbsp;":result[i][11]%></a></td>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][12].equals("")?"&nbsp;":result[i][12]%></a></td>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][13].equals("")?"&nbsp;":result[i][13]%></a></td>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][21].equals("")?"&nbsp;":result[i][21]%></a></td>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][22].equals("")?"&nbsp;":result[i][22]%></a></td>
				<td><a href="f3792_33.jsp?sContactId=<%=result[i][0]%>&sCallersPhone=<%=result[i][1]%>&sRecipientPhone=<%=result[i][2]%>&sPhoneType=<%=result[i][3]%>&sPhoneNo=<%=result[i][4]%>&sChnCode=<%=result[i][5]%>&sChnName=<%=result[i][6]%>&sInterfaceCode=<%=result[i][7]%>&sInterfaceName=<%=result[i][8]%>&sInteractiveCode=<%=result[i][9]%>&sInteractiveName=<%=result[i][10]%>&sLoginNo=<%=result[i][11]%>&sContactBeginTime=<%=result[i][12]%>&sContactEndTime=<%=result[i][13]%>&sContactStatus=<%=result[i][14]%>&sContactStatusName=<%=result[i][15]%>&sContactIdOld=<%=result[i][16]%>&sContactIp=<%=result[i][17]%>&sOpCodeOld=<%=result[i][18]%>&sOpAcceptOld=<%=result[i][19]%>&sOpCode=<%=result[i][20]%>&sOpName=<%=result[i][21]%>&sOpAccept=<%=result[i][22]%>&sOpResult=<%=result[i][23]%>&sOpTime=<%=result[i][24]%>&sOpNotes=<%=result[i][25]%>&sOpPhoneNo=<%=result[i][26]%>"><%=result[i][23].equals("")?"&nbsp;":result[i][23]%></a></td>
     	<%}%>
    	</tr>	
     	<%}%>	
     	</table>
     	<TABLE cellSpacing=0>
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
      </table>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

