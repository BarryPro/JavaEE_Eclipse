<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		/*------�鿴�ֻ��û��Ƿ���ʵ�����û�*/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String PhoneNo = request.getParameter("PhoneNo");
		String operType = request.getParameter("operType");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String isBlackList = "";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>

	<wtc:service name="se885Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="7">
	  <wtc:param value="<%=printAccept%>"/>
	  <wtc:param value="01"/>
	  <wtc:param value="<%=opCode%>"/>
	  <wtc:param value="<%=workNo%>"/>
	  <wtc:param value="<%=password%>"/>
	  <wtc:param value="<%=PhoneNo%>"/>
	  <wtc:param value=""/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=startTime%>"/>
	  <wtc:param value="<%=endTime%>"/>
	  <wtc:param value="<%=operType%>"/>
	</wtc:service>
	<wtc:array id="dcust2" scope="end" />
<%
	if(retCode2.equals("000000")){
    if(dcust2.length>0){
    	if("".equals(operType)){ //����ʽΪ��ȫ����������ʾ@2015/4/17 
    		if("Y".equals(dcust2[0][6])){
	    		isBlackList = "(����������)";
		    }else{
		    	isBlackList = "(����������)";
		    }
    	}
    }
  }
%>
	<div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">��ѯ��Ϣ<font class='red'><%=isBlackList%></font></div>
			</div>
			<table>
				<tr>
					<th>�ֻ�����</th>						
					<th>������Դ</th>
					<th>������Ϣ����</th>
					<th>������״̬</th>
					<th>�ӽ������ԭ������</th>
					<th>����ʽ</th>
					<th>��������</th>
					<th>����ʱ��</th>
				</tr>
	 	<%if(retCode2.equals("000000")){
		    if(dcust2.length>0){
			    for(int i=0;i<dcust2.length; i++){
				    if(dcust2[i][0].trim().equals("")){
				    }else{
		%>
				<tr> 
					<td width="6%"><%=PhoneNo%></td>
					<td width="7%"><%if(dcust2[i][0].equals("01")){out.print("ȫ�����ƽ̨");}if(dcust2[i][0].equals("02")){out.print("ʡ�ڼ��");}if(dcust2[i][0].equals("03")){out.print("�ٱ�����");}if(dcust2[i][0].equals("04")){out.print("�û�Ͷ��");}%></td>
					<td width="6%"><%if(dcust2[i][1].equals("01")){out.print("��������");}if(dcust2[i][1].equals("02")){out.print("ɧ�ŵ绰");}%></td>
					<td width="6%"><%if(dcust2[i][6].equals("Y")){out.print("��");}if(dcust2[i][6].equals("N")){out.print("��");}%></td>
					<td width="20%"><%=dcust2[i][3]%></td>
					<td width="10%"><%if(dcust2[i][2].trim().equals("01")){out.print("ͣ����");}if(dcust2[i][2].trim().equals("02")){out.print("�ָ�����");}if(dcust2[i][2].trim().equals("03")){out.print("ͣ����");}if(dcust2[i][2].trim().equals("04")){out.print("�ָ�����");}%></td>
					<td width="6%"><%=dcust2[i][4]%></td>
					<td width="10%"><%=dcust2[i][5]%></td>
			  </tr>
			  <%
 				   } 
				 }
			 }else{%>
			 <tr height='25' align='center'> 
					<td colspan='8'>û�в�ѯ��¼��</td>
			 </tr>
		 <%}
		 }%>
		  </table>
		</div>
	</div>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode2%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg2%>" />
