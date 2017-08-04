
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/public/CallCrmPD.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>


<%
		String cnttOpCode = request.getParameter("opCode");
		String cnttOpName = request.getParameter("opName");		
		
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String noPass = (String)session.getAttribute("password");
		String orgCode = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String phoneNo = request.getParameter("phoneNo");
		String oldPass = request.getParameter("phonePass");
		String newPass = request.getParameter("t_new_pass");
		System.out.println(" === phoneNo " + phoneNo + "   , newPass " + newPass);
		
		String loginAccept = request.getParameter("loginAccept");
		String idNo= request.getParameter("idNo");
		String payFee= request.getParameter("payFee");
		String factPay= request.getParameter("t_handFee");
		String opType = request.getParameter("opType");
		String opFlag = request.getParameter("opFlag");
		String trueOpCode = request.getParameter("trueOpCode");
		String opNote = request.getParameter("asNotes");
		String ipAdd= request.getParameter("selfIpAddr");
		String strIdenType = request.getParameter("identity_type")==null ?"": request.getParameter("identity_type");
		String strIdenInfo = request.getParameter("identity_info")==null ?"": request.getParameter("identity_info");
		String sysRemark= "系统备注：用户密码修改（渠道协同）";
		
		String ecNewPass = Encrypt.encrypt(newPass);
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
			 routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%

/* 获取配置信息 */
		String readPath = request.getRealPath("npage/properties")+"/callCrmpd.properties";
		String crmpdIp = readValue("callCrmpd","m053","crmpdIp",readPath);
		String crmpdPort = readValue("callCrmpd","m053","crmpdPort",readPath);
		String crmpdAppId = readValue("callCrmpd","m053","appId",readPath);
		String orderType = readValue("callCrmpd","m053","orderType",readPath);
		String mainSvcId = readValue("callCrmpd","m053","mainSvcId",readPath);
		String mainSvcAct = readValue("callCrmpd","m053","mainSvcAct",readPath);
		String channelId = readValue("callCrmpd","m053","channelId",readPath);
		String province = readValue("callCrmpd","m053","province",readPath);

		StringBuffer valueSB = new StringBuffer();
		valueSB.append(loginAccept).append("|")
			.append(regionCode).append("|")
			.append(trueOpCode).append("|")
			.append(workNo).append("|")
			.append(noPass).append("|")
			.append(phoneNo).append("|")
			.append("").append("|")
			.append(orgCode).append("|")
			.append(opType).append("|")
			.append(opFlag).append("|")
			.append(idNo).append("|")
			.append(oldPass).append("|")
			.append(ecNewPass).append("|")
			.append(payFee).append("|")
			.append(factPay).append("|")
			.append(sysRemark).append("|")
			.append(opNote).append("|")
			.append(ipAdd).append("|")
			.append(strIdenType).append("|")
			.append(strIdenInfo).append("|");
		
		String orderId = "";
		orderId = sLoginAccept;
		
		String currTime = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new Date());
		
		StringBuffer dataSB = new StringBuffer();
		dataSB.append("bizCode=1000").append(",")
					.append("crmOrderId=A").append(orderId).append(",")
					.append("ossOrderId=A").append(orderId).append(",")
					.append("svcNo=").append(phoneNo).append(",")
					.append("orderType=YP").append(",")
					.append("regionId=").append(regionCode).append(",")
					.append("orderCreateTime=").append(currTime).append(",")
					.append("reqDate=").append(currTime).append(",")
					.append("dealLevel=").append("1").append(",")
					.append("contactId=").append(currTime).append(",")
					.append("loginNo=").append(workNo).append(",")
					.append("groupId=").append(groupId).append(",")
					.append("province=").append(province).append(",")
					.append("channelId=").append(channelId).append(",")
					.append("mainSvcId=").append(mainSvcId).append(",")
					.append("mainSvcAct=").append(mainSvcAct).append(",")
					.append("prptyId=").append("100001|100002|100003|100004|100005|100006|100007|100008|100009|100010|100011|100012|100013|100014|100015|100016|100017|100018|100019|100020").append(",")
					.append("prptyName=").append("iLoginAccept|iChnSource|op_code|iLoginNo|iLoginPwd|iPhoneNo|iUserPwd|orgCode|voptype|vopflag|vIdNo|vOldPaswd|vNewPaswd|payFee|realFee|systemNote|opNote|ipAddr|iIccidNum|iLaterSet").append(",")
					.append("prptyNewValue=").append(valueSB).append(",")
					.append("prptyOldValue=").append(valueSB);
		
		System.out.println("CallCRMPD by ningtn  $" + dataSB.toString()+"$");
		
		
		
		
		String backStr = callPD(crmpdIp,crmpdPort,crmpdAppId,dataSB.toString());
		
		if(backStr != null && backStr.length() > 0){
			if(backStr.indexOf("RespCode") != -1){
				String RespCode = "";
				String RespMsg = "";
				String backArray[] = backStr.split(",");
				for(int i = 0; i < backArray.length; i++){
					String valArr[] = backArray[i].split("=");
					if(valArr.length == 2){
						if("RespCode".equals(valArr[0])){
							RespCode = valArr[1];
						}else if("RespMsg".equals(valArr[0])){
							RespMsg = valArr[1];
						}
					}
				}
				
				if("0".equals(RespCode)){
					%>
					<script>
							rdShowMessageDialog("操作成功",2);
							window.location="fm053.jsp?activePhone=<%=phoneNo%>&opCode=<%=cnttOpCode%>&opName=<%=cnttOpName%>";
					</script>
					<%
				}else{
					%>
					<script>
							rdShowMessageDialog("操作失败，<%=RespCode%>:<%=RespMsg%>",0);
							window.location="fm053.jsp?activePhone=<%=phoneNo%>&opCode=<%=cnttOpCode%>&opName=<%=cnttOpName%>";
					</script>
					<%
				}
				
			}else{
				%>
				<script>
						rdShowMessageDialog("调用应用集成平台失败，返回值格式不正确!",0);
						window.location="fm053.jsp?activePhone=<%=phoneNo%>&opCode=<%=cnttOpCode%>&opName=<%=cnttOpName%>";
				</script>
				<%
			}
		}else{
%>
				<script>
						rdShowMessageDialog("调用应用集成平台失败，返回值不正确!",0);
						window.location="fm053.jsp?activePhone=<%=phoneNo%>&opCode=<%=cnttOpCode%>&opName=<%=cnttOpName%>";
				</script>
<%
		}
%>