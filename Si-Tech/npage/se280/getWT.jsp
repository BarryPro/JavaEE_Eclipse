<%
  /* *********************
   * ����:��ͥ��Ʒ���
   * �汾: 1.0
   * ����: 2011/09/21
   * ����: ningtn
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String parentPhone = request.getParameter("parentPhone");
	
	String famCode = request.getParameter("famCode");
	String prodCode = request.getParameter("prodCode");
	String famRole = request.getParameter("famRole");
	String busiType = request.getParameter("busiType");
	String memRoleId = request.getParameter("memRoleId");
	System.out.println("getHomeEasy.jsp-----[" + famCode + "|" + prodCode + "|" + famRole + "|" + memRoleId + "]");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
%>
		<wtc:service name="sFamSelCheck" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="9">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=parentPhone%>"/>
				<wtc:param value=""/>
				<wtc:param value="1"/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value="<%=prodCode%>"/>
				<wtc:param value="<%=famRole%>"/>
				<wtc:param value="<%=memRoleId%>"/>
				<wtc:param value="<%=busiType%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
		System.out.println("---------getHomeEasy.jsp--------" + retCode1);
		if("000000".equals(retCode1)){
			String busiId = result[0][0];
			System.out.println("---------getHomeEasy.jsp--------length" + result.length);
%>
<tr id="zhjt1">
  <td class="blue"  >SP��ҵ����</td>
	<td >
		<select id="spEnterpriCode" name="spEnterpriCode" onchange="getSpBusiCode(this)" style="width:180px">
			<option value ="" >--��ѡ��--</option>
			<option value ="699212" >����ͨ��ý��ɷ����޹�˾</option>
			<option value ="699213" >δ���������޹�˾</option>
		</select>
		<font class="orange">*</font>
	</td>
	<td class="blue"  >SPҵ�����</td>
	<td >
		<select id="spBusiCode" name="spBusiCode" onchange="getSTBId(this)">
			<option value ="" >--��ѡ��--</option>
		</select>
		<font class="orange">*</font>
	</td>
</tr>
<tr id="zhjt2" >
  <td class="blue" >������id</td>
	<td colspan="3" >
		<input type="text" id="STBId" name="STBId" maxlength="32" style="width:210px;" value="" />
		<font class="orange">*</font>
	</td>
</tr>
<tr id="zhjt4" >
  <td class="blue" >��������</td>
	<td colspan="3">
		<input type="text" id="postalCode" name="postalCode" maxlength="6" value="" v_type="0_9" />
		<font class="orange">*</font>
	</td>
	<td style="display:none" class="blue" >�����Ƿ��Զ�ȡ��</td>
	<td style="display:none">
		<select id="autoCancel" name="autoCancel" >
			<option value ="1" selected>��</option>
			<option value ="0" >��</option>
		</select>
		<font class="orange">*</font>
	</td>
</tr>
<tr id="zhjt3" >
	<td class="blue" >װ����ַ</td>
	<td colspan="3" >
		<input type="text" id="installAddr" name="installAddr" maxlength="64" style="width:450px;" value="" />
		<font class="orange">*</font>
	</td>
	<input type="hidden" id="sp_busiId_hidden" value="<%=busiId%>" />
</tr>
<%
	}
%>
