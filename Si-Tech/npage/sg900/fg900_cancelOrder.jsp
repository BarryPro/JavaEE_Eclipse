<%@ page contentType= "text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String accept = WtcUtil.repNull(request.getParameter("accept"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String opCode = (String)request.getParameter("opCode");
		System.out.println("hejwa--------------- accept " + accept);
		System.out.println("hejwa--------------- phoneNo " + phoneNo);
		System.out.println("hejwa--------------- opCode " + opCode);
		String sIpAddress = request.getRemoteAddr();
		String groupId = (String)session.getAttribute("groupId");
		String sOpTime=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());//"20080912 09:59:01";
		String orgCode = (String)session.getAttribute("orgCode");
		String sRegionCode = regionCode.substring(0,2);
		String sMark="["+inLoginNo+"]对[" + phoneNo + "]做[撤单]";
		String BureauId = regionCode.substring(0,2);

		String errorCode = "";
		String errorMsg = "";
try{	
		
		UType sendInfo  = new UType();
		sendInfo.setUe("LONG",   accept);//流水
		sendInfo.setUe("STRING", opCode);
		sendInfo.setUe("STRING", inLoginNo);//工号
		sendInfo.setUe("STRING", password);//密码
		
		sendInfo.setUe("STRING", sIpAddress);//ip
		sendInfo.setUe("STRING", groupId);//groupid
		sendInfo.setUe("STRING", sOpTime);//操作时间
		sendInfo.setUe("STRING", sRegionCode);//regioncode
		sendInfo.setUe("STRING", sMark);	//[aaaaxp]做[撤单]
		sendInfo.setUe("STRING", BureauId);// regioncode
		sendInfo.setUe("STRING", groupId);	//	(String)session.getAttribute("groupId");
		
		UType orderMsg  = new UType();  
		orderMsg.setUe("STRING", "3");//3是撤单
		orderMsg.setUe("LONG", "3");//1 #lChangeType 变更类型   select * from sOrderArrayChangeType t
		orderMsg.setUe("STRING", inLoginNo);//工号，变更人
		orderMsg.setUe("STRING", "撤单");//变更内容撤单
		orderMsg.setUe("LONG", "3");//变更原因标示（我应该有一个新的）
		orderMsg.setUe("STRING", sOpTime);//当前时间串
		orderMsg.setUe("LONG", "2");// 变更审批结果ID      (不知道是什么)       
		orderMsg.setUe("LONG", accept);//流水
		orderMsg.setUe("LONG", "3");//审核规则标识    
		orderMsg.setUe("STRING", ""); //变更审核人 9
		orderMsg.setUe("STRING", "");//变更审核时间 10
		orderMsg.setUe("STRING", "");//变更审核意见 11
		orderMsg.setUe("LONG", accept);//流水12
		
		UType uCustOrderId  = new UType();
		
		String sql = "select b.order_array_id from dservordermsg a ,dorderarraymsg b where  b.order_array_id = a.order_array_id and a.service_no='" + phoneNo + "'";
%>
		<wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="order_array" scope="end" />
			
		var array = [];
<%
		UType uuCustOrderId  = new UType();
		
		if (order_array.length > 0){
				UType us[] = new UType[order_array.length];
				for(int i = 0; i < order_array.length; i++){
						us[i] = new UType();
						us[i].setUe("STRING", order_array[i][0]);
						System.out.println("hejwa---------order_array["+i+"]-------------" + order_array[i]);
						uuCustOrderId.setUe(us[i]);
				}
		}
		
		orderMsg.setUe(uuCustOrderId);
%>
		<wtc:utype name="sCustOrderDraw" id="retVal" scope="end" >
			 <wtc:uparam value="<%=sendInfo %>" type="UTYPE"/> 
			 <wtc:uparam value="<%=orderMsg %>" type="UTYPE"/> 
		</wtc:utype>
<%
		if(retVal.getValue(0) != null && retVal.getValue(0).equals("0")){
				errorCode = "000000";
		} else {
				errorCode = retVal.getValue(0); 
		}
		
		errorMsg = retVal.getValue(1);
		if(errorMsg != null && errorMsg.length() > 35){
				errorMsg = errorMsg.substring(0,35);
		}
}catch(Exception e){
		errorCode = "40404";
		errorMsg  = "调用服务系统错误，请联系管理员";
}
		
%>
		var response = new AJAXPacket();
		response.data.add("code", "<%=errorCode%>");
		response.data.add("msg", "<%=errorMsg%>");
		core.ajax.receivePacket(response);