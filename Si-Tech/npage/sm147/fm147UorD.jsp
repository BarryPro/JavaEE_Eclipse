<%
/********************
 * version v2.0
 * gaopeng 2014/08/08 10:59:49 R_CMI_HLJ_xueyz_2014_1666493@关于实现融合通信联合集团的需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm147UorD.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String OwnerName =  request.getParameter("OwnerName");
		String OwnerID =  request.getParameter("OwnerID");
		String OwnerMobile =  request.getParameter("OwnerMobile");
		String ModuleSerialNumber =  request.getParameter("ModuleSerialNumber");
		String InstallationPoints =  request.getParameter("InstallationPoints");
		String InstallationPerson =  request.getParameter("InstallationPerson");
		String InstalPerCon =  request.getParameter("InstalPerCon");
		String FrameNumber =  request.getParameter("FrameNumber");
		String PlateNumber =  request.getParameter("PlateNumber");
		
		String serviceName =  request.getParameter("serviceName");
		String opFlag =  request.getParameter("opFlag");
		
		
		String  inputParsm [] = new String[20];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		inputParsm[7] = OwnerName;
		inputParsm[8] = OwnerID;
		inputParsm[9] = OwnerMobile;
		inputParsm[10] = ModuleSerialNumber;
		inputParsm[11] = InstallationPoints;
		inputParsm[12] = InstallationPerson;
		inputParsm[13] = InstalPerCon;
		inputParsm[14] = FrameNumber;
		inputParsm[15] = PlateNumber;
		
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[7]=====" + inputParsm[7]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[8]=====" + inputParsm[8]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[9]=====" + inputParsm[9]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[10]=====" + inputParsm[10]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[11]=====" + inputParsm[11]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[12]=====" + inputParsm[12]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[13]=====" + inputParsm[13]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[14]=====" + inputParsm[14]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====inputParsm[15]=====" + inputParsm[15]);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====serviceName=====" + serviceName);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp =====opFlag=====" + opFlag);
		
		String retCode11 = "";
		String retMsg11 = "";
		int retLength = 0;
		
try{		
%>
		<wtc:service name="<%=serviceName%>" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>
				<wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>
				<wtc:param value="<%=inputParsm[15]%>"/>
				
				
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp ==========" + retCode11);
		System.out.println("========gaopengSeeLog==== fm147UorD.jsp ==========" + retMsg11);
	
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("opFlag","<%=opFlag%>");

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         