<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%	

	//session��ȡֵ,��ƴ������
	String accountType =(String)session.getAttribute("accountType");//��������
	String region_id = (String)session.getAttribute("regCode");//����
	String login_no = (String)session.getAttribute("workNo");//��¼����
	String login_name = (String)session.getAttribute("workName");
	String workGroupId = (String)session.getAttribute("workGroupId");//��¼���Ź���
	String powerRight= (String)session.getAttribute("powerRight");
	String password =(String)session.getAttribute("password");//��¼����
	String ip_address = (String)session.getAttribute("ipAddr");
	String remoteAddr=(String)session.getAttribute("remoteAddr");//Զ�̵�ַ
	String group_id = (String)session.getAttribute("groupId");
	String isAgent = (String) session.getAttribute("isAgent");//�Ƿ�����
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
	
	String chanType=  request.getParameter("chanType"); //Ӫҵǰ̨�������ͣ�Ӫ��ϵͳͳһ���壬��Ϊ0��
	String contactId  = request.getParameter("contactId")==null?"-1":request.getParameter("contactId");//�Ӵ�ID
	String actId=  request.getParameter("actId"); //�ID
	String brandId = request.getParameter("brandId");//Ʒ��
	String innetMons = request.getParameter("innetMons");//�ͻ���������
	String svcNum = request.getParameter("svcNum");//�������
	String custGrpId = request.getParameter("custGrpId");//�û�Ⱥ����
	String custId = request.getParameter("custId");//�ͻ�ID
	String opCode = request.getParameter("opCode")==null?"g794": request.getParameter("opCode"); 
	String idNo = request.getParameter("idNo")==null?"0":request.getParameter("idNo"); //�û�ID
	if(("".equals(idNo))||(null==idNo)||("N/A".equals(idNo))||("null".equalsIgnoreCase(idNo))){
		idNo ="0";
	}
	if("null".equals(opCode)||"".equals(opCode)||null==opCode||"N/A".equals(opCode)){
		opCode="g794";
	}
	String orderArrayId = request.getParameter("orderArrayId");//crm��������
	String custOrderId = request.getParameter("custOrderId");//crm��������
	String custOrderNo = request.getParameter("custOrderNo");//crm��������
	String servBusiId = request.getParameter("servBusiId");//crm��������
	String prtFlag = request.getParameter("prtFlag");//crm��������
	String opName = request.getParameter("opName");//crm��������
	String gCustId = request.getParameter("gCustId");
	/*gaopeng 2014/07/07 17:09:39 v_smCode ���ڼ�ľ˹�ֹ�˾���뿪ͨ�����Ԫ��װ�ѵ���ʾ ��ȡ���� v_smCode*/
	String v_smCode = request.getParameter("v_smCode");//smcode
	if(v_smCode == null || "null".equals(v_smCode)) v_smCode = "";
 	System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++v_smCode="+v_smCode);
	String userName = "";
	String totalOweFee = "0";
	String meansIdStr = "";//�����ֶ�ID��������ʼ��ҳ������¼���
	String score = "0";//����ֵ
	String selectMeansId = request.getParameter("selectMeansId");
	String orderId = request.getParameter("orderID");//������ˮ
	String gScore = request.getParameter("gScore");//�������ֵ��ն˻���ֵ
	String selectvalidMode = request.getParameter("selectvalidMode");//��Ч��ʽ
	System.out.println("++++++++++++++++selectvalidMode+++++++++" + selectvalidMode);
	
	/*****************20100310���**·�ɹ���************/
	String routerKey = request.getParameter("routerKey")==null?"userno":request.getParameter("routerKey");
	String routerValue = request.getParameter("routerValue")==null?idNo:request.getParameter("routerValue");
	/*****************************************************/

	 System.out.println("------------------------main1-----------------------------");
	 System.out.println("++++++++++++++++actId+++++++++" + actId);
	 System.out.println("++++++++++++++++orderArrayId+++++++++" + orderArrayId);
	 System.out.println("++++++++++++++++custOrderId+++++++++" + custOrderId);
	
	 String netCode = request.getParameter("netCode"); //�����������
	 if(netCode == null || "null".equals(netCode)) netCode = "";
	 System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++netCode="+netCode);
 	 String oTrueCode = request.getParameter("oTrueCode"); //�����������
 	 System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++oTrueCode="+oTrueCode);
%>
<!-- ���������ˮ-->
<wtc:sequence name="sPubSelect" key="sMaxSysAccept"  routerKey="region" routerValue="<%=region_id%>" id="printAccept"/>
<!-- ��Ҫ�ṩ�ͻ���Ϣ�ķ���-->
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
	String mode_code = "";//���ʷ�code
	String cust_id = "";
	String cust_name = "";//�ͻ�����
	String id_no = "";//id_no
	String belong_code = "";//�û�����
	String mode_name = "";//���ʷ�����
	String vCurPoint = "";//��ǰ����//WsGetMeansList
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
	//���Ϣ
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
	List meansList = new ArrayList();//�ֶ��б�
	List htmlList = new ArrayList();//Ӫ����ʽ��ϸ��Ϣ
	Map custInfo = null;//�ͻ���Ϣ
	Map feeInfo = null;//������Ϣ
	if ("0".equals(retCode)) {
		actName = (String) result.getValue("OUT_DATA.ACTION.ACTION_NAME");//���񷵻صĻ����
		actDate = (String) result.getValue("OUT_DATA.ACTION.ACTION_DATE");//���񷵻صĻ�ڼ�
		actDesc = (String) result.getValue("OUT_DATA.ACTION.ACTION_DESC");//���񷵻صĻ������
		action_ID = (String) result.getValue("OUT_DATA.ACTION.ACTION_ID");//���񷵻صĻ����
		miantdIp = (String) result.getValue("OUT_DATA.ACTION.MIANTD_IP");//���񷵻صĻ������
		act_type = (String) result.getValue("OUT_DATA.ACTION.ACT_TYPE");//���񷵻صĻ����
		meansIdStr = (String) result.getValue("OUT_DATA.MEANSID_STR");//���񷵻صĻ����
		priFeeMoney = (String) result.getValue("OUT_DATA.PRIFEE_MONEY");//���񷵻صĻ����
		busiType = (String) result.getValue("OUT_DATA.ACTION.BUSI_TYPE");
		isMessage = (String) result.getValue("OUT_DATA.ACTION.IS_MESSAGE");//���񷵻صĻ���Ƿ��Ͷ�������
		updateNo = (String) result.getValue("OUT_DATA.ACTION.UPDATE_NO");//���񷵻صĻ���Ƿ��Ͷ�������
		isApprec = (String) result.getValue("OUT_DATA.ACTION.IS_APPREC");//���񷵻صĻ���Ƿ��Ͷ�������
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
		meansList = (List) result.getValue("OUT_DATA.MEANS.MEAN");//���񷵻ص��ֶν����
		myResult = result;
		} else {
%>
	<script type="text/javascript">
		$(document).ready(function(){
				showDialog("Ӫ��ϵͳ��ѯӪ������WsGetMeansList�ӿ���æ,���Ժ�����",0);
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
						/* Ӫ�����Ϣ*/
					%>
					<div class="title">
						<div class="text">
							Ӫ�����Ϣ
						</div>
						<div class="title_tu">
							<input type="button" class="butClose" id="picActMsg" value="" />
						</div>
					</div>
					<div class="input" id="titleActMsg">
						<table>
							<tr>
								<th>
									����ƣ�
								</th>
								<td colspan="2">
									<%=actName%>
								</td>
								<th>
									�ʱ�䣺
								</th>
								<td colspan="2">
									<%=actDate%>
								</td>
							</tr>
							<tr>
								<th>
									�������
								</th>
								<td colspan="5">
									<%=actDesc%>
								</td>
							</tr>
							<!--��ˮ�� -->
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
						<input type="button" class="b_foot" value="�ύ" id="btnSave"
							name="btnSave" onclick="submitAct()" disabled="disabled" />
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="javascript:closeSale();" />
					</div>
					<%@ include file="footer.jsp"%>
			</form>
		</div>
		<script type="text/javascript" src="/npage/se112/js/sitechJson.js"></script>
		<%@ include file="jsGlobal.jsp"%>
		<!--��ͬ��ʽ���л�����js����-->
		<%@ include file="jsMeansCtrl.jsp"%>
		<!--���Ĵ�������ɵ�js����-->
		<%@ include file="jsXML.jsp"%>
		<!--����ȫ��ͳһӪ������js����-->
		<%@ include file="jsForGroupAct.jsp"%>
		<!--����ͳһ�ɷ�ҳ��-->
		<%@ include file="public_title_name_p.jsp"%>
		<script type="text/javascript" src="/npage/se112/js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>
