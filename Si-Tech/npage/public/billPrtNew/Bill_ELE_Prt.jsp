<%
/********************
 *������: si-tech
 *create by hejwa @ 2016/11/19 9:45:38
 * ��Ʊ��Ŀ
 ********************/
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>


<HTML>
<HEAD>

<%

	
	String billType = "2";	//��Ʊ
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	//String password = (String)session.getAttribute("password");
	String printMethod = request.getParameter("printMethod") == null ? "1" : request.getParameter("printMethod");
	
	String dlgMsg = request.getParameter("dlgMsg") == null ? "�Ƿ��ӡƱ�ݣ�" : request.getParameter("dlgMsg");
	String feeName = request.getParameter("feeName") == null ? "��Ʊ��" : request.getParameter("feeName");	
	
	//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
	String infoStr = request.getParameter("infoStr");
	String opCode = request.getParameter("opCode");
	String submitCfm = WtcUtil.repNull(request.getParameter("submitCfm"));

	String loginAccept = request.getParameter("loginAccept");

	String queryString = request.getQueryString();  

%>

</HEAD>
<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>��ӡƱ�ݣ�<%=feeName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
	</head>
<FORM method=post name="spubPrint">
  <!------------------------------------------------------>
  <div class="popup" id="div_invoice">
			<div class="popup_ok" id="rdImage" align=center>
		  	<div class="popup_zi orange" id="message">�Ƿ��ӡƱ�ݣ�</div>
		  </div>

	    <div align="center" style="display:none" id="div_billprt">
					<input class="b_foot" id="btn_Elec_inv" onClick="Bill_prt('EI')"   type="button" value="��ӡ���ӷ�Ʊ" />
					<input class="b_foot" id="btn_Pape_inv" onClick="Paper_invoice('EP')" type="button" value="��ӡֽ�ʷ�Ʊ" />
				  <input class="b_foot" id="btn_Pape_rec" onClick="Bill_prt('PR')"  type="button" value="��ӡֽ���վ�" />
	    </div>
	 </div>
</FORM>
</BODY>

<!-------�����ӡ�ؼ�---------->
<OBJECT
	classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
	codebase="/ocx/PrintEx.dll#version=1,1,0,5" 
	id="printctrl"
	style="DISPLAY: none"
	VIEWASTEXT
>
</OBJECT>

<%@ include file="PrintBillNum_ELE.jsp" %> 
<SCRIPT language="JavaScript" >

	
document.onkeydown = function() {
	if (window.event.keyCode == 27) {
		window.close();
	}  
};
		
$(document).ready(function(){
	

	
	$("#message").text("<%=dlgMsg%>");
	
	if("REC"==parm11213){//��ӡ�վ�
		$("#btn_Elec_inv").hide();
		$("#btn_Pape_inv").hide();
		$("#btn_Pape_rec").show();
	}else{//��ӡ��Ʊ
		
		$("#btn_Elec_inv").show();
		$("#btn_Pape_inv").show();
		if(parm11214=="HID_PR"){
			$("#btn_Pape_rec").hide();
		}
			if(typeof(parm10015)!="undefined"){
				if(Number(parm10015)!=0){
				}else{
					//0Ԫ��Ʊ����ӡֱ�ӹر� ������NaN���  ���Դ�ӡ�վݣ�ֻ���վݵ������ִ�д��߼�
					window.close();
				}
			}else{
				window.close();
			}
	}
	
	$("#div_billprt").show();
	
	go_ajax_BillAction();
});

/*
 * ��ѯ�ֻ������Ӧ��Ʒ�ƣ����Ʒ��ʹ��
 * ֧�Ŵ�ӡ���ӷ�Ʊ��Χ���£� 
		1) kf�ƶ���� 
		2) kg�ƶ������������ 
		3) ki���ſ�� 
	����ҵ�񲻿���֧�ŵ��ӷ�Ʊ�� 
		1) kd�й��ƶ���ͨ��� 
		2) ke������� 
		3) kh������ͨ��� 
		
 * ֻ�п��������Բ�ѯ�� kd ke kh Ʒ�ƣ���Ӱ�������ֻ��ŵ�Ʒ�Ƶ��ӷ�Ʊ��ӡ
 */
function go_ajax_BillAction(){
    var packet = new AJAXPacket("ajax_BillAction.jsp","���Ժ�...");
        packet.data.add("opCode",parm10036);//
        packet.data.add("phoneNo",parm10008);//
    core.ajax.sendPacket(packet,do_ajax_BillAction);
    packet =null;
}
function do_ajax_BillAction(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//
    		var smCode =  packet.data.findValueByName("smCode");//
    		//kd ke kh ��֧�ֵ��ӷ�Ʊ
    		if("kd"==smCode||"ke"==smCode||"kh"==smCode){
    			$("#btn_Elec_inv").hide();
    		}
    }

}


			var s_old_number = "";//��Ʊ����
			var s_old_code = "";//��Ʊ����
			var s_old_accept = "";
			
//���Ϊ���������ж���ҵ�����ͣ���ҵ����ֽ�ʳ���ֻ�ܴ�ӡֽ�ʣ���ҵ�ǵ��ӳ���ֻ���ǵ���
function go_EL_check(opr){
		var ret_val = true;
		if(parm10072=="2"&&opr!="PR"){
			//����ҵ���Ҵ�ӡ��Ʊ
			var inDbPacketss = new AJAXPacket("getOldNumber.jsp","����ȡ��Ʊ��Ϣ�����Ժ�......");
					inDbPacketss.data.add("liushui", parm10030);
					inDbPacketss.data.add("z_loginAccept", parm11215);
					inDbPacketss.data.add("old_ym", parm11216);
					inDbPacketss.data.add("opCode", parm10036);
					inDbPacketss.data.add("workno", parm10001);
					inDbPacketss.data.add("jiner", parm10015);
					inDbPacketss.data.add("shuilv", parm10062);
					
					core.ajax.sendPacket(inDbPacketss, function(packet){
							
							var retCode=packet.data.findValueByName("retCode");
							var retMsge=packet.data.findValueByName("retMsge");
					    
					    if(retCode == "000000"){
									s_old_number = packet.data.findValueByName("s_old_number");
									s_old_code   = packet.data.findValueByName("s_old_code");
									s_old_accept = packet.data.findValueByName("s_old_accept");
									
									//EI  ������ӷ�Ʊ
									//EP  ���ֽ�ʷ�Ʊ
									//PR  ���ֽ���վ�
								
									if(s_old_accept==""){
											rdShowMessageDialog("δ��ѯ����ˮ["+parm10030+"]�ķ�Ʊ������Ϣ");
											ret_val = false;
									}else{
											var ei_flag =packet.data.findValueByName("ei_flag");//�Ƿ�Ϊ���ӷ�Ʊ��־λ�����ݼƷѷ����ѯ�����Ƿ����e�ж�
											
											if("true"==ei_flag){
													if("EI"!=opr){
														rdShowMessageDialog("��ҵ��Ϊ���ӷ�Ʊ������ֻ�ܴ�ӡ���ӷ�Ʊ");
														ret_val = false;
													}
											}
									}
							}else{
									rdShowMessageDialog("����sInvAcceptQry��ѯ����"+retCode+"��"+retMsge,1);
									ret_val = false;
							}
	
					});
					inDbPacketss = null;
		}
		return ret_val;
}



//��ӡֽ�ʷ�Ʊ
function Paper_invoice(opr){
	
		if(!go_EL_check(opr)) return ;
		
 		var inDbPacketss = new AJAXPacket("ajax_Bill_Preholding.jsp","����ȡ��Ʊ��Ϣ�����Ժ�......");
				inDbPacketss.data.add("liushui", parm10030);
				inDbPacketss.data.add("opcode", parm10036);
				inDbPacketss.data.add("workno", parm10001);
				inDbPacketss.data.add("time", "");
		if(parm10008=="") {
				inDbPacketss.data.add("phonenos", "-1");
				inDbPacketss.data.add("id_no", "-1");
				inDbPacketss.data.add("contract_no", "-1");		
		}else {
				inDbPacketss.data.add("phonenos", parm10008);
				inDbPacketss.data.add("id_no", id_noss);
				inDbPacketss.data.add("contract_no", contract_no);
		}
				inDbPacketss.data.add("zhipiaohao", parm10013);
				inDbPacketss.data.add("fapiaohao", "");
				inDbPacketss.data.add("fapiaodai", "");
				inDbPacketss.data.add("sm_name", smcodes);
		
		if(billtypemode=="model4") {
				model4moneyxiao=(Number(parm10020)-Number(INNET_FEEshue)).toFixed(2)+","+(Number(parm10021)-Number(HAND_FEEshue)).toFixed(2)+","+parm10022+","+(Number(parm10023)-Number(DEPOSITshue)).toFixed(2)+","+(Number(parm10024)-Number(SIM_FEEshue)).toFixed(2)+","+parm10025+","+parm10026+","+parm10027;
				model4moneyda=digit_uppercase((Number(parm10020)-Number(INNET_FEEshue)))+","+digit_uppercase((Number(parm10021)-Number(HAND_FEEshue)))+","+digit_uppercase(parm10022)+","+digit_uppercase((Number(parm10023)-Number(DEPOSITshue)))+","+digit_uppercase((Number(parm10024)-Number(SIM_FEEshue)))+","+digit_uppercase(parm10025)+","+digit_uppercase(parm10026)+","+digit_uppercase(parm10027);
				model4notes+=getBillPart("10028")+""+parm10028+"<p>"+getBillPart("10047")+""+parm10029+"<p>"+getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+"<p>";
				
			if(parm10049=="BX" || parm10049=="BY") {
					model4notes+=getBillPart("10050")+""+parm10050+"<p>";
					model4notes+=getBillPart("10051")+""+parm10051+"<p>";
		      model4notes+=getBillPart("10052")+""+parm10052+"<p>";		
		      model4notes+=getBillPart("10053")+""+parm10053+"<p>";
		      model4notes+=getBillPart("10054")+""+parm10054+"<p>";
		      model4notes+=getBillPart("10055")+""+parm10055+"<p>";
		      model4notes+=getBillPart("10056")+""+parm10056+"<p>";
		      model4notes+=getBillPart("10057")+""+parm10057+"<p>";
		      model4notes+=getBillPart("10058")+""+parm10058+"<p>";
		      model4notes+=getBillPart("10059")+""+parm10059+"<p>";
		      model4notes+=getBillPart("10060")+""+parm10060+"<p>";	
		      model4notes+=getBillPart("10064")+""+parm10064+"<p>";	
			}
			
			if(		parm10072=="2" 
					&& Number(parm10020)=="0" 
					&& Number(parm10021)=="0" 
					&& Number(parm10022)=="0" 
					&& Number(parm10023)=="0" 
					&& Number(parm10024)=="0" 
					&& Number(parm10025)=="0" 
					&& Number(parm10026)=="0" 
					&& Number(parm10027)=="0"
				) {
			
					inDbPacketss.data.add("jinexiao", parm10015);
					inDbPacketss.data.add("jineda", digit_uppercase(parm10016));		
					inDbPacketss.data.add("beizhu", model4notes);
					inDbPacketss.data.add("biaozhi", "6");
					inDbPacketss.data.add("zengzhisinfo", "");
					inDbPacketss.data.add("shuilv","0");
					inDbPacketss.data.add("shuie", "0");
					inDbPacketss.data.add("zhangqi", "");
					inDbPacketss.data.add("username", parm10005);
					inDbPacketss.data.add("fapiaoleixing", "0");
					inDbPacketss.data.add("huowuguige", "�˷�");
					inDbPacketss.data.add("xinghao", parm10061);
					inDbPacketss.data.add("danwei", parm10042);
					inDbPacketss.data.add("shuliang", parm10043);
					inDbPacketss.data.add("danjia", parm10015);
			
			}else {
			
					inDbPacketss.data.add("jinexiao", model4moneyxiao);
					inDbPacketss.data.add("jineda", model4moneyda);
					
					inDbPacketss.data.add("beizhu", model4notes);
					inDbPacketss.data.add("biaozhi", "6");
					inDbPacketss.data.add("zengzhisinfo", "");
					inDbPacketss.data.add("shuilv",INNET_FEEshuilv+","+HAND_FEEshuilv+",0,"+DEPOSITshuilv+","+SIM_FEEshuilv+",0,0,0");
					inDbPacketss.data.add("shuie", INNET_FEEshue+","+HAND_FEEshue+",0,"+DEPOSITshue+","+SIM_FEEshue+",0,0,0");
					inDbPacketss.data.add("zhangqi", "");
					inDbPacketss.data.add("username", parm10005);
					inDbPacketss.data.add("fapiaoleixing", "0");
					inDbPacketss.data.add("huowuguige", "0001,0002,0003,0004,0005,0006,0007,0008");
								
					inDbPacketss.data.add("xinghao", parm10061);
					inDbPacketss.data.add("danwei", parm10042);
					inDbPacketss.data.add("shuliang", parm10043);
					inDbPacketss.data.add("danjia", model4moneyxiao);
			
			}
		}
		
		else if(billtypemode=="model1"){
			  model1moneyxiao=parm10016;
			  model1moneyda=digit_uppercase(parm10016);
			  model1notes+=getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+"<p>";
			  model1notes+=getBillPart("10038")+""+parm10038+"<p>"+getBillPart("10039")+""+parm10039+"<p>"+getBillPart("10040")+""+parm10040+"<p>";		  
			  if(parm10049=="BX" || parm10049=="BY") {
						model1notes+=getBillPart("10050")+""+parm10050+"<p>";
						model1notes+=getBillPart("10051")+""+parm10051+"<p>";
			      model1notes+=getBillPart("10052")+""+parm10052+"<p>";		
			      model1notes+=getBillPart("10053")+""+parm10053+"<p>";
			      model1notes+=getBillPart("10054")+""+parm10054+"<p>";
			      model1notes+=getBillPart("10055")+""+parm10055+"<p>";
			      model1notes+=getBillPart("10056")+""+parm10056+"<p>";
			      model1notes+=getBillPart("10057")+""+parm10057+"<p>";
			      model1notes+=getBillPart("10058")+""+parm10058+"<p>";
			      model1notes+=getBillPart("10059")+""+parm10059+"<p>";
			      model1notes+=getBillPart("10060")+""+parm10060+"<p>";	
			      model1notes+=getBillPart("10064")+""+parm10064+"<p>";	
				}
				inDbPacketss.data.add("jinexiao", model1moneyxiao);
				inDbPacketss.data.add("jineda", model1moneyda);
				inDbPacketss.data.add("beizhu", model1notes);
				inDbPacketss.data.add("biaozhi", "6");
				inDbPacketss.data.add("zengzhisinfo", "");
				inDbPacketss.data.add("shuilv", parm10062);
				inDbPacketss.data.add("shuie", parm10063);
				inDbPacketss.data.add("zhangqi", "");
	
				inDbPacketss.data.add("username", parm10005);
				inDbPacketss.data.add("fapiaoleixing", "0");
				inDbPacketss.data.add("huowuguige", "�ϼ�");
				inDbPacketss.data.add("xinghao", parm10061);
				inDbPacketss.data.add("danwei", parm10042);
				inDbPacketss.data.add("shuliang", parm10043);
				inDbPacketss.data.add("danjia", parm10044);			
		}
		
		else if(billtypemode=="model6") {
				model6moneyxiao=parm10076;
				model6notes+=getBillPart("10028")+""+parm10028+"<p>"+getBillPart("10047")+""+parm10029+"<p>";
				
				if(parm10049=="BX" || parm10049=="BY") {
					model6notes+=getBillPart("10050")+""+parm10050+"<p>";
					model6notes+=getBillPart("10051")+""+parm10051+"<p>";
		      model6notes+=getBillPart("10052")+""+parm10052+"<p>";		
		      model6notes+=getBillPart("10053")+""+parm10053+"<p>";
		      model6notes+=getBillPart("10054")+""+parm10054+"<p>";
		      model6notes+=getBillPart("10055")+""+parm10055+"<p>";
		      model6notes+=getBillPart("10056")+""+parm10056+"<p>";
		      model6notes+=getBillPart("10057")+""+parm10057+"<p>";
		      model6notes+=getBillPart("10058")+""+parm10058+"<p>";
		      model6notes+=getBillPart("10059")+""+parm10059+"<p>";
		      model6notes+=getBillPart("10060")+""+parm10060+"<p>";	
		      model6notes+=getBillPart("10064")+""+parm10064+"<p>";	
				}
		  
			var smmodel6= new Array();
			smmodel6=parm10076.split(",");

			for(var smsd=0;smsd<smmodel6.length;smsd++) {					
				model6moneyda+=digit_uppercase(smmodel6[smsd])+",";												
			}
			model6moneyda=model6moneyda.substr(0,model6moneyda.length-1);
			  
			inDbPacketss.data.add("jinexiao", model6moneyxiao);
			inDbPacketss.data.add("jineda", model6moneyda);
			inDbPacketss.data.add("beizhu", "");
			inDbPacketss.data.add("biaozhi", "6");
			inDbPacketss.data.add("zengzhisinfo", "");
			inDbPacketss.data.add("shuilv",parm10062);
			inDbPacketss.data.add("shuie",parm10063);
			inDbPacketss.data.add("zhangqi", "");
			
			inDbPacketss.data.add("username", parm10005);
			inDbPacketss.data.add("fapiaoleixing", "0");
			inDbPacketss.data.add("huowuguige", parm10041);
			inDbPacketss.data.add("xinghao", parm10061);
			inDbPacketss.data.add("danwei", parm10042);
			inDbPacketss.data.add("shuliang", parm10043);
			inDbPacketss.data.add("danjia", parm10076);
		
		}
		
		else if(billtypemode=="model7") {

			model7moneyxiao=(Number(parm10044)-Number(SIM_FEEshue));
			model7moneyda=digit_uppercase((Number(parm10044)-Number(SIM_FEEshue)));
			model7notes+=getBillPart("10028")+""+parm10028+"<p>"+getBillPart("10047")+""+parm10029+"<p>";
			
			if(parm10049=="BX" || parm10049=="BY") {
				model7notes+=getBillPart("10050")+""+parm10050+"<p>";
				model7notes+=getBillPart("10051")+""+parm10051+"<p>";
	      model7notes+=getBillPart("10052")+""+parm10052+"<p>";		
	      model7notes+=getBillPart("10053")+""+parm10053+"<p>";
	      model7notes+=getBillPart("10054")+""+parm10054+"<p>";
	      model7notes+=getBillPart("10055")+""+parm10055+"<p>";
	      model7notes+=getBillPart("10056")+""+parm10056+"<p>";
	      model7notes+=getBillPart("10057")+""+parm10057+"<p>";
	      model7notes+=getBillPart("10058")+""+parm10058+"<p>";
	      model7notes+=getBillPart("10059")+""+parm10059+"<p>";
	      model7notes+=getBillPart("10060")+""+parm10060+"<p>";	
	      model7notes+=getBillPart("10064")+""+parm10064+"<p>";	
			}
		  
			  
			inDbPacketss.data.add("jinexiao", model7moneyxiao);
			inDbPacketss.data.add("jineda", model7moneyda);
			inDbPacketss.data.add("beizhu", "");
			inDbPacketss.data.add("biaozhi", "6");
			inDbPacketss.data.add("zengzhisinfo", "");
			inDbPacketss.data.add("shuilv",SIM_FEEshuilv);
			inDbPacketss.data.add("shuie",SIM_FEEshue);
			inDbPacketss.data.add("zhangqi", "");
			
			inDbPacketss.data.add("username", parm10005);
			inDbPacketss.data.add("fapiaoleixing", "0");
			inDbPacketss.data.add("huowuguige", parm10041);
			inDbPacketss.data.add("xinghao", parm10061);
			inDbPacketss.data.add("danwei", parm10042);
			inDbPacketss.data.add("shuliang", parm10043);
			inDbPacketss.data.add("danjia", (Number(parm10044)-Number(SIM_FEEshue)));
		
		}
		
		if(billtypemode=="model8") {
			if(parm10079=="1") {
				model8moneyxiao=parm10080+","+parm10067;
				model8moneyda=digit_uppercase(parm10080)+","+digit_uppercase(parm10067);
			}else {
				model8moneyxiao=parm10066+","+parm10067;
				model8moneyda=digit_uppercase(parm10066)+","+digit_uppercase(parm10067);
			}

			model8notes+=getBillPart("10065")+""+parm10065+"<p>"+getBillPart("10068")+"<p>";
			if(parm10049=="BX" || parm10049=="BY") {
				model8notes+=getBillPart("10050")+""+parm10050+"<p>";
				model8notes+=getBillPart("10051")+""+parm10051+"<p>";
	      model8notes+=getBillPart("10052")+""+parm10052+"<p>";		
	      model8notes+=getBillPart("10053")+""+parm10053+"<p>";
	      model8notes+=getBillPart("10054")+""+parm10054+"<p>";
	      model8notes+=getBillPart("10055")+""+parm10055+"<p>";
	      model8notes+=getBillPart("10056")+""+parm10056+"<p>";
	      model8notes+=getBillPart("10057")+""+parm10057+"<p>";
	      model8notes+=getBillPart("10058")+""+parm10058+"<p>";
	      model8notes+=getBillPart("10059")+""+parm10059+"<p>";
	      model8notes+=getBillPart("10060")+""+parm10060+"<p>";	
	      model8notes+=getBillPart("10064")+""+parm10064+"<p>";	
			}
			
			inDbPacketss.data.add("jinexiao", model8moneyxiao);
			inDbPacketss.data.add("jineda", model8moneyda);
			
			inDbPacketss.data.add("beizhu", model8notes);
			inDbPacketss.data.add("biaozhi", "6");
			inDbPacketss.data.add("zengzhisinfo", "");
			
			if(parm10079=="1") {
				inDbPacketss.data.add("shuilv", parm10062+",0");
				inDbPacketss.data.add("shuie", parm10063+",0");
			}else {
				inDbPacketss.data.add("shuilv", "0,0");
				inDbPacketss.data.add("shuie", "0,0");
			}
			inDbPacketss.data.add("zhangqi", "");
			
			inDbPacketss.data.add("username", parm10005);
			inDbPacketss.data.add("fapiaoleixing", "0");
			inDbPacketss.data.add("huowuguige", "��װ��,����ײ�Ԥ���");
			inDbPacketss.data.add("xinghao", parm10061);
			inDbPacketss.data.add("danwei", parm10042);
			inDbPacketss.data.add("shuliang", parm10043);
			inDbPacketss.data.add("danjia", model8moneyxiao);
		}
		
		  else if(billtypemode=="model12") {
				model12moneyxiao=parm10015;
				model12moneyda=digit_uppercase(parm10016);
				model12notes+=getBillPart("10028")+""+parm10028+"<p>"+getBillPart("10047")+""+parm10029+"<p>"+getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+"<p>";
				
				
				
				inDbPacketss.data.add("jinexiao", model12moneyxiao);
				inDbPacketss.data.add("jineda", model12moneyda);
				
				inDbPacketss.data.add("beizhu", model12notes);
				inDbPacketss.data.add("biaozhi", "6");
				inDbPacketss.data.add("zengzhisinfo", "");
				inDbPacketss.data.add("shuilv","0");
				inDbPacketss.data.add("shuie", "0");
				inDbPacketss.data.add("zhangqi", "");
				inDbPacketss.data.add("username", parm10005);
				inDbPacketss.data.add("fapiaoleixing", "0");
				inDbPacketss.data.add("huowuguige", "��ֵ���");
							
				inDbPacketss.data.add("xinghao", parm10061);
				inDbPacketss.data.add("danwei", parm10042);
				inDbPacketss.data.add("shuliang", parm10043);
				inDbPacketss.data.add("danjia", model12moneyxiao);
			}
			else if(billtypemode=="model13") {
			 
			 	model13moneyxiao=parm10076;
				//model13notes+=getBillPart("10028")+""+parm10028+"<p>"+getBillPart("10047")+""+parm10029+"<p>";
			  model13notes+=getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+"<p>";
			  model13notes+=getBillPart("10038")+""+parm10038+"<p>"+getBillPart("10039")+""+parm10039+"<p>"+getBillPart("10040")+""+parm10040+"<p>";		 
				
				if(parm10049=="BX" || parm10049=="BY") {
					model13notes+=getBillPart("10050")+""+parm10050+"<p>";
					model13notes+=getBillPart("10051")+""+parm10051+"<p>";
			    model13notes+=getBillPart("10052")+""+parm10052+"<p>";		
			    model13notes+=getBillPart("10053")+""+parm10053+"<p>";
			    model13notes+=getBillPart("10054")+""+parm10054+"<p>";
			    model13notes+=getBillPart("10055")+""+parm10055+"<p>";
			    model13notes+=getBillPart("10056")+""+parm10056+"<p>";
			    model13notes+=getBillPart("10057")+""+parm10057+"<p>";
			    model13notes+=getBillPart("10058")+""+parm10058+"<p>";
			    model13notes+=getBillPart("10059")+""+parm10059+"<p>";
			    model13notes+=getBillPart("10060")+""+parm10060+"<p>";	
			    model13notes+=getBillPart("10064")+""+parm10064+"<p>";	
				}
			  
				var smmodel13= new Array();
				smmodel13=parm10076.split(",");
		
				for(var smsd=0;smsd<smmodel13.length;smsd++) {					
					model13moneyda+=digit_uppercase(smmodel13[smsd])+",";												
				}
				model13moneyda=model13moneyda.substr(0,model13moneyda.length-1);
				  
				inDbPacketss.data.add("jinexiao", model13moneyxiao);
				inDbPacketss.data.add("jineda", model13moneyda);
				inDbPacketss.data.add("beizhu", "");
				inDbPacketss.data.add("biaozhi", "6");
				inDbPacketss.data.add("zengzhisinfo", "");
				inDbPacketss.data.add("shuilv",parm10062);
				inDbPacketss.data.add("shuie",parm10063);
				inDbPacketss.data.add("zhangqi", "");
				
				inDbPacketss.data.add("username", parm10005);
				inDbPacketss.data.add("fapiaoleixing", "0");
				inDbPacketss.data.add("huowuguige", parm10041);
				inDbPacketss.data.add("xinghao", parm10061);
				inDbPacketss.data.add("danwei", parm10042);
				inDbPacketss.data.add("shuliang", parm10043);
				inDbPacketss.data.add("danjia", parm10044);
			 
			 }
		 else if(billtypemode=="model14") {
		 
			 	model14moneyxiao=(Number(parm10020)-Number(INNET_FEEshue)).toFixed(2)+","+(Number(parm10021)-Number(HAND_FEEshue)).toFixed(2)+","+parm10022+","+(Number(parm10023)-Number(DEPOSITshue)).toFixed(2)+","+(Number(parm10024)-Number(SIM_FEEshue)).toFixed(2)+","+parm10025+","+parm10026+","+parm10027;
				model14moneyda=digit_uppercase((Number(parm10020)-Number(INNET_FEEshue)))+","+digit_uppercase((Number(parm10021)-Number(HAND_FEEshue)))+","+digit_uppercase(parm10022)+","+digit_uppercase((Number(parm10023)-Number(DEPOSITshue)))+","+digit_uppercase((Number(parm10024)-Number(SIM_FEEshue)))+","+digit_uppercase(parm10025)+","+digit_uppercase(parm10026)+","+digit_uppercase(parm10027);
				model14notes+=getBillPart("10028")+""+parm10028+"<p>"+getBillPart("10047")+""+parm10029+"<p>"+getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+"<p>";
				
				if(parm10049=="BX" || parm10049=="BY") {
					model14notes+=getBillPart("10050")+""+parm10050+"<p>";
					model14notes+=getBillPart("10051")+""+parm10051+"<p>";
		      model14notes+=getBillPart("10052")+""+parm10052+"<p>";		
		      model14notes+=getBillPart("10053")+""+parm10053+"<p>";
		      model14notes+=getBillPart("10054")+""+parm10054+"<p>";
		      model14notes+=getBillPart("10055")+""+parm10055+"<p>";
		      model14notes+=getBillPart("10056")+""+parm10056+"<p>";
		      model14notes+=getBillPart("10057")+""+parm10057+"<p>";
		      model14notes+=getBillPart("10058")+""+parm10058+"<p>";
		      model14notes+=getBillPart("10059")+""+parm10059+"<p>";
		      model14notes+=getBillPart("10060")+""+parm10060+"<p>";	
		      model14notes+=getBillPart("10064")+""+parm10064+"<p>";	
		 }
			
			if(parm10072=="2" 
					&& Number(parm10020)=="0" 
					&& Number(parm10021)=="0" 
					&& Number(parm10022)=="0" 
					&& Number(parm10023)=="0" 
					&& Number(parm10024)=="0" 
					&& Number(parm10025)=="0"
					&& Number(parm10026)=="0" 
					&& Number(parm10027)=="0"
				) {
			
					inDbPacketss.data.add("jinexiao", parm10015);
					inDbPacketss.data.add("jineda", digit_uppercase(parm10016));		
					inDbPacketss.data.add("beizhu", model14notes);
					inDbPacketss.data.add("biaozhi", "6");
					inDbPacketss.data.add("zengzhisinfo", "");
					inDbPacketss.data.add("shuilv","0");
					inDbPacketss.data.add("shuie", "0");
					inDbPacketss.data.add("zhangqi", "");
					inDbPacketss.data.add("username", parm10005);
					inDbPacketss.data.add("fapiaoleixing", "0");
					inDbPacketss.data.add("huowuguige", "�˷�");
								
					inDbPacketss.data.add("xinghao", parm10061);
					inDbPacketss.data.add("danwei", parm10042);
					inDbPacketss.data.add("shuliang", parm10043);
					inDbPacketss.data.add("danjia", parm10015);
			
			}else {
			
					inDbPacketss.data.add("jinexiao", model14moneyxiao);
					inDbPacketss.data.add("jineda", model14moneyda);
					
					inDbPacketss.data.add("beizhu", model14notes);
					inDbPacketss.data.add("biaozhi", "6");
					inDbPacketss.data.add("zengzhisinfo", "");
					inDbPacketss.data.add("shuilv",INNET_FEEshuilv+","+HAND_FEEshuilv+",0,"+DEPOSITshuilv+","+SIM_FEEshuilv+",0,0,0");
					inDbPacketss.data.add("shuie", INNET_FEEshue+","+HAND_FEEshue+",0,"+DEPOSITshue+","+SIM_FEEshue+",0,0,0");
					inDbPacketss.data.add("zhangqi", "");
					inDbPacketss.data.add("username", parm10005);
					inDbPacketss.data.add("fapiaoleixing", "0");
					inDbPacketss.data.add("huowuguige", "0001,0002,0003,0004,0005,0006,0007,0008");
								
					inDbPacketss.data.add("xinghao", parm10061);
					inDbPacketss.data.add("danwei", parm10042);
					inDbPacketss.data.add("shuliang", parm10043);
					inDbPacketss.data.add("danjia", model14moneyxiao);
												
			}
		 	
		 }
		


		inDbPacketss.data.add("regionCode", "<%=regionCode_bill%>");
		inDbPacketss.data.add("groupId", "<%=groupId%>");
		inDbPacketss.data.add("hongziflag", parm10072);																		
		core.ajax.sendPacket(inDbPacketss, do_Paper_invoice);
		inDbPacketss = null;	
}


function do_Paper_invoice(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	
	var billhao = packet.data.findValueByName("billhao");
 	var billdai = packet.data.findValueByName("billdai");
	var yzacceptsdf = packet.data.findValueByName("yzaccept");

	 if(retCode=="000000") {	 
		 	var billhao = packet.data.findValueByName("billhao");
		 	var billdai = packet.data.findValueByName("billdai");
		 	var yzacceptsdf = packet.data.findValueByName("yzaccept");
			fapiaohao=billhao;
		  fapiaodai=billdai;
		  yzaccept=yzacceptsdf;
		  printflag="0";
		  
		  if(confirm('��Ʊ������'+fapiaohao+'���Ƿ��ӡ��')==1){
			 			
			 	var inDbPacketss = new AJAXPacket("ajax_Bill_SaveInDB.jsp","����ȡ��Ʊ��Ϣ�����Ժ�......");
						inDbPacketss.data.add("liushui", yzaccept);
						inDbPacketss.data.add("fapiaohao", fapiaohao);
						inDbPacketss.data.add("fapiaodai", fapiaodai);
						inDbPacketss.data.add("workno", parm10001);
						inDbPacketss.data.add("regionCode", "<%=regionCode_bill%>");
						inDbPacketss.data.add("groupId", "<%=groupId%>");
						//�����Ʊ��ӡʱ�����һλ����Ҫ��5
						inDbPacketss.data.add("hongziflag",parm10081);	
						
						core.ajax.sendPacket(inDbPacketss, doPrint_Paper_invoice);
						inDbPacketss = null;
		
			}else {
				//ȡ������һ�ε�����scancelInDB����Ԥռ�ͷ�
			  var inDbPacketss = new AJAXPacket("ajax_Bill_PrtCancel.jsp","����ȡ��Ԥռ�����Ժ�......");
						inDbPacketss.data.add("liushui", yzaccept);
						inDbPacketss.data.add("fapiaohao", fapiaohao);
						inDbPacketss.data.add("fapiaodai", fapiaodai);
						inDbPacketss.data.add("workno", parm10001);
						inDbPacketss.data.add("regionCode", "<%=regionCode_bill%>");
						inDbPacketss.data.add("groupId", "<%=groupId%>");
						inDbPacketss.data.add("hongziflag", parm10072);
						core.ajax.sendPacket(inDbPacketss, do_BillCancel);
						inDbPacketss = null;	
			}

	 }else {
	   	alert("��Ʊ����Ԥռʧ�ܣ�������룺"+retCode+"������ԭ��"+retMsg);
	   	printflag="1";
	 }
}

function do_BillCancel(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		if (retCode != "000000") { 
			rdShowMessageDialog("��Ʊȡ��Ԥռʧ��,������룺"+retCode+"��������Ϣ��"+retMsg,0);
			window.close();
		}else {
			window.close();
		} 
		
}

	function doPrint_Paper_invoice(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if ("<%=submitCfm%>" == "submit") {
			window.close();
			return;
		}
		
		
		if (retCode != "000000") { //������ ==
			rdShowMessageDialog("���ӷ�Ʊ���ʧ��,������룺"+retCode+"��������Ϣ��"+retMsg,0);
			window.close();
			return false;
		} else {
			 if(billtypemode=="model4") {//����ģ��4
			 	if(parm10036=="b542"){
	       	normalPrint4_b542();
	     	}else{
	     		normalPrint4();
	     	}
			 }
			 if(billtypemode=="model1") {//Ԥ��Ʊģ��1
			   normalPrint1();
			 }
			 	if(billtypemode=="model6") {//Ӫ�������նˣ�����ʵ����۷�Ʊ6
			 	if(parm10036=="m408"||parm10036=="m409"){
			 		normalPrint6_m408();
			 	}else if(parm10036=="m415"){
			 		normalPrint_m415();
			 	}else{
			   	normalPrint6();
			 	}
			 }
			 	if(billtypemode=="model7") {//SIM����Ʊ7
			   
			   if(parm10036=="m401"){
				   normalPrint7_m401();
			 	}else{
			 		normalPrint7();
			 	}
			 	
			 }
			 	if(billtypemode=="model8") {//�����Ʊ8
			   normalPrint8();
			 }
			 	if(billtypemode=="model12") {//�ֻ����˻���ֵ12
			   normalPrint12();
			 }
			 	if(billtypemode=="model13") {//��Լ�ײͷѷ�Ʊ13
			   normalPrint13();
			 }
		}
		window.returnValue = "0";
	}
	
	
	 
	 
	var rowInit = Number('<%=rowInit%>');
	if(parm10049=="BX" || parm10049=="BY") {
			rowInit= rowInit+1;
	}

//��ӡ���ӷ�Ʊ
	function Bill_prt(opr){
		

			
			var payaccept   = parm10030;
			var opcode      = parm10036;
			var workno      = parm10001;
			var phonenos    = "";
			var id_no       = "";
			var contract_nos = contract_no;
			if(parm10008=="") {
					phonenos    = "-1";
					id_no       = "-1";
					contract_nos = "-1";
			}else{
				  phonenos    = parm10008;
					id_no       = id_noss;
					contract_nos = contract_no;
			}
			var sm_code = smcodes;
			var pay_note = "";
			var s_xmmc = "";   //��Ŀ����
			var xmdw   = "";   //��Ŀ��λ
			var s_ggxh = "";   //����ͺ�
			var xmsl   = "";   //��Ŀ����
			var hsbz   = "";   //�ַ���
			var s_xmdj = "";   //��Ŀ����
			var s_sl   = "";   //˰��
			var s_se   = "";   //˰��
			var chbz   = parm10072;   //����ʶ
			
			if(!go_EL_check(opr)) return ;
			
			var old_accept = parm10030; //ԭʼҵ����ˮ
			var old_ym  = parm11216; //ԭʼҵ������
			var kphjje = parm10015;  //��Ʊ�ϼƽ��
			var hjbhsje = "";    //�ϼƲ���˰���
			var hjse = "";  //�ϼ�˰��
			var returnPage = "";
	 
			if(billtypemode=="model4") {
					pay_note+=getBillPart("10028")+""+parm10028+" "+getBillPart("10047")+""+parm10029+" "+getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+" ";
					if(parm10072=="2" && Number(parm10020)=="0" && Number(parm10021)=="0" && Number(parm10022)=="0" && Number(parm10023)=="0" && Number(parm10024)=="0" && Number(parm10025)=="0" && Number(parm10026)=="0" && Number(parm10027)=="0")
					{
							s_xmmc = "�˷�";
							xmdw   =parm10042;
							s_ggxh = parm10061;
							xmsl = parm10043;
							hsbz ="0";
							s_xmdj = parm10015;
							s_sl = "0";
							s_se = "0";
					}else{
						  var innet = (Number(parm10020)).toFixed(2);
						  var hand = (Number(parm10021)).toFixed(2);
						  var choice = parm10022;
						  var depoist = (Number(parm10023)).toFixed(2);
						  var sim = (Number(parm10024)).toFixed(2);
						  var fee = parm10025;
						  var machine = parm10026;
						  var other = parm10027;
							if(innet!=0&& innet!="0.00"){
								s_xmdj += innet+",";
								s_xmmc += "������,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += INNET_FEEshuilv+",";
								s_se += INNET_FEEshue+",";
							}
							if(hand!=0&& hand!="0.00"){
								s_xmdj += hand+",";
								s_xmmc += "������,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += HAND_FEEshuilv+",";
								s_se += HAND_FEEshue+",";
							}
							if(choice!=0&& choice!="0.00"){
								s_xmdj += choice+",";
								s_xmmc += "ѡ�ŷ�,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							if(depoist!=0&& depoist!="0.00"){
								s_xmdj += depoist+",";
								s_xmmc += "Ѻ��,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += DEPOSITshuilv+",";
								s_se += DEPOSITshue+",";
							}
							if(sim!=0&& sim!="0.00"){
								s_xmdj += sim+",";
								s_xmmc += "SIM����,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += SIM_FEEshuilv+",";
								s_se += SIM_FEEshue+",";
							}
							if(fee!=0&& fee!="0.00"){
								s_xmdj += fee+",";
								s_xmmc += "Ԥ�滰��,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							if(machine!=0&& machine!="0.00"){
								s_xmdj += machine+",";
								s_xmmc += "������,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							if(other!=0&& other!="0.00"){
								s_xmdj += other+",";
								s_xmmc += "������,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							s_xmdj = s_xmdj.substring(0,s_xmdj.length-1);
							s_xmmc = s_xmmc.substring(0,s_xmmc.length-1);
							xmdw = xmdw.substring(0,xmdw.length-1);
							xmsl = xmsl.substring(0,xmsl.length-1);
							s_ggxh = s_ggxh.substring(0,s_ggxh.length-1);
							hsbz = hsbz.substring(0,hsbz.length-1);
							s_sl = s_sl.substring(0,s_sl.length-1);
							s_se = s_se.substring(0,s_se.length-1);
					}
			}
			else if(billtypemode=="model1"){
							s_xmmc = "�ϼ�";
							xmdw   =parm10042;
							s_ggxh = parm10061;
							xmsl = parm10043;
							hsbz ="1";
							s_xmdj = parm10044;
							s_sl = parm10062;
							s_se = parm10063;
							pay_note+=getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+" ";
					    pay_note+=getBillPart("10038")+""+parm10038+" "+getBillPart("10039")+""+parm10039+" "+getBillPart("10040")+""+parm10040+" ";		  
					    if(xmsl==""||xmsl=="0"){
								xmsl = 1;
							}
							if(xmdw==""){
								xmdw = "Ԫ";
							}
			}else if(billtypemode=="model6") {
							s_xmmc = parm10041;
							if(s_xmmc==""||s_xmmc.length==0){
								s_xmmc = parm10006;
							}
							xmdw   = parm10042;
							s_ggxh = parm10061;
							xmsl = parm10043;
							hsbz ="1";
							s_sl = parm10062;
							s_se = getRateFee(kphjje,s_sl);
							s_xmdj = (Number(kphjje)).toFixed(2);
							if(s_se!=""&&s_se!="0"&&s_se!="0.00"){
								s_se = Number(s_se).toFixed(2);
							}
							pay_note = getBillPart("10028")+""+parm10028+" "+getBillPart("10047")+""+parm10029+" ";
					    if(xmsl==""||xmsl=="0"){
								xmsl = 1;
							}
							if(xmdw==""){
								xmdw = "Ԫ";
							}
			}else if(billtypemode=="model7") {
							s_xmmc = parm10041;
							if(s_xmmc==""||s_xmmc.length==0){
								s_xmmc = parm10006;
							}
							xmdw   =parm10042;
							s_ggxh = parm10061;
							xmsl = parm10043;
							hsbz ="1";
							s_xmdj = (Number(parm10044));
							s_sl = parm10062;
							s_se = parm10063;
							pay_note = getBillPart("10028")+""+parm10028+" "+getBillPart("10047")+""+parm10029+" ";
					    if(xmsl==""||xmsl=="0"){
								xmsl = 1;
							}
							if(xmdw==""){
								xmdw = "Ԫ";
							}
			}else if(billtypemode=="model8") {
							kphjje = 0;
							if(parm10079=="1") {
								if(parm10080!=0&parm10080!=0.0){
									s_xmmc += "��װ��,"
									xmdw   +="Ԫ,";
									s_ggxh += ",";
									xmsl += "1,";
									s_xmdj+=parm10080+",";
									s_sl += parm10062+",";
									s_se += parm10063+",";
									hsbz +="1,";
									kphjje += Number(parm10080);
								}
								if(parm10067!=0&parm10067!=0.0){
									s_xmmc += "����ײ�Ԥ���,"
									xmdw   +="Ԫ,";
									s_ggxh += ",";
									xmsl += "1,";
									s_xmdj+=parm10067+",";
									s_sl += 0+",";
									s_se += 0+",";
									hsbz +="0,";
									kphjje += Number(parm10067);
								}
							}else {
								if(parm10066!=0&parm10066!=0.0){
									s_xmmc += "��װ��,"
									xmdw   +="Ԫ,";
									s_ggxh += ",";
									xmsl += "1,";
									s_xmdj+=parm10066+",";
									s_sl += 0+",";
									s_se += 0+",";
									hsbz +="0,";
									
									kphjje += Number(parm10066);
								}
								if(parm10067!=0&parm10067!=0.0){
									s_xmmc += "����ײ�Ԥ���,"
									xmdw   +="Ԫ,";
									s_ggxh += ",";
									xmsl += "1,";
									s_xmdj+=parm10067+",";
									s_sl += 0+",";
									s_se += 0+",";
									hsbz +="0,";
									kphjje +=Number(parm10067);
								}
							}
							s_xmdj = s_xmdj.substring(0,s_xmdj.length-1);
							s_xmmc = s_xmmc.substring(0,s_xmmc.length-1);
							xmdw = xmdw.substring(0,xmdw.length-1);
							xmsl = xmsl.substring(0,xmsl.length-1);
							s_ggxh = s_ggxh.substring(0,s_ggxh.length-1);
							hsbz = hsbz.substring(0,hsbz.length-1);
							s_sl = s_sl.substring(0,s_sl.length-1);
							s_se = s_se.substring(0,s_se.length-1);
							pay_note = getBillPart("10065")+""+parm10065+" "+getBillPart("10068")+" ";
			}else if(billtypemode=="model12") {
							s_xmmc = parm10041;
							if(s_xmmc==""||s_xmmc.length==0){
								s_xmmc = parm10006;
							}
							xmdw   =parm10042;
							s_ggxh = parm10061;
							xmsl = parm10043;
							hsbz ="0";
							s_xmdj = parm10015;
							s_sl = "0";
							s_se = "0";
							pay_note = getBillPart("10028")+""+parm10028+" "+getBillPart("10047")+""+parm10029+" "+getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+" ";
					    if(xmsl==""||xmsl=="0"){
								xmsl = 1;
							}
							if(xmdw==""){
								xmdw = "Ԫ";
							}
			}else if(billtypemode=="model13") {
							if(parm10044!=0&& parm10025!="0.00"){
								s_xmmc += parm10041+",";
								if(parm10041==""||parm10041.length==0){
									s_xmmc += parm10006+",";
								}
								xmdw   +=parm10042+",";
								s_ggxh += parm10061+",";
								xmsl += parm10043+",";
								hsbz +="1"+",";
								s_xmdj += parm10044+",";
								s_sl += parm10062+",";
								s_se += parm10063+",";
							}
							if(parm10025!=0&& parm10025!="0.00"){
								s_xmdj += parm10025+",";
								s_xmmc += "Ԥ�滰��,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							s_xmdj = s_xmdj.substring(0,s_xmdj.length-1);
							s_xmmc = s_xmmc.substring(0,s_xmmc.length-1);
							xmdw = xmdw.substring(0,xmdw.length-1);
							xmsl = xmsl.substring(0,xmsl.length-1);
							s_ggxh = s_ggxh.substring(0,s_ggxh.length-1);
							hsbz = hsbz.substring(0,hsbz.length-1);
							s_sl = s_sl.substring(0,s_sl.length-1);
							s_se = s_se.substring(0,s_se.length-1);
							pay_note+=getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+" ";
					  	pay_note+=getBillPart("10038")+""+parm10038+" "+getBillPart("10039")+""+parm10039+" "+getBillPart("10040")+""+parm10040+" ";		 
			}else if(billtypemode=="model14") {
					if(parm10072=="2" && Number(parm10020)=="0" && Number(parm10021)=="0" && Number(parm10022)=="0" && Number(parm10023)=="0" && Number(parm10024)=="0" && Number(parm10025)=="0" && Number(parm10026)=="0" && Number(parm10027)=="0") {
							s_xmmc = "�˷�";
							xmdw   =parm10042;
							s_ggxh = parm10061;
							xmsl = parm10043;
							hsbz ="0";
							s_xmdj = parm10015;
							s_sl = "0";
							s_se = "0";
							pay_note+=getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+" ";
					  	pay_note+=getBillPart("10038")+""+parm10038+" "+getBillPart("10039")+""+parm10039+" "+getBillPart("10040")+""+parm10040+" ";		 
					    if(xmsl==""||xmsl=="0"){
								xmsl = 1;
							}
							if(xmdw==""){
								xmdw = "Ԫ";
							}
					}else{
							var innet = (Number(parm10020)).toFixed(2);
						  var hand = (Number(parm10021)).toFixed(2);
						  var choice = parm10022;
						  var depoist = (Number(parm10023)).toFixed(2);
						  var sim = (Number(parm10024)).toFixed(2);
						  var fee = parm10025;
						  var machine = parm10026;
						  var other = parm10027;
							if(innet!=0&& innet!="0.00"){
								s_xmdj += innet+",";
								s_xmmc += "������,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += INNET_FEEshuilv+",";
								s_se += INNET_FEEshue+",";
							}
							if(hand!=0&& hand!="0.00"){
								s_xmdj += hand+",";
								s_xmmc += "������,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += HAND_FEEshuilv+",";
								s_se += HAND_FEEshue+",";
							}
							if(choice!=0&& choice!="0.00"){
								s_xmdj += choice+",";
								s_xmmc += "ѡ�ŷ�,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							if(depoist!=0&& depoist!="0.00"){
								s_xmdj += depoist+",";
								s_xmmc += "Ѻ��,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += DEPOSITshuilv+",";
								s_se += DEPOSITshue+",";
							}
							if(sim!=0&& sim!="0.00"){
								s_xmdj += sim+",";
								s_xmmc += "SIM����,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += SIM_FEEshuilv+",";
								s_se += SIM_FEEshue+",";
							}
							if(fee!=0&& fee!="0.00"){
								s_xmdj += fee+",";
								s_xmmc += "Ԥ�滰��,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							if(machine!=0&& machine!="0.00"){
								s_xmdj += machine+",";
								s_xmmc += "������,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							if(other!=0&& other!="0.00"){
								s_xmdj += other+",";
								s_xmmc += "������,";
								xmdw   +="Ԫ,";
								s_ggxh += ",";
								xmsl += "1,";
								hsbz +="0,";
								s_sl += 0+",";
								s_se += 0+",";
							}
							s_xmdj = s_xmdj.substring(0,s_xmdj.length-1);
							s_xmmc = s_xmmc.substring(0,s_xmmc.length-1);
							xmdw = xmdw.substring(0,xmdw.length-1);
							xmsl = xmsl.substring(0,xmsl.length-1);
							s_ggxh = s_ggxh.substring(0,s_ggxh.length-1);
							hsbz = hsbz.substring(0,hsbz.length-1);
							s_sl = s_sl.substring(0,s_sl.length-1);
							s_se = s_se.substring(0,s_se.length-1);
							pay_note+=getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019+" ";
					  	pay_note+=getBillPart("10038")+""+parm10038+" "+getBillPart("10039")+""+parm10039+" "+getBillPart("10040")+""+parm10040+" ";		 
					}
			}
			if(opr=="EI"){//���ӷ�Ʊ
				var toPath = "ajax_Electronic_invoice.jsp";
				
				if(chbz=="2"){//�����ĵ��ӷ�Ʊ
					  toPath = "ajax_Electronic_invoice_COR.jsp";
				}
				
				if(parm10045.trim()!=""){
					//���ն˵����
					pay_note = "IMEI��"+parm10045+ "  " +pay_note;
					s_ggxh = s_xmmc +" "+s_ggxh;
					s_xmmc = s_ggxh; // �ն˻��� Ʒ��  �ͺ�
					
					s_ggxh = "";
				}
				
				if(s_xmmc.trim()==""&&s_xmdj.trim()==""){
					
					if(parm10072!="2"){
						//���ǳ������Ǯ�Ǹ����Ĺ�ȥ
						var fflag = "";
						if(kphjje<0){
								kphjje = 0-kphjje;
						}
						
					}
					//����Ʊû����ϸ��ʱ����Ϊ�ܶ�
					s_xmmc = "������ϸ";//��ϸ����
					s_xmdj = kphjje;//��ϸ���
				}
				
				if(opcode=="b542"){
					s_xmmc = "��Ԥ���";
				}
				
				if(pay_note.trim()==""){
					pay_note = "��ע��"
				}
				
				var aPackets = new AJAXPacket(toPath,"����ȡ��Ʊ��Ϣ�����Ժ�......");
						aPackets.data.add("payaccept",payaccept);
						aPackets.data.add("op_code",opcode);
						aPackets.data.add("phone_no",phonenos);
						aPackets.data.add("pay_note",pay_note);
						aPackets.data.add("id_no",id_no);
						aPackets.data.add("sm_code",sm_code);
						aPackets.data.add("s_xmmc",s_xmmc);
						aPackets.data.add("xmdw",xmdw);
						aPackets.data.add("s_ggxh",s_ggxh);
						aPackets.data.add("xmsl",xmsl);
						aPackets.data.add("s_hsbz",hsbz);
						aPackets.data.add("s_xmdj",s_xmdj);
						aPackets.data.add("s_sl",s_sl);
						aPackets.data.add("s_se",s_se);
						aPackets.data.add("chbz",chbz);
						aPackets.data.add("old_accept",s_old_accept);
						aPackets.data.add("old_ym",old_ym);
						aPackets.data.add("kphjje",kphjje);
						aPackets.data.add("hjbhsje","");
						aPackets.data.add("hjse","");
						aPackets.data.add("contractno",contract_nos);
						aPackets.data.add("s_old_number",s_old_number);
						aPackets.data.add("s_old_code",s_old_code);
						aPackets.data.add("returnPage",returnPage);
						
						aPackets.data.add("parm11215",parm11215);
						
						core.ajax.sendPacket(aPackets, do_ajax_PrintInvoice_dz);
						aPackets = null;
						
			}else if(opr=="PR"){//ֽ���վ�
				
				var aPackets = new AJAXPacket("ajax_Paper_receipt.jsp","����ȡ��Ʊ��Ϣ�����Ժ�......");
						aPackets.data.add("payaccept",payaccept);
						aPackets.data.add("op_code",opcode);
						aPackets.data.add("phone_no",phonenos);
						aPackets.data.add("pay_note",pay_note);
						aPackets.data.add("id_no",id_no);
						aPackets.data.add("sm_code",sm_code);
						aPackets.data.add("s_xmmc",s_xmmc);
						aPackets.data.add("xmdw",xmdw);
						aPackets.data.add("s_ggxh",s_ggxh);
						aPackets.data.add("xmsl",xmsl);
						aPackets.data.add("s_hsbz",hsbz);
						aPackets.data.add("s_xmdj",s_xmdj);
						aPackets.data.add("s_sl",s_sl);
						aPackets.data.add("s_se",s_se);
						aPackets.data.add("chbz",chbz);
						aPackets.data.add("old_accept",s_old_accept);
						aPackets.data.add("old_ym",old_ym);
						aPackets.data.add("kphjje",kphjje);
						aPackets.data.add("hjbhsje","");
						aPackets.data.add("hjse","");
						aPackets.data.add("contractno",contract_nos);
						aPackets.data.add("s_old_number",s_old_number);
						aPackets.data.add("s_old_code",s_old_code);
						aPackets.data.add("returnPage",returnPage);
						
						
						core.ajax.sendPacket(aPackets, do_Paper_receipt);
						aPackets = null;
			}
}

 



//ֽ���վ�
function do_Paper_receipt(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		if("000000"==retCode){
			if(billtypemode=="model12") {//�ֻ����˻���ֵ12
			   normalPrint12();
			}
			if(billtypemode=="model4") {//�����վ�4
	       normalPrint4sj();
			}
			if(billtypemode=="model8") {//����վ�8
			   normalPrint8sj();
			}
			if(billtypemode=="model6") {//�ն����վ�6--Ŀǰֻ��4977��������е�kf�������ҿ���ն�ѡ��ONT��ʱ�����ҡ�������ȡ��ʽ��ΪѺ�����վ�


			   if(parm10085=="zsj" ) {
			   	if(parm10036=="m404"){
			   		normalPrint_m404();
			   	}else if(parm10036=="m414"||parm10036=="m415"){
			   		normalPrint_m414();
			   	}else if(parm10036=="m432"){
			   		normalPrint_m432();
			   	}else if(parm10036=="m447"){
			   		normalPrint_m447();
			   	} else if(parm10036=="m358"){
			   		normalPrint_m358();
			   	} else{
			   		normalPrint6sj();
			  	}
			   }else if(parm10085=="MBH"){
			   	normalPrintMBHsj();
			   }
			  
			  
			   if(parm10036=="m461"){
			   		normalPrint_m461();
			   }
			   	
			}
			
			if(billtypemode=="model7") {//SIM����Ʊ7
				if(parm10036=="m401"){
					   normalPrint7_m401();
				}else{
						normalPrint7();
				}
			}
			
		}else{
			rdShowMessageDialog(retCode+":"+retMsg);
		}
		
		
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes"){	
			retValue = "confirm";	
		}
		
		window.returnValue= retValue;
		window.close();
}	






function normalPrint_m461() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
     //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
    printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն����վ�");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		
 		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
 				
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 	 
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10087")+""+parm10087);
	  printctrl.PrintEx(66, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ն�ID��"+parm10055);		
 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		
		
		var shulianghe=0;
		var jiagehe=0;
		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
		for(var smsd=0;smsd<sm.length;smsd++) {
		printctrl.PrintEx(24, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
		printctrl.PrintEx(53, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
		printctrl.PrintEx(75, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
		printctrl.PrintEx(97, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
		
		shulianghe+=Number(sm2[smsd]);
		jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		//printctrl.PrintEx(65, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
 		printctrl.PrintEx(97, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		}

 		 		if(parm10049=="BX" || parm10049=="BY") {
 		 			 		
 		
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(70, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
 			 			 		
 		}else {
 		
 			 		
 		
 		printctrl.PrintEx(23, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		/*2016/4/7 16:16:04 gaopeng 10028 10029 ����ӡ*/
 		
 			printctrl.PrintEx(23, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
 			printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
 		
 		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
    }


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}




function do_ajax_PrintInvoice_dz(packet){

		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		if("000000"==retCode){
			rdShowMessageDialog("��ӡ�ɹ�",2);
				var cfmInfo = "<%=submitCfm%>";
				var retValue = "";
				if(cfmInfo == "Yes"){	
					retValue = "confirm";	
				}
				
				window.returnValue= retValue;
				window.close();
		}else{
			rdShowMessageDialog(retMsg,0);
		}
		
		

}	
	
/**
*
*��ȡ˰����1Ϊ�ܶ���2Ϊ˰��
**/
/*˰����㣺��˰���/(1+˰��)*˰�ʣ����룺��˰���/(1+˰��)��----��˰��ʽ*/
function getRateFee(fee,shuilv){
		return (Number(fee)/(1+Number(shuilv))*Number(shuilv)).toFixed(2);
}	


function digit_uppercase(n){  
    var fraction = ['��', '��'];  
    var digit = ['��', 'Ҽ', '��', '��', '��', '��', '½', '��', '��', '��'];  
    var unit = [ ['Ԫ', '��', '��'], ['', 'ʰ', '��', 'Ǫ']  ];  
    var head = n < 0? '��': '';  
    n = Math.abs(n);  
  
    var s = '';  
  
    for (var i = 0; i < fraction.length; i++)   
    {  
        s += (digit[Math.floor(n * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/��./, '');  
    }  
    s = s || '��';  
    n = Math.floor(n);  
  
    for (var i = 0; i < unit[0].length && n > 0; i++)   
    {  
        var p = '';  
        for (var j = 0; j < unit[1].length && n > 0; j++)   
        {  
            p = digit[n % 10] + unit[1][j] + p;  
            n = Math.floor(n / 10);  
        }  
        s = p.replace(/(��.)*��$/, '').replace(/^$/, '��')  + unit[0][i] + s;  
    }  
    return head + s.replace(/(��.)*��Ԫ/, 'Ԫ').replace(/(��.)+/g, '��').replace(/^��$/, '��Ԫ��');  
}


//��Ʊ���վݴ�ӡģ��
function normalPrint4_b542() {
	try {
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
	 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
    //printctrl.PrintEx(126,rowInit-2, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaohao);
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);	
 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016));
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
 		
 	 
 		
 		printctrl.PrintEx(27, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ԥ��"+parm10021);	
 		
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
 		printctrl.PrintEx(100, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
 		
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}



//��Ʊ���վݴ�ӡģ��
function normalPrint4() {
	try {
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
	 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
    //printctrl.PrintEx(126,rowInit-2, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaohao);
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);	
 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016));
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
 		
 		if(parm10049=="BX" || parm10049=="BY") {
 		
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(70, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);

 		
 		}else {
 		
 		printctrl.PrintEx(30, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10020")+""+parm10020);		
 		printctrl.PrintEx(65, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10021")+""+parm10021);	
 		printctrl.PrintEx(100, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10022")+""+parm10022);	
 		printctrl.PrintEx(125, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10023")+""+parm10023);	
 		
 		printctrl.PrintEx(30, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10024")+""+parm10024);		
 		printctrl.PrintEx(65, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10025")+""+parm10025);	
 		printctrl.PrintEx(100, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10026")+""+parm10026);	
 		printctrl.PrintEx(125, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10027")+""+parm10027);		 		
 		
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
 		printctrl.PrintEx(100, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
 		
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
    }


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}

	
function normalPrint1() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
	 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
     //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
    printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaohao);
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 	
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10048")+""+parm10048);
 			
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016));
 		printctrl.PrintEx(140, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10037")+""+parm10037);
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
 		

 		if(parm10049=="BX" || parm10049=="BY") {
 		
 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
 			 			 		
 		}else {

 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10038")+""+parm10038);		
 		printctrl.PrintEx(50, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10039")+""+parm10039);	
 		printctrl.PrintEx(77, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10040")+""+parm10040);	
 		
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	

    }

		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}

function normalPrint6() {

	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
     //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);		 		
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10041"));	
 		printctrl.PrintEx(53, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10042"));
 		printctrl.PrintEx(75, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
 		printctrl.PrintEx(97, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10044"));
 		if(parm10078 != "kf" && parm10078 != "ki"){
 			printctrl.PrintEx(123, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10045"));
 		}
 		}
 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		if(parm10078 != "kf" && parm10078 != "ki"){
			sm4=parm10045.split(",");
		}
		
		var shulianghe=0;
		var jiagehe=0;
		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
		for(var smsd=0;smsd<sm.length;smsd++) {
		printctrl.PrintEx(24, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
		printctrl.PrintEx(53, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
		printctrl.PrintEx(75, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
		printctrl.PrintEx(97, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
		if(parm10078 != "kf" && parm10078 != "ki"){
			printctrl.PrintEx(120, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
		}
		shulianghe+=Number(sm2[smsd]);
		jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		//printctrl.PrintEx(65, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
 		printctrl.PrintEx(97, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		}

 		 		if(parm10049=="BX" || parm10049=="BY") {
 		 			 		
 		
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
 			 			 		
 		}else {
 		
 			 		
 		
 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
 		if(parm10078 != "kf" && parm10078 != "ki"){
	 		printctrl.PrintEx(23, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(100, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
 		}
 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
    }


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}



function normalPrint7() {
 
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
     //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10041"));	
 		printctrl.PrintEx(58, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10061"));
 		printctrl.PrintEx(75, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10042"));
 		printctrl.PrintEx(97, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
 		printctrl.PrintEx(123, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10044"));
 		}
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10061.split(",");
		sm2=parm10042.split(",");
		sm3=parm10043.split(",");
		sm4=parm10044.split(",");
		var shulianghe=0;
		var jiagehe=0;
		
		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
		for(var smsd=0;smsd<sm.length;smsd++) {
		printctrl.PrintEx(24, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
		printctrl.PrintEx(53, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
		printctrl.PrintEx(75, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
		printctrl.PrintEx(97, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
		printctrl.PrintEx(123, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
		shulianghe+=Number(sm3[smsd]);
		jiagehe+=Number(sm4[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		//printctrl.PrintEx(97, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
 		printctrl.PrintEx(123, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		}
 		
 		if(parm10049=="BX" || parm10049=="BY") {
 			 		 		
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 			 		 		
 		
 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
 			 			 		
 		}else {
 		
 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		if(parm10036 != "m401"){
	 		printctrl.PrintEx(23, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(60, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
 		}
 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	

    }

		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}


function normalPrint13() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
     //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Լ�ײͷ�");
 		printctrl.PrintEx(53, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Ʒ��");	
 		printctrl.PrintEx(73, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 		printctrl.PrintEx(95, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
 		printctrl.PrintEx(127, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10045"));
 		}
 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10061.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		sm4=parm10045.split(",");
		var shulianghe=0;
		var jiagehe=0;
		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
		for(var smsd=0;smsd<sm.length;smsd++) {
		printctrl.PrintEx(23, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
		printctrl.PrintEx(54, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
		printctrl.PrintEx(73, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
		printctrl.PrintEx(95, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
		//printctrl.PrintEx(117, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
		printctrl.PrintEx(124, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
		shulianghe+=Number(sm2[smsd]);
		jiagehe+=Number(sm3[smsd]);
		}
 		
 		//printctrl.PrintEx(65, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
 		//printctrl.PrintEx(97, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		}

 		 		if(parm10049=="BX" || parm10049=="BY") {
 		 			 		
 		
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		printctrl.PrintEx(140, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10037")+""+parm10037);

 		
 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
 			 			 		
 		}else {
 		
 			 		
 		
 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		printctrl.PrintEx(140, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10037")+""+parm10037);
 		
 		printctrl.PrintEx(23, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
 		
 		printctrl.PrintEx(23, rowInit + 14+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10038")+""+parm10038);		
 		printctrl.PrintEx(60, rowInit + 14+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10039")+""+parm10039);	
 		printctrl.PrintEx(97, rowInit + 14+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10040")+""+parm10040);
 		
 		printctrl.PrintEx(23, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
    }


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}



function normalPrint8() {
 
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
   // printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);
 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	
 		printctrl.PrintEx(66, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 			 		
 			 		
 		
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
 		
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ŀ��");	
 	  printctrl.PrintEx(40, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10066")+""+parm10066);	
 		printctrl.PrintEx(83, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10067")+""+parm10067);
 		
 		

 		if(parm10049=="BX" || parm10049=="BY") {
 		

 		
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
 		printctrl.PrintEx(100, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10047);
 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	 		/* 
		   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
		   * ����ʡ���kg������Ʒ��kh
		   */
	 		if(parm10078 == "kf" || parm10078 == "kg" || parm10078 == "kh" || parm10078 == "ki"){
	 			printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͷ����ߣ�10086");
	 		}
 		
 		}else {
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
 		printctrl.PrintEx(100, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10047);
 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
	 		/* 
		   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
		   * ����ʡ���kg������Ʒ��kh
		   */
	 		if(parm10078 == "kf" || parm10078 == "kg" || parm10078 == "kh" || parm10078 == "ki"){
	 			printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͷ����ߣ�10086");
	 		}
 		}
		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}


function normalPrint12() {
 
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
     //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
    printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ֻ�֧�����˻��ֽ��ֵ�վ�");
    //printctrl.PrintEx(140,rowInit+3, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
 		printctrl.PrintEx(40, rowInit+5,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(23, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
 		
 		
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	

		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}



	
function normalPrint6_m408(){

	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
	 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);		 		
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		

 		printctrl.PrintEx(25, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Ʒ��");	
 		printctrl.PrintEx(45, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͺ�");
 		printctrl.PrintEx(65, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��λ");
 		printctrl.PrintEx(85, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 		printctrl.PrintEx(105, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 		printctrl.PrintEx(125, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"MAC");
 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		var sm5= new Array();
		
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		sm4=parm10045.split(",");
		sm5=parm10061.split(",");
		
		var shulianghe=0;
		var jiagehe=0;
	 
			for(var smsd=0;smsd<sm.length;smsd++) {
				printctrl.PrintEx(25, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
				printctrl.PrintEx(45, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm5[smsd]);	
				printctrl.PrintEx(65, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
				printctrl.PrintEx(85, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
				printctrl.PrintEx(105, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);
				printctrl.PrintEx(125, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
				
				shulianghe+=Number(sm2[smsd]);
				jiagehe+=Number(sm3[smsd]);
			}
			
	 		printctrl.PrintEx(25, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		printctrl.PrintEx(105, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}  
	
		
function normalPrint7_m401() {
	 
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
     //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10041"));	
 		printctrl.PrintEx(58, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10061"));
 		printctrl.PrintEx(85, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10042"));
 		printctrl.PrintEx(107, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
 		printctrl.PrintEx(133, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10044"));
 		}
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10061.split(",");
		sm2=parm10042.split(",");
		sm3=parm10043.split(",");
		sm4=parm10044.split(",");
		var shulianghe=0;
		var jiagehe=0;
		
		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
		for(var smsd=0;smsd<sm.length;smsd++) {
		printctrl.PrintEx(24, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
		printctrl.PrintEx(53, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
		printctrl.PrintEx(85, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
		printctrl.PrintEx(107, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
		printctrl.PrintEx(133, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
		shulianghe+=Number(sm3[smsd]);
		jiagehe+=Number(sm4[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		//printctrl.PrintEx(97, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
 		printctrl.PrintEx(123, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		}
 		
 		if(parm10049=="BX" || parm10049=="BY") {
 			 		 		
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 			 		 		
 		
 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
 			 			 		
 		}else {
 		
 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		if(parm10036 != "m401"){
	 		printctrl.PrintEx(23, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(60, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
 		}
 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	

    }

		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}




function normalPrint4sj() {

	try {
	
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
	//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
	  //printctrl.PrintEx(126,rowInit-2, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
	  //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaohao);
	  printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾Ԥ����վ�");
		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);	
		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
		printctrl.PrintEx(85, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016));
		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
		
		if(parm10049=="BX" || parm10049=="BY") {
		
		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
			
		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
		printctrl.PrintEx(80, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
		printctrl.PrintEx(117, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
		printctrl.PrintEx(70, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
		printctrl.PrintEx(117, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
		printctrl.PrintEx(80, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
		printctrl.PrintEx(90, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
		
		
		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
		printctrl.PrintEx(60, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
		printctrl.PrintEx(85, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
		printctrl.PrintEx(110, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	
		
		}else {
		
		printctrl.PrintEx(30, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10020")+""+parm10020);		
		printctrl.PrintEx(65, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10021")+""+parm10021);	
		printctrl.PrintEx(100, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10022")+""+parm10022);	
		printctrl.PrintEx(125, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10023")+""+parm10023);	
		
		printctrl.PrintEx(30, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10024")+""+parm10024);		
		printctrl.PrintEx(65, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10025")+""+parm10025);	
		printctrl.PrintEx(100, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10026")+""+parm10026);	
		printctrl.PrintEx(125, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10027")+""+parm10027);		 		
		
		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
		printctrl.PrintEx(100, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
		
		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
		printctrl.PrintEx(60, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
		printctrl.PrintEx(85, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
		printctrl.PrintEx(110, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
	  }
	
	
		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("�վݴ�ӡ������ȷ�Ͽؼ��Ƿ�װ!", 0);
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}

	
function normalPrint8sj() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
   // printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
    printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾��������վ�");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);
 		printctrl.PrintEx(66, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);	
 		//printctrl.PrintEx(101, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 			 		
 			 		
 		
 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
 		
 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��Ŀ��");	
 	  printctrl.PrintEx(40, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10066")+""+parm10066);	
 		printctrl.PrintEx(83, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10067")+""+parm10067);
		
		

 		if(parm10049=="BX" || parm10049=="BY") {
 		

 		
 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(60, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 25,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 25,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
 		printctrl.PrintEx(100, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10047);
 		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 24,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 24,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 24,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
			/* 
		   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
		   * ����ʡ���kg������Ʒ��kh
		   */
	 		if(parm10078 == "kf" || parm10078 == "kg" || parm10078 == "kh" || parm10078 == "ki"){
	 			printctrl.PrintEx(23, rowInit + 26,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͷ����ߣ�10086");
	 		}
	 		
 		}else {
 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
 		printctrl.PrintEx(100, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10047);
 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 20,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 20,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 20,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
	 		/* 
		   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
		   * ����ʡ���kg������Ʒ��kh
		   */
	 		if(parm10078 == "kf" || parm10078 == "kg" || parm10078 == "kh" || parm10078 == "ki"){
	 			printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"�ͷ����ߣ�10086");
	 		}
 		}


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("�վݴ�ӡ������ȷ�Ͽؼ��Ƿ�װ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}


function normalPrint_m404() {
	
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
	//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
	   //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
	  printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ƶ�����ͨ�������շ��վ�");
	  //printctrl.PrintEx(140,rowInit+3, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
		printctrl.PrintEx(40, rowInit+5,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
		printctrl.PrintEx(23, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
		printctrl.PrintEx(66, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
		printctrl.PrintEx(66, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
		printctrl.PrintEx(101, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
		printctrl.PrintEx(132, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);
		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
		
		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�"+parm10015);	
		printctrl.PrintEx(85, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
		
		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
		
		if(parm10086.length>55){
			printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,55));//��ע
			printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10086.substring(55,parm10086.length));//��ע
		}else{
			printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086);//��ע
		}
		
		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
		printctrl.PrintEx(60, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
		printctrl.PrintEx(85, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
		printctrl.PrintEx(110, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
	  
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}	
	
	



function normalPrint_m414() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
    printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն����վ�");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
 				
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 	 
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI�룺"+""+parm10087);
 		
 		
 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Ʒ�����");	
 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��λ");
 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 			 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		
		
		var shulianghe=0;
		var jiagehe=0;
		 
		for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
		printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
 		
 		printctrl.PrintEx(23, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}
function normalPrint_m415() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
    printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն��෢Ʊ");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 	 
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI�룺"+""+parm10087);
 		
 		
 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Ʒ�����");	
 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��λ");
 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 			 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		
		
		var shulianghe=0;
		var jiagehe=0;
		 
		for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
 		
 		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}
function normalPrint_m432() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
  printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն����վ�");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
 				
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 	 
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI�룺"+""+parm10087);
 		
 		
 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Ʒ�����");	
 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��λ");
 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 			 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		
		
		var shulianghe=0;
		var jiagehe=0;
		 
		for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
			printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
			printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
 		
 		printctrl.PrintEx(23, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}

function normalPrint_m447() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
  printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն����վ�");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
 				
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 	 
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI�룺"+""+parm10087);
 		
 		
 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Ʒ�����");	
 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��λ");
 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 			 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		
		
		var shulianghe=0;
		var jiagehe=0;
		 
		for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
			printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
			printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
 		
 		printctrl.PrintEx(23, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}
function normalPrint_m358() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		 
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
    printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն����վ�");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
 				
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 	 
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI�룺"+""+parm10087);
 		
 		
 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"Ʒ�����");	
 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"��λ");
 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"����");
 			 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		
		
		var shulianghe=0;
		var jiagehe=0;
		 
		for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
		printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
 		
 		printctrl.PrintEx(23, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}
	


function normalPrint6sj() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
	//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
	   //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
	  //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
	  printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն����վ�");
		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
		
		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
		//printctrl.PrintEx(101, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
				
		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
		
		if(parm10049=="BX" || parm10049=="BY") {
		}else {
		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10041"));	
		printctrl.PrintEx(53, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10042"));
		printctrl.PrintEx(75, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
		printctrl.PrintEx(97, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10044"));
		if(parm10078 != "kf" && parm10078 != "ki"){
			printctrl.PrintEx(123, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10045"));
		}
		}
		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		if(parm10078 != "kf" && parm10078 != "ki"){
			sm4=parm10045.split(",");
		}
		
		var shulianghe=0;
		var jiagehe=0;
		if(parm10049=="BX" || parm10049=="BY") {
		}else {
		for(var smsd=0;smsd<sm.length;smsd++) {
		printctrl.PrintEx(24, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
		printctrl.PrintEx(53, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
		printctrl.PrintEx(75, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
		printctrl.PrintEx(97, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
		if(parm10078 != "kf" && parm10078 != "ki"){
			printctrl.PrintEx(120, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
		}
		shulianghe+=Number(sm2[smsd]);
		jiagehe+=Number(sm3[smsd]);
		}
		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
		//printctrl.PrintEx(65, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
		printctrl.PrintEx(97, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
		}
	
		 		if(parm10049=="BX" || parm10049=="BY") {
		 			 		
		
		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
		
		
		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
			
		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
		printctrl.PrintEx(80, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
		printctrl.PrintEx(117, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
		printctrl.PrintEx(70, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
		printctrl.PrintEx(80, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
		printctrl.PrintEx(117, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
		printctrl.PrintEx(90, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
		
		
		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
		printctrl.PrintEx(60, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
		printctrl.PrintEx(85, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
		printctrl.PrintEx(110, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
			 			 		
		}else {
		
			 		
		
		printctrl.PrintEx(23, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
		printctrl.PrintEx(85, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
		
		if(parm10078 != "kf" && parm10078 != "ki"){
	 		printctrl.PrintEx(23, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(100, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
		}else {
			printctrl.PrintEx(23, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086);
		}
		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
		printctrl.PrintEx(60, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
		printctrl.PrintEx(85, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
		printctrl.PrintEx(110, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
	  }
	
	
		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		
	
	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}





function normalPrintMBHsj() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		var fontSizeInit = Number('<%=fontSizeInit%>');//�����С
		var fontType = "����";//����
		var fontStrongInit = Number('<%=fontStrongInit%>');//�����ϸ
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//����|��ˮ|ҵ������|��|��|��|�û�����|����|�ƶ�̨��|Э�����|֧Ʊ����|�ϼƽ��(��д)|���(Сд)|ҵ����Ŀ|����Ա|�տ�Ա|IMEINo|�Ƿ����������Ʒ�|֧����ʽ|POS�ɷ���Ŀ
     //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
    //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
    printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն����վ�");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		
 		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���η�Ʊ���룺"+fapiaohao);
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		//printctrl.PrintEx(101, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
 				
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
 			printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10087")+""+parm10087);
	 		
 		}
 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		
		
		var shulianghe=0;
		var jiagehe=0;
		if(parm10049=="BX" || parm10049=="BY") {
 		}else {
		for(var smsd=0;smsd<sm.length;smsd++) {
		printctrl.PrintEx(24, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
		printctrl.PrintEx(53, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
		printctrl.PrintEx(75, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
		printctrl.PrintEx(97, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
		
		shulianghe+=Number(sm2[smsd]);
		jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		//printctrl.PrintEx(65, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
 		printctrl.PrintEx(97, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		}

 		 		if(parm10049=="BX" || parm10049=="BY") {
 		 			 		
 		
 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
 			
 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
 		printctrl.PrintEx(80, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
 		printctrl.PrintEx(117, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
 		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
 		printctrl.PrintEx(70, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
 		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
 		printctrl.PrintEx(80, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
 		printctrl.PrintEx(117, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
 		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
 		printctrl.PrintEx(90, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
 		
 		
 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
 			 			 		
 		}else {
 		
 			 		
 		
 		printctrl.PrintEx(23, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"���ν�(Сд)��"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		/*2016/4/7 16:16:04 gaopeng 10028 10029 ����ӡ*/
 		
 			printctrl.PrintEx(23, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
 			printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
 		
 		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
    }


		 
		//��ӡ����
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("��Ʊ��ӡ����,��ʹ�ò���Ʊ���ܴ�ӡ��Ʊ!", 0);
		//alert(e.printstacktrace());	//wanghfa �����޸�
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}



		
</SCRIPT>




</HTML>   
