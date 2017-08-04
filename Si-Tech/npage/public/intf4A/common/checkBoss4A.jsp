<%
/********************
 * version v2.0
 * gaopeng 2014/03/10 10:48:14 关于完善金库模式管理和敏感信息模糊化的需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/public/intf4A/properties/getRDMessage.jsp" %>
<%
		System.out.println("============ checkBoss4A.jsp ==========");
		
	
		String opCode4A =  request.getParameter("opCode4A");
		/*获取调用方法时的固定值，用于判断入口为main.jsp(公共方法)还是特殊的页面*/
		String openType = request.getParameter("openType");
		String readPath = request.getRealPath("/npage/public/intf4A/properties")+"/treasury.properties";
		String openFlag = readValue("treasury",opCode4A,"openFlag",readPath);
		String checkModel = readValue("treasury",opCode4A,"checkModel",readPath);
		System.out.println("gaopengSeeLogcheckBoss4A====openFlag~~~~~~~~~~"+openFlag);	
		System.out.println("gaopengSeeLogcheckBoss4A====openType==checkModel~~~~~~~~~~"+openType+"=="+checkModel);
		String checkFlag = "false";
		/*如果开关没开,那么不用金库验证*/
		if(!"true".equals(openFlag)){
			checkFlag = "false";
		}
		/*main页面进来的NORMAL不验证SPECIAL*/
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