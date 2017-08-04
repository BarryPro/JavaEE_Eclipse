<%
    /*************************************
    * ��  ��: ������ǩ�ʷ��������� g398
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2013-1-15
    **************************************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String offerId = WtcUtil.repStr(request.getParameter("offerId"), "");
	String offerName = WtcUtil.repStr(request.getParameter("offerName"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
	String password=WtcUtil.repNull((String)session.getAttribute("password"));
  String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String groupId=WtcUtil.repNull((String)session.getAttribute("groupId"));
  String chkFlay = "checked";
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="sG398Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="5">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=groupId%>"/>
		<wtc:param value="<%=offerId%>"/>
		<wtc:param value="<%=offerName%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">������ǩ�ʷ��������ò�ѯ���</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set' >
				<tr>
				  <th></th>
					<th>�ʷѴ���</th>
					<th>�ʷ�����</th>
					<th>�ʷѿ�ʼʱ��</th>
					<th>�ʷѽ���ʱ��</th>
					<th>״̬</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='6'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
					  String state = "";
					  if("1".equals(ret[i][0])){
					    state = "δ����";
					  }else if("2".equals(ret[i][0])){
					    state = "������";
					  }else{
					    state = "�ǰ����ʷ�";
					  }
%>
					<tr align="center" id="row_<%=i%>">
					  <td>
					    <%
					      if(i==0){
					    %>
					        <input type="radio" id="qryRadio<%=i%>" name="qryRadioName" value="" v_state="<%=ret[i][0]%>" v_offerId="<%=ret[i][1]%>" checked="<%=chkFlay%>" onclick="selecQryInfo(this.v_state)" />
					    <% 
					      }else{
					    %>
					        <input type="radio" id="qryRadio<%=i%>" name="qryRadioName" value="" v_state="<%=ret[i][0]%>" v_offerId="<%=ret[i][1]%>" onclick="selecQryInfo(this.v_state)" />
					    <%   
					      }
					    %>
					    
					  </td>
						<td><%=ret[i][1]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
						<td><%=ret[i][4]%></td>
						<td><%=state%></td>
					</tr>
<%
					}
%>
          <tr id="subBtnTr">
            <td colspan="6" align="center" id="footer">
              <input type="button" id="subBtn" name="subBtn" class="b_foot" value="" v_flag="" onClick="subInfo(this)" />   
            </td>
          </tr>
<%
				}
%>
			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />