   <%
	/**
	 * Title: ����ƻ�
	 * Description: ����ƻ�չʾҳ��
	 * Copyright: 2012-7-9 9:20:38
	 * Company: SI-TECH
	 * author��liujian
	 * version 1.0 
	 */
%>
<%
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	System.out.println("---liujian---opCode=" + opCode);
%>
<%@ page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="/npage/s1104/ignoreIn.jsp" %>
<%@ include file="/npage/common/qcommon/print_include1.jsp"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%
	
	String phoneNo = WtcUtil.repNull(request.getParameter("activePhone"));
	String broadPhone = WtcUtil.repNull(request.getParameter("broadPhone"));
	String workNo = (String) session.getAttribute("workNo");
    String password = (String) session.getAttribute("password");
	String regionCode= (String)session.getAttribute("regCode");
	System.out.println("---liujian---activePhone=" +phoneNo + "----broadPhone=" +broadPhone);
	String oprDate =  new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String servBusiId = "";
	String userRegionName = "";
	String offerName = "";
	String smCode ="";
	String orgCode = (String) session.getAttribute("orgCode");
	System.out.println(orgCode+"e916ssss");
	String c0="",c1="",c2="",c3="",c4="",c5="",c6="",c7="",c8="",c9="",c10="",c11="",c12="",c13="",c21="",c22="";
	boolean runFlag = false;
	String[][] rstParams = new String[][]{};
	String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String sql = "select * from Service_Offer where  function_code = 'e916'";
	String ifKe = "";
	/*2014/07/08 14:31:05 gaopeng R_CMI_HLJ_xueyz_2014_1644996@����ũ�����߿����WBS��ҵ��ϵͳ֧������ ���ط�ʽ*/
	String sbearType = "";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:param value="<%=sql%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end" />
<%
	servBusiId = result2[0][0];
	System.out.println("--------liujian--------servBusiId=" + servBusiId);
%>	
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />

	<%
		String[] inputParams = new String[8];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = workNo;
		inputParams[4] = password;
		inputParams[5] = "";
		inputParams[6] = "";
		inputParams[7] = broadPhone;
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("---liujian---inputParams[" + i + "]=" + inputParams[i]);
		}
	%>
	<wtc:service name="se916Qry" routerKey="reg	ion" routerValue="<%=regionCode%>"
			retcode="retCode" retmsg="retMsg" outnum="23">
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
		<%
			if(retCode.equals("000000")) {
				runFlag = true;
				System.out.println("------e916---tempArr.length=" + tempArr.length);
				System.out.println("------e916---tempArr[0].length=" + tempArr[0].length);
				offerName = tempArr[0][7];
				smCode = tempArr[0][8];
				userRegionName = tempArr[0][9];
				c0=tempArr[0][0];
				c1=tempArr[0][1];
				c2=tempArr[0][2];
				c3=tempArr[0][3];
				c4=tempArr[0][4];
				c5=tempArr[0][5];
				c6=tempArr[0][6];
				c7=tempArr[0][7];
				c8=tempArr[0][12];
				c9=tempArr[0][11];
				//liujian 2012-9-18 9:56:45 ��ӳ���
				c10=tempArr[0][13];
				c11=tempArr[0][14];
				c12=tempArr[0][15];
				//gaopeng 20121031 ����һ��Ʒ��
				ifKe=tempArr[0][8].trim();
				/*2014/07/08 14:29:13 gaopeng R_CMI_HLJ_xueyz_2014_1644996@����ũ�����߿����WBS��ҵ��ϵͳ֧������ ��������,�±�16��17������ ���س��ط�ʽ*/
				sbearType = tempArr[0][16].trim();
				c13 = tempArr[0][17];
				c21=tempArr[0][21];
				c22=tempArr[0][22];
				System.out.println("gaopengSeeLog=========sbearType="+sbearType);
				/* kd����ͨ��ke����磻kf���ƶ����*/
			}else {
		%>
				<script>
					rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
					removeCurrentTab();
				</script>
		<%		
			}
			
			

	String isNeedHold = "1";
	/* 
   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
   * ����ʡ���kg������Ʒ��kh
   * houxuefengҪ��kf  kgֻ�������֣�kh���ֲ��䡣2014/11/4 13:36:10
   */
	if("kf".equals(ifKe) || "kg".equals(ifKe) || "ki".equals(ifKe)){
		isNeedHold = "1";
		/*5�Ĳ���ҪԤռ*/
		if("5".equals(c13)){
			//isNeedHold = "0";
		}
	}
	/*2014/11/21 10:32:26 gaopeng khƷ�Ƹ�Ϊ��ͨ�Խ� ��kdһ�����淨*/
	else if("kh".equals(ifKe)){
		/*kh��ȫ��5 ����ҪԤռ*/
		isNeedHold = "0";
	}
	else if("ke".equals(ifKe)){
  		isNeedHold = "0";
  }
			
System.out.println("-----liujian---------isNeedHold----------------->"+isNeedHold);			


		%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 
			routerValue="<%=regionCode%>"  id="sysAccept" /> 	
<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<META http-equiv=Content-Type content="text/html; charset=gb2312">
		<script>
			$(function() {
				$('#pageHref').val(window.location.href);
				if(<%=runFlag%>) {
					$('#cfmLoginNew').text('<%=c0%>');
					$('#custName').text('<%=c1%>');
					$('#detailAddr').text('<%=c2%>');
					$('#detailAddrOld12').val('<%=c2%>');
					$('#contactPhoneNo').text('<%=c3%>');
					$('#idIccid').text('<%=c4%>');
					$('#runState').text('<%=c5%>');
					$('#curFee').text('<%=c7%>');
					$('#prepayFee').text('<%=c6%>');
					$('#custNameText').val('<%=c1%>');
					$('#curPart').text('<%=c8%>');
					$('#oPartnerCode').val('<%=c9%>');
					//liujian 2012-9-18 10:08:55 
					$('#cctNameOld').val('<%=c10%>');
					$('#appointTimeOld').val('<%=c11%>');
					$('#accessTypeOld').val('<%=c12%>');
					$('#propertyUnitOld').val('<%=c13%>');
					if('<%=ifKe%>' == 'kd') {
						getOldResByCfmLogin();
					}
					buttonShow();
		/*����ǹ��������ke��������ԴԤռ��������ʾ*/
		if("<%=ifKe%>" == "ke"){
			$("#yz_resource").attr("disabled","disabled");
			$("#sf_resource").attr("disabled","disabled");
			$("#keShowSpan").show();
		}
		
				}else {
					rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
				}
				
				<% if("kf".equals(ifKe)&&"0".equals(c22)){%>
					kdzdchange();
					go_checkSNShow();
				<%}%>
				FEEsqfs();
			});
			
			function setGetAreaResource(val) {
				$('#isGetAreaResource').val(val);
				
			}
			function setYzResource(val) {
				$('#isYzResource').val(val);
				if(val == '0') {
					//$('#yz_resource').val('��ԴԤռ');
				}else if(val == '1') {
					//$('#yz_resource').val('ȡ��Ԥռ');
				}	
			}
			function setNoPort(val) {
				$('#noPort').val(val);
			}
			function setInputsReadOnly(flag) {
				$('#contactPhone').css("readonly",flag);
				$('#contactCustName').css("readonly",flag);
				$('#enter_addr').css("readonly",flag);
			}
			/*���С����ѯ*/
			function queryResource() { 
				idleResInfo();
				if($('#isYzResource').val() != "1"){
				
				 var smcodess="<%=smCode%>";			   
					var path ="../se276/queryResource.jsp?opCode="+"<%=opCode%>"+"&smCode="+smcodess;
					window.open(path,'С����Դ��ѯ','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
				}else{	 
					yzResource();//�ͷ���Դ 	
				}
			} 
			
			//�ƿ�"��Դ��Ϣ"�ı�
			function idleResInfo() {
				$('#cctId').val('');
				$('#cctName').val('');
				$('#ipAddress').val('');
				$('#portCode').val('');
				$('#deviceType').val('');
				$('#portType').val('');
				$('#deviceCode').val('');
				$('#deviceInAddress').val('');
				$('#areaCode').val('');
				$('#areaName').val('');
				$('#standAddress').val('');
				$('#enterType').val('');
			}
			function oneTok(str,tok,loc)
			{
			 var temStr=str;
			 var temLoc;
			 var temLen;
			 for(ii=0;ii<loc-1;ii++)
			 {
			     temLen=temStr.length;
			     temLoc=temStr.indexOf(tok);
			     temStr=temStr.substring(temLoc+1,temLen);
			 }
			 if(temStr.indexOf(tok)==-1)
			    return temStr;
			 else
			    return temStr.substring(0,temStr.indexOf(tok));
			}
			// С����Դ��ѯ�����ĺ���
			function returnResBack(retInfo) {
			//alert(retInfo);
			//alert(262);
				var resPre=retInfo.substr(0,2);
				var resContent=retInfo.substr(2,retInfo.length-1);
				//alert(resContent);
				document.all.enter_type.value=  oneTok(resContent, "|", 5);
				//alert(266);
				var sbearType = oneTok(resContent, "|", 19);
				
				var propertyUnit = oneTok(resContent, "|", 20);
				$("#propertyUnit").val(propertyUnit);
				/*2014/07/08 14:38:50 gaopeng R_CMI_HLJ_xueyz_2014_1644996@����ũ�����߿����WBS��ҵ��ϵͳ֧������ У�鷽��
					��Ȼд�����µ㣬���ǻ��ǱȽ��Ͻ�
				*/
				if("<%=ifKe%>" == "kf" || "<%=ifKe%>" == "ki"){
					/*����*/
					if("<%=sbearType%>" == "1"){
						if(sbearType == "0"){
							/*
							rdShowMessageDialog("�ÿ����������Ϊ1/���ߣ���ѡ��1/���ߵ�С����Դ��");
							$("#cfmBtn").attr("disabled","disabled");
							return false;
							*/
							$("#cfmBtn").attr("disabled","");
						}else if(sbearType == "1"){
							$("#cfmBtn").attr("disabled","");
						}
					}
					/*����*/
					if("<%=sbearType%>" == "0"){
						if(sbearType == "1"){
							rdShowMessageDialog("�ÿ����������Ϊ0/���ߣ���ѡ��0/���ߵ�С����Դ��");
							$("#cfmBtn").attr("disabled","disabled");
							return false;
						}else if(sbearType == "0"){
							$("#cfmBtn").attr("disabled","");
						}
					}
				}
				
	/* 4977�������С���ʷѲ�ѯ���ӹ�����ƣ���������Ϊ�ƶ��������С����������Ϊ��磬���������ԴԤռ@2014/5/29 16:39:50 */
	/*2014/11/19 10:52:43 ��ͨ�ں���Ŀ gaopeng �޸� ֻ��С�����������жϼ��ɣ�kg��ke��kh������Ԥռ
		kg=3 ke=4 kh=5
		2015/01/08 11:11:09 gaopeng 3 4 5 6(����)��ʱ�� ��������ԴԤռ
	*/
	if( document.all.propertyUnit.value.trim() == "3" || document.all.propertyUnit.value.trim() == "4" ){
		$("#isNeedHold").val("0");
		document.all.yz_resource.disabled=true;
	}
	/*2016/5/31 10:22:02 gaopeng ������ͨ����ͻ�Ǩ��֧��ϵͳ���첹������ĺ� 
		С���������� Ϊ5 5-��ͨ����ͨ���У�  6 6-����(�ƶ��Խ�)
		��������Ϊ ��2/FTTH���͡�3/FTTB��ʱ ��ҪԤռ
		�����������ҪԤռ
	*/
	if(document.all.propertyUnit.value.trim() == "5" || document.all.propertyUnit.value.trim() == "6"){
		/*��������Ϊ ��2/FTTH���͡�3/FTTB��ʱ ��ҪԤռ*/
		if(document.all.enter_type.value == "2" || document.all.enter_type.value == "3"){
			$("#isNeedHold").val("1");
			document.all.yz_resource.disabled=false;
		}else{
			$("#isNeedHold").val("0");
			document.all.yz_resource.disabled=true;
		}
	}
				
				
				//alert(resContent);
				$('#areaName').val(oneTok(resContent, "|", 3));
				$('#areaCode').val(oneTok(resContent, "|", 2));
				/*2013/3/4 ����һ 15:19:56 gaopeng ������һ��������������Ų�����*/
				$('#areaAddr').val(oneTok(resContent, "|", 3));
				$('#standardCode').val(oneTok(resContent, "|", 6));//addressCode��ַ����
				$('#enterType').val(oneTok(resContent, "|", 5));
				$('#standAddress').val(oneTok(resContent, "|", 7));
				$('#deviceType').val(oneTok(resContent, "|", 8));
				$('#deviceCode').val(oneTok(resContent, "|", 9));
				$('#ipAddress').val(oneTok(resContent, "|", 12));
				$('#deviceInAddress').val(oneTok(resContent, "|", 13));
				$('#portType').val(oneTok(resContent, "|", 14));
				$('#portCode').val(oneTok(resContent, "|", 15));
				$('#cctId').val(oneTok(resContent, "|", 16));
				document.all.nPartnerCode.value=oneTok(resContent, "|", 17);
				
				document.all.belongCategory.value=oneTok(resContent, "|", 18);
				document.all.bearType.value=oneTok(resContent, "|", 19);
				document.all.distKdCode.value=oneTok(resContent, "|", 21);
				document.all.nearInfo.value=oneTok(resContent, "|", 22);
	
				
				/*2014/07/08 14:53:03 gaopeng ��ֵ����������*/
				$('#sbearType').val(sbearType);
				/*
				2015/12/29 9:41:46 gaopeng 
				R_CMI_HLJ_guanjg_2015_2521975@�����޸Ŀ���ƻ����������
				ȥ��������
				ԭҪ��ͬƷ�ƿ����ƻ�������ԭ�߼�����ͨ��Ʒ�Ƶ�ת��Ϊ������������ѯ
				���Բ���Ҫ�����жϡ�
				if($.trim($("#propertyUnitOld").val()) != $.trim($("#propertyUnit").val())){
					rdShowMessageDialog("�¾�С���������ʲ�һ�£��������ƻ���");
					return false;
				}
				*/
				
				var pkt = new AJAXPacket("ajaxGetPartnerName.jsp","���Ժ�...");
				pkt.data.add("partnerCode",document.all.nPartnerCode.value);
				pkt.data.add("iSmCode","<%=smCode%>");
				core.ajax.sendPacket(pkt,doPartnertName);
				pkt = null;	
					
				var cctIdVal = $('#cctId').val();
				if(cctIdVal != ""){
					var packet = new AJAXPacket("../s4977/ajaxGetCctName.jsp","���Ժ�...");
					packet.data.add("cctId",cctIdVal);
					core.ajax.sendPacket(packet,doAjaxGetCctName);
					packet = null;
				} 
				//����С����Դ״̬λ
				setGetAreaResource('1');
				if (resPre =="3%"){
				//rdShowMessageDialog("����Դ���豸û�ж˿ڣ�����Ԥռ��");
					setNoPort('1');
					//buttonShow();
				}else if (resPre =="4%"){
					setNoPort('0');
					buttonShow();
				}
				
			}
			function doPartnertName(packet)
			{
				var retCode = packet.data.findValueByName("ptRtCode");
				var retMsg = packet.data.findValueByName("ptRtMsg");
				
				if(retCode == "000000")
				{
					var ptName = packet.data.findValueByName("ptName");
					document.all.nPartnerName.value=ptName;	
				}
				else
				{
					rdShowMessageDialog(retMsg,0);
					removeCurrentTab();
				}
			}			
			
			//���á�С����Դ��ѯ���͡���ԴԤռ����ť����ʾ״̬
function buttonShow() {

	if(document.all.isYzResource.value=="0")
	{	
		
    if(document.all.isGetAreaResource.value=="1")
		{
			document.all.yz_resource.disabled=false;
		}else if (document.all.isDoNoResource.value=="1")
		{
			document.all.yz_resource.disabled=true;
		}else if ((document.all.isDoNoResource.value !="1") && (document.all.isGetAreaResource.value!="1") )
		{
			document.all.query_res.disabled=false;
			document.all.yz_resource.disabled=true;
		}
		
		if($("#isNeedHold").val() == "1"){
			/*��ҪԤռ��*/
			document.all.yz_resource.disabled=false;
			document.all.sf_resource.disabled=true;
		}else{
			document.all.yz_resource.disabled=true;
			document.all.sf_resource.disabled=true;
		}
		
	}
	else{
			document.all.query_res.disabled=true;
      document.all.yz_resource.disabled=true;
      document.all.sf_resource.disabled=false;
	}

}
			
			//���ɵ��ž�����
			function doAjaxGetCctName(packet) {
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMessage");
				var cctName = packet.data.findValueByName("cctName");
				if(retCode == "000000") {
					$('#cctName').val(cctName);	
				}else {
					rdShowMessageDialog(retMsg,0);
				}
			}
			
			/*��ȡ����Դ��Ϣ*/
			function getOldResByCfmLogin() {
					document.all.deviceNameOld.value="";
						//liujian 2012-9-18 10:16:44 end
						document.all.deviceCodeOld.value="";
						document.all.ipAddressOld.value="";
						document.all.deviceInAddressOld.value= "";
						document.all.portCodeOld.value= "";
						document.all.cctIdOld.value = "";       
			}
			
			/*��ԴԤռ*/
			function yzResource() {
				if($('#isGetAreaResource').val() == "0") {
				       rdShowMessageDialog("û��ѡ����Դ����ѡ����Դ");
				       return false;
				}
				if(!$('#cfmLogin').val()) {
						rdShowMessageDialog("û�п����½�˺Ų�����Ԥռ��Դ",0);
						return false;
				}
				var contactCustName = $('#contactCustName').val();
				if(!contactCustName && contactCustName != "0"){
				  	rdShowMessageDialog("��ϵ�˲�����Ϊ�գ�������");
				  	$('#contactCustName').focus();
				  	return false;
				}
				var contactPhone = $('#contactPhone').val();
				if(!contactPhone && contactPhone != "0"){
				  	rdShowMessageDialog("��ϵ���벻����Ϊ�գ�������");
				  	$('#contactPhone').focus();
				  	return false;
				}
				var enter_addr = $('#enter_addr').val();
				if(!enter_addr){
					rdShowMessageDialog("��װ��ַ������Ϊ�գ�������");
					$('#enter_addr').focus();
					return false;
				}
				
				var zhengze = /[\~\`\^\,\=]+/g;
			    if(zhengze.test($('#enter_addr').val())){
		         	rdShowMessageDialog("��װ��ַ�����԰���~`^,=�������ַ����޸�!");
		         	$('#enter_addr').focus();
		         	return false;
			    }
				
				 
				var myPacket = new AJAXPacket("../se276/ajax_yzResource.jsp", "����У�飬���Ժ�......");
				myPacket.data.add("serviceOrder","<%=servBusiId%>" );
				myPacket.data.add("addressCode", $('#standardCode').val());
				myPacket.data.add("businessCity",  "<%=userRegionName%> ");
				myPacket.data.add("businessArea","");/*ҵ����������*/
				myPacket.data.add("businessDemand","");/*ҵ����������*/
				myPacket.data.add("loginNo", "<%=workNo%>");
				myPacket.data.add("applyId","");/*����ϵͳ��������*/
				myPacket.data.add("productName", "<%=offerName%>");
				myPacket.data.add("productCode", $('#cfmLogin').val());
				myPacket.data.add("productType","12");/*��Ʒ����*/
				myPacket.data.add("productState","");/*��Ʒҵ��״̬*/
				myPacket.data.add("validateTime","");/*����Чʱ��*/
				myPacket.data.add("relatedProductCode","");/*������Ʒ*/
				myPacket.data.add("account", $('#cfmLogin').val());
				myPacket.data.add("password","null");/*����*/
				myPacket.data.add("customerName", $('#custName').text());/*liujian 2012-12-18 15:10:30 �� chenlin ��ͨ   �޸ĳ� �ͻ�����*/
				myPacket.data.add("customerAddress", $('#detailAddr').text());/*liujian 2012-12-18 15:10:30 �� chenlin ��ͨ   �޸ĳ� ��װ��ַ*/
				myPacket.data.add("customerGrade","");/*�û�����*/
				myPacket.data.add("customerLinkMan",$('#contactCustName').val());/*�û���ϵ��*/
				myPacket.data.add("customerPhone", $('#contactPhone').val());
				myPacket.data.add("customerMail","");/*��ϵ����*/
				myPacket.data.add("customerCode",$('#cfmLogin').val());/*�û����*/
				myPacket.data.add("newCustomerName",$('#contactCustName').val());/*liujian 2012-12-18 15:10:30 �� chenlin ��ͨ   �޸ĳ� ��ϵ������*/
				myPacket.data.add("newCustomerAddress",$('#enter_addr').val());/* liujian 2012-12-18 15:10:30 �� chenlin ��ͨ  �޸ĳ� ��ϵ�˵�ַ*/
				myPacket.data.add("newCustomerPhone",$('#contactPhone').val());/* liujian 2012-12-18 15:10:30 �� chenlin ��ͨ  �޸ĳ� ��ϵ�˵绰*/
				myPacket.data.add("stdAddress",$('#standAddress').val());/*�û���׼��ַ*/
				myPacket.data.add("newRate","");/*�¿������*/
				myPacket.data.add("oldRate","");/*�ɿ������*/
				myPacket.data.add("serviceType","17");/*��������*/	
				myPacket.data.add("deviceName", $('#deviceType').val());
				myPacket.data.add("deviceId", $('#deviceCode').val());
				myPacket.data.add("portName", $('#portType').val());
				myPacket.data.add("portId", $('#portCode').val());
				myPacket.data.add("collType","");/*��������*/
				myPacket.data.add("broadBandObject","");/*�������*/
				myPacket.data.add("opCode", "<%=opCode%>");
				myPacket.data.add("enterType", $("#enterType").val());
				myPacket.data.add("propertyUnit", $("#propertyUnit").val());
				if($('#isYzResource').val() == "1"){
					rdShowMessageDialog("���û���Ԥռ��Դ,���Ҫ����Ԥռ��ȷ��Ҫ�ͷ�ԭ����Դ��",1); 
					myPacket.data.add("yzFlag", "2" );
					myPacket.data.add("productApplyUses","����ƻ���Դ�ͷ�");/*��;*/
					myPacket.data.add("opNote", "��Դ�ͷ�");/*��ע*/
					core.ajax.sendPacket(myPacket,doYzResource);
					myPacket = null;
				}else if($('#isYzResource').val() == "0"){
					myPacket.data.add("yzFlag", "0" );//liujian 2012-12-18 15:07:40 Ԥռ0���鵵1���ͷ�2
					myPacket.data.add("productApplyUses","����ƻ���ԴԤռ");/*��;*/
					myPacket.data.add("opNote", "��ԴԤռ");/*��ע*/
					core.ajax.sendPacket(myPacket,doYzResource);
					myPacket = null;
				}
			} 
			function doYzResource(packet) {
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				var retContent = packet.data.findValueByName("retContent");
				var iType = packet.data.findValueByName("iType");
				if(iType=="0"){
					if(retCode=="000000"){	//��ʾ���÷���ɹ�
						var retValue=retContent.split(",");
						var retContent=retValue[2].split("=");
						if(retContent[1]=="0"){//�ж��Ƿ�Ԥռ�ɹ�
							//��Щ����򲻿ɱ༭
							setInputsReadOnly(true);
							setYzResource("1");
							//setYzResource("0");
							rdShowMessageDialog("��ԴԤռ�ɹ�",2);
							buttonShow();
							var myPacket = new AJAXPacket("../sm462/ajax_getAreaInfo1.jsp", "���ڻ�ȡ�����Ժ�......");
							myPacket.data.add("kuandaiNum", $("#cfmLoginNew").text());
							myPacket.data.add("iObjectType", "03");
							myPacket.data.add("smCode", "<%=smCode%>" );
							core.ajax.sendPacket(myPacket,doGetAreaInfo);
							myPacket = null;
							
					//document.all.query_res.disabled=true;
					//document.all.yz_resource.disabled=true;
					//document.all.isfouyuzhan.value="yes";
							
						}else{
							rdShowMessageDialog("��ԴԤռʧ��",0);
							return false;
						}     
					}
					else {                                       
						rdShowMessageDialog(retMsg,0); 
						setYzResource("0");
						return false;
					}
				}else if(iType=="2"){
			        if(retCode=="000000" ){	 
						var retValue=retContent.split(",");
						var retContent=retValue[2].split("=");
						if(retContent[1]=="0"){   
							idleResInfo();
							//��Щ�����ɱ༭
							setInputsReadOnly(false);       	 
							setGetAreaResource("0");
							setYzResource("0");
							rdShowMessageDialog("��Դ�ͷųɹ�",1);
							buttonShow();
						}else{
							rdShowMessageDialog("��Դ�ͷ�ʧ��",0); 
						} 
			        }else{ 
						rdShowMessageDialog(retMsg,0);  
						//setYzResource("1");
						setYzResource("0");
			        }
				}
			}
			var returnStr="";
			function doGetAreaInfo(packet)
			{
				var retCode = packet.data.findValueByName("retCode");
			  	var retMsg = packet.data.findValueByName("retMessage");
			  
				if(retCode=="000000"){	
					var result1= packet.data.findValueByName("result1");
					returnStr=result1;
				//	alert(oneTok(returnStr, "|", 24));
					$('#areaAddr').val($('#areaAddr').val()+"|"+oneTok(returnStr, "|", 24));
				}else if(retCode=="202" || retCode=="203"){
					rdShowMessageDialog("�Բ���������Ĳ�ѯ������Χ̫���뾫ȷ�ؼ��ʺ��ѯ");	
					return false;
				}else{   
				   		rdShowMessageDialog(retMsg);
				   		return false;
				}
			}
			
			function doSubmit() {
				getAfterPrompt(); 
				
				if(!check(document.prodCfm)){
					return false;
				}
				if(!checkElement($("#kdZdFee")[0])){
					return false;
				}
				if(!forDate(document.all.bookDate)){
					rdShowMessageDialog("ԤԼ����ʱ���ʽ����ȷ��");
					document.all.bookDate.focus();
					return false;
				}
				if(forDate(document.all.bookDate)){
					if($(document.getElementById("bookDate")).val() < "<%=dateStr2%>")
					{
						rdShowMessageDialog("ԤԼ����ʱ�䲻��С�ڵ�ǰʱ�䣡");
						return false;
					}
				}
				
				    if( ($("#noPort").val() != "1") && 
        (document.all.isYzResource.value!="1") && 
        (document.all.isDoNoResource.value !="1")
        &&($("#isNeedHold").val() == "1")){
      rdShowMessageDialog("û��Ԥռ��Դ������Ԥռ��Դ����!");
      return false;  
    }
				
				
				var path = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
				if("<%=ifKe%>" == "kf"&&"0" == "<%=c22%>"){
					if($("#kdZd").val()=="ONT"&&$("#fysqfs").val()=="0"){
						showBroadKdZdBill("Bill","ȷʵҪ���п���ն˷�Ʊ��ӡ��","Yes");
					}
				//	if($("#kdZd").val()=="CPE"){
				//		showBroadKdZdBill("Bill","ȷʵҪ���п���ն˷�Ʊ��ӡ��","Yes");
				//	}
				}
				if(rdShowConfirmDialog("��ȷ���Ƿ���п���ƻ���")==1) {	
					document.prodCfm.action="fe916_2.jsp";
					document.prodCfm.submit();
				}
			}
			function doReset(){
				location = $('#pageHref').val();
			}

			/*���������ӡ*/
			function showPrtDlg(printType,DlgMessage,submitCfm) {   
				var h=210;
				var w=400;
			    var t = screen.availHeight / 2 - h / 2;
			    var l = screen.availWidth / 2 - w / 2;
			    var opCode=$("#opCode").val();
				var pType="subprint";
				var billType="1";
				var mode_code=null;
				var fav_code=null;
				var area_code=null;
				var sysAccept = $('#sysAccept').val();
			    var printStr = printInfo(printType);
			    var iRetrun = 0;
			    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
			    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			    var ret = window.showModalDialog(path, printStr, prop);
			}
			/*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
			function getPubSmCode(kdNo){
					var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("phoneNo","");
					getdataPacket.data.add("kdNo",kdNo);
					core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
					getdataPacket = null;
			}
			function doPubSmCodeBack(packet){
				retCode = packet.data.findValueByName("retcode");
				retMsg = packet.data.findValueByName("retmsg");
				smCode = packet.data.findValueByName("smCode");
				if(retCode == "000000"){
					$("#pubSmCode").val(smCode);
				}
			}
			/*��ӡ��Ϣ*/
			function printInfo(printType) {
				getPubSmCode($("#cfmLogin").val());
				var pubSmCode = $("#pubSmCode").val();
				
				var retInfo = "";
			    if (printType == "Detail"){					
					var cust_info="";
					var opr_info="";
					var note_info1="";
					var note_info2="";
					var note_info3="";
					var note_info4="";        
					cust_info += "����ʺţ�" + $("#cfmLogin").val() + "|";
					cust_info += "�ͻ�������" + $('#custName').text() + "|";
					cust_info += "�ͻ�ԭ��ַ��" + $('#detailAddr').text() + "|";
					cust_info += "�ͻ��µ�ַ��" + $('#enter_addr').val() + "|";
					
					opr_info += "ҵ������ʱ�䣺<%=oprDate%>|";
					opr_info += "ҵ��������ƣ�����ƻ�" + "               ";
					opr_info += "������ˮ��" + $('#sysAccept').val() + "|";
					opr_info += "�ƻ������ѣ�" + $("#payFee").val() + "Ԫ |";
					if(printSN){
						opr_info+= "S/N�룺"+$("#snNumber").val()+"|";
					}
					
					note_info1 += "��ע��"+"|";
				  /* 
			     * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
			     * ����ʡ���kg������Ʒ��kh
			     */
					if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
						note_info1 += "1������ϵ�绰�䶯ʱ���뼰ʱ���ƶ���˾��ϵ���Ա������»�������ʱ��ʱ�յ�֪ͨ��"+"|";
						note_info1 += "2������������벦��������ߣ�10086��"+"|";
					}
					/*
					note_info2 += "1������ƻ�����Ҫ���û�ԭ���Ŀ��ҵ��װ���û��µĽ����ַ�����5������������ƻ����������ƻ�������ԭ�п��ʹ���жϡ�" + "|";
					note_info2 += "2�����ƻ������п��ҵ�����������գ�����������ͣ���������޲��Ӻ��ƻ����ձ�׼��ȡ�ƻ����á�" + "|";
					*/
					retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
					retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
				}
			    return retInfo;
			}
			 
			//showBroadKdZdBill("Bill","ȷʵҪ���п���ն˷�Ʊ��ӡ��","Yes");
			function showBroadKdZdBill(printType,DlgMessage,submitCfm){
				var printInfo = "";
				var prtLoginAccept = "<%=loginAccept%>";
				var zhengjianType = ["���֤","����֤","���ڲ�","�۰�ͨ��֤","����֤","̨��ͨ��֤","���������","����","Ӫҵִ��","����"];
				zhengjianType["A"]="��֯��������";
				zhengjianType["B"]="��λ����֤��";
				zhengjianType["C"]="��λ֤��";
				var idType = "<%=c21%>";
				var iccidtypess=zhengjianType[idType];
				var iccidnoss=$('#idIccid').text();
				var fysqfss=$("#fysqfs").val();
				var  billArgsObj = new Object();
				
				var custName = $("#custNameText").val();
				var phoneNo = "<%=activePhone%>";
				var feeName = "����ƻ�";
			  
		 		/*2014/09/11 15:18:07 gaopeng ����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż�����
			  		���� ����豸�ն˿� 
			  	*/
		  		var kdZdFee = $("#kdZdFee").val();
				$(billArgsObj).attr("10001","<%=workNo%>");     //����
				$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10005",custName);   //�ͻ�����
				$(billArgsObj).attr("10006","����ƻ�");    //ҵ�����
				$(billArgsObj).attr("10008",phoneNo);    //�û�����
				$(billArgsObj).attr("10015", kdZdFee+"");   //���η�Ʊ���
				$(billArgsObj).attr("10016", kdZdFee+"");   //��д���ϼ�
				$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
				/*10028 10029 ����ӡ*/
			  	$(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
				$(billArgsObj).attr("10029","");	 //Ӫ������	
				$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
				$(billArgsObj).attr("10036","e916");   //��������
				$(billArgsObj).attr("10042","̨");                   //��λ
				$(billArgsObj).attr("10043","1");	                   //����
				$(billArgsObj).attr("10044",kdZdFee+"");	                //����
				/*10045����ӡ*/
				$(billArgsObj).attr("10045","");	       //IMEI
				/*�ͺŲ���*/
				$(billArgsObj).attr("10061","");	       //�ͺ�
	 			$(billArgsObj).attr("10078", "<%=ifKe%>"); //���Ʒ��		
	 			$(billArgsObj).attr("10071","6");
	 			
	 			$(billArgsObj).attr("10083", iccidtypess); //֤������
	 			$(billArgsObj).attr("10084", iccidnoss); //֤������
	 			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ
	 			$(billArgsObj).attr("10086", "�𾴵��û���������������������ʱ����Я��ONT�豸��Ѻ��Ʊ����Ч֤�������ƶ�ָ������Ӫҵ��������Ѻ�𡣿���ն�Ѻ�𷵻���ֹ���ڣ��û�������90���ڣ�����90�죩��"); //��ע
	 			$(billArgsObj).attr("10041", "����ն�Ѻ�����");           //Ʒ����� ʵ���ǿ���ն�����
	 			$(billArgsObj).attr("10065", $("#cfmLoginNew").text()); //����˺�
				var h=210;
				var w=400;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
				var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��"+"&feeName="+feeName;
				var loginAccept = prtLoginAccept;
				var path = path +"&loginAccept="+loginAccept+"&opCode=e916"+"&submitCfm=submitCfm";
				var ret = window.showModalDialog(path,billArgsObj,prop);		

			}
			
			function sfResource(){
	var myPacket = new AJAXPacket("../se276/ajax_yzResource.jsp", "����У�飬���Ժ�......");
	myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
	myPacket.data.add("customerCode",document.all.cfmLogin.value);/*�û����*/
	myPacket.data.add("productType","12");/*��Ʒ����*/
	myPacket.data.add("opCode", "<%=opCode%>");
	myPacket.data.add("yzFlag", "2");
	/*2013/3/1 ������ 9:09:16 gaopeng FTTH�������Ӳ��� addressCode ��ַ����*/
	myPacket.data.add("addressCode", document.all.standardCode.value);
	core.ajax.sendPacket(myPacket,doSfResource);
	myPacket = null;
}
function doSfResource(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var retContent = packet.data.findValueByName("retContent");
	var iType = packet.data.findValueByName("iType");
	if(retCode=="000000"){
		//��Щ�����ɱ༭
    setInputsReadOnly(false); 
		//��Щ��ť����
		document.all.isYzResource.value="0";
		rdShowMessageDialog("��Դ�ͷųɹ�",2);
		buttonShow();
	}else{
		rdShowMessageDialog("��Դ�ͷ�ʧ��",0);
		return false;
	}
}
function kdzdchange(){
	var kdzdtypes = $("#kdZd").val();
	if(kdzdtypes=="ONT") {		    
	    $("#fysqfsdisplay1").show();
	    $("#fysqfsdisplay2").show();
	    $("#kdzdfydisplay").removeAttr("colSpan");
	    FEEsqfs();
	}else {
	    $("#fysqfsdisplay1").hide();
	    $("#fysqfsdisplay2").hide();
	    $("#kdzdfydisplay").attr("colSpan","3");
		$("#kdZdFee").removeAttr("readonly");
		$("#kdZdFee").removeAttr("class");
		$("#yjfwxianshi").hide();
	}
}
var snShow="0";
var printSN=false;
function showSN(){
	var kdZd = $("#kdZd").val();
	var fysqfs = $("#fysqfs").val();
	if(snShow=="2"&&kdZd=="ONT"&&(fysqfs=="0"||fysqfs=="1")){
		$("#sntitletd").show();
		$("#sntexttd").show();
		$("#snNumber").attr("v_must","1");
		printSN=true;
	}
	else{
		$("#sntitletd").hide();
		$("#sntexttd").hide();
		$("#snNumber").attr("v_must","0");
		printSN=false;
	}
}
function FEEsqfs() {
	var fysqfs = $("#fysqfs").val();
	if(fysqfs=="0") {//Ѻ��
		$("#kdZdFee").attr("v_minvalue","50");
		$("#kdZdFee").attr("v_maxvalue","200");
		$("#kdZdFee").attr("v_must","1");
		$("#kdZdFee").val("");
		$("#kdZdFee").removeAttr("readonly");
		$("#kdZdFee").removeAttr("class");
		$("#yjfwxianshi").show();
	}
	else if(fysqfs=="999"){
		}
	else {//�Ա�
		$("#kdZdFee").removeAttr("v_minvalue");
		$("#kdZdFee").removeAttr("v_maxvalue");
		$("#kdZdFee").removeAttr("v_must");
		$("#kdZdFee").val("0");
		$("#kdZdFee").attr("readonly","readonly");
		$("#kdZdFee").attr("class","InputGrey");
		$("#yjfwxianshi").hide();
	}
}

function go_checkSNShow(){
	var packet = new AJAXPacket("/npage/s4977/ajaxCheckSnShow.jsp","���Ժ�...");
	packet.data.add("iLognAccept","<%=loginAccept%>");
	packet.data.add("iChnSource","01");
	packet.data.add("iOpCode","<%=opCode%>");
	packet.data.add("iLoginNo","<%=workNo%>");
	packet.data.add("iLoginPwd","<%=password%>");
	packet.data.add("iPhoneNo","<%=ifKe%>");
	packet.data.add("iUserPwd","");
	core.ajax.sendPacket(packet,do_checkSNShow);
	packet =null;
}

function do_checkSNShow(packet){
	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
    if(error_code=="000000"){
    	snShow=packet.data.findValueByName("vFlag");
    	showSN();
		return;
    }else{//����ʧ��
    	snShow="1";
    	showSN();
    	return false;
    }
}
		</script>
	</HEAD>
<BODY>
<DIV id=operation>
<FORM name="prodCfm" action="" method="post" width="100%">
	
	<%@ include file="/npage/include/header.jsp" %>	
	<div id="Operation_table">
		<div class="title">
			<div id="title_zi">������Ϣ</div>
	</div>
	<div id="custInfo">
		<table>
			<tr>
				<td class="blue">����˺�</td>
				<td><font id="cfmLoginNew"></font></td>
				<td class="blue">�ͻ�����</td>
				<td><font id="custName"></font></td>
			</tr>	
			<tr>
				<td class="blue">��װ��ַ</td>
				<td><font id="detailAddr"></font></td>
				<td class="blue">��ϵ�绰</td>
				<td><font id="contactPhoneNo"></font></td>
			</tr>	
			<tr>
				<td class="blue">֤������</td>
				<td><font id="idIccid"></font></td>
				<td class="blue">����״̬</td>
				<td><font id="runState"></font></td>
			</tr>	
			<tr>
				<td class="blue">��ǰ�ʷ�</td>
				<td><font id="curFee"></font></td>
				<td class="blue">��ǰ����Ԥ���</td>
				<td><font id="prepayFee"></font></td>
			</tr>	
			<tr>
				<td class="blue">��ǰ������</td>
				<td><font id="curPart"></font></td>
			</tr>				
		</table>
	</div>
	
	<div id="Operation_table">
		<div class="title">
			<div id="title_zi">��Դ��Ϣ</div>
	</div>
	<table cellSpacing=0 id="serviceNoInfo">	
		<tr>
			<td colspan=6 align="center">     
				<input type="button" class="b_text" id="query_res" name="query_res" value="С����Դ��ѯ" onClick="queryResource()" >
				<input type="button" class="b_text" id="yz_resource" name="yz_resource" value="��ԴԤռ" disabled onClick="yzResource()">
				<input type="button" class="b_text" name="sf_resource" id="sf_resource" value="��Դ�ͷ�" onClick="sfResource()">
							 <span id="keShowSpan" style="color:red;display:none;">�����������ԴԤռ����Դ�ͷ�</span>
			          <%if("1".equals(isNeedHold)) {%>
			          <span  style="color:red;">����������ԴԤռ���������п���ƻ���������Դ�ͷš�����Ҫֱ�ӹرս���</span>
			          <%}%>
			</td>   
		</tr>
			
		<tr>  
			<td class="blue">��ϵ��</td>
			<td>
				<input type="text" name="contactCustName" id="contactCustName" v_must="1" class="required" maxlength="15" value=""> 
				<font class="orange">*</font>
			</td>
			<td class="blue">��ϵ�绰</td>
			<td>
				<input type="text" name="contactPhone" id="contactPhone" v_must="1"  class="required andCellphone" value="" />
				<font class="orange">*</font>
			</td>
			<td class="blue">С������</td>
			<td>
				<input type="text" name="areaName" id="areaName" readonly />
			</td>
		</tr>  
		<tr>  
			<td class="blue">��װ��ַ</td>
			<td colspan=3>
				<input type="text" name="enter_addr" id="enter_addr" size="80" v_must="1"  value="" maxlength="100" />
				<font class="orange">*</font>
			</td>
			<td class="blue">���ž�����</td>
			<td >
				<input type="text" name="cctName" id="cctName" readonly />
			</td>
		</tr> 
		<tr>  	
			<td class="blue">ʩ��Ҫ��</td>
			<td colspan="3">
				<input type="text" name="constructRequest" id="constructRequest" size="80" />
			</td>
			<td class="blue">������</td>
			<td >
				<input type="text" name="nPartnerName" id="nPartnerName" size="20" />
			</td>
		</tr>
		<tr>
			<td class="blue">���뷽ʽ</td>
			<td> 
				<input type="text" name="enterType" id="enterType" class="InputGrey" maxlength="25" size="20" readonly />
			</td>
			<td class="blue">ԤԼʱ��</td>
			<td> 
				<input type="text" name="bookDate"  id="bookDate"  v_must="1"  v_format="yyyyMMdd" class="required" value=""/>
				<font class="orange">*(��ʽYYYYMMDD)</font>
			</td>
			<td class="blue">�ƻ�������</td>
			<td> 
				<select name="payFee" id="payFee" style="width:80px">
					<option value="0">0</option>	
					<option value="10">10</option>	
					<option value="20">20</option>	
					<option value="30">30</option>	
					<option value="40">40</option>	
					<option value="50" selected>50</option>	
				</select>
			</td>
		</tr>
		<% if("kf".equals(ifKe)&&"0".equals(c22)){%>
			     	<tr>
								<td class="blue">����ն�</td>
			        	<td>
			        		<select name = "kdZd" id="kdZd" onchange="kdzdchange();showSN();">
			        			<option value="ONT">ONT</option>
			        			<!-- <option value="CPE">CPE</option> -->
			        		<select>
			        		<font class="orange">*</font>
			        	</td>
			        	<td class="blue" id="fysqfsdisplay1">������ȡ��ʽ</td>
			        	<td id="fysqfsdisplay2">
			        		<select id ="fysqfs" name = "fysqfs" onchange="FEEsqfs();showSN();">
			        			<option value="0">Ѻ��</option>
			        			<option value="2">�Ա�</option>	
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	<td class="blue">����ն˷���</td>
			        	<td id="kdzdfydisplay" >
			        		<input type="text" name="kdZdFee" id="kdZdFee" value="" v_must ="0" v_type="money" v_minvalue="50" v_maxvalue="200" class='forMoney required'/>
			        		<font class="orange">*</font><span id="yjfwxianshi">Ѻ��Χ50-200Ԫ</span>       
			        	</td> 
			     	</tr>
			     	<tr>
						<td class="blue" id="sntitletd">S/N��</td>
			        	<td id="sntexttd">
			        		<input type="text" name="snNumber" id="snNumber" maxlength="30" value="" size="50" v_must ="1" v_type="" class='required'/><font class="orange">*</font>
			        	</td>
			        	<td></td>
			        	<td></td>
			        	<td></td>
			        	<td></td>
			     	</tr>
		<%}else{%>
			<input type="hidden" id="kdZd" name="kdZd" value="999"/>
			<input type="hidden" id="fysqfs" name="fysqfs" value="999"/>
			<input type="hidden" id="kdZdFee" name="kdZdFee" value="999"/>
		<%} %>
	</table>
	<%@ include file="/npage/common/qcommon/bd_0007.jsp" %>	<!--sys_note op_note-->
		<input type="hidden"  id="opCode" name="opCode"  value="<%=opCode%>" />
		<input type="hidden"  id="phoneNo" name="phoneNo"  value="<%=phoneNo%>" />
		<input type="hidden"  id="sysAccept" name="sysAccept"  value="<%=sysAccept%>" />
		<input type="hidden"  id="custNameText" name="custNameText"  value="" />
		<input type="hidden"  id="pageHref" name="pageHref"  value="" />
		
	<!-- ���ر� begin -->
		<!-- ��ԴԤռ״̬λ 0δԤռ��1��Ԥռ -->
		<input type="hidden"  id="isYzResource" name="isYzResource"  value="0" />
		<!-- �Ƿ��Ѿ�ѡ��С����Դ״̬λ 0δѡ��1��ѡ��-->
		<input type="hidden"  id="isGetAreaResource" name="isGetAreaResource"  value="0" />
		<!-- �����½�˺�״̬λ ���� -->
		<input type="hidden"  id="cfmLoginCheck" name="cfmLoginCheck"  value="0" />
		<!-- �����½�˺� -->
		<input type="hidden" name="cfmLogin"  id="cfmLogin"  value="<%=broadPhone%>" />
		<!-- ���� -->
		<input type="hidden"  id="noPort" name="noPort"  value="0" >
		<!-- ��֯���� -->
		<input type="hidden"  id="orgCode" name="orgCode"  value="<%=orgCode%>" >
		
		
			<!-- ����Դ��Ϣ begin-->
				<!--iIpAddrOldIP        IP��ַ��-->
				<input type="hidden" name="ipAddressOld" id="ipAddressOld" value="" >
				<!--iPortCodeOld 		�˿ڱ����-->
				<input type="hidden" name="portCodeOld" id="portCodeOld" value="" >
				<!--iDeviceCodeOld 		�豸�����-->
				<input type="hidden" name="deviceCodeOld" id="deviceCodeOld" value="" >
				<!--iDeviceInAddressOld	�豸��װ��ַ��-->
				<input type="hidden" name="deviceInAddressOld" id="deviceInAddressOld" value="" >
				<!--iCctIdOld			���žֱ����-->
				<input type="hidden" name="cctIdOld" id="cctIdOld" value="" >
				<!--partnerCode			ԭ����������-->
				<input type="hidden" name="oPartnerCode" id="oPartnerCode" value="" >
				<!--partnerCode			�º���������-->
				<input type="hidden" name="nPartnerCode" id="nPartnerCode" value="" >
				<!--iStandAddressOld	��׼��ַ���ƾ�-->
				<input type="hidden" name="standAddressOld" id="standAddressOld" value="" >
			<!-- ����Դ��Ϣ end-->
		
			<!-- ����Դ��Ϣ begin-->
				<!--iCctIdNew 		���žֱ�����-->
				<input type="hidden" name="cctId" id="cctId" value="" >
				<!--iIpAddrNewIP 	IP��ַ��-->
				<input type="hidden" name="ipAddress" id="ipAddress" value="" >
				<!--iPortCodeNew	�˿ڱ�����-->
				<input type="hidden" name="portCode" id="portCode" value="" >
				<!--iDeviceCodeNew	�豸������-->
				<input type="hidden" name="deviceCode" id="deviceCode" value="" >
				<!--iDeviceInAddressNew	�豸��װ��ַ��-->
				<input type="hidden" name="deviceInAddress" id="deviceInAddress" value="" >
				<!--iAreaCodeNew		С��������-->
				<input type="hidden" name="areaCode" id="areaCode" value="" >
				<!--iAreaNameNew		С��������-->
				<input type="hidden" name="areaName" id="areaName" value="" >
				<input type="hidden" name="areaAddr" id="areaAddr" value="" >
				<!--iStandAddress		��׼��ַ������-->
				<input type="hidden" name="standAddress" id="standAddress" value="" >
				<input type="hidden"  name="standardCode" id="standardCode" value="" >
				<!--detailAddrOld		�û���ַ������-->
				<input type="hidden" name="detailAddrOld12" id="detailAddrOld12" value="" >
				<!--deviceType		-->
				<input type="hidden" name="deviceType" id="deviceType" value="" >
				<!--portType		-->
				<input type="hidden" name="portType" id="portType" value="" >
			<!-- ����Դ��Ϣ end-->
			<input type="hidden" name="isfouyuzhan" id="isfouyuzhan" value="no" >
		 
		 	<!-- 2012-9-18 10:00:02 ���� begin-->
		 		<!--cctNameOld		���ž����ƾ�-->
				<input type="hidden" name="cctNameOld" id="cctNameOld" value="" >
				<!--appointTimeOld	ԤԼʱ���  -->
				<input type="hidden" name="appointTimeOld" id="appointTimeOld" value="" >
				<!--accessTypeOld     �������;�  -->
				<input type="hidden" name="accessTypeOld" id="accessTypeOld" value="" >
				<!--propertyUnitOld     С���������ʾ�  -->
				<input type="hidden" name="propertyUnitOld" id="propertyUnitOld" value="" >
				
				<!--deviceNameOld     �豸���ƾ�  -->
				<input type="hidden" name="deviceNameOld" id="deviceNameOld" value="" >
				<!--deviceName     deviceType �豸������  -->
		 	<!-- 2012-9-18 10:00:02 ���� end-->
		 	
		 	<!-- 2014/04/04 11:15:23 gaopeng Ʒ��sm_code -->
			<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
			<!-- 2014/07/09 9:00:26 gaopeng �������� -->
			<input type="hidden" name="sbearType" id="sbearType" value="" />
			<!-- 2014/12/05 17:25:57 gaopeng С���������� -->
			<input type="hidden" name="propertyUnit" id="propertyUnit" value="" />
			<!---- �Ƿ���ҪԤռ    0����Ҫ     1��Ҫ --->
      <input type="hidden"  id="isNeedHold" name="isNeedHold"  value="<%=isNeedHold%>" >
      
      <input type="hidden"  id="isDoNoResource" name="isDoNoResource"  value="0" >
      <input type="hidden" name="servBusiId" value="<%=servBusiId%>"/>
			<input type="hidden" name="enter_type" value=""/>
			
			<input type="hidden" name="belongCategory" value=""/><!-- ������� -->
			<input type="hidden" name="bearType" value=""/> <!-- ���ط�ʽ -->
			<input type="hidden" name="distKdCode" value=""/> <!-- С������ -->
			<input type="hidden" name="nearInfo" value=""/> <!-- С��������� -->
			
			
		<!-- ���ر� end -->
		
	<table cellSpacing=0>
		<tr id="footer">
			<td align="center"> 
				<INPUT class="b_foot_long" id="cfmBtn" onClick="doSubmit()" type="button" value="ȷ��&��ӡ" />
				<INPUT class="b_foot" onclick="doReset()" type="button" value="����"> 
				<INPUT class="b_foot" onclick="removeCurrentTab()" type="button" value="�ر�"> 
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
</DIV>
</BODY>
</HTML>
