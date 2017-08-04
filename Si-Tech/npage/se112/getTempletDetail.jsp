<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@ page import="java.util.*"%>
<%

	String TEMPLET_ID = (String)request.getParameter("TEMPLET_ID");
	String REGIN_CODE = (String)request.getParameter("REGIN_CODE");
	String QUERY_TYPE = (String)request.getParameter("QUERY_TYPE");
	String CONSUME_TIME = (String)request.getParameter("CONSUME_TIME");
	String TM_CONTENT_ID = (String)request.getParameter("TM_CONTENT_ID");
	String TEMPLET_TYPE = (String)request.getParameter("TEMPLET_TYPE");
	String selectMeansId = (String)request.getParameter("selectMeansId");
	String orderId = (String)request.getParameter("orderId");
	String loginNo   = (String)session.getAttribute("workNo");//登录工号
	String password   = (String)session.getAttribute("password");//登录密码
	
	//add zhangxy 20161222
	String ASSIFEE_CODE = (String)request.getParameter("ASSIFEE_CODE");
	ASSIFEE_CODE=(ASSIFEE_CODE==null?"":ASSIFEE_CODE);
	String PHONE_NO = (String)request.getParameter("PHONE_NO");
	PHONE_NO=(PHONE_NO==null?"":PHONE_NO);
	String ACT_ID = (String)request.getParameter("ACT_ID");
	ACT_ID=(ACT_ID==null?"":ACT_ID);
	
	System.out.println("zhangxy 20161222 getTempletDetail.jsp:"+TEMPLET_ID+
			"--REGIN_CODE:"+REGIN_CODE+"====QUERY_TYPE:"+QUERY_TYPE+"-----CONSUME_TIME:"+
			CONSUME_TIME+"======TM_CONTENT_ID:"+TM_CONTENT_ID+
			" ASSIFEE_CODE:"+ASSIFEE_CODE+" PHONE_NO:"+PHONE_NO);
	
		//iUnitStr == 6
 %>
	<s:service name="WsGetTempletDetailService">
		<s:param name="ROOT"> 
			<s:param name="REQUEST_INFO">
				<s:param name="TEMPLET_ID" type="string" value="<%=TEMPLET_ID%>" />
				<s:param name="REGIN_CODE" type="string" value="<%=REGIN_CODE%>" />
				<s:param name="CONSUME_TIME" type="string" value="<%=CONSUME_TIME%>" />
				<s:param name="TM_CONTENT_ID" type="string" value="<%=TM_CONTENT_ID%>" />
				<s:param name="QUERY_TYPE" type="string" value="<%=QUERY_TYPE%>" />
				<s:param name="selectMeansId" type="string" value="<%=selectMeansId%>" />
				<s:param name="orderId" type="string" value="<%=orderId%>" />
				<s:param name="ASSIFEE_CODE" type="string" value="<%=ASSIFEE_CODE%>" />
				<s:param name="PHONE_NO" type="string" value="<%=PHONE_NO%>" />
				<s:param name="ACT_ID" type="string" value="<%=ACT_ID%>" />
				<s:param name="TEMPLET_TYPE" type="string" value="<%=TEMPLET_TYPE%>" />
				<s:param name="loginNo" type="string" value="<%=loginNo%>" />
				<s:param name="password" type="string" value="<%=password%>" />
			</s:param>		
		</s:param>
	</s:service>
<%	
	StringBuffer html = new StringBuffer();
	String meansjsonstr = "";
	String flag = "";
	String specialfunds = "";
	String systempay = "";
	String ssfeeinfo = "";
	String assifeeinfo = "";
	String scoreinfo = "";
	String spInfo = "";
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	String queryType = (String) result.getValue("OUT_DATA.REQUEST_INFO.QUERY_TYPE");
	if(!"3".equals(queryType)){
		List optionList = result.getList("OUT_DATA.REQUEST_INFO.OPTIONS_LIST.OPTION_INFO");
		if ("0".equals(RETURN_CODE)) {
			if(!"N/A".equals(optionList.get(0))){
				html.append("<option value='0'>--请选择--</option>");
				for(int i=0; i<optionList.size(); i++){
					Map optionInfo = MapBean.isMap(optionList.get(i));
					String name = optionInfo.get("NAME").toString();
					String value = optionInfo.get("VALUE").toString();
					html.append("<option value='").append(value).append("'>").append(name).append("</option>");
				}
			}
		}
	}else{
	   meansjsonstr = (String) result.getValue("OUT_DATA.REQUEST_INFO.MEANS.MEAN.MEANSJSONSTR");
	   flag = (String) result.getValue("OUT_DATA.REQUEST_INFO.MEANS.MEAN.FLAG");
	   specialfunds = (String) result.getValue("OUT_DATA.REQUEST_INFO.MEANS.MEAN.SPECIALFUNDS");
	   systempay = (String) result.getValue("OUT_DATA.REQUEST_INFO.MEANS.MEAN.SYSTEMPAY");
	   ssfeeinfo = (String) result.getValue("OUT_DATA.REQUEST_INFO.MEANS.MEAN.SSFEEINFO");
	   assifeeinfo = (String) result.getValue("OUT_DATA.REQUEST_INFO.MEANS.MEAN.ASSIFEEINFO");
	   scoreinfo = (String) result.getValue("OUT_DATA.REQUEST_INFO.MEANS.MEAN.SCOREINFO");
	   //add zhagnxy20170505 for 关于终端类营销活动承载数据业务及优化营销管理平台BOSS侧配置选项的函
	   spInfo = (String) result.getValue("OUT_DATA.REQUEST_INFO.MEANS.MEAN.SPINFO");

	}

%>			
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("html","<%=html%>");
	response.data.add("meansjsonstr","<%=meansjsonstr%>");
	response.data.add("flag","<%=flag%>");
	response.data.add("specialfunds","<%=specialfunds%>");
	response.data.add("systempay","<%=systempay%>");
	response.data.add("ssfeeinfo","<%=ssfeeinfo%>");
	response.data.add("assifeeinfo","<%=assifeeinfo%>");
	response.data.add("scoreinfo","<%=scoreinfo%>");
	//add zhagnxy20170505 for 关于终端类营销活动承载数据业务及优化营销管理平台BOSS侧配置选项的函
	response.data.add("spInfo","<%=spInfo%>");
	
	core.ajax.receivePacket(response);
