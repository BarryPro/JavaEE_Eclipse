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
	<td class="blue" rowspan="7">亲情通</td>
	<td class="blue">
		操作类型
	</td>
	<td>
		订购亲情通
		<input type="hidden" id="kinShipBusiId" value="<%=busiId%>" />
	</td>
	<td class="blue">
		资费
	</td>
	<td>
		<input type="hidden" id="propOfferId" name="propOfferId" value="<%=result[0][1]%>" />
		<%=result[0][1]%>-<%=result[0][6]%>
	</td>
</tr>
<tr>
	<td class="blue">
		开始时间
	</td>
	<td>
		<input type="text" id="kinShipBeginTime" v_must="1" readonly value="<%=currTime%>"
		 onClick="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true,alwaysUseStartDate:true})" /> 
		<font class="orange">*</font>
	</td>
	<td class="blue">
		结束时间
	</td>
	<td>
		<input type="text" id="kinShipEndTime" v_must="1" readonly value="2050-01-01 00:00:00"
		 onClick="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true,alwaysUseStartDate:true})" /> 
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		申请人姓名
	</td>
	<td>
		<input type="text" id="propName" name="applyName" maxlength="10" v_type = "string" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
	<td class="blue">
		申请人性别
	</td>
	<td>
		<input type="radio" name="propSex" value="男" checked />男
		<input type="radio" name="propSex" value="女" />女
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		出生日期
	</td>
	<td>
		<input type="text" id="propBirthday" v_must="1" readonly
		 onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',readOnly:true,alwaysUseStartDate:true})" /> 
		<font class="orange">*</font>
	</td>
	<td class="blue">
		身份证号
	</td>
	<td>
		<input type="text" id="prodCardNo" name="prodCardNo" maxlength="30" v_type = "idcard" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		行政区
	</td>
	<td>
		<input type="text" id="propDistrict" name="propDistrict" maxlength="25" v_type = "string" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
	<td class="blue">
		常住详细地址
	</td>
	<td>
		<input type="text" id="propAddress" name="propAddress" maxlength="100" v_type = "string" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		申请人常住固话
	</td>
	<td>
		<input type="text" id="propTelephone" name="propTelephone" maxlength="20" v_type="0_9" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
	<td class="blue">
		用户登录帐号
	</td>
	<td>
		<input type="text" id="userAccounts" name="userAccounts" maxlength="20" v_type = "string" v_must = "1" onblur = "checkElement(this)" onfocus="getAccount()" />
		<font class="orange">*</font>
	</td>
</tr>
<tr>
	<td class="blue">
		社区
	</td>
	<td colspan="3">
		<input type="text" id="propCommunity" name="propCommunity" maxlength="50" v_type = "string" v_must = "1" onblur = "checkElement(this)" />
		<font class="orange">*</font>
	</td>
</tr>
<%
	}
%>
