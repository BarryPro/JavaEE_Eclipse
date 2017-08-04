<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String searchOpCode = request.getParameter("searchOpCode");
		String password = (String)session.getAttribute("password");
		String phonenos = request.getParameter("phonenos");
		String wulidanh = request.getParameter("wulidanh");
		String wuliucommpany = request.getParameter("wuliucommpany");
		
		String peisongjieguo = request.getParameter("peisongjieguo");
		String shibaireson = request.getParameter("shibaireson");
		String sflagss = request.getParameter("sflagss");
		
		String opCode = request.getParameter("opCode");
		String  groupId = (String)session.getAttribute("groupId");
		String sOpTime=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
		String orgCode = (String)session.getAttribute("orgCode");
		String sRegionCode = regionCode.substring(0,2);
	//	String BureauId = regionCode.substring(0,2);
		String opnote = "";
		
		String errorCode = "";
		String errorMsg = "";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />

<%
	if(opCode != null && (opCode.equals("g606") || opCode.equals("g843"))) {
		opnote =workNo+"进行"+opCode+"填写物流单号受理操作";
%>
		<wtc:service name="sg530Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode606" retmsg="retMsg606" outnum="1">
	        <wtc:param value="<%=loginAccept%>"/>
	        <wtc:param value="01"/>
	        <wtc:param value="<%=opCode%>"/>
	    	<wtc:param value="<%=workNo%>"/>
	    	<wtc:param value="<%=password%>"/>
	     	<wtc:param value="<%=phonenos%>"/>
	    	<wtc:param value=""/>
	    	<wtc:param value="<%=opnote%>"/>
	    	<wtc:param value=""/>
	    	<wtc:param value=""/>
	    	<wtc:param value=""/>
	    	<wtc:param value=""/>
	    	<wtc:param value="<%=wulidanh%>"/>
	    	<wtc:param value="<%=wuliucommpany%>"/>
	    	<wtc:param value=""/>
	    	<wtc:param value=""/>
	    	<wtc:param value="1"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
	
	
		var response = new AJAXPacket();
	
		response.data.add("retcode","<%= retCode606 %>");
		response.data.add("retmsg","<%= retMsg606 %>");
		core.ajax.receivePacket(response);
<%
	}else if(opCode != null && (opCode.equals("g607")||opCode.equals("g844"))) {
		
		
		opnote =workNo+"进行"+opCode+"配送结果受理操作";
%>
		<wtc:service name="sg530Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode607" retmsg="retMsg607" outnum="1">
	        <wtc:param value="<%=loginAccept%>"/>
	        <wtc:param value="01"/>
	        <wtc:param value="<%=opCode%>"/>
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=password%>"/>
         	<wtc:param value="<%=phonenos%>"/>
        	<wtc:param value=""/>
        	<wtc:param value="<%=opnote%>"/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value="<%=peisongjieguo%>"/>
        	<wtc:param value="<%=shibaireson%>"/>
        	<wtc:param value="<%=sflagss%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
			
	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode607 %>");
	response.data.add("retmsg","<%= retMsg607 %>");
	response.data.add("sendStatus","<%=peisongjieguo %>");
	core.ajax.receivePacket(response);
<%
	}else if(opCode != null && (opCode.equals("backOrder|g607")||opCode.equals("backOrder|g844"))) {
		String sendOpCode = "";
		String opFlagBack = opCode.split("\\|")[1];
		if("g607".equals(opFlagBack))
		{
			sendOpCode = "g608";
		}
		if("g844".equals(opFlagBack))
		{
			sendOpCode = "g900";
		}
		String sIpAddress = request.getRemoteAddr();
		String sMark="["+workNo+"]对[" + phonenos + "]做["+sendOpCode+"] [撤单]";
			/**
			 *@ 输入参数：
			 *select * from dservordermsg where service_no like '209%'
				-[0]---------utype:
				-[0][0]--------long:110303419935
				-[0][1]--------string:q046
				-[0][2]--------string:aaaaxp
				-[0][3]--------string:EIGBDHBHPHHPMJCE
				-[0][4]--------string:10.109.221.11
				-[0][5]--------string:10031
				-[0][6]--------string:20130320 15:00:30
				-[0][7]--------string:01
				-[0][8]--------string:[aaaaxp]对[C0112090500000012]做[一次性费用缴费]
				-[0][9]--------string:01
				-[0][10]--------string:10031
				-[1]---------utype:
				-[1][0]--------string:3
				-[1][1]--------long:3
				-[1][2]--------string:aaaaxp
				-[1][3]--------string:在缴费处统一撤单
				-[1][4]--------long:3
				-[1][5]--------string:20130320 15:00:30
				-[1][6]--------long:2
				-[1][7]--------long:110303419935
				-[1][8]--------long:3
				-[1][9]--------string:
				-[1][10]--------string:
				-[1][11]--------string:
				-[1][12]--------long:110303419935
				-[1][13]--------utype:
				-[1][13][0]-------utype:
				-[1][13][0][0]------string:A0112090500000012
				
				select b.order_array_id from dservordermsg a ,dorderarraymsg b where  b.order_array_id = a.order_array_id and a.service_no='15045869789';
				
				RCustOrderOPChange.log
				sCustOrderDraw
			 
				System.out.println("zhouby opCode " + opCode);
			*/
			
			UType sendInfo  = new UType();
			sendInfo.setUe("LONG",   loginAccept);//流水
			sendInfo.setUe("STRING", sendOpCode);
			sendInfo.setUe("STRING", workNo);//工号
			sendInfo.setUe("STRING", password);//密码
			
			sendInfo.setUe("STRING", sIpAddress);//ip
			sendInfo.setUe("STRING", groupId);//groupid
			sendInfo.setUe("STRING", sOpTime);//操作时间
			sendInfo.setUe("STRING", sRegionCode);//regioncode
			sendInfo.setUe("STRING", sMark);	//[aaaaxp]做[撤单]
			sendInfo.setUe("STRING", sRegionCode);// regioncode
			sendInfo.setUe("STRING", groupId);	//	(String)session.getAttribute("groupId");
			
			UType orderMsg  = new UType();  
			orderMsg.setUe("STRING", "3");//3是撤单
			orderMsg.setUe("LONG", "3");//1 #lChangeType 变更类型   select * from sOrderArrayChangeType t
			orderMsg.setUe("STRING", workNo);//工号，变更人
			orderMsg.setUe("STRING", "撤单");//变更内容撤单
			orderMsg.setUe("LONG", "3");//变更原因标示（我应该有一个新的）
			orderMsg.setUe("STRING", sOpTime);//当前时间串
			orderMsg.setUe("LONG", "2");// 变更审批结果ID      (不知道是什么)       
			orderMsg.setUe("LONG", loginAccept);//流水
			orderMsg.setUe("LONG", "3");//审核规则标识    
			orderMsg.setUe("STRING", ""); //变更审核人 9
			orderMsg.setUe("STRING", "");//变更审核时间 10
			orderMsg.setUe("STRING", "");//变更审核意见 11
			orderMsg.setUe("LONG", loginAccept);//流水12
			
			
			UType uCustOrderId  = new UType();
			String sql = "select b.order_array_id from dservordermsg a ,dorderarraymsg b where  b.order_array_id = a.order_array_id and a.service_no='" + phonenos + "'";
			System.out.println("--liujian--sql=" + sql);
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
	%>
	var response = new AJAXPacket();
	response.data.add("retcode","<%=errorCode %>");
	response.data.add("retmsg","<%=errorMsg %>");
	core.ajax.receivePacket(response);
<%
}
%>	