<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String opCode = "g982";
    String opName = "�ʷ����ն˷���Ŀ���û����� ";
    String workno = (String)session.getAttribute("workNo");
	String nopass =(String)session.getAttribute("password");
	String ipAddr =(String)session.getAttribute("ipAddr");
	String phone_brand = WtcUtil.repStr(request.getParameter("phone_brand"), "");
	String phone_type = WtcUtil.repStr(request.getParameter("phone_type"), "");
	String regionCode = (String)session.getAttribute("regCode");
	String regionCode1 = request.getParameter("region_code");
	String remark = "����Ա��"+workno+"�������ʷ����ն˷���Ŀ���û�������ˮ��ѯ";
	String loginAccept = WtcUtil.repStr(request.getParameter("loginAccept"), "");
	
	
	System.out.println(" zhouby xxx " + regionCode1);
%>

	<wtc:service name="sg982Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="10" >
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value="q"/>   <%/*������ʶ q ��ѯ 0 ���� 1 ɾ��*/%>
		<wtc:param value="<%=phone_brand%>"/>
		<wtc:param value="<%=phone_type%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=regionCode1%>"/> <%/*���д��� ɾ����ֵ*/%>
	</wtc:service>
	
	<wtc:array id="ret" scope="end" />
<%
    if("000000".equals(retCode)){
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">��ѯ���</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
<%
				if(ret.length>0){
				
                    if("0".equals(ret[0][8])){
                        
%>
    					<tr align="center">
        					<td><%=ret[0][9]%></td>
    					</tr>
<%
                    } else{
%>
                        <tr>
                            <th>����</th>
        					<th>Ʒ��</th>
        					<th>����</th>
        					<th>��ʼʱ��</th>
        					<th>����ʱ��</th>
        					<th>����</th>
                        </tr>
                        
                        <tr>
                            <td><%=ret[0][0]%></td>
    						<td><%=ret[0][2]%></td>
    						<td><%=ret[0][4]%></td>
    						<td><%=ret[0][5]%></td>
    						<td><%=ret[0][6]%></td>
    						<td>�ɹ�<%=ret[0][7]%>��</td>
                        </tr>
                        <tr>
                            <td><%=ret[0][0]%></td>
    						<td><%=ret[0][2]%></td>
    						<td><%=ret[0][4]%></td>
    						<td><%=ret[0][5]%></td>
    						<td><%=ret[0][6]%></td>
    						<td>ʧ��<%=ret[0][9]%>��</td>
                        </tr>
<%
				    }
				}
%>
			</table>
	</div>
</div>
<%
}
%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />