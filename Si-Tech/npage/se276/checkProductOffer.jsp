
<%
/********************
 * version v2.0
 * liangyl 2015/02/11 9:50:29 关于哈尔滨分公司申请批量更正客户信息以及进行系统优化的请示
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String offer_id = request.getParameter("offer_id");
		
		String  inParamsMigu [] = new String[2];
	    inParamsMigu[0] = "select count(1) from product_offer_scene t where t.op_code = '4977' and t.offer_id =:offer_id and t.op_type = '1'";
	    inParamsMigu[1] = "offer_id="+offer_id;
		String retCode11 = "";
		String retMsg11 = "";
		String miguFlag = "N";
		
try{		
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inParamsMigu[0]%>" />
			<wtc:param value="<%=inParamsMigu[1]%>" />
		</wtc:service>
		<wtc:array id="result_migu" scope="end" />
		var infoArray = new Array();

<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			if(result_migu.length>0){
        if(Integer.parseInt(result_migu[0][0]) > 0){
        	miguFlag = "Y";
        }else{
        	miguFlag = "N";
        }
      }
			
		}else{
			miguFlag = "N";
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			%>
var infoArray = new Array();
<%
		}
%>
var response = new AJAXPacket(); response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("miguFlag","<%=miguFlag %>");
core.ajax.receivePacket(response);
