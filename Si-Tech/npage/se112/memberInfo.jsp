<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%	
	int totalMoney = 0;
	String reginCode = (String) session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");
	String password =(String)session.getAttribute("password");
	String actType = request.getParameter("actType");
	String svcNum = request.getParameter("svcNum");
	String orderId = request.getParameter("orderId");
	String meansId = request.getParameter("meansId");
	String netCode = request.getParameter("netCode");
	String memNo = request.getParameter("memNo");
	String memFee = request.getParameter("memFee");
	String memAddFee = request.getParameter("memAddFee");
	String memFund = request.getParameter("memFund");
	String memSysFee = request.getParameter("memSysFee");
	String familyLowType = request.getParameter("familyLowType");
	String netScoreMoney = request.getParameter("netScoreMoney");
	String spNetFlag = request.getParameter("spNetFlag");
	
	System.out.println("netCode========================="+netCode);
	System.out.println("memNo=========================\n"+memNo);
	System.out.println("memFee=========================\n"+memFee);
	System.out.println("memAddFee=========================\n"+memAddFee);
	System.out.println("memFund=========================\n"+memFund);
	System.out.println("memSysFee=========================\n"+memSysFee);
	System.out.println("familyLowType=========================\n"+familyLowType);
	System.out.println("netScoreMoney=========================\n"+netScoreMoney);
	System.out.println("spNetFlag=========================\n"+spNetFlag);
	
	/**
	   getMemberData.jsp��sQryBroadInfoWS_XML �������Σ�oper_type,Ĭ��Ϊ0�������ħ�ٺ�SPҵ����oper_type=2
	*/
	
	String operType = "0";
	if("Y".equals(spNetFlag) && "16".equals(actType)){
		operType = "2";
	}else if("Y".equals(spNetFlag) && "19".equals(actType)){
		operType = "4";
	}
	System.out.println("operType=========================\n"+operType);

	String xml = memNo + memFee + memAddFee + memFund + memSysFee+familyLowType;
	MapBean mb = new MapBean();	
%>
<%@ include file="getMapBean.jsp"%>
<%
//modify 2014-3-13 19:12:58 start
	String lowType = "";
	String lowFee = "";
	String lowTypec = "";
	List lowTypeList =  mb.getList("OUT_DATA.H47");
	if(lowTypeList != null && lowTypeList.size() >0){
		lowType = mb.getString("OUT_DATA.H47.LOW_TYPE");//
		if("0".equals(lowType)){
			lowTypec="��Ա�ϼƵ�����ʽ";
		}else if("1".equals(lowType)){
			lowTypec="���ҳ����õ���";
		}
		lowFee = mb.getString("OUT_DATA.H47.LOW_FEE");//
	}
	
//modify 2014-3-13 19:12:58 end	
	List memMapList = mb.getList("OUT_DATA.H15.MEMBER_LIST.MEMBER_INFO");
	List fundMapList = mb.getList("OUT_DATA.H18.FUND_LIST.FUND_INFO");
	if("N/A".equals(fundMapList.get(0)))fundMapList = new ArrayList();
	List sysPayMapList = mb.getList("OUT_DATA.H19.SYSPAY_LIST.SYSPAY_INFO");
	if("N/A".equals(sysPayMapList.get(0)))sysPayMapList = new ArrayList();
	List memList = new ArrayList();
	List freeMemList = new ArrayList();
	System.out.println("memMapList size=========================="+memMapList.size());
	for(int i=0; i<memMapList.size(); i++){
		System.out.println("i=========================="+i);
		Map memMap = (Map)memMapList.get(i);
		String memberType = (String)memMap.get("MEMBER_TYPE");
		String memberNumType = (String)memMap.get("MEMBER_NUM_TYPE");
		String payValue = (String)memMap.get("PAY_VALUE");
		String sysPayValue = (String)memMap.get("SYSPAY_VALUE");
		String memberTypeStr = "";
		int iPayValue = Integer.parseInt(payValue);
		totalMoney += iPayValue;
		if("P".equals(memberType)){
			memberTypeStr = "�ֻ���Ա";
		}
		if("T".equals(memberType)){
			memberTypeStr = "TD�̻���Ա";
		}
		if("B".equals(memberType)){
			memberTypeStr = "�����Ա";
		}
		System.out.println("|||||||||||||||||||||||||||||||||||MEMBER_TYPE="+memberType+"|||MEMBER_NUM_TYPE"+memberNumType);
		if("1".equals(memberNumType)){
			memList.add(new String[]{memberType, payValue, sysPayValue, memberTypeStr});
		}
		//���� ��Ա�������� ���̶�����ʽ��
		if("0".equals(memberNumType) || "2".equals(memberNumType)  ){
			freeMemList.add(new String[]{memberType, memberTypeStr,memberNumType});
		}
	}
	//��Աר��
	String fundFree = "0";
	if(fundMapList.size() > 0){
		Map fundValue = (Map)fundMapList.get(0);
		fundFree = (String)fundValue.get("FUNDS_FREE");
		int iPayValue = Integer.parseInt(fundFree);
		totalMoney += iPayValue;
	}
	//��Աϵͳ��ֵ
	String sysPayFree = "0";
	if(sysPayMapList.size() > 0){
		Map sysPayValue = (Map)sysPayMapList.get(0);
		sysPayFree = (String)sysPayValue.get("SYS_FREE");
	}
%>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation"><div id="operation_table">
			<div class="title">
				<div class = "text" onclick = "showMemberList('fixed')">
					�̶���Ա�б�
				</div>
			</div>
			<div class="input" id="member_list_fixed">
				<table id='table_member'>
					<tr>
						<th>����״̬</th>
						<th>��Ա����</th>
						<th>ר����</th>
						<th>ϵͳ��ֵ���</th>
						<th>����</th>
					</tr>
					<%
					for(int i=0; i<memList.size(); i++){ 
						String[] member = (String[])memList.get(i);%>
						<tr id="tr_member_<%=i%>">
							<td id="td_member_statue_<%=i %>">δ����</td>
							<td><%=member[3] %></td>
							<td><%=member[1] %></td>
							<td><%=member[2] %></td>
							<td>
								<input type="button" class="b_text" id="b_member_choose_<%=i %>" value="����" 
									onclick="addMember('<%=i %>','<%=member[0]%>', '<%=member[1]%>', '<%=member[2]%>')"/>
								<input type="button" style="display : none" class="b_text" id="b_member_reset_<%=i %>" value="����" onclick="resetMember('<%=i%>')"/>
								<input type="hidden" name="member_value" id="hid_member_value_<%=i %>" />
								<input type="hidden" name="member_print" id="hid_member_print_<%=i %>" />
								<input type="hidden" id="member_fund_value_<%=i %>" value="<%=member[1]%>"/>
								<input type="hidden" id="member_sysPay_value_<%=i %>" value="<%=member[2]%>"/>
							</td>
						</tr>
					<%} %>
				</table>
			</div>
			<div class="title">
				<div class = "text" onclick = "showMemberList('free')">
					���ɷ����Ա�б�
				</div>
			</div>
			<div class="input" id="member_list_free" style="display : none">
				<table id='table_free_info'>
					<tr><th>�ɷ���ר��</th><th>�Ѿ�����ר��</th><th>�ɷ���ϵͳ��ֵ</th><th>�ѷ���ϵͳ��ֵ</th></tr>
					<tr><td><%=fundFree %></td><td id="used_fund">0</td><td><%=sysPayFree %></td><td id="used_sysPay">0</td></tr>
					<tr><th colspan='3'>��Ա����</th><th>����</th></tr>
					<%
					for(int i=0; i<freeMemList.size(); i++) {
						String[] member = (String[])freeMemList.get(i);%>
						<tr><td colspan='3'><%=member[1] %></td>
						<td><input value="����" type="button" class="b_text" onclick="addFreeMember('<%=member[0]%>','<%=member[2]%>')"></td></tr>
					<%} %>
				</table>
				<table id='table_free_member'>
					<tr><th>��Ա����</th><th>��Ա����</th><th>ר����</th><th>ϵͳ��ֵ���</th><th>����</th></tr>
				</table>
			</div>
		</div></div>
		<div id="order_info" style="display:none">
		<div id="operation_table">
			<div class="title">
				<div class = "text">
					��Ա������Ϣ
				</div>
			</div>
			<div class="input" id="order_html">
			</div>
		</div>
		</div>
	<%if (!"".equals(lowTypec) && !"".equals(lowType) ){ %>
		<div id="operation_table">
			<div class="title">
				<div class = "text">
					��ͥ������Ϣ
				</div>
			</div>
			<div class="input" id="lowTypediv">
				<th>�������ͣ�  <%=lowTypec %></th>  
				<th>������  <%=lowFee %>  </th>  
			</div>
		</div>
	<%} %>
		<div id="operation_button">
			<input type="button" class="b_foot" value="ȷ��" id="btnSubmit"
							name="btnSubmit" onclick="submitAll()" />
			<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
		</div>
	</body>
	<script type="text/javascript">
		var gFreeId = 100;//���ɷ����ԱID
		
		//--------------------------ѡ���иı䱳��ɫ-------------------------------------
		function chooseTr(memberNo){
			var trs = $("#table_member tr");
			for(var i=1; i<trs.size(); i++){
				var trId = $(trs[i]).attr("id");
				if("tr_member_"+memberNo == trId){
					$(trs[i]).css({background : "#20cccc"});
				}else{
					$(trs[i]).css({background : "#ffffff"});
				}
			}
		}
		//--------------------------������Ա-------------------------------------
		function addMember(memberNo, type, funds, sysPay){
			$("#order_html").html("");
			chooseTr(memberNo);
			var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se112/memberOrderInfo.jsp","���Ժ�...");
			packet.data.add("memberNo",memberNo);
			packet.data.add("xml","<%=xml %>");
			packet.data.add("type", type);
			packet.data.add("funds", funds);
			packet.data.add("sysPay", sysPay);
			packet.data.add("netCode", "<%=netCode %>");
			core.ajax.sendPacketHtml(packet,renderOrderInfo,true);
			packet = null;
		}
		function addFreeMember(type,memberNumType){
			var usedFund = $("#used_fund").text();
			var usedSysPay = $("#used_sysPay").text();
			if(usedFund == "<%=fundFree%>" && usedSysPay == "<%=sysPayFree%>"){
				showDialog("�Ѿ�û�пɹ������ר���ϵͳ��ֵ���",1);
				return;
			}
			addMember("-1", type, "", "");
		}
		function renderOrderInfo(renderHtml){
			$("#order_info").css("display","block");
			$("#order_html").html(renderHtml);
			//��ͥ�ദ���߼� ��������ר���ϵͳ��ֵ��ѡ��
			limitFamilyMoney();
		}
		
		function limitFamilyMoney(){
			var hid_coefficientSys = $("#hid_coefficientSys").val();
			var hid_CoefficientFun = $("#hid_CoefficientFun").val();
			if(hid_CoefficientFun){
				$("#fund_value_0").attr("readonly","readonly");
				$("#fund_value_1").attr("readonly","readonly");
			}
			if(hid_coefficientSys){
				$("#sysPay_value_0").attr("readonly","readonly");
				$("#sysPay_value_1").attr("readonly","readonly");
			}
		}
		
		function familyMoneyfund(){
			//��ͥר�����
			var fund_value = $("#fund_value").val();
			if(!isInt(fund_value)){
				alert("�ܶ��������������");
				$("#fund_value").val("");
				return;
			}
			if(fund_value%60!=0){
				showDialog("ר�������Ϊ60�ı��������޸ģ�",1);
				$("#fund_value").val("");
				return;
			}
			var hid_CoefficientFun = $("#hid_CoefficientFun").val();
			if(hid_CoefficientFun == '1' || hid_CoefficientFun == '2' || hid_CoefficientFun == '3'){
			//����Ԥ��=����Ԥ���/60����ȡ��-�Ԥ�����ϵ����*60����������ʽ������ĵ���Ԥ��Ϊ��ֵ�������Ԥ��ֱ�ӱ�Ϊ0��
				var fund_value_1 = "0";
				if(Math.floor(fund_value/60) > hid_CoefficientFun){
					fund_value_1 =  (Math.floor(fund_value/60)-hid_CoefficientFun)*60;//����
				}
				var fund_value_0 = fund_value - fund_value_1;//�
				$("#fund_value_0").val(fund_value_0);
				$("#fund_value_1").val(fund_value_1);
			}else{
				$("#fund_value").val("");
				alert("����ô�������ϵ�������Ա");
			}
		}
		function familyMoneySysPay(){
			//��ͥϵͳ��ֵ����
			var sysPay_value = $("#sysPay_value").val();
			if(!isInt(sysPay_value)){
				alert("�ܶ��������������");
				$("#fund_value").val("");
				return;
			}
			if(sysPay_value%60!=0){
				showDialog("ר�������Ϊ60�ı��������޸ģ�",1);
				$("#sysPay_value").val("");
				return;
			}
			var hid_coefficientSys = $("#hid_coefficientSys").val();
			
			if(hid_coefficientSys =='1' || hid_coefficientSys == '2' || hid_coefficientSys == '3'){
				familyTypePhone = true ;
			//����Ԥ��=����Ԥ���/60����ȡ��-�Ԥ�����ϵ����*60����������ʽ������ĵ���Ԥ��Ϊ��ֵ�������Ԥ��ֱ�ӱ�Ϊ0��
				var sysPay_value_1 = "0";
				if(Math.floor(sysPay_value/60) > hid_coefficientSys){
					sysPay_value_1 = (Math.floor(sysPay_value/60)-hid_coefficientSys)*60;//����
				}
				var sysPay_value_0 = sysPay_value - sysPay_value_1;//�
				$("#sysPay_value_0").val(sysPay_value_0);
				$("#sysPay_value_1").val(sysPay_value_1);
			}else{
				$("#sysPay_value").val("");
				alert("����ô�������ϵ�������Ա");
			}
			
		}
		
		//--------------------------������Ա END-------------------------------------
		//--------------------------��Ա����-------------------------------------
		/**�����Աȫ�ֱ����� 20130726 sunzj	
		 *��Ϊ�ʷ�Ҫ�����첽������ֻ�е������첽����ȫ������֮��ſ��Լ�������
		 *���ʹ��ȫ�ֱ�������ȫ�������ݣ���������ʧ֮�󱣴�����Ա��Ϣ
		 *ÿ�����"����"ʱ��ʼ������ȫ�ֱ���
		*/
		//������Ϣ������
		var gFreeFlag = "";
		var gMemNo = "";
		var gMemberId = "";//�ֻ���
		var gPassword = "";
		var gIdNo = "";
		var gCustId = "";
		var gGroupId = "";
		var gSmCode = "";
		var gModeCode = "";//��ǰ���ʷ�
		var gMemType = "";//��Ա����
		var gPrintInfo = "";//��ӡ��Ϣ
		
		//������������
		var gMainPass = false;
		var gMemFee = "";//���ʷ� 
		var gMemFeeValid = "";//���ʷ���Ч��ʽ
		var gPreNetFlag = "";//��ǩ����ʷ�ת������ 5����ת���� 4����ת����
		var gMemAddFee = "";//�����ʷ�
		//--�����ʷ���Чʱ��������
		var gMemberIdStr = "";
		var gAddFeeOperType = "";
		var gAddFeeDateType = "";
		var gAddFeeOfferType = "";
		var gAddFeeUnit = "";
		var gAddFeeOffset = "";
		var gMemFund = "";//ר��
		var gMemFundVal = "";//ר����
		var gMemSysPay = "";//ϵͳ��ֵ
		var gMemSysPayVal = "";//ϵͳ��ֵ���
		var gNetCode = "";//����˺�
		//-���ʷѸ�����ѡ�ʷ�
		var gFeeExtCode = "";//��ѡ�ײͱ���
		var gFeeExtName = "";//��ѡ�ײ�����
		var gFeeExtStatus = "";//��ѡ�ײ�״̬
		var gFeeExtFlag = "";//��ѡ�ײ���Ч��ʾ
		var gFeeExtInst = "";//��ѡ�ײ�ʵ��(ȡ���� ����0)
		var gFeeExtStart = "";//��ѡ�ʷѿ�ʼʱ��
		var gFeeExtEnd = "";//��ѡ�ʷѽ���ʱ��
		//���ʷѲ�����
		var gPriFeePass = false;
		var gPriFeeStartTime = "";
		var gPriFeeEndTime = "";
		//���ʷѱذ󸽼��ʷ�
		var gFeeExtPass = false;
		//�����ʷѲ�����
		var gAddFeePass = false;
		var gAddFeeStartTime = "";
		var gAddFeeEndTime = "";
		//��ͥ��ר���ϵͳ��ֵ
		var familyTypefund = "";
		var familyTypeSysPay = "";
		
		var gNetSmCode = "";
		var gNetFlag = "";
		
		//���ó�Ա��Ϣ
		function resetMemberData(){
			gFreeFlag = "";
			gMemNo = "";
			gMemberId = "";
			gPassword = "";
			gIdNo = "";
			gCustId = "";
			gGroupId = "";
			gSmCode = "";
			gMemType = "";
			gModeCode = "";
			gPrintInfo = "";
			gFeeExtPass = false;
			resetCheckGParams();
		}
		//����ȫ�ֱ���
		function resetCheckGParams(){
			gMainPass = false;
			gMemFee = "";
			gMemFeeValid = "";
			gPreNetFlag = "";
			gMemAddFee = "";
			gMemberIdStr = "";
			gAddFeeOperType = "";
			gAddFeeDateType = "";
			gAddFeeOfferType = "";
			gAddFeeUnit = "";
			gAddFeeOffset = "";
			gMemFund = "";
			gMemFundVal = "";
			gMemSysPay = "";
			gMemSysPayVal = "";
			gFeeExtCode = "";
			gFeeExtName = "";
			gFeeExtStatus = "";
			gFeeExtFlag = "";
			gFeeExtInst = "";
			gFeeExtStart = "";
			gFeeExtEnd = "";
			
			gPriFeePass = false;
			gPriFeeStartTime = "";
			gPriFeeEndTime = "";
			
			gAddFeePass = false;
			gAddFeeStartTime = "";
			gAddFeeEndTime = "";
			familyTypefund = "";
			familyTypeSysPay = "";
		}
		//--------------------------��������-------------------------------------
		//��ǩ���У�����
		function sendNetPreAjax(){
			var sPacket = new AJAXPacket("memberCheckPreNet.jsp","���Ժ�......");
			sPacket.data.add("svcNum","<%=svcNum%>");
			sPacket.data.add("netCode",gNetCode);
			sPacket.data.add("actType","<%=actType%>");
			sPacket.data.add("netFee", gMemFee);
			sPacket.data.add("netScoreMoney", "<%=netScoreMoney%>");
			core.ajax.sendPacket(sPacket,checkNetPre);
			sPacket = null;
		}
		//���ͻ�ȡ�ʷ���Чʱ������
		function sendPriFeeAjax(){
			var sPacket = new AJAXPacket("getEffectTime.jsp","���Ժ�......");
			sPacket.data.add("iChnSource","<%=reginCode%>");
			sPacket.data.add("iLoginNo","<%=loginNo%>");
			sPacket.data.add("iLoginPWD","<%=password%>");
			sPacket.data.add("iPhoneNo",gMemberId);
			sPacket.data.add("iOprAccept","<%=orderId%>");
			sPacket.data.add("iPhoneNoStr",gMemberId);
			sPacket.data.add("iOfferIdStr",gMemFee);
			sPacket.data.add("iOprTypeStr","1");
			if(gMemFeeValid == "5"){//��ǩ��,������Ч��ʽ���ʷѵ����þ���		
				sPacket.data.add("iDateTypeStr","x");		
			}else{
				sPacket.data.add("iDateTypeStr",gMemFeeValid);	
			}
			sPacket.data.add("iOfferTypeStr","0");
			sPacket.data.add("iOffsetStr","x");
			sPacket.data.add("iUnitStr","x");
			sPacket.data.add("meansId","<%=meansId%>");
			
			core.ajax.sendPacket(sPacket,getPriFeeTime);
			sPacket = null;
		}
		//���ͻ�ȡ�����ʷ���Чʱ������
		function sendAddFreeAjax(){
			var sPacket = new AJAXPacket("getEffectTime.jsp","���Ժ�......");
			sPacket.data.add("iChnSource","<%=reginCode%>");
			sPacket.data.add("iLoginNo","<%=loginNo%>");
			sPacket.data.add("iLoginPWD","<%=password%>");
			sPacket.data.add("iPhoneNo", gMemberId);
			sPacket.data.add("iOprAccept","<%=orderId%>");
			sPacket.data.add("iPhoneNoStr",gMemberIdStr);
			sPacket.data.add("iOfferIdStr",gMemAddFee);
			sPacket.data.add("iOprTypeStr",gAddFeeOperType);
			sPacket.data.add("iUnitStr",gAddFeeUnit);
			sPacket.data.add("iDateTypeStr",gAddFeeDateType);
			sPacket.data.add("iOfferTypeStr",gAddFeeOperType);
			sPacket.data.add("iOffsetStr",gAddFeeOffset);
			sPacket.data.add("meansId","<%=meansId%>");
			core.ajax.sendPacket(sPacket,getAddFeeTime);
			sPacket = null;
		}
		//��ó�Ա��Ϣ
		function sendMemberDataAjax(){
			var sPacket = new AJAXPacket("getMemberData.jsp","���Ժ�......");
			sPacket.data.add("memberNo", gMemberId);
			sPacket.data.add("memType", gMemType);
			sPacket.data.add("operType", "<%=operType%>");
			core.ajax.sendPacket(sPacket,getMemberData);
		}
		//У���Ա����
		function sendCheckPasswordAjax(){
			var sPacket = new AJAXPacket("checkPassword.jsp","���Ժ�......");
			sPacket.data.add("phoneNo", gMemberId);
			sPacket.data.add("password", gPassword);
			core.ajax.sendPacket(sPacket,checkPassword);
		}
		//У��TD�̻�
		function sendCheckTDAjax(){
			var sPacket = new AJAXPacket("checkTD.jsp","���Ժ�......");
			sPacket.data.add("phoneNo", gMemberId);
			core.ajax.sendPacket(sPacket,checkTD);
		}
		//������ʷѰ󶨿�ѡ�ײ�
		function sendFeeExtAjax(feeCode){
			if(gMemType != "B"){
				var sPacket = new AJAXPacket("getFeeExt.jsp","���Ժ�......");
				sPacket.data.add("idNo", gIdNo);
				sPacket.data.add("modeCode", gModeCode);
				sPacket.data.add("feeCode", feeCode);
				sPacket.data.add("belongCode", gGroupId);
				core.ajax.sendPacket(sPacket,showFeeExt);
				sPacket = null;
			}else{
				gFeeExtPass = true;
			}
		}
		//--------------------------��������-------------------------------------
		function checkNetPre(packet){
			var retCode = packet.data.findValueByName("returnCode");
			var retMsg = packet.data.findValueByName("returnMsg");
			if( retCode=="w00006"){
				showDialog(retMsg+";      ��ʾ:����Ӫ�������ڻ��ֵ���Ԫ�أ����Ƚ��л��ֵ���д������������!", 1);
				return;
			}
			if(retCode != "000000" && retCode!="w00006"){
				showDialog(retMsg, 1);
				return ;
			}
			gPreNetFlag = packet.data.findValueByName("netFlag");//��ǩ����ʷ�ת������ 5����ת���� 4����ת����
			gNetFlag = packet.data.findValueByName("netFlag");
			//document.getElementById("global_netFlag").value = gPreNetFlag;
			gPriFeeStartTime = packet.data.findValueByName("effDate");
			gPriFeeEndTime = packet.data.findValueByName("expDate");
			sendPriFeeAjax();
		}
		function getPriFeeTime(packet){
			var retCode = packet.data.findValueByName("RETURN_CODE");
			var retMsg = packet.data.findValueByName("RETURN_MSG");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			gPriFeePass = true;
			if(gMemFeeValid != "5" || gPreNetFlag == "4"){//������ǩ��Ļ��߰���ת����
				gPriFeeStartTime = packet.data.findValueByName("effDateStr");
				gPriFeeEndTime = packet.data.findValueByName("expDateStr");
			}
			buildFeeExtInfo();
			createMemberStr();
		}
		function buildFeeExtInfo(){
			//���ʷѸ����ʷ�
			var feeExts = $("#table_feeExt :checkbox");
			var feeExtSplit = "#";
			for(var i=0; i<feeExts.length; i++){
				var feeExtDatas = $(feeExts[i]).val();
				var feeExtData = feeExtDatas.split("@");
				
				var newStatus = ""; 
				var instId = "";
				var start = "";
				var end = "";
				if($(feeExts[i]).attr("checked")){
					newStatus = "N";//����
					instId = "0";
					start = gPriFeeStartTime;
					end = gPriFeeEndTime;
				}else{
					newStatus = "Y";//ȡ��
					instId = feeExtData[4];
					start = feeExtData[5];
					end = gPriFeeStartTime;
				}
				var oldStatus = feeExtData[3];
				//���ԭ״̬Ϊ���� ��old = Y ȡ��֮����Ҫ��Y �����ж��¾�״̬����
				if(newStatus != oldStatus){
					continue;
				}
				gFeeExtCode += feeExtData[0] + feeExtSplit;
				gFeeExtName += feeExtData[1] + feeExtSplit;
				gFeeExtStatus += newStatus + feeExtSplit;	
				gFeeExtFlag += feeExtData[2] + feeExtSplit;
				gFeeExtInst += instId + feeExtSplit;
				gFeeExtStart += start + feeExtSplit;
				gFeeExtEnd += end + feeExtSplit;
			}
		}
		function getAddFeeTime(packet){
			var retCode = packet.data.findValueByName("RETURN_CODE");
			var retMsg = packet.data.findValueByName("RETURN_MSG");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			gAddFeePass = true;
			gAddFeeStartTime = packet.data.findValueByName("effDateStr");
			gAddFeeEndTime = packet.data.findValueByName("expDateStr");
			createMemberStr();
		}
		function getMemberData(packet){
			var retCode =  packet.data.findValueByName("returnCode");
			var retMsg = packet.data.findValueByName("returnMsg");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			if(gMemType == "B"){
				gNetCode = gMemberId;
				gMemberId = packet.data.findValueByName("memberNo");
				gSmCode = packet.data.findValueByName("smCode");
				gNetSmCode = packet.data.findValueByName("smCode");
				//document.getElementById("global_netSmCode").value = gSmCode;
			}else{
				gNetCode = "#";//ռλ
			}
			gIdNo = packet.data.findValueByName("idNo");
			gCustId = packet.data.findValueByName("custId");
			gGroupId = packet.data.findValueByName("belongCode");
			gSmCode = packet.data.findValueByName("smCode");
			gModeCode = packet.data.findValueByName("modeCode");
			$("#memberNo").attr("disabled", "disabled");
			if(gMemType != "B"){
				$("#memberPsd").attr("disabled", "disabled");
			}
			$("#button_mem_check").attr("disabled", "disabled");
			$("#button_mem_save").attr("disabled", "");
			$('#table_fee').css("display", "block");
			$('#table_addFee').css("display", "block");
			$('#table_fund').css("display", "block");
			$('#table_syspay').css("display", "block");
		}
		function showFeeExt(packet){
			$('#table_feeExt').html("");
			var retCode = packet.data.findValueByName("returnCode");
			var retMsg = packet.data.findValueByName("returnMsg");
			if(retCode != "000000"){
				gFeeExtPass = false;
				showDialog(retMsg, 1);
				return ;
			}
			var feeExtCodes = packet.data.findValueByName("feeExtCodes");
			var feeExtNames = packet.data.findValueByName("feeExtNames");
			var feeExtChoiceds = packet.data.findValueByName("feeExtChoiced");
			var feeExtSendFlags = packet.data.findValueByName("feeExtSendFlags");
			var feeExtSendFlagStrs = packet.data.findValueByName("feeExtSendFlagStrs");
			var feeExtStatusStrs = packet.data.findValueByName("feeExtStatusStrs");
			var feeExtInstStrs = packet.data.findValueByName("feeExtInstStrs");
			var feeExtStartStrs = packet.data.findValueByName("feeExtStartStrs");
			$('#table_feeExt').css("display", "block");
			if(feeExtCodes != ""){
				var feeExtCode = feeExtCodes.split("@");
				var feeExtName = feeExtNames.split("@");
				var feeExtChoiced = feeExtChoiceds.split("@");
				var feeExtSendFlag = feeExtSendFlags.split("@");
				var feeExtSendFlagStr = feeExtSendFlagStrs.split("@");
				var feeExtStatusStr = feeExtStatusStrs.split("@");
				var feeExtInstStr = feeExtInstStrs.split("@");
				var feeExtStartStr = feeExtStartStrs.split("@");
				var statusStr;
				$('#table_feeExt').append("<tr><th>ѡ���ѡ�ײ�</th><th>��ѡ�ײʹ���</th><th>��ѡ�ײ�����</th><th>��Ч��ʽ</th><th>״̬</th></tr>");
				for(var i=0; i<feeExtCode.length; i++){
					if(feeExtStatusStr[i] == ("Y")){
						statusStr = "�ѿ�ͨ";
					}else{
						statusStr = "δ��ͨ";
					}
					var innerHtml = "<tr><td><input type = 'checkbox' name='feeExt' ";
					innerHtml += "value='"+feeExtCode[i]+"@"+feeExtName[i]+"@"+feeExtSendFlag[i]+"@"+feeExtStatusStr[i]+"@"+feeExtInstStr[i]+"@"+feeExtStartStr[i]+"' ";
					if(feeExtChoiced[i] == "0"||feeExtChoiced[i] == "1"||feeExtChoiced[i] == "4"){
						innerHtml += "checked ";
					}
					if(feeExtChoiced[i] == "2"||feeExtChoiced[i] == "9"){
						innerHtml += "checked onclick='return false' ";
					}
					if(feeExtChoiced[i] == "a"||feeExtChoiced[i] == "b"||feeExtChoiced[i] == "d"){
						innerHtml += "onclick='return false' ";
					}
					innerHtml +="></td>";
					innerHtml +="<td>"+feeExtCode[i]+"</td>";
					innerHtml +="<td>"+feeExtName[i]+"</td>";
					innerHtml +="<td>"+feeExtSendFlagStr[i]+"</td>";
					innerHtml +="<td>"+statusStr+"</td></tr>";
					$('#table_feeExt').append(innerHtml);
				}
			}
			gFeeExtPass = true;
		}
		function checkPassword(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			sendMemberDataAjax();
		}
		function checkTD(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			sendCheckPasswordAjax();
		}
		//--------------------------У�����-------------------------------------
		function checkMember(freeFlag){
			resetMemberData();
			gMemNo = $("#memNo").val();
			gMemberId = $("#memberNo").val();//�û�����
			gMemType = $("#memType").val();//��Ա����
			if(gMemType != "B"){
				gPassword = $("#memberPsd").val();
				if(gPassword == ""){
					showDialog("������������룡",1);
					return;
				}
			}
			gFreeFlag = freeFlag;
			if(gMemType == "B"){
				gPrintInfo += "�����Ա:" + gMemberId;
				sendMemberDataAjax();
			}
			if(gMemType == "P"){
				gPrintInfo += "�ֻ���Ա:" + gMemberId;
				sendCheckPasswordAjax();
			}
			if(gMemType == "T"){
				gPrintInfo += "TD�̻���Ա:" + gMemberId;
				//sendCheckPasswordAjax();
				sendCheckTDAjax();
			}
		}
		//--------------------------�����Ա-------------------------------------
		function saveMember(){	
			resetCheckGParams();
			//���ʷ�
			var feeNum = $("#feeNum").val();//���ʷ�����
			if(feeNum > 0){
				if($("#table_fee input:checked").size() == 0){
					showDialog("��ѡ�����ʷ�",1);
					return ;
				}
				gMemFee = $("#table_fee input:checked").val();
				gPrintInfo += " �������ʷ�"+gMemFee;
				gMemFeeValid = $("#hid_fee_"+gMemFee).val();
				if(gMemType == "B" && gMemFeeValid == "5"){
					sendNetPreAjax();
				}else{
					sendPriFeeAjax();
				}
			}else{
				gPriFeePass = true;
				gFeeExtPass = true;
			}
			//�����ʷ�
			var addFeeNum = $("#addFeeNum").val();
			var chooseNum = 0;
			if(addFeeNum > 0){
				var checkedAddFee = $("#table_addFee input:checked");
				var split = "";
				if(checkedAddFee.length > 0){
					gPrintInfo += " �������ʷ�";
				}
				for(var i=0; i<checkedAddFee.length; i++){
					chooseNum ++;
					var addFee = $(checkedAddFee[i]).val();
					var addFeeTime = $("#hid_addfee_time_"+addFee).val();
					gMemberIdStr += split + gMemberId;
					gMemAddFee += split + addFee;
					gAddFeeOperType += split + "1";
					gAddFeeDateType += split + "0";
					gAddFeeOfferType += split + "1";
					gAddFeeUnit += split + "6";
					gAddFeeOffset += split + addFeeTime;
					gPrintInfo += " "+addFee;
					split = "#";
				}
				sendAddFreeAjax();
			}else{
				gAddFeePass = true;
			}
			//ר��
			
			var fundNum = $("#fundNum").val();
			gMemFundVal = $("#member_fund_value_"+gMemNo).val();
			var memFundStr = "";
			if(fundNum > 0){
				var fund_value_0 = $("#fund_value_0").val();
				var fund_value_1 = $("#fund_value_1").val();
				
				if( !fund_value_0  && !fund_value_1){
					var memFundStr1 = $("#hid_fund_0").val();
					var memFundStr2 = $("#hid_fund_1").val();
					var end='';
					var start ='';
					if(memFundStr1){
						var start = memFundStr1.indexOf("(");
						var end = memFundStr1.indexOf(")");
						gMemFund=memFundStr1.substring(start+1, end);
					}else if(memFundStr2) {
						start = memFundStr2.indexOf("(");
						end = memFundStr2.indexOf(")");	
						gMemFund=memFundStr2.substring(start+1, end);
					}
				}else if(fund_value_0 =="" || fund_value_0 == "0"){
					var memFundStr2 = $("#hid_fund_1").val();
					var start2 = memFundStr2.indexOf("(");
					var end2 = memFundStr2.indexOf(")");
					gMemFund = memFundStr2.substring(start2+1, end2);
				}else if(fund_value_1 =="" || fund_value_1 == "0") {
					var memFundStr1 = $("#hid_fund_0").val();
					var start1 = memFundStr1.indexOf("(");
					var end1 = memFundStr1.indexOf(")");
					gMemFund = memFundStr1.substring(start1+1, end1);
				}else{
					var memFundStr1 = $("#hid_fund_0").val();
					var start1 = memFundStr1.indexOf("(");
					var end1 = memFundStr1.indexOf(")");
					var memFundStr2 = $("#hid_fund_1").val();
					var start2 = memFundStr2.indexOf("(");
					var end2 = memFundStr2.indexOf(")");
					gMemFund = memFundStr1.substring(start1+1, end1)+'#'+memFundStr2.substring(start2+1, end2);
					familyTypefund=fund_value_0+'#'+fund_value_1;
				}
			}
			
			//ϵͳ��ֵ
			var sysPayNum = $("#sysPayNum").val();
			gMemSysPayVal = $("#member_sysPay_value_"+gMemNo).val();
			var memSysPayStr = "";
			if(sysPayNum > 0){
				var sysPay_value_0 = $("#sysPay_value_0").val();
				var sysPay_value_1 = $("#sysPay_value_1").val();
				if(sysPay_value_0 =="" || sysPay_value_0 == "0"){
					var memFundStr2 = $("#hid_sysPay_1").val();
					var start2 = memFundStr2.indexOf("(");
					var end2 = memFundStr2.indexOf(")");
					gMemSysPay = memFundStr2.substring(start2+1, end2);
				}else if(sysPay_value_1 =="" || sysPay_value_1 == "0") {
					var memFundStr1 = $("#hid_sysPay_0").val();
					var start1 = memFundStr1.indexOf("(");
					var end1 = memFundStr1.indexOf(")");
					gMemSysPay = memFundStr1.substring(start1+1, end1);
				}else {
					var memFundStr1 = $("#hid_sysPay_0").val();
					var start1 = memFundStr1.indexOf("(");
					var end1 = memFundStr1.indexOf(")");
					var memFundStr2 = $("#hid_sysPay_1").val();
					var start2 = memFundStr2.indexOf("(");
					var end2 = memFundStr2.indexOf(")");
					gMemSysPay = memFundStr1.substring(start1+1, end1)+'#'+memFundStr2.substring(start2+1, end2);
					familyTypeSysPay=sysPay_value_0+'#'+sysPay_value_1;
				}
			}
			
			if(gFreeFlag == "-1"){
				gMemFundVal = Number($("#fund_value_0").val())+Number($("#fund_value_1").val());
				var usedFund = $("#used_fund").text();
				if(Number("<%=fundFree%>")>0){
					if(!isInt(gMemFundVal)){
						showDialog("ר�����������������", 1);
						return;
					}
					if(Number("<%=fundFree%>") < Number(gMemFundVal) + Number(usedFund)){
						showDialog("�Ѿ������ר���ܶ���ڿ��Է����ר���ܶ�����·��䣡",1);
						return ;
					}
					if(gMemFundVal%60!=0){
						showDialog("ר�������Ϊ60�ı��������޸ģ�",1);
						return;
					}
				}else{
					gMemFundVal = "0";
					usedFund = "0";
				}
				
				gMemSysPayVal = Number($("#sysPay_value_0").val())+Number($("#sysPay_value_1").val());;
				var usedSysPay = $("#used_sysPay").text();
				if(Number("<%=sysPayFree%>")>0 ){
					if(!isInt(gMemSysPayVal)){
						showDialog("ϵͳ��ֵ����������������", 1);
						return;
					}
					if(Number("<%=sysPayFree%>") < Number(gMemSysPayVal) + Number(usedSysPay)){
						showDialog("�Ѿ������ϵͳ��ֵ�ܶ���ڿ��Է����ϵͳ��ֵ�ܶ�����·��䣡",1);
						return ;
					}
					if(gMemSysPayVal%60!=0){
						showDialog("ϵͳ��ֵ������Ϊ60�ı��������޸ģ�",1);
						return;
					}
				}else{
					gMemSysPayVal = "0";
					usedSysPay = "0";
				}
				
				$("#used_fund").text(Number(gMemFundVal) + Number(usedFund));
				$("#used_sysPay").text(Number(gMemSysPayVal) + Number(usedSysPay));
			}
			if(Number(gMemFundVal) > 0){
				gPrintInfo += " ����ר�� "+ memFundStr + gMemFundVal + "Ԫ";
			}
			if(Number(gMemSysPayVal) > 0){
				gPrintInfo += " ����ϵͳ��ֵ "+ memFundStr + gMemSysPayVal + "Ԫ";	
			}
			gMainPass = true;
			createMemberStr();
		}
		function createMemberStr(){
			if(!gPriFeePass || !gAddFeePass || !gMainPass ||!gFeeExtPass){
				return;
			}
			//��Ӽ�ͥģʽ��ר����㹫ʽУ��ʹ���
			var gMemFundValTem = gMemFundVal;
			var gMemSysPayValTem = gMemSysPayVal;
			if(familyTypefund != ""){
				gMemFundVal=familyTypefund;
			}
			if(familyTypeSysPay != ""){
				gMemSysPayVal=familyTypeSysPay;
			}
			var memberValue = gMemberId+"|"+gMemType+"|"
				+gIdNo+"|"+gCustId+"|"+gGroupId+"|"+gSmCode+"|"
				+gMemFee+"|"+gPriFeeStartTime+"|"+gPriFeeEndTime+"|"
				+gMemAddFee+"|"+gAddFeeStartTime+"|"+gAddFeeEndTime+"|"
				+gMemFund+"|"+gMemSysPay+"|"+gMemFundVal+"|"+gMemSysPayVal+"|"
				+gNetCode+"|"
				+gFeeExtCode+"|"+gFeeExtName+"|"+gFeeExtStatus+"|"+gFeeExtFlag+"|"
				+gFeeExtInst+"|"+gFeeExtStart+"|"+gFeeExtEnd+"|"
				+gPrintInfo;
			gMemFundVal=gMemFundValTem;
			gMemSysPayVal=gMemSysPayValTem;
			$("#order_html").html("");
			if(gMemNo != "-1"){
				$("#hid_member_value_"+gMemNo).val(memberValue);
				$("#td_member_statue_"+gMemNo).html("<font color='red'>�ѷ���"+gMemberId+"</font>");
				$("#b_member_choose_"+gMemNo).css("display","none");
				$("#b_member_reset_"+gMemNo).css("display","block");
			}else{
				var appendHtml = "<tr id='free_tr_"+gFreeId+"'><td>" + gMemberId + "</td>";
				var memTypeStr = "";
				if(gMemType == "T")memTypeStr ="TD�̻���Ա";
				if(gMemType == "B")memTypeStr ="�����Ա";
				if(gMemType == "P")memTypeStr ="�ֻ���Ա";
				appendHtml += "<td>"+memTypeStr+"</td>";
				appendHtml += "<td id='free_td_fund_"+gFreeId+"'>"+gMemFundVal+"</td>";
				appendHtml += "<td id='free_td_sysPay_"+gFreeId+"'>"+gMemSysPayVal+"</td>";
				appendHtml += "<td><input type='button' class='b_text' value='ɾ��' onclick = 'removeTr("+gFreeId+")' />";
				appendHtml += "<input type='hidden' name='member_value' value='"+memberValue+"' /></td></tr>";
				$("#table_free_member").append(appendHtml);
				gFreeId ++;
			}
		}
		function resetMember(memNo){
			$("#td_member_statue_"+memNo).html("δ����");
			$("#b_member_choose_"+memNo).css("display","block");
			$("#b_member_reset_"+memNo).css("display","none");
			$("#hid_member_value_"+memNo).val("");
		}
		
		function submitAll(){
			var allMemberInfo = "";
			var memberValues = $("input[name = member_value]");
			var split = "";
			for(var i=0; i<memberValues.size(); i++){
				if($(memberValues[i]).val() == ""){
					showDialog("����û�з���ĳ�Ա",1);
					return;
				}
				allMemberInfo += split + $(memberValues[i]).val();
				split = "@@";
			}
			var usedFund = $("#used_fund").text();
			var usedSysPay = $("#used_sysPay").text();
			if("<%=fundFree %>"!=usedFund || "<%=sysPayFree%>"!=usedSysPay){
				showDialog("���п������ɷ����ר���ϵͳ��ֵ",1);
				return;
			}
			parent.buildGlobalNetInfo(gNetSmCode,gNetFlag);
			parent.addH11NetBindingFun(gPriFeeStartTime);
			parent.buildH15XML(allMemberInfo, "<%=totalMoney %>", gPreNetFlag);
			closeWin();
		}
		function showMemberList(listType){
			if(listType == 'fixed'){
				$("#member_list_fixed").css("display","block");
				$("#member_list_free").css("display","none");
			}
			if(listType == 'free'){
				$("#member_list_fixed").css("display","none");
				$("#member_list_free").css("display","block");
			}
			$("#order_html").html("");
		}
		function removeTr(trId){
			var memFundVal = $("#free_td_fund_"+trId).text();
			var usedFund = $("#used_fund").text();
			$("#used_fund").text(Number(usedFund) - Number(memFundVal));
			var memSysPayVal = $("#free_td_sysPay_"+trId).text();
			var usedSysPay = $("#used_sysPay").text();
			$("#used_sysPay").text(Number(usedSysPay) - Number(memSysPayVal));
			$("#free_tr_"+trId).remove();
		}
		function closeWin(){
			closeDivWin();
		}
		function isInt(v){
			var Int = /^-?\d+$/;
			if(Int.exec(v)) {
				return true;
			} else {
				return false;
			}
		}
		function isTel(v){
			var mobilePatrn = /^((\(\d{3}\))|(\d{3}\-))?1[3,5,8]\d{9}$/;
			if(mobilePatrn.exec(v)) {
				return true;
			} else {
				return false;
			}
		}
		function showReNumberDialog(obj) {
		    var path = "/npage/common/ReNumberDialog.jsp";
		    var h=170;
		    var w=470;
		    var t=screen.availHeight/2-h/2;
		    var l=screen.availWidth/2-w/2;
		    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";
		    
			returnValue = window.showModalDialog(path,"",prop);
		    
			if (returnValue != '') {
			   obj.value = returnValue;
			}
		}
		

	</script>
</html>