<%
/********************
 version v2.0
 ������: si-tech
 author: liujian at 2011.12.21
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String pageHref = request.getParameter("pageHref");
	String custName = request.getParameter("custNameText");
	String sysAccept = request.getParameter("sysAccept");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");
	String loginNo = (String)session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String cfmLogin = request.getParameter("cfmLogin");//����˺�
	String orgCode = request.getParameter("orgCode");//����˺�
	String payFee = request.getParameter("payFee");//����˺�
	String ipAddressOld = request.getParameter("ipAddressOld");
	String ipAddress = request.getParameter("ipAddress");
	String constructRequest = request.getParameter("constructRequest");
	constructRequest = "�ƻ�װ��|" + constructRequest;
	System.out.println("-----liujian----constructRequest=" + constructRequest);
	String bookDate = request.getParameter("bookDate");
	String sys_note = request.getParameter("sys_note");
	String portCodeOld = request.getParameter("portCodeOld");
	String portCode = request.getParameter("portCode");
	String deviceCodeOld = request.getParameter("deviceCodeOld");
	String deviceCode = request.getParameter("deviceCode");
	String deviceInAddressOld = request.getParameter("deviceInAddressOld");
	String deviceInAddress = request.getParameter("deviceInAddress");
	String cctIdOld = request.getParameter("cctIdOld");
	String cctId = request.getParameter("cctId");
	String standAddress = request.getParameter("standAddress");
	String standAddressOld = request.getParameter("standAddressOld");
	String areaCode = request.getParameter("areaCode");
	/*2013/3/4 ����һ 15:14:32 gaopeng FTTH���� ֱ�Ӹ���ȡֵ���� ����*/
	String areaName = request.getParameter("areaAddr");
	String contactCustName = request.getParameter("contactCustName");
	String contactPhone = request.getParameter("contactPhone");
//	String sys_note = request.getParameter("sys_note");//�ն�����
	String enterType = request.getParameter("enterType");
	String detailAddrOld = request.getParameter("detailAddrOld12");
	System.out.println("---gaopeng1111111111---" + detailAddrOld );
	String enter_addr = request.getParameter("enter_addr");
  	String  retFlag="",retMsg="";
  	String  iPartCodeOld  = request.getParameter("oPartnerCode");        
  	String  iPartCodeNew = request.getParameter("nPartnerCode");
  	//liujian 2012-9-18 10:09:43 
  	String  cctNameOld  = request.getParameter("cctNameOld");        
  	String  appointTimeOld = request.getParameter("appointTimeOld");
  	String  accessTypeOld  = request.getParameter("accessTypeOld");  
  	String  cctName = request.getParameter("cctName");
  	String  deviceNameOld  = request.getParameter("deviceNameOld");
  	String  deviceType = request.getParameter("deviceType");
  	/*��ȡǰ̨Ʒ��smcode*/
  	String pubSmCode = request.getParameter("pubSmCode");
  	/*2014/07/08 14:55:15 gaopeng ��ȡǰ̨��������*/
  	String sbearType = request.getParameter("sbearType");
  	/*2014/12/05 17:26:37 gaopeng С����������*/
  	String propertyUnit = request.getParameter("propertyUnit");
  	
  	String isDoNoResource=WtcUtil.repNull((String)request.getParameter("isNeedHold"));//�Ƿ�Ԥռ��Դ��ʶ
  	
  	String servBusiId = WtcUtil.repNull(request.getParameter("servBusiId"));
  	
  	String standardCode = WtcUtil.repNull(request.getParameter("standardCode"));
  	
  	String belongCategory = WtcUtil.repNull(request.getParameter("belongCategory"));
  	String bearType = WtcUtil.repNull(request.getParameter("bearType"));
  	String distKdCode = WtcUtil.repNull(request.getParameter("distKdCode"));
  	String nearInfo = WtcUtil.repNull(request.getParameter("nearInfo"));
  	
  	String kdZd =request.getParameter("kdZd");
  	String fysqfs = request.getParameter("fysqfs");
  	String kdZdFee = request.getParameter("kdZdFee");
  	String snNumber = request.getParameter("snNumber");
  	
  	/*
  	2014/07/08 14:56:58 gaopeng R_CMI_HLJ_xueyz_2014_1644996@����ũ�����߿����WBS��ҵ��ϵͳ֧������
  	������Ʒ��Ϊ���ƶ����(kf)��ʱ�����ط�ʽΪ��1/���ߡ����ƻ�Ҳֻ����ѡ��1/���ߡ������ط�ʽΪ��0/���ߡ����ƻ�Ҳֻ����ѡ��0/���ߡ������ط�ʽΪ��1/���ߡ�ʱʩ�����еĽ������ʹ���3/���ߡ���
  	*/
  	/*
  	if("kf".equals(pubSmCode) && "1".equals(sbearType)){
  		enterType = "3";
  	}*/
		/* 
     * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
     * ����ʡ���kg������Ʒ��kh
     * �����Ʒ��Ϊ��ʡ���(kg)��ʱ���ɵ�ʱ�������ʹ���4����
     */
     /*
  	if("kg".equals(pubSmCode) || "kh".equals(pubSmCode)){
  		enterType = "4";
  	}*/
  	
	String  inputParsm [] = new String[50];
	inputParsm[0] = sysAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = loginNo;
	inputParsm[4] = loginNoPass;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = cfmLogin;
	inputParsm[8] = "";
	inputParsm[9] = "";
	inputParsm[10] = orgCode;//��֯����
	inputParsm[11] = payFee;//������
	inputParsm[12] = "";//ʵ��
	inputParsm[13] = ipAddressOld;//IP��ַ��
	inputParsm[14] = ipAddress;//IP��ַ��
	inputParsm[15] = constructRequest;//ʩ��Ҫ��
	inputParsm[16] = bookDate;//ԤԼʱ��
	inputParsm[17] = loginNo +"��"+phoneNo+"���п���ƻ�";//ϵͳ��ע
	inputParsm[18] = portCodeOld;//�˿ڱ����
	inputParsm[19] = portCode;//�˿ڱ�����
	inputParsm[20] = deviceCodeOld;//�豸�����
	inputParsm[21] = deviceCode;//�豸������
	inputParsm[22] = deviceInAddressOld;//�豸��װ��ַ��
	inputParsm[23] = deviceInAddress;//�豸��װ��ַ��
	inputParsm[24] = cctIdOld;//���žֱ����
	inputParsm[25] = cctId;//���žֱ�����
	inputParsm[26] = standAddress;//��׼��ַ������
	inputParsm[27] = standAddressOld;//��׼��ַ���ƾ�
	inputParsm[28] = areaCode;//С��������
	inputParsm[29] = areaName;//С������
	inputParsm[30] = contactCustName;//��ϵ������
	inputParsm[31] = contactPhone;//��ϵ�˵绰
	inputParsm[32] = "";//�ն�����
	inputParsm[33] = enterType;//���뷽ʽ
	inputParsm[34] = detailAddrOld;//�û���װ��ϸ��ַ��
	inputParsm[35] = enter_addr;//�û���װ��ϸ��ַ��
	inputParsm[36] = iPartCodeOld;//�û���װ��ϸ��ַ��
	inputParsm[37] = iPartCodeNew;//�û���װ��ϸ��ַ��
	//liujian 2012-9-18 10:11:24
	inputParsm[38] = cctNameOld;//���ž����ƾ�
	inputParsm[39] = cctName;//���ž�������
	inputParsm[40] = deviceNameOld;//�豸���ƾ�
	inputParsm[41] = deviceType;//�豸������
	inputParsm[42] = accessTypeOld;//���뷽ʽ��
	inputParsm[43] = appointTimeOld;//ԤԼʱ���
	inputParsm[44] = propertyUnit;//С����������
	
	inputParsm[45] = belongCategory;
	inputParsm[46] = bearType;
	inputParsm[47] = distKdCode;
	inputParsm[48] = nearInfo;
	if("999".equals(kdZd)&&"999".equals(fysqfs)&&"999".equals(kdZdFee)){
		inputParsm[49]="";
	}
	else{
		inputParsm[49] = kdZd+"|"+fysqfs+"|"+kdZdFee+"|"+snNumber;
	}
	
	
	for(int i=0;i<inputParsm.length;i++) {
		System.out.println("---liujian---[" + i + "]=" + inputParsm[i] );
	}
%>
	
	<wtc:service name="se916Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeQry" retmsg="retMsgQry" outnum="42">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
		<wtc:param value="<%=inputParsm[8]%>"/>
		<wtc:param value="<%=inputParsm[9]%>"/>
		<wtc:param value="<%=inputParsm[10]%>"/>
		<wtc:param value="<%=inputParsm[11]%>"/>
		<wtc:param value="<%=inputParsm[12]%>"/>
		<wtc:param value="<%=inputParsm[13]%>"/>
		<wtc:param value="<%=inputParsm[14]%>"/>
		<wtc:param value="<%=inputParsm[15]%>"/>
		<wtc:param value="<%=inputParsm[16]%>"/>
		<wtc:param value="<%=inputParsm[17]%>"/>
		<wtc:param value="<%=inputParsm[18]%>"/>
		<wtc:param value="<%=inputParsm[19]%>"/>
		<wtc:param value="<%=inputParsm[20]%>"/>
		<wtc:param value="<%=inputParsm[21]%>"/>
		<wtc:param value="<%=inputParsm[22]%>"/>
		<wtc:param value="<%=inputParsm[23]%>"/>
		<wtc:param value="<%=inputParsm[24]%>"/>
		<wtc:param value="<%=inputParsm[25]%>"/>
		<wtc:param value="<%=inputParsm[26]%>"/>
		<wtc:param value="<%=inputParsm[27]%>"/>
		<wtc:param value="<%=inputParsm[28]%>"/>
		<wtc:param value="<%=inputParsm[29]%>"/>
		<wtc:param value="<%=inputParsm[30]%>"/>
		<wtc:param value="<%=inputParsm[31]%>"/>
		<wtc:param value="<%=inputParsm[32]%>"/>
		<wtc:param value="<%=inputParsm[33]%>"/>
		<wtc:param value="<%=inputParsm[34]%>"/>
		<wtc:param value="<%=inputParsm[35]%>"/>
		<wtc:param value="<%=inputParsm[36]%>"/>
		<wtc:param value="<%=inputParsm[37]%>"/>
		<wtc:param value="<%=inputParsm[38]%>"/>
		<wtc:param value="<%=inputParsm[39]%>"/>
		<wtc:param value="<%=inputParsm[40]%>"/>
		<wtc:param value="<%=inputParsm[41]%>"/>
		<wtc:param value="<%=inputParsm[42]%>"/>
		<wtc:param value="<%=inputParsm[43]%>"/>
		<wtc:param value="<%=inputParsm[44]%>"/>
		<wtc:param value="<%=inputParsm[45]%>"/>
		<wtc:param value="<%=inputParsm[46]%>"/>
		<wtc:param value="<%=inputParsm[47]%>"/>
		<wtc:param value="<%=inputParsm[48]%>"/>
		<wtc:param value="<%=inputParsm[49]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
	
	
<%
 
	String errCode = retCodeQry;
	String errMsg = retMsgQry;
	if(errCode.equals("000000")){
%>
	<script language="JavaScript">
		rdShowMessageDialog("�����ɹ���");
		var printInfo = "";
		var prtLoginAccept = '<%=sysAccept%>';
		var custName = '<%=custName%>';
		var payFee = "<%=payFee%>";
		var broadNo = '<%=cfmLogin%>';
		var printStr = "�ƻ�������";
		var opName = "����ƻ�";
		printInfo += '<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>' + '|';
		printInfo += '<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>' + '|';
		printInfo += '<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>' + '|';
		
		printInfo += prtLoginAccept + "|";
		printInfo += custName + "|";
		printInfo += " " + "|";
		printInfo += " " + "|";
		printInfo += broadNo + "|";
		printInfo += " " + "|";
		printInfo += payFee + "|";
		printInfo += payFee + "|";
		printInfo += opName + "|";
		printInfo += printStr + "��" + payFee + "Ԫ" + "~";
		/* 
     * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
     * ����ʡ���kg������Ʒ��kh
     */
		if("<%=pubSmCode%>" == "kf" || "<%=pubSmCode%>" == "kg" || "<%=pubSmCode%>" == "kh" || "<%=pubSmCode%>" == "ki"){
			printInfo += "�ͷ����ߣ�10086" + "|";
		}else{
			printInfo += "�ͷ����ߣ�10050" + "~";
			printInfo += "��ַ��http://www.10050.net" + "|";
		}
		
	//	if(Number(payFee)==0){
			//0Ԫ����ӡ��Ʊ
	//		return;
	//	}
		
		var  billArgsObj = new Object();
	    $(billArgsObj).attr("10001","<%=loginNo%>");       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",custName); //�ͻ�����
 		$(billArgsObj).attr("10006",opName); //ҵ�����
 		$(billArgsObj).attr("10008","<%=phoneNo%>"); //�û�����
		$(billArgsObj).attr("10015", payFee); //���η�Ʊ���(Сд)��
		$(billArgsObj).attr("10016", payFee); //��д���ϼ�
		
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		$(billArgsObj).attr("10017",sumtypes1); //���νɷ��ֽ�
 		$(billArgsObj).attr("10018",sumtypes2); //֧Ʊ
 		$(billArgsObj).attr("10019",sumtypes3); //ˢ��
 		$(billArgsObj).attr("10021",payFee); //������
 		$(billArgsObj).attr("10030",prtLoginAccept); //��ˮ��--ҵ����ˮ
 		$(billArgsObj).attr("10036","<%=opCode%>"); //��������
 		
 		 var path = "";
 		/* 
     * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
     * ����ʡ���kg������Ʒ��kh
     */
 		if("<%=pubSmCode%>" == "kf" || "<%=pubSmCode%>" == "kg" || "<%=pubSmCode%>" == "kh" || "<%=pubSmCode%>" == "ki"){
 			//path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "��Ʊ��ӡ";
 					//��Ʊ��Ŀ�޸�Ϊ��·��
			 path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "��Ʊ��ӡ";
	
		}else{
			path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "��Ʊ��ӡ";
		}
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var loginAccept = prtLoginAccept;
		var path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm&phoneNo=<%=phoneNo%>";
		var ret = window.showModalDialog(path,billArgsObj,prop);
		location.href='<%=pageHref%>';
	</script>	
<%
	} else{%>
	 <script language="JavaScript">
	 	function realeaseResource()
{	
				var myPacket = new AJAXPacket("/npage/se276/ajax_yzResource.jsp", "����У�飬���Ժ�......");
				  	myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
						myPacket.data.add("customerCode","<%=cfmLogin%>");/*�û����*/
						myPacket.data.add("productType","12");/*��Ʒ����*/
						myPacket.data.add("opCode", "<%=opCode%>");
						myPacket.data.add("yzFlag", "2");
						/*2013/3/1 ������ 9:09:16 gaopeng FTTH�������Ӳ��� addressCode ��ַ����*/
						myPacket.data.add("addressCode", "<%=standardCode%>");
				   core.ajax.sendPacket(myPacket,doRealeaseResource);
		       myPacket = null;			 	
} 
function doRealeaseResource(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
     if(retCode=="000000"){
      		rdShowMessageDialog("��Դ�ͷųɹ�");
     }
     else{ 
         	rdShowMessageDialog("��Դ�ͷ�ʧ��"); 
     }
}

		rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
		if("<%=isDoNoResource%>" =="1"){
    	realeaseResource();//�ͷ���Ԥռ����Դ
    }
    
		location.href='<%=pageHref%>';
	 </script>
<%
	}
%>

