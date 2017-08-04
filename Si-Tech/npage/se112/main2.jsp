<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%	

	//session中取值,供拼报文用
	String accountType =(String)session.getAttribute("accountType");//工号类型
	String region_id = (String)session.getAttribute("regCode");//区域
	String login_no = (String)session.getAttribute("workNo");//登录工号
	String login_name = (String)session.getAttribute("workName");
	String workGroupId = (String)session.getAttribute("workGroupId");//登录工号归属
	String powerRight= (String)session.getAttribute("powerRight");
	String password =(String)session.getAttribute("password");//登录密码
	String ip_address = (String)session.getAttribute("ipAddr");
	String remoteAddr=(String)session.getAttribute("remoteAddr");//远程地址
	String group_id = (String)session.getAttribute("groupId");
	String isAgent = (String) session.getAttribute("isAgent");//是否代办点
	String orgCode = (String)session.getAttribute("orgCode");
	String isPreengage=request.getParameter("isPreengage");
	String ip_addr=request.getRemoteAddr();
	System.out.println("-------------------region_id--------------------" + region_id);
	System.out.println("-------------------login_no--------------------" + login_no);
	System.out.println("-------------------login_name--------------------" + login_name);
	System.out.println("-------------------powerRight--------------------" + powerRight);
	System.out.println("-------------------password--------------------" + password);
	System.out.println("-------------------ip_address--------------------" + ip_address);
	System.out.println("-------------------remoteAddr--------------------" + remoteAddr);
	System.out.println("-------------------group_id--------------------" + group_id);
	System.out.println("-------------------orgCode--------------------" + orgCode);	
	System.out.println("-------------------ip_addr--------------------" + ip_addr);	
	System.out.println("-------------------isPreengage--------------------" + isPreengage);	
	
	String chanType=  request.getParameter("chanType"); //营业前台渠道类型（营销系统统一定义，置为0）
	String contactId  = request.getParameter("contactId")==null?"-1":request.getParameter("contactId");//接触ID
	String actId=  request.getParameter("actId"); //活动ID
	String brandId = request.getParameter("brandId");//品牌
	String innetMons = request.getParameter("innetMons");//客户入网月数
	String svcNum = request.getParameter("svcNum");//服务号码
	String custGrpId = request.getParameter("custGrpId");//用户群编码
	String custId = request.getParameter("custId");//客户ID
	String opCode = request.getParameter("opCode")==null?"g794": request.getParameter("opCode"); 
	String idNo = request.getParameter("idNo")==null?"0":request.getParameter("idNo"); //用户ID
	if(("".equals(idNo))||(null==idNo)||("N/A".equals(idNo))||("null".equalsIgnoreCase(idNo))){
		idNo ="0";
	}
	if("null".equals(opCode)||"".equals(opCode)||null==opCode||"N/A".equals(opCode)){
		opCode="g794";
	}
	String orderArrayId = request.getParameter("orderArrayId");//crm传过来的
	String custOrderId = request.getParameter("custOrderId");//crm传过来的
	String custOrderNo = request.getParameter("custOrderNo");//crm传过来的
	String servBusiId = request.getParameter("servBusiId");//crm传过来的
	String prtFlag = request.getParameter("prtFlag");//crm传过来的
	String opName = request.getParameter("opName");//crm传过来的
	String gCustId = request.getParameter("gCustId");
	/*gaopeng 2014/07/07 17:09:39 v_smCode 关于佳木斯分公司申请开通宽带零元初装费的请示 获取参数 v_smCode*/
	String v_smCode = request.getParameter("v_smCode");//smcode
	if(v_smCode == null || "null".equals(v_smCode)) v_smCode = "";
 	System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++v_smCode="+v_smCode);
	String userName = "";
	String totalOweFee = "0";
	String meansIdStr = "";//所有手段ID串，供初始化页面添加事件用
	String score = "0";//积分值
	String selectMeansId = request.getParameter("selectMeansId");
	String orderId = request.getParameter("orderID");//销售流水
	String gScore = request.getParameter("gScore");//渠道积分抵终端积分值
	String selectvalidMode = request.getParameter("selectvalidMode");//生效方式
	System.out.println("++++++++++++++++selectvalidMode+++++++++" + selectvalidMode);
	
	/*****************20100310添加**路由规则************/
	String routerKey = request.getParameter("routerKey")==null?"userno":request.getParameter("routerKey");
	String routerValue = request.getParameter("routerValue")==null?idNo:request.getParameter("routerValue");
	/*****************************************************/

	 System.out.println("------------------------main1-----------------------------");
	 System.out.println("++++++++++++++++actId+++++++++" + actId);
	 System.out.println("++++++++++++++++orderArrayId+++++++++" + orderArrayId);
	 System.out.println("++++++++++++++++custOrderId+++++++++" + custOrderId);
	
	 String netCode = request.getParameter("netCode"); //宽带开户号码
	 if(netCode == null || "null".equals(netCode)) netCode = "";
	 System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++netCode="+netCode);
 	 String oTrueCode = request.getParameter("oTrueCode"); //宽带开户号码
 	 System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++oTrueCode="+oTrueCode);
%>
<!-- 获得销售流水-->
<wtc:sequence name="sPubSelect" key="sMaxSysAccept"  routerKey="region" routerValue="<%=region_id%>" id="printAccept"/>
<!-- 需要提供客户信息的服务-->
<s:service name="sMKTGetUsrInf">
	<s:param name="ROOT">
		<s:param name="PHONE_NO" type="string" value="<%=svcNum%>" />
	</s:param>
</s:service>
<%
	Map UserInfoMap = null;

	if ("0".equals(retCode) && result != null) {
		com.sitech.crmpd.core.bean.MapBean mp = new com.sitech.crmpd.core.bean.MapBean();
		List actions = result.getList("OUT_DATA.USER_INFO");
		HashMap map = new HashMap();
		if (null != actions) {
			Iterator itr = actions.iterator();
			while (itr.hasNext()) {
				UserInfoMap = mp.isMap(itr.next());
			}
		}
	}
	String mode_code = "";//主资费code
	String cust_id = "";
	String cust_name = "";//客户名称
	String id_no = "";//id_no
	String belong_code = "";//用户归属
	String mode_name = "";//主资费名称
	String vCurPoint = "";//当前积分//WsGetMeansList
	String hasStoredValue = (String)session.getAttribute("mktRegionValue");
	String regionGroup = "";
	String regionCityId = "";
	String regionArea = "";
	String regionAreaId = "";
	String regionOperm = "";
	String regionOpermId = "";
%>
<s:service name="WsGetMeansList">
	<s:param name="ROOT">
		<s:param name="REQUEST_INFO">
			<s:param name="ID_NO" type="string" value="<%=idNo%>" />
			<s:param name="PHONE_NO" type="string" value="<%=svcNum%>" />
			<s:param name="REGION_CODE" type="string" value="<%=region_id%>" />
			<s:param name="ACT_ID" type="string" value="<%=actId%>" />
			<s:param name="CUST_GROUP_ID" type="string" value="<%=custGrpId%>" />
			<s:param name="BRAND_ID" type="string" value="<%=brandId%>" />
			<s:param name="GROUP_ID" type="string" value="<%=group_id%>" />
			<s:param name="MODE_CODE" type="string" value="<%=mode_code%>" />
			<s:param name="REGION_STORED" type="string" value="<%=hasStoredValue%>" />
			<s:param name="WORK_GROUP" type="string" value="<%=workGroupId%>" />
			<s:param name="SELECT_MEANS" type="string" value="<%=selectMeansId%>" />
		</s:param>
	</s:param>
</s:service>
<%
	//活动信息
	String actName = "";
	String actDate = "";
	String actDesc = "";
	String action_ID = "";
	String miantdIp = "";
	String act_type = "";
	String priFeeMoney = "";
	String busiType = "";	
	String isMessage = "";
	String updateNo = "";
	String isApprec = "";
	com.sitech.crmpd.core.bean.MapBean myResult = new com.sitech.crmpd.core.bean.MapBean();
	List meansList = new ArrayList();//手段列表
	List htmlList = new ArrayList();//营销方式详细信息
	Map custInfo = null;//客户信息
	Map feeInfo = null;//费用信息
	if ("0".equals(retCode)) {
		actName = (String) result.getValue("OUT_DATA.ACTION.ACTION_NAME");//服务返回的活动名称
		actDate = (String) result.getValue("OUT_DATA.ACTION.ACTION_DATE");//服务返回的活动期间
		actDesc = (String) result.getValue("OUT_DATA.ACTION.ACTION_DESC");//服务返回的获得描述
		action_ID = (String) result.getValue("OUT_DATA.ACTION.ACTION_ID");//服务返回的活动名称
		miantdIp = (String) result.getValue("OUT_DATA.ACTION.MIANTD_IP");//服务返回的获得描述
		act_type = (String) result.getValue("OUT_DATA.ACTION.ACT_TYPE");//服务返回的活动名称
		meansIdStr = (String) result.getValue("OUT_DATA.MEANSID_STR");//服务返回的活动名称
		priFeeMoney = (String) result.getValue("OUT_DATA.PRIFEE_MONEY");//服务返回的活动名称
		busiType = (String) result.getValue("OUT_DATA.ACTION.BUSI_TYPE");
		isMessage = (String) result.getValue("OUT_DATA.ACTION.IS_MESSAGE");//服务返回的获得是否发送短信提醒
		updateNo = (String) result.getValue("OUT_DATA.ACTION.UPDATE_NO");//服务返回的获得是否发送短信提醒
		isApprec = (String) result.getValue("OUT_DATA.ACTION.IS_APPREC");//服务返回的获得是否发送短信提醒
		if(!"T".equals(hasStoredValue)){
			hasStoredValue = "T";
			regionOperm = result.getString("OUT_DATA.REGION_INFO.OPERM_NAME");
			regionOpermId = result.getString("OUT_DATA.REGION_INFO.OPERM_ID");
			regionArea = result.getString("OUT_DATA.REGION_INFO.AREA_NAME");
			regionAreaId = result.getString("OUT_DATA.REGION_INFO.AREA_ID");
			regionGroup = result.getString("OUT_DATA.REGION_INFO.GROUP_NAME");
			regionCityId = result.getString("OUT_DATA.REGION_INFO.CITY_ID");
			if("N/A".equals(regionOperm))regionOperm="";
			if("N/A".equals(regionOpermId))regionOpermId="";
			if("N/A".equals(regionArea))regionArea="";
			if("N/A".equals(regionAreaId))regionAreaId="";
			if("N/A".equals(regionGroup))regionGroup="";
			if("N/A".equals(regionCityId))regionCityId="";
			session.setAttribute("mktRegionValue",hasStoredValue);
			session.setAttribute("mktRegionOperm",regionOperm);
			session.setAttribute("mktRegionOpermId",regionOpermId);
			session.setAttribute("mktRegionArea",regionArea);
			session.setAttribute("mktRegionAreaId",regionAreaId);
			session.setAttribute("mktRegionGroup",regionGroup);
			session.setAttribute("mktRegionCityId",regionCityId);
		}else{
			regionOperm = (String)session.getAttribute("mktRegionOperm");
			regionOpermId = (String)session.getAttribute("mktRegionOpermId");
			regionArea = (String)session.getAttribute("mktRegionArea");
			regionAreaId = (String)session.getAttribute("mktRegionAreaId");
			regionGroup = (String)session.getAttribute("mktRegionGroup");
			regionCityId = (String)session.getAttribute("mktRegionCityId");
		}
		System.out.println("regionOperm========================" + regionOperm);
		System.out.println("regionOpermId========================" + regionOpermId);
		System.out.println("regionArea========================" + regionArea);
		System.out.println("regionAreaId========================" + regionAreaId);
		System.out.println("regionGroup========================" + regionGroup);
		System.out.println("regionCityId========================" + regionCityId);
		System.out.println("actName========================" + actName);
		System.out.println("actDate========================" + actDate);
		System.out.println("actDesc========================" + actDesc);
		System.out.println("action_ID========================" + action_ID);
		System.out.println("miantdIp========================" + miantdIp);
		System.out.println("act_type========================" + act_type);
		System.out.println("meansIdStr========================" + meansIdStr);
		System.out.println("priFeeMoney========================" + priFeeMoney);
		System.out.println("busiType========================" + busiType);
		System.out.println("isMessage========================"+ isMessage);
		System.out.println("updateNo========================"+ updateNo);
		meansList = (List) result.getValue("OUT_DATA.MEANS.MEAN");//服务返回的手段结果集
		myResult = result;
		} else {
%>
	<script type="text/javascript">
		$(document).ready(function(){
				showDialog("营销系统查询营销档次WsGetMeansList接口正忙,请稍后再试",0);
		});
	</script>
<%
	return;
	}
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title></title>
	</head>
	<body id="openMain">
		<div id="operation">
			<form method=post name="frm4938" action="">
				<div id="operation_table">
					<%
						/* 营销活动信息*/
					%>
					<div class="title">
						<div class="text">
							营销活动信息
						</div>
						<div class="title_tu">
							<input type="button" class="butClose" id="picActMsg" value="" />
						</div>
					</div>
					<div class="input" id="titleActMsg">
						<table>
							<tr>
								<th>
									活动名称：
								</th>
								<td colspan="2">
									<%=actName%>
								</td>
								<th>
									活动时间：
								</th>
								<td colspan="2">
									<%=actDate%>
								</td>
							</tr>
							<tr>
								<th>
									活动描述：
								</th>
								<td colspan="5">
									<%=actDesc%>
								</td>
							</tr>
							<!--流水号 -->
							<%
								if(null!=orderId&&!"".equals(orderId)){
							%>
										<input type="hidden" name="login_accept" id="login_accept" value="<%=orderId %>">
							<%}else{%>
										<input type="hidden" name="login_accept" id="login_accept" value="<%=printAccept %>">
							<%}%>
							<input type="hidden" name="selectvalidMode" id="selectvalidMode" value="<%=selectvalidMode %>">
						</table>
					</div>
					<%
						if (null != custInfo)
							userName = SiUtil.repNull((String) custInfo.get("CUST_NAME"));
					%>

					<%@ include file="userMsg.jsp"%>
					<%@ include file="userCueMsg.jsp"%>
					<%@ include file="searchMeansInfo.jsp"%>
					<%@ include file="activeRule.jsp"%>
					<%@ include file="note.jsp"%>
					<div id="operation_button">
						<input type="button" class="b_foot" value="提交" id="btnSave"
							name="btnSave" onclick="submitAct()" disabled="disabled" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="javascript:closeSale();" />
					</div>
					<%@ include file="footer.jsp"%>
			</form>
		</div>
		<script type="text/javascript" src="/npage/se112/js/sitechJson.js"></script>
		<%@ include file="jsGlobal.jsp"%>
		<!--不同方式间切换控制js函数-->
		<%@ include file="jsMeansCtrl.jsp"%>
		<!--报文处理和生成的js函数-->
		<%@ include file="jsXML.jsp"%>
		<!--处理全网统一营销案的js函数-->
		<%@ include file="jsForGroupAct.jsp"%>
		<!--跳到统一缴费页面-->
		<%@ include file="public_title_name_p.jsp"%>
		<script type="text/javascript" src="/npage/se112/js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>
