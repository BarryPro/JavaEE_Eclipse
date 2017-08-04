<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
 <%!
		public static String createArray(String aimArrayName, int xDimension)
    {
        String stringArray = "var " + aimArrayName + " = new Array(";
        int flag = 1;
        for(int i = 0; i < xDimension; i++)
        {
            if(flag == 1)
            {
                stringArray = stringArray + "new Array()";
                flag = 0;
                continue;
            }
            if(flag == 0)
            {
                stringArray = stringArray + ",new Array()";
            }
        }

        stringArray = stringArray + ");";
        return stringArray;
    }
%>
<%
			String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
			String[] inPubParams = new String[31];
			inPubParams[0] = request.getParameter("loginAccept");//操作流水
			inPubParams[1] = "01";//渠道标识
			inPubParams[2] = request.getParameter("opCode"); 
			inPubParams[3] = request.getParameter("workNo");//操作员工号
			inPubParams[4] = (String) session.getAttribute("password");//操作员密码
			inPubParams[5] = request.getParameter("phoneNo");//服务号码
			inPubParams[6] = request.getParameter("iUserPwd");//用户密码
			inPubParams[7] = request.getParameter("radioIndex");//操作类型
			inPubParams[8] = request.getParameter("phoneNo");//服务号码
			inPubParams[9] = request.getParameter("cfmLogin");//宽带账号
			inPubParams[10] = request.getParameter("0");//宽带旧密码
			inPubParams[11] = request.getParameter("0");//宽带账号新密码
			inPubParams[12] = request.getParameter("vPhoneNo");//转存号码
			inPubParams[13] = request.getParameter("vConID");//转存账号   
			inPubParams[14] = request.getParameter("backPrepay");//转存金额      
			inPubParams[15] = request.getParameter("orgCode");
			inPubParams[16] = request.getParameter("handFee");
			inPubParams[17] = request.getParameter("factPay");
			inPubParams[18] = request.getParameter("ipAdd");
			inPubParams[19] =  request.getParameter("construct_request")==null?"没有":request.getParameter("construct_request");
			inPubParams[20] =  request.getParameter("appointTime")==null?dateStr2:request.getParameter("appointTime");
			inPubParams[21] = request.getParameter("sysRemark");
			
			
			
      /*旧资源信息*/
      inPubParams[22] = request.getParameter("portCodeOld");
      inPubParams[23] = request.getParameter("deviceCodeOld");
      inPubParams[24] = request.getParameter("ipAddressOld");
      inPubParams[25] = request.getParameter("deviceInAddressOld");
      inPubParams[26] = request.getParameter("cctIdOld");
      /*inPubParams[26] = "001";*/
      inPubParams[27] = "";//标准地址新
      inPubParams[28] = "";//标准地址旧
      inPubParams[29] = request.getParameter("iModemFlag");
      
      inPubParams[30] = request.getParameter("reasonDescription");
      
      
			System.out.println("opCode========"+request.getParameter("opCode"));
			System.out.println("radioIndex========"+request.getParameter("radioIndex"));
			System.out.println("phone_no========"+request.getParameter("phoneNo"));
			System.out.println("cfmLogin========"+request.getParameter("cfmLogin"));
			System.out.println("cfmOldPwd========"+"0");
			System.out.println("cfmNewPwd========"+"0");
			System.out.println("workNo========"+request.getParameter("workNo"));
			System.out.println("passwd========"+(String) session.getAttribute("password"));
			System.out.println("passwd========"+request.getParameter("loginAccept"));
			System.out.println("vPhoneNo========"+request.getParameter("vPhoneNo"));
			System.out.println("vConID========"+request.getParameter("vConID"));
			System.out.println("backPrepay========"+request.getParameter("backPrepay"));
			System.out.println("orgCode========"+request.getParameter("orgCode"));
			System.out.println("handFee========"+request.getParameter("handFee"));
			System.out.println("factPay========"+request.getParameter("factPay"));
			System.out.println("factPay========"+request.getParameter("ipAdd"));
			System.out.println("construct_requesst========"+inPubParams[16]);
			System.out.println("appointTime========"+inPubParams[17]);
			System.out.println("sysRemark========"+request.getParameter("sysRemark"));
			
			System.out.println("旧资源信息==============");
			System.out.println("portCodeOld========"+request.getParameter("portCodeOld"));
			System.out.println("deviceCodeOld========"+request.getParameter("deviceCodeOld"));
			System.out.println("ipAddressOld========"+request.getParameter("ipAddressOld"));
			System.out.println("deviceInAddressOld========"+request.getParameter("deviceInAddressOld"));
			/*System.out.println("cctIdOld========"+request.getParameter("cctIdOld"));*/
			String strServName="";
			if("b540".equals(inPubParams[2])) {
					strServName = "sBroadInfoOpr";
			}else {
				  strServName = "sBroadBandChg";
			}
%>
		<wtc:service name="<%=strServName%>" routerKey="phone" routerValue="<%=inPubParams[2]%>" outnum="3" >
		<wtc:param value="<%=inPubParams[0]%>"/>
		<wtc:param value="<%=inPubParams[1]%>"/>
		<wtc:param value="<%=inPubParams[2]%>"/>
		<wtc:param value="<%=inPubParams[3]%>"/>
		<wtc:param value="<%=inPubParams[4]%>"/>
		<wtc:param value="<%=inPubParams[5]%>"/>
		<wtc:param value="<%=inPubParams[6]%>"/>
		<wtc:param value="<%=inPubParams[7]%>"/>
		<wtc:param value="<%=inPubParams[8]%>"/>
		<wtc:param value="<%=inPubParams[9]%>"/>	
		<wtc:param value="<%=inPubParams[10]%>"/>
		<wtc:param value="<%=inPubParams[11]%>"/>
		<wtc:param value="<%=inPubParams[12]%>"/>
		<wtc:param value="<%=inPubParams[13]%>"/>
		<wtc:param value="<%=inPubParams[14]%>"/>	
		<wtc:param value="<%=inPubParams[15]%>"/>	
		<wtc:param value="<%=inPubParams[16]%>"/>
		<wtc:param value="<%=inPubParams[17]%>"/>
		<wtc:param value="<%=inPubParams[18]%>"/>	
		<wtc:param value="<%=inPubParams[19]%>"/>	
		<wtc:param value="<%=inPubParams[20]%>"/>	
		<wtc:param value="<%=inPubParams[21]%>"/>
		<wtc:param value="<%=inPubParams[22]%>"/>
		<wtc:param value="<%=inPubParams[23]%>"/>	
		<wtc:param value="<%=inPubParams[24]%>"/>
		<wtc:param value="<%=inPubParams[25]%>"/>
		<wtc:param value="<%=inPubParams[26]%>"/>	
		<wtc:param value="<%=inPubParams[27]%>"/>
		<wtc:param value="<%=inPubParams[28]%>"/>
		<wtc:param value="<%=inPubParams[29]%>"/>	
		<wtc:param value="<%=inPubParams[30]%>"/>		
		</wtc:service>
		<wtc:array id="backInfo" scope="end"/>
<%
    String errCode = retCode;
    String errMsg = retMsg;
    String b540LoginAccept="";
    if(backInfo.length>0){
    	b540LoginAccept = backInfo[0][0];
    	System.out.println("###################################f1213->f1213LoginAccept->"+b540LoginAccept);
    }
    //增加统一接触	
    String opBeginTime1  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//业务开始时间
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+inPubParams[0]+"&retCodeForCntt="+retCode+"&opName=综合变更&workNo="+inPubParams[6]+"&loginAccept="+b540LoginAccept+"&pageActivePhone="+inPubParams[2]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime1;
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("Msg1 :" + errCode + ":" + errMsg);
    System.out.println(backInfo.length);
    String strArray = createArray("backInfo", backInfo.length);
%>
		<%=strArray%>
<%
		if(backInfo.length>0){
    	for (int j = 0; j < backInfo[0].length; j++) {
    	    	    System.out.println("backInfo[0][j]===="+backInfo[0][j]);
%>
				backInfo[0][<%=j%>] = "<%=backInfo[0][j]%>";
<%
    	}
    }
%>

		var response = new AJAXPacket();
		response.data.add("backString",backInfo);
		response.data.add("flag","1");
		response.data.add("errCode","<%=errCode%>");
		response.data.add("errMsg","<%=errMsg%>");
		core.ajax.receivePacket(response);

