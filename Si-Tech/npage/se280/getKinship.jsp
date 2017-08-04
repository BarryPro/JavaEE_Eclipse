<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String opCode = request.getParameter("opCode");
	String parentPhone = request.getParameter("parentPhone");
	
	String famCode = request.getParameter("famCode");
	String prodCode = request.getParameter("prodCode");
	String famRole = request.getParameter("famRole");
	String busiType = request.getParameter("busiType");
	String memRoleId = request.getParameter("memRoleId");
	System.out.println("getBusi.jsp-----[" + famCode + "|" + prodCode + "|" + famRole + "|" + memRoleId + "]");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
%>
		<wtc:service name="sFamSelCheck" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="8">
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
		System.out.println("---------getOfferContent.jsp--------" + retCode1);
		if("000000".equals(retCode1)){
			String busiId = result[0][0];
			System.out.println("---------getOfferContent.jsp--------length" + result.length);
%>
<tr>
	<td class="blue" rowspan="7">����ͨ</td>
	<td class="blue">
		��������
	</td>
	<td>
		��������ͨ
		<input type="hidden" id="kinShipBusiId" value="<%=busiId%>" />
	</td>
	<td class="blue">
		�ʷ�
	</td>
	<td>
		<input type="hidden" id="propOfferId" name="propOfferId" value="<%=result[0][1]%>" />
		<%=result[0][1]%>-<%=result[0][6]%>
	</td>
</tr>
<tr>
	<td class="blue">
		��ʼʱ��
	</td>
	<td>
		<input type="text" id="kinShipBeginTime" v_must="1" readonly value="<%=currTime%>"
		 onClick="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true,alwaysUseStartDate:true})" /> 
		<font class="orange">*</font>
	</td>
	<td class="blue">
		����ʱ��
	</td>
	<td>
		<input type="text" id="kinShipEndTime" v_must="1" readonly value="2050-01-01 00:00:00"
		 onClick="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true,alwaysUseStartDate:true})" /> 
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		����������
	</td>
	<td>
		<input type="text" id="propName" name="applyName" maxlength="10" v_type = "string" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
	<td class="blue">
		�������Ա�
	</td>
	<td>
		<input type="radio" name="propSex" value="��" checked />��
		<input type="radio" name="propSex" value="Ů" />Ů
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		��������
	</td>
	<td>
		<input type="text" id="propBirthday" v_must="1" readonly
		 onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',readOnly:true,alwaysUseStartDate:true})" /> 
		<font class="orange">*</font>
	</td>
	<td class="blue">
		���֤��
	</td>
	<td>
		<input type="text" id="prodCardNo" name="prodCardNo" maxlength="30" v_type = "idcard" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		������
	</td>
	<td>
		<input type="text" id="propDistrict" name="propDistrict" maxlength="25" v_type = "string" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
	<td class="blue">
		��ס��ϸ��ַ
	</td>
	<td>
		<input type="text" id="propAddress" name="propAddress" maxlength="100" v_type = "string" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		�����˳�ס�̻�
	</td>
	<td>
		<input type="text" id="propTelephone" name="propTelephone" maxlength="20" v_type="0_9" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
	<td class="blue">
		�û���¼�ʺ�
	</td>
	<td>
		<input type="text" id="userAccounts" name="userAccounts" maxlength="20" v_type = "string" v_must = "1" onblur = "checkElement(this)" onfocus="getAccount()" />
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		����
	</td>
	<td colspan="3">
		<input type="text" id="propCommunity" name="propCommunity" maxlength="50" v_type = "string" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
</tr>
<%
	}
%>
