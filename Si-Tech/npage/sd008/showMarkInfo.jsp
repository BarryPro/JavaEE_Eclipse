<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2013-6-20 9:37:28
********************/
%>
              
<%
		String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
		String regionCode    = (String)session.getAttribute("regCode");
		String sysAccept     = (String)request.getParameter("sysAccept");
		String retCode       = "";
		String retMsg        = "";
		
		
		String iLoginAccept  = "0";
		String iChnSource    = "01";
		String iOpCode       = opCode;
		String iLoginNo      = (String)session.getAttribute("workNo");
		String iLoginPwd     = (String)session.getAttribute("password");
		String iPhoneNo      = (String)request.getParameter("phoneNo");
		String iUserPwd      = "";
		String iQryAccept    = sysAccept;
		String tabNameArr[] = new String[]{"MK_ACTRECORD_INFO","MK_ACTRECORDSCORE_INFO","MK_ACTRECORDPRODUCT_INFO","MK_ACTRECORDRES_INFO","MK_ACTRECORDFEEEXT_INFO",""};
		
		String result1[][] = new String[][]{}; //������Ϣ��ѯ
		String result2[][] = new String[][]{}; //�ʷ���Ϣ��ѯ
		String result3[][] = new String[][]{}; //��Դ��Ϣ��ѯ
		String result4[][] = new String[][]{}; //
		String result5[][] = new String[][]{}; //
		opName = iPhoneNo;
try{
%>		

<!--������Ϣ��ѯ-->
    <wtc:service name="sMktTabQry" outnum="20" retmsg="msg0" retcode="code0" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=iLoginAccept%>" />
    	<wtc:param value="<%=iChnSource%>" />
    	<wtc:param value="<%=iOpCode%>" />
    	<wtc:param value="<%=iLoginNo%>" />
    	<wtc:param value="<%=iLoginPwd%>" />
    	<wtc:param value="<%=iPhoneNo%>" />
    	<wtc:param value="<%=iUserPwd%>" />
    	<wtc:param value="<%=iQryAccept%>" />			
    	<wtc:param value="<%=tabNameArr[0]%>" />	
		</wtc:service>
		<wtc:array id="resultBase" scope="end" />
<%
if(resultBase.length>0){
	iQryAccept = resultBase[0][4];
}
%>			
<!--������Ϣ��ѯ-->
    <wtc:service name="sMktTabQry" outnum="20" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=iLoginAccept%>" />
    	<wtc:param value="<%=iChnSource%>" />
    	<wtc:param value="<%=iOpCode%>" />
    	<wtc:param value="<%=iLoginNo%>" />
    	<wtc:param value="<%=iLoginPwd%>" />
    	<wtc:param value="<%=iPhoneNo%>" />
    	<wtc:param value="<%=iUserPwd%>" />
    	<wtc:param value="<%=iQryAccept%>" />			
    	<wtc:param value="<%=tabNameArr[1]%>" />	
		</wtc:service>
		<wtc:array id="result_t1_1" start="0"  length="4"  scope="end"  />
		<wtc:array id="result_t1"   start="4"  length="16" scope="end"  />
 
<!--�ʷ���Ϣ��ѯ-->
	  <wtc:service name="sMktTabQry" outnum="28" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=iLoginAccept%>" />
    	<wtc:param value="<%=iChnSource%>" />
    	<wtc:param value="<%=iOpCode%>" />
    	<wtc:param value="<%=iLoginNo%>" />
    	<wtc:param value="<%=iLoginPwd%>" />
    	<wtc:param value="<%=iPhoneNo%>" />
    	<wtc:param value="<%=iUserPwd%>" />
    	<wtc:param value="<%=iQryAccept%>" />			
    	<wtc:param value="<%=tabNameArr[2]%>" />					
		</wtc:service>
		<wtc:array id="result_t2_1" start="0"  length="4"  scope="end" />
		<wtc:array id="result_t2"   start="4"  length="24" scope="end" />	
 	
<!--��Դ��Ϣ��ѯ-->
	  <wtc:service name="sMktTabQry" outnum="47" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=iLoginAccept%>" />
    	<wtc:param value="<%=iChnSource%>" />
    	<wtc:param value="<%=iOpCode%>" />
    	<wtc:param value="<%=iLoginNo%>" />
    	<wtc:param value="<%=iLoginPwd%>" />
    	<wtc:param value="<%=iPhoneNo%>" />
    	<wtc:param value="<%=iUserPwd%>" />
    	<wtc:param value="<%=iQryAccept%>" />			
    	<wtc:param value="<%=tabNameArr[3]%>" />					
		</wtc:service>
		<wtc:array id="result_t3_1"  start="0"  length="4"  scope="end"/>
		<wtc:array id="result_t3"    start="4"  length="43" scope="end" />	
 				
<!--������Ϣ��ѯ-->
	  <wtc:service name="sMktTabQry" outnum="52" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=iLoginAccept%>" />
    	<wtc:param value="<%=iChnSource%>" />
    	<wtc:param value="<%=iOpCode%>" />
    	<wtc:param value="<%=iLoginNo%>" />
    	<wtc:param value="<%=iLoginPwd%>" />
    	<wtc:param value="<%=iPhoneNo%>" />
    	<wtc:param value="<%=iUserPwd%>" />
    	<wtc:param value="<%=iQryAccept%>" />			
    	<wtc:param value="<%=tabNameArr[4]%>" />					
		</wtc:service>
		<wtc:array id="result_t4_1" start="0"  length="4"   scope="end" />
		<wtc:array id="result_t4"   start="4"  length="48"  scope="end" />			
 							
<%
 	result1 = result_t1;
 	result2 = result_t2;
 	result3 = result_t3;
 	result4 = result_t4;
}catch(Exception e){
		retCode = "000409";
		retMsg = "���÷���sWIflowQryϵͳ����";
%>
<script language="javascript" type="text/javascript">
	 alert("������ô���",0);
	 window.close();
</script>
<%		
}

%>
<script language="javascript" type="text/javascript">
 
</script>
</head>

<body onload="" style="overflow-y:auto; overflow-x:hidden;">
	<form  name="frmMain" action="" method="post">
<%@ include file="/npage/include/header_pop.jsp" %>
 			<div class="title">
					<div id="title_zi">������Ϣ��ѯ</div>
				</div>

			<table cellspacing=0>
				<tr>
					<th>��������</th>
					<th>��������</th>
					<th>�ۼ�ֵ</th>
					<th>�������</th>
				</tr>
<%
 
			for(int i=0;i<result1.length;i++){
				if(iPhoneNo.equals(result1[i][5])){
					out.print("<tr>");
					if("0".equals(result1[i][8].trim())){
						out.print("<td>�ۼ�����</td>");
					}else if("1".equals(result1[i][8].trim())){
						out.print("<td>�ֿۻ���</td>");
					}else{
						out.print("<td>"+result1[i][8]+"</td>");
					}
					
					if("1".equals(result1[i][9].trim())){
						out.print("<td>���ֵ���������</td>");
					}else if("2".equals(result1[i][9].trim())){
						out.print("<td>���ֵ����ֽ�</td>");
					}else{
						out.print("<td>"+result1[i][9]+"</td>");
					}
					out.print("<td>"+result1[i][10]+"</td>");
					out.print("<td>"+result1[i][11]+"</td>");
					out.print("</tr>");
				}
			}
%>
</table>

			<div class="title">
					<div id="title_zi">�ʷ���Ϣ��ѯ</div>
				</div>

			<table cellspacing=0>
				<tr>
					<th>�ʷ�ID</th>
					<th>�ʷ�����</th>
					<th>��ʼʱ��</th>
					<th>����ʱ��</th>
				</tr>
<%
			for(int i=0;i<result2.length;i++){
			if(iPhoneNo.equals(result2[i][5])){
					out.print("<tr>");
					out.print("<td>"+result2[i][8]+"</td>");
					out.print("<td>"+result2[i][9]+"</td>");
					out.print("<td>"+result2[i][10]+"</td>");
					out.print("<td>"+result2[i][13]+"</td>");
					out.print("</tr>");
				}
			}
%>
</table>

			<div class="title">
					<div id="title_zi">��Դ��Ϣ��ѯ</div>
				</div>

			<table cellspacing=0>
				<tr>
					<th>��Դ����</th>
					<th>��Դ����</th>
					<th>��Դ�ͺ�����</th>
					<th>�ն˴���</th>
					<th>�ɱ���</th>
					<th>���ۼ�</th>
				</tr>
<%
			for(int i=0;i<result3.length;i++){
			if(iPhoneNo.equals(result3[i][5])){
					out.print("<tr>");
					if("1".equals(result3[i][8].trim())){
						out.print("<td>�ն�</td>");
					}else if("3".equals(result3[i][8].trim())){
						out.print("<td>����Ʒ</td>");
					}else{
						out.print("<td>"+result3[i][8]+"</td>");
					}
					
					out.print("<td>"+result3[i][10]+"</td>");
					out.print("<td>"+result3[i][12]+"</td>");
					out.print("<td>"+result3[i][13]+"</td>");
					out.print("<td>"+result3[i][14]+"</td>");
					out.print("<td>"+result3[i][15]+"</td>");
					out.print("</tr>");
				}
			}
%>
</table>
<%
String feeType   = "";
StringBuffer table0Str = new StringBuffer();
StringBuffer table1Str = new StringBuffer();
StringBuffer table2Str = new StringBuffer();
StringBuffer table3Str = new StringBuffer();


for(int i=0;i<result4.length;i++){	
		feeType = result4[i][10];
	if(iPhoneNo.equals(result4[i][5])){		
		if("0".equals(feeType))	{//�ֽ�
							table0Str.append("<tr>");
							table0Str.append("<td>�ֽ�</td>");
							table0Str.append("<td>"+result4[i][14]+"</td>");
							table0Str.append("</tr>");
		}else if("1".equals(feeType))	{//ר��
							table1Str.append("<tr>");
							table1Str.append("<td>ר��</td>");
							table1Str.append("<td>"+result4[i][11]+"</td>");
							if("0".equals(result4[i][12])){	
								table1Str.append("<td>������Ч</td>");
							}else	if("1".equals(result4[i][12])){	
								table1Str.append("<td>������Ч</td>");
							}else if("2".equals(result4[i][12])){	
								table1Str.append("<td>�Զ���ʱ��</td>");
							}else{	
								table1Str.append("<td>"+result4[i][12]+"</td>");
							}
							table1Str.append("<td>"+result4[i][29]+"</td>");
							table1Str.append("<td>"+result4[i][14]+"</td>");
							table1Str.append("<td>"+result4[i][15]+"</td>");
							if("999999".equals(result4[i][17])){
								table1Str.append("<td>0</td>");
							}else{
								table1Str.append("<td>"+result4[i][17]+"</td>");
							}
							table1Str.append("</tr>");
		}else if("2".equals(feeType))	{//ϵͳ��ֵ
							table2Str.append("<tr>");
							table2Str.append("<td>ϵͳ��ֵ</td>");
							table2Str.append("<td>"+result4[i][11]+"</td>");
							if("0".equals(result4[i][12])){	
								table2Str.append("<td>������Ч</td>");
							}else	if("2".equals(result4[i][12])){	
								table2Str.append("<td>�Զ���ʱ��</td>");
							}else if("3".equals(result4[i][12])){	
								table2Str.append("<td>�������</td>");
							}else{	
								table2Str.append("<td>"+result4[i][12]+"</td>");
							}
							table2Str.append("<td>"+result4[i][14]+"</td>");
							table2Str.append("<td>"+result4[i][15]+"</td>");
							if("999999".equals(result4[i][17])){
								table2Str.append("<td>0</td>");
							}else{
								table2Str.append("<td>"+result4[i][17]+"</td>");
							}
							table2Str.append("<td>"+result4[i][29]+"</td>");
							table2Str.append("</tr>");
		}else if("3".equals(feeType))	{//�����Ż�
		
							table3Str.append("<tr>");
							table3Str.append("<td>�����Ż�</td>");
							table3Str.append("<td>"+result4[i][14]+"</td>");
							table3Str.append("<td>"+result4[i][15]+"</td>");
							table3Str.append("<td>"+result4[i][17]+"</td>");
							table3Str.append("</tr>");
		}else{
		}
	}
}
%>			
			<div class="title">
					<div id="title_zi">������Ϣ��ѯ</div>
				</div>

<table cellspacing=0>
						<tr>
							<th>��������</th>
							<th>���</th>
						</tr>
						<%=table0Str.toString()%>
</table>				
<table cellspacing=0>
						<tr>
							<th>��������</th>
							<th>ר������</th>
							<th>��Ч��ʽ</th>
							<th>ר������</th>
							<th>���</th>
							<th>����</th>
							<th>ÿ�·������</th>
						</tr>
						<%=table1Str.toString()%>
</table>				
		<table cellspacing=0>
						<tr>
							<th>��������</th>
							<th>ϵͳ��ֵ����</th>
							<th>��Ч��ʽ</th>
							<th>���</th>
							<th>����</th>
							<th>ÿ�·������</th>
							<th>ϵͳ��ֵר������</th>
						</tr>			
						<%=table2Str.toString()%>
</table>								
<table cellspacing=0>
						<tr>
							<th>��������</th>
							<th>���Żݽ��</th>
							<th>���Ż�����</th>
							<th>�Żݱ���</th>
						</tr>		
						<%=table3Str.toString()%>
</table>							
																
	
<table>			
			<tr>
			<td  align="center" id="footer">
				<input class="b_foot" name="back"    type="button" onClick="window.close()" value="�ر�"/>
			</td>
		</tr>
</table>	
		</form>
	</body>
</html>
 
 
 