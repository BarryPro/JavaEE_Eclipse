<%
	/*
		* 2014/04/04 10:59:58 gaopeng
		* ��ӹ���������ͨ���ֻ���������˺Ż�ȡ��Ʒ��sm_code
		*	�ƶ���ͥ�ͻ����ҵ����Ӫ֧��ϵͳ����
	*/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode= (String)session.getAttribute("regCode");
		/*�������*/
		String phoneNo = request.getParameter("phoneNo");
		System.out.println("======gaopengSeLog==========phoneNo="+phoneNo);
		/*����˺�*/
		String kdNo = request.getParameter("kdNo");
		System.out.println("======gaopengSeLog==========kdNo="+kdNo);
		String getBroadSql = "";
		if(phoneNo != null && !"".equals(phoneNo)){
			getBroadSql = "select sm_code from dcustmsg where phone_no = '"+phoneNo+"'";
		}else if(kdNo != null && !"".equals(kdNo)){
			getBroadSql = "select a.sm_code from dcustmsg a,dbroadbandmsg b "
			+ "where a.phone_no = b.phone_no "
			+ "and b.cfm_login = '"+kdNo+"'";
		}
		
		String smCode = "";
		System.out.println("======gaopengSeLog====== getBroadSql ===" + getBroadSql);
%>
	<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=getBroadSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
<%
	if(!(retCode.equals("0") || retCode.equals("000000"))){
	}else if(result != null && result.length > 0){
		smCode = result[0][0];
	}
	System.out.println("============ smCode ===" + smCode);
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("smCode","<%=smCode%>");
	core.ajax.receivePacket(response);