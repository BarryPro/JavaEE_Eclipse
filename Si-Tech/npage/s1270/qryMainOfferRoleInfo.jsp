<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"));
		String filFlag = WtcUtil.repNull(request.getParameter("filFlag"));
		String offer_id = WtcUtil.repNull(request.getParameter("dgMoffer"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String smCode = WtcUtil.repNull(request.getParameter("smCode"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password"); 
		String regionCode = (String)session.getAttribute("regCode");
		String accountType = (String)session.getAttribute("accountType"); //1 为营业工号 2 为客服工号
		String strArray="var retAry;";  
		String[][] resPosc = new String[][]{};
		String retCode = "111111";
		String retMsg = "查询可选资费失败";
		if("null".equals(offer_id)){
			offer_id = "";
		}
		String sqlStr="select a.offer_attr_type, a.name from offer_CateGory a , PRODUCT_OFFER_SCENE_CFG b where  instr(b.role_limit, a.offer_attr_type) > 0  and    b.op_code ='"+opCode+"' and exists (select 1 from product_offer_detail c,product_offer d where   c.ELEMENT_TYPE='10C' and c.ELEMENT_ID = d.offer_id and a.offer_attr_type = d.offer_attr_type and c.offer_id ='"+offer_id+"') union select a.offer_attr_type, a.name from offer_CateGory a,product_offer c where substr(c.user_range,2,1) = '2' and a.offer_attr_type = c.offer_attr_type ";
		
		if("e092".equals(opCode) || "m365".equals(opCode)){
				   //sqlStr="select a.offer_attr_type, a.name  from offer_CateGory a, PRODUCT_OFFER_SCENE_CFG b where instr(b.role_limit, a.offer_attr_type) > 0   and    b.op_code = 'e092'      and exists (select 1 from product_offer_detail c,product_offer d where   c.ELEMENT_TYPE='10C' and c.ELEMENT_ID = d.offer_id and a.offer_attr_type = d.offer_attr_type    and c.offer_id ='"+offer_id+"')  ";
				   sqlStr=" select 'YnKI','集团宽带打折资费'  from dual";
		}
		System.out.println("msde=="+sqlStr);
	
		if("1272".equals(opCode) || "1270".equals(opCode)){ /* update for 关于优化客服CRM系统功能七月份第六次需求的函@2014/9/15 */
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
			<wtc:service name="sOfferTypeQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
				<wtc:param value="<%=printAccept%>"/>
				<wtc:param value="01"/>	
				<wtc:param value="1272"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=smCode%>"/>
				<wtc:param value="<%=accountType%>"/>
				<wtc:param value="<%=offer_id%>"/>
			</wtc:service>	
			<wtc:array id="resultList"  scope="end"/>
<%	
			resPosc = resultList;
			retCode = retCode1;
			retMsg = retMsg1;
		}else{
%>
			<wtc:service name="sPubSelect"  retCode="retCode1"  retMsg="retMsg1" outnum="2" >
				<wtc:param value="<%=sqlStr%>"/>
			</wtc:service>
			<wtc:array id="resultList" scope="end"/>
<%
			resPosc = resultList;
			retCode = retCode1;
			retMsg = retMsg1;
		}

	if(retCode.equals("000000")){
	  int retValNum=resPosc.length;
	  System.out.println("@@@@sPubSelect===="+retValNum);	
	  strArray = WtcUtil.createArray("retAry",retValNum);
%>
		<%=strArray%>
<%	  
		for(int i=0;i<retValNum;i++){
			for(int j=0;j<2;j++){
%>
			retAry[<%=i%>][<%=j%>] = "<%=resPosc[i][j]%>";
<%			
			}
		}
	}else{
%>
		<%=strArray%>
<%		
	}
%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("retAry",retAry);
core.ajax.receivePacket(response);