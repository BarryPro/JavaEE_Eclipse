<%
/********************
 * version v2.0
 * gaopeng 2014/03/10 10:48:14 �������ƽ��ģʽ�����������Ϣģ����������
 * ������: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/public/intf4A/properties/getRDMessage.jsp" %>
<%
		System.out.println("============ checkBoss4A.jsp ==========");
		
	
		String opCode4A =  request.getParameter("opCode4A");
		/*��ȡ���÷���ʱ�Ĺ̶�ֵ�������ж����Ϊmain.jsp(��������)���������ҳ��*/
		String openType = request.getParameter("openType");
		String readPath = request.getRealPath("/npage/public/intf4A/properties")+"/treasury.properties";
		String openFlag = readValue("treasury",opCode4A,"openFlag",readPath);
		String checkModel = readValue("treasury",opCode4A,"checkModel",readPath);
		System.out.println("gaopengSeeLogcheckBoss4A====openFlag~~~~~~~~~~"+openFlag);	
		System.out.println("gaopengSeeLogcheckBoss4A====openType==checkModel~~~~~~~~~~"+openType+"=="+checkModel);
		String checkFlag = "false";
		/*�������û��,��ô���ý����֤*/
		if(!"true".equals(openFlag)){
			checkFlag = "false";
		}
		/*mainҳ�������NORMAL����֤SPECIAL*/
		else if("NORMAL".equals(openType) && "SPECIAL".equals(checkModel)){
			checkFlag = "false";
		}
		else{
			checkFlag = "true";
		}
		System.out.println("gaopengSeeLogcheckBoss4A==============checkFlag=="+checkFlag);

%>
var response = new AJAXPacket();
response.data.add("checkFlag","<%=checkFlag %>");
response.data.add("opCode","<%=opCode4A %>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         