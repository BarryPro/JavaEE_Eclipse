<%
/*************************************
* 功  能: g378·虚拟V网用户办理 
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-12-31 13:52:45
**************************************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%

	/*主页面传递的参数*/
	String chnSource	= "01";
	String opCode		= request.getParameter("opCode");
	String loginNo		= (String)session.getAttribute("workNo");
	String loginPwd		= (String)session.getAttribute("password");
	
	String phoneNo	= (String)request.getParameter("phoneNo");
	String regionCode	= (String)session.getAttribute("regCode");

	String strArray     = "var retAry;";  
	String offerId 		= "";/*资费id*/
	String retCode      = "";
	String retMsg       = "";
	String  id_no       = "";
	String method 		= request.getParameter("method"); 	
	%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
	//获得套餐分类
	if(method != null && method != "" && method.equals("getWholeClass")) {
		//	String sql_select1 = "SELECT b.offer_id FROM product_offer_instance a,product_offer b ,dcustmsg c WHERE a.offer_id=b.offer_id AND a.serv_id=c.id_no AND b.offer_type='10' AND a.exp_date>SYSDATE  AND c.phone_no=:phoneNo";
		//	String srv_params1 = "phoneNo=" + phoneNo;
%>	
		<wtc:utype name="sPMQryUserInfo" id="retUserInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
		     <wtc:uparam value="0" type="LONG"/>
		     <wtc:uparam value="<%=phoneNo%>" type="STRING"/>
		     <wtc:uparam value="<%=loginNo%>" type="string"/>
		     <wtc:uparam value="<%=loginPwd%>" type="string"/>
		     <wtc:uparam value="<%=opCode%>" type="string"/>	
		</wtc:utype>
	
<%
		retCode =retUserInfo.getValue(0);
		retMsg  =retUserInfo.getValue(1);	
			
		if(retCode.equals("0")) {	
			id_no          = retUserInfo.getValue("2.0.2.1");   /*用户id*/
			offerId      = retUserInfo.getValue("2.0.2.31");  /* 当月基本产品ID*/
		}
		System.out.println("---liujian1---offerId=" + offerId);
		//opcode 为1272，跟1272中的附加销售品 的销售品保持一致
		String _opcode = "1272";
		String sql_select2 ="select a.offer_attr_type, a.name from offer_CateGory a , PRODUCT_OFFER_SCENE_CFG b where  instr(b.role_limit, a.offer_attr_type) > 0  and    b.op_code =:opCode and exists (select 1 from product_offer_detail c,product_offer d where   c.ELEMENT_TYPE='10C' and c.ELEMENT_ID = d.offer_id and a.offer_attr_type = d.offer_attr_type and c.offer_id =:offerId) union select a.offer_attr_type, a.name from offer_CateGory a,product_offer c where substr(c.user_range,2,1) = '2' and a.offer_attr_type = c.offer_attr_type ";
		String srv_params2 = "opCode=" + _opcode + ",offerId=" + offerId;
%>	
		<wtc:service name="TlsPubSelCrm" routerKey="regioncode" 
			routerValue="<%=regionCode%>" retcode="qryClassCode" retmsg="qryClassMsg" outnum="2">
			<wtc:param value="<%=sql_select2%>"/>
			<wtc:param value="<%=srv_params2%>"/>
		</wtc:service>
		<wtc:array id="result_Class" scope="end"/>
<%
		System.out.println("----liujian2--qryClassCode=" + qryClassCode);
		if(qryClassCode.equals("000000") && result_Class.length > 0) {
			int retValNum=result_Class.length;
			
			strArray = WtcUtil.createArray("retAry",retValNum);
%>
			<%=strArray%>
<%				
			for(int i=0;i<retValNum;i++){
				for(int j=0;j<2;j++){
%>
					retAry[<%=i%>][<%=j%>] = "<%=result_Class[i][j]%>";
<%			
				}
			}
		}else {
%>
			<%=strArray%>
<%			
		}
%>
		var response = new AJAXPacket();
		response.data.add("errorCode","<%=qryClassCode%>");
		response.data.add("errorMsg","<%=qryClassMsg%>");
		response.data.add("id_no","<%=id_no%>");
		response.data.add("offerId","<%=offerId%>");
		response.data.add("retAry",retAry);
		core.ajax.receivePacket(response);	
<%
	}
%>

