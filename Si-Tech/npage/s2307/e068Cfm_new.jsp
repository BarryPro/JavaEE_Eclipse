<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	// ��wCreditCfgOpr���������ü�¼���в��� ���漰��ʷ���� ��Ҫ����֮ǰ��
	String regionCode=(String)session.getAttribute("regCode");
	String phoneNo = (String)request.getParameter("phoneNo");
	String opName = "�û��������޸�";
	String opCode = "e068";
	String detail_code = request.getParameter("detail_code"); 
	String limit_grade = request.getParameter("limit_grade"); 
	String credit_expire = request.getParameter("credit_expire");  
	String CONTACT_PERSON = request.getParameter("CONTACT_PERSON"); 
	String CONTACT_PHONE = request.getParameter("CONTACT_PHONE");  
	String manager_name = request.getParameter("manager_name"); 
	String manager_phone = request.getParameter("manager_phone");
	String workNo = request.getParameter("workNo");
	String attr_code = request.getParameter("attr_code");
	// tpcall
	String loginAccept = request.getParameter("loginAccept");
	String stopFlag = request.getParameter("stopFlag");
 
	String noPass = (String)session.getAttribute("password");						//��������
	String orgCode= (String)session.getAttribute("orgCode");						//��������
	 
	String ownerCode = request.getParameter("ownerCode");							//
 
	String handFee= request.getParameter("handFee");								//������
	String factPay= request.getParameter("factPay");								//
	String sysRemark= request.getParameter("sysRemark");							//ϵͳ��ע
	String remark= request.getParameter("remark");									//��ע
	String ipAdd= (String)session.getAttribute("ip_Addr");							//IP��ַ
	String ifDetail = request.getParameter("ifDetail");								//
	String asCustName = request.getParameter("asCustName");							//�ͻ�����
	String asCustPhone = request.getParameter("asCustPhone");						//
	String asIdType = request.getParameter("asIdType");								//
	String asIdIccid = request.getParameter("asIdIccid");							//
	String asIdAddress = request.getParameter("asIdAddress");						//
	String asContractAddress = request.getParameter("asContractAddress");			//
	String asNotes = request.getParameter("asNotes");								//
	//ifDetail ��ʼ �� �޸������ȵ�ֵ
	//new �������޸ĵĲ���
	String idNo = request.getParameter("idNo");
	String oldCredit = request.getParameter("oldCredit");
	String newCredit = request.getParameter("newCredit");
	String expireTime = request.getParameter("expireTime");
 
	String chgStatus = request.getParameter("chgStatus");

	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA oldCredit is "+oldCredit+" and newCredit is "+newCredit);

%>
	<wtc:service name="e068Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=detail_code%>"/>
		<wtc:param value="<%=limit_grade%>"/>
		<wtc:param value="<%=credit_expire%>"/>
		<wtc:param value="<%=CONTACT_PERSON%>"/>
		<wtc:param value="<%=CONTACT_PHONE%>"/>
		<wtc:param value="<%=manager_name%>"/>
		<wtc:param value="<%=manager_phone%>"/>
		<wtc:param value="<%=attr_code%>"/>

		<wtc:param value="<%=loginAccept%>"/> 
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=orgCode%>"/>
 
		<wtc:param value="<%=ownerCode%>"/>
		<wtc:param value="<%=stopFlag%>"/>
		<wtc:param value="<%=handFee%>"/>
		<wtc:param value="<%=factPay%>"/>
		<wtc:param value="<%=sysRemark%>"/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAdd%>"/>
		<wtc:param value="<%=asCustName%>"/>
		<wtc:param value="<%=asCustPhone%>"/>
		<wtc:param value="<%=asIdType%>"/>
		<wtc:param value="<%=asIdIccid%>"/>
		<wtc:param value="<%=asIdAddress%>"/>
		<wtc:param value="<%=asContractAddress%>"/>
		<wtc:param value="<%=asNotes%>"/>
		<wtc:param value="<%=ifDetail%>"/>
		<wtc:param value="<%=idNo%>"/>
		<wtc:param value="<%=oldCredit%>"/>
		<wtc:param value="<%=newCredit%>"/>
		<wtc:param value="<%=expireTime%>"/>
		<wtc:param value="<%=chgStatus%>"/>
	 
	</wtc:service>
	<wtc:array id="creditCfg" scope="end"/>
<%
	String  errCode = retCode;
	String  errMsg = retMsg;
	if(errCode.equals("000000"))
	{
		String strArray = WtcUtil.createArray("creditCfg",creditCfg.length);
		%>
		<%=strArray%>
		<%
		for(int i = 0 ; i < creditCfg.length ; i ++){
			for(int j = 0 ; j < creditCfg[i].length ; j ++){
		%>
				creditCfg[<%=i%>][<%=j%>] = "<%=creditCfg[i][j].trim()%>";
		<%
			}
		}
		%>
		var response = new AJAXPacket();
	    response.data.add("creditCfg",creditCfg);
		response.data.add("flag_new","1");
		response.data.add("errCode_new","<%=errCode%>");
		response.data.add("errMsg_new","<%=errMsg%>");
		response.data.add("flag_edit","1");
		core.ajax.receivePacket(response);
		<%
	}
	else
	{
		%>
		var response = new AJAXPacket();
	
		response.data.add("flag_new","2");
		response.data.add("errCode_new","<%=errCode%>");
		response.data.add("errMsg_new","<%=errMsg%>");
		response.data.add("flag_edit","2");
		core.ajax.receivePacket(response);
		<%
	}
%>

	
