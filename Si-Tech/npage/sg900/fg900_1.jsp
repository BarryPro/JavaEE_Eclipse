<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2013-12-19 17:08:05
 g900�����Ͽ�������ʧ�ܳ��� 
********************/
%>
              
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String workNo     = (String)session.getAttribute("workNo");
	String password   = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
<%	
	String paraAray[] = new String[8];
	paraAray[0] = accept;  															 //��ˮ
	paraAray[1] = "01";                                  //��������
	paraAray[2] = opCode;                                //��������
	paraAray[3] = workNo;                                //����
	paraAray[4] = password;                              //��������
	paraAray[5] = "";                                    //�û�����
	paraAray[6] = "";                                    //�û�����
	paraAray[7] = "";                                    // 
%> 

	<wtc:service name="sg900Qry" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
	</wtc:service>
	<wtc:array id="sg900QryResult" scope="end"    />
	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
$(document).ready(function (){
	if("<%=code%>"!="000000"){
		rdShowMessageDialog("��ѯ�����б����<%=code%>:<%=msg%>",0);
		removeCurrentTab();
	}
});
 
function cancelOrder(phoneNo){
	var packet = new AJAXPacket("fg900_cancelOrder.jsp","���������ύ�����Ժ�...");
			packet.data.add("accept","<%=accept%>");
			packet.data.add("opCode", '<%=opCode%>');
			packet.data.add("phoneNo",phoneNo);
			core.ajax.sendPacket(packet,doCancelOrder);
			packet =null;
}
function doCancelOrder(packet){
		var code = packet.data.findValueByName("code");
		var msg  = packet.data.findValueByName("msg");	
		if ("000000" == code){
				rdShowMessageDialog("�����ɹ���",2);
				location = location;//ˢ��ҳ��
		} else {
				rdShowMessageDialog("����ʧ�ܣ�" + code +"��"+ msg, 0);
		}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="prodCfm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">�����б�</div></div>
<table cellSpacing="0">
	<tr>
		<th width="50%">�ֻ�����</th>
		<th width="50%">����</th>
	</tr>
<%
	StringBuffer sb = new StringBuffer();
	for(int i=0;i<sg900QryResult.length;i++){
		sb.append("<tr>");
		sb.append("<td>");
		sb.append(sg900QryResult[i][0]);
		sb.append("</td>");
		sb.append("<td>");
		sb.append("<input type='button' class='b_text' value='����' onclick='cancelOrder(\""+sg900QryResult[i][0]+"\")'>");
		sb.append("</td>");
		sb.append("</tr>");
	}
	out.print(sb.toString());
%>
</table>
<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
			<INPUT class=b_foot onclick="removeCurrentTab()" type=button value=�ر�> 
	 	</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>