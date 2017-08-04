<%
    /*************************************
    * 功  能: 关于开发租赁式呼叫中心BOSS系统需求的函 3690
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-11-26
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode = (String)session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode	=(String)session.getAttribute("regCode");	
	String method = WtcUtil.repNull((String)request.getParameter("method"));
	String provCode = WtcUtil.repNull((String)request.getParameter("prov_code"));
	String cityCode = WtcUtil.repNull((String)request.getParameter("cityCode"));
	
	//3691
	String idNo = WtcUtil.repNull((String)request.getParameter("idNo"));//集团用户ID
	String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String accessId	= 	WtcUtil.repNull((String)request.getParameter("accessId"));//接入号ID
 	String accessCode = WtcUtil.repNull((String)request.getParameter("accessCode"));//接入号
%>
 	var array = new Array();
 	//构造函数
    function Obj(name,code) {
      this.name = name;
      this.code = code;
    }
    
    
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%
	if(method != null && method.equals("getProv")) {
		String paramProv = "Select distinct Province_name,Province_code from sGrpAllAreaCode";
%>
		array = [];
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
			<wtc:param value="<%=paramProv%>"/>
		</wtc:service>
		<wtc:array id="resultProv"  scope="end"/>
<%
		if("000000".equals(retCode)){
			if(resultProv.length>0){
				for(int outter = 0 ; resultProv != null && outter < resultProv.length; outter ++){
%>
					array.push(new Obj("<%=resultProv[outter][0]%>","<%=resultProv[outter][1]%>"));
<%
				}
			}
		}
%>
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		response.data.add("provArray",array);
		core.ajax.receivePacket(response);
<%		
	}else if(method != null && method.equals("getCity")) {
		String paramCity = "Select distinct area_order, City_name from sGrpAllAreaCode where Province_code=:prov_code";
		String valCity = "prov_code=" + provCode;
%>
		array = [];
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCityCode" retmsg="retCityMsg" outnum="2" >
			<wtc:param value="<%=paramCity%>"/>
			<wtc:param value="<%=valCity%>"/>
		</wtc:service>
		<wtc:array id="resultCity"  scope="end"/>
<%
		if("000000".equals(retCityCode)){
			if(resultCity.length>0){
				for(int outter = 0 ; resultCity != null && outter < resultCity.length; outter ++){
%>
					array.push(new Obj("<%=resultCity[outter][1]%>","<%=resultCity[outter][0]%>"));
<%
				}
			}
		}
%>
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retCityCode%>");
		response.data.add("retMsg","<%=retCityMsg%>");
		response.data.add("cityArray",array);
		core.ajax.receivePacket(response);
<%
	}else if(method != null && method.equals("getProvCode")) {
		String paramCity = "Select distinct province_code from sGrpAllAreaCode where area_order =:area_order";
		String valCity = "area_order=" + cityCode;
%>
		array = [];
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
				retcode="retProvCode" retmsg="retProvMsg" outnum="1" >
			<wtc:param value="<%=paramCity%>"/>
			<wtc:param value="<%=valCity%>"/>
		</wtc:service>
		<wtc:array id="resultProvCode"  scope="end"/>
<%
		if("000000".equals(retProvCode)){
			provCode = resultProvCode[0][0];
		}else {
			provCode = "";
		}
%>
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retProvCode%>");
		response.data.add("retMsg","<%=retProvMsg%>");
		response.data.add("provCode","<%=provCode%>");
		response.data.add("cityCode","<%=cityCode%>");
		core.ajax.receivePacket(response);
<%
	}else if(method != null && method.equals("delRecord")) {
		if(accessId != null) {
			accessId = accessId.replaceFirst("no_","");
		}
		//0删除;1增加 	
		String[] inputParams = new String[11];
		inputParams[0] = printAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = loginNo;
		inputParams[4] = password;
		inputParams[5] = "";
		inputParams[6] = "";
		inputParams[7] = "0";//0删除;1增加 	
		inputParams[8] = idNo;
		inputParams[9] = accessId;
		inputParams[10] = accessCode;
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("----liujian3691---delRecord--inputParams【" + i + "】=" + inputParams[i]);
		}
%>
		<wtc:service name="sAccessCodeCfm" routerKey="region" routerValue="<%=regionCode%>" 
			retcode="retDelCode" retmsg="retDelMsg" outnum="1" >
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
			<wtc:param value="<%=inputParams[8]%>"/>
			<wtc:param value="<%=inputParams[9]%>"/>
			<wtc:param value="<%=inputParams[10]%>"/>
		</wtc:service>
		<wtc:array id="resultDelRecord"  scope="end"/>
			
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retDelCode%>");
		response.data.add("retMsg","<%=retDelMsg%>");
		core.ajax.receivePacket(response);
<%
	}else if(method != null && method.equals("addRecord")) {
		//0删除;1增加 	
		String[] inputParams = new String[11];
		inputParams[0] = printAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = loginNo;
		inputParams[4] = password;
		inputParams[5] = "";
		inputParams[6] = "";
		inputParams[7] = "1";//0删除;1增加 	
		inputParams[8] = idNo;
		inputParams[9] = printAccept;//添加时，accessId设置成流水
		inputParams[10] = accessCode;
		
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("----liujian3691---addRecord--inputParams【" + i + "】=" + inputParams[i]);
		}
%>
		<wtc:service name="sAccessCodeCfm" routerKey="region" routerValue="<%=regionCode%>" 
			retcode="retAddCode" retmsg="retAddMsg" outnum="1" >
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
			<wtc:param value="<%=inputParams[8]%>"/>
			<wtc:param value="<%=inputParams[9]%>"/>
			<wtc:param value="<%=inputParams[10]%>"/>
		</wtc:service>
		<wtc:array id="resultAddRecord"  scope="end"/>
			
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retAddCode%>");
		response.data.add("retMsg","<%=retAddMsg%>");
		core.ajax.receivePacket(response);
<%
	}
%>
	  

