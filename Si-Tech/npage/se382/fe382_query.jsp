<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String oldlogins = request.getParameter("oldlogins");
		String phoneNo = request.getParameter("phoneNo");
		String projectType = request.getParameter("projectType");
		String projectCode = request.getParameter("projectCode");
		String retcode="";
		String retmsg="";
		String bodefutypes="";//����Ԥ��ר������
		String bodefusamount="";//����Ԥ��ר��ʣ����
		String acdefutypes="";//�Ԥ��ר������
		String acdefusamount="";//�Ԥ��ר��ʣ����
		String giadefuntype="";//����Ԥ���ר������
		String gitdeamount="";//����Ԥ�����
		String prgitefutypes="";//Ԥ��������ר������
		String prgiteconamount="";//Ԥ��������ʣ����
		String codeamount="";//��תԤ����
		String prgitereamount="";//Ԥ��������Ӧ���ս��
		String fillcash="";//�û�Ӧ�����ֽ�
%>
<%
		
		String  inputParsm [] = new String[4];
		inputParsm[0] = phoneNo;
		inputParsm[1] = oldlogins;
		inputParsm[2] = projectType;
		inputParsm[3] = projectCode;

%>
	
		<wtc:service name="s8379QryNew"  outnum="13">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
		if(ret.length > 0)
		{
			if((ret[0][0]!="000000")&&!ret[0][0].equals("000000"))
			{
			retcode=ret[0][0];
			retmsg=ret[0][1];
		 }else {
		 	retcode=ret[0][0];
			retmsg=ret[0][1];
			bodefutypes=ret[0][3];
			if(bodefutypes==null) {
			bodefutypes="CC";
		  }else {
		  bodefutypes=bodefutypes.trim();
			}
			bodefusamount=ret[0][4];
			if(bodefusamount==null) {
			bodefusamount="0.00";
		  }else {
		  	bodefusamount=bodefusamount.trim();
			}
			acdefutypes=ret[0][5];
			if(acdefutypes==null) {
			acdefutypes="CD";
		}else {
			acdefutypes=acdefutypes.trim();
			}
			acdefusamount=ret[0][6];
			if(acdefusamount==null) {
			acdefusamount="0.00";
		}else {
			acdefusamount=acdefusamount.trim();
			}
			giadefuntype=ret[0][7];
			if(giadefuntype==null) {
			giadefuntype="";
		}else {
			giadefuntype=giadefuntype.trim();
			}
			gitdeamount=ret[0][8];
			if(gitdeamount==null) {
			gitdeamount="";
		}else {
			gitdeamount=gitdeamount.trim();
			}
			prgitefutypes=ret[0][9];
			if(prgitefutypes==null) {
			prgitefutypes="CZ";
		}else {
			prgitefutypes=prgitefutypes.trim();
			}
			prgiteconamount=ret[0][10];
			if(prgiteconamount==null) {
			prgiteconamount="0.00";
		}else {
			prgiteconamount=prgiteconamount.trim();
			}
			codeamount=ret[0][2];
			if(codeamount==null) {
			codeamount="0.00";
		}else {
			codeamount=codeamount.trim();
			}
			prgitereamount=ret[0][11];
			if(prgitereamount==null) {
			prgitereamount="0.00";
		}else {
			prgitereamount=prgitereamount.trim();
			}
			fillcash=ret[0][12];
			if(fillcash==null) {
			fillcash="0.00";
		}else {
			fillcash=fillcash.trim();
			}
		 }
		}
		else if(ret == null || ret.length == 0){
			retcode="���Է���Ĵ���";
			retmsg="s8379QryNew���񷵻ؽ��Ϊ�գ�";
		}
		
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%=retCode%>");
	response.data.add("retmsg","<%=retMsg%>");
	response.data.add("bodefutypes","<%=bodefutypes%>");
	response.data.add("bodefusamount","<%=bodefusamount%>");
	response.data.add("acdefutypes","<%=acdefutypes%>");
	response.data.add("acdefusamount","<%=acdefusamount%>");
	response.data.add("giadefuntype","<%=giadefuntype%>");
	response.data.add("gitdeamount","<%=gitdeamount%>");
	response.data.add("prgitefutypes","<%=prgitefutypes%>");
	response.data.add("prgiteconamount","<%=prgiteconamount%>");
	response.data.add("codeamount","<%=codeamount%>");
	response.data.add("prgitereamount","<%=prgitereamount%>");
	response.data.add("fillcash","<%=fillcash%>");
	core.ajax.receivePacket(response);