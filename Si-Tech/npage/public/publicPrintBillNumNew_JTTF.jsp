
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
  
		String work_no_bill =(String)session.getAttribute("workNo");
		String org_code_bill =(String)session.getAttribute("orgCode");
		String regionCode_bill = org_code_bill.substring(0,2);
		String groupId = (String)session.getAttribute("groupId");
		String notess=work_no_bill+"���з�ƱԤռ";
		String bill_number = "";
		String printLogoFlag = "N";
		String bill_daima="";
		String bill_loginacce="";
		String bill_yuzhanmsg="";
		
		//��ӡ��ʼֵ
		int rowInit = 6;
		int fontSizeInit = 9;
		int fontStrongInit = 0;//0Ϊ���Ӵ�
		String fontType = "����";
		String vR = "0";
	%>
<script language="javascript" type="text/javascript" src="/npage/public/billKeyValue.js"></script>
		<script>
	var printflag="0";//0���Դ�ӡ 1���ܴ�ӡ
	var shuilvarray= new Array();
	var shoujuflag="1";//0��ӡ1����ӡ
			
	var obj = window.dialogArguments;
	var parm10001="";
	var parm10002="";
	var parm10003="";
	var parm10004="";
	var parm10005="";
	var parm10006="";
	var parm10007="";
	var parm10008="";
	var parm10009="";
	var parm10010="";
	var parm10011="";
	var parm10012="";
	var parm10013="";
	var parm10014="";
	var parm10015="";
	var parm10016="";
	var parm10017="";
	var parm10018="";
	var parm10019="";
	var parm10020="";
	var parm10021="";
	var parm10022="";
	var parm10023="";
	var parm10024="";
	var parm10025="";
	var parm10026="";
	var parm10027="";
	var parm10028="";
	var parm10029="";
	var parm10030="";
	var parm10031="";
	var parm10032="";
	var parm10033="";
	var parm10034="";
	var parm10035="";
	var parm10036="";
	var parm10037="";
	var parm10038="";
	var parm10039="";
	var parm10040="";
	var parm10041="";
	var parm10042="";
	var parm10043="";
	var parm10044="";
	var parm10045="";
	var parm10046="";
	var parm10047="";
	var parm10048="";
	var parm10049="";
	var parm10050="";
	var parm10051="";
	var parm10052="";
	var parm10053="";
	var parm10054="";
	var parm10055="";
	var parm10056="";
	var parm10057="";
	var parm10058="";
	var parm10059="";
	var parm10060="";
	var parm10061="";
	var parm10062="";
	var parm10063="";
	var parm10064="";
	var parm10065="";
	var parm10066="";
	var parm10067="";
	var parm10068="";
	var parm10069="";
	var parm10070="";
	var parm10071="";
	var parm10072="";
	var parm10073="";
	var parm10074="";
	var parm10075="";
  var parm10076="";
  
  var parm10077="";
  var parm10078="";
  var parm10079="";
  var parm10080="";
  var parm10081="";
  var parm10082="";
	
	var id_noss="";
	var smnamess="";
	var smcodes="";
	var groupnames="";
	var fapiaohao="";
	var fapiaodai="";
	var yzaccept="";
	var billtypemode="";
	var contract_no="";
	var usernames="";
	var worknames="";
	var kdsuijimas="";

	for(i in obj){
		var v = $(obj).attr(i);
    
		if(v!= undefined){

		}else{
			v = "";
		}
		if(i=="10001") {
				parm10001=v;
		}
		else if(i=="10002")	{
				parm10002=v;
		}
		else if(i=="10003")	{
				parm10003=v;
		}	
		else if(i=="10004")	{
				parm10004=v;
		}	
		else if(i=="10005")	{
				parm10005=v;
		}
		else if(i=="10006")	{
				parm10006=v;
		}			
		else if(i=="10007")	{
				parm10007=v;
		}			
		else if(i=="10008")	{
				parm10008=v;
		}			
		else if(i=="10009")	{
				parm10009=v;
		}			
		else if(i=="10010")	{
				parm10010=v;
		}	
		else if(i=="10011")	{
				parm10011=v;
		}	
		else if(i=="10012")	{
				parm10012=v;
		}	
		else if(i=="10013")	{
				parm10013=v;
		}	
		else if(i=="10014")	{
				parm10014=v;
		}	
		else if(i=="10015")	{
				parm10015=v;
		}	
		else if(i=="10016")	{
				parm10016=v;
		}			
		else if(i=="10017")	{
				parm10017=v;
		}		
		else if(i=="10018")	{
				parm10018=v;
		}	
		else if(i=="10019")	{
				parm10019=v;
		}	
		else if(i=="10020")	{
				parm10020=v;
		}	
		else if(i=="10021")	{
				parm10021=v;
		}	
		else if(i=="10022")	{
				parm10022=v;
		}	
		else if(i=="10023")	{
				parm10023=v;
		}	
		else if(i=="10024")	{
				parm10024=v;
		}														
		else if(i=="10025")	{
				parm10025=v;
		}	
		else if(i=="10026")	{
				parm10026=v;
		}			
		else if(i=="10027")	{
				parm10027=v;
		}			
		else if(i=="10028")	{
				parm10028=v;
		}			
		else if(i=="10029")	{
				parm10029=v;
		}			
		else if(i=="10030")	{
				parm10030=v;
		}			
		else if(i=="10031")	{
				parm10031=v;
		}			
		else if(i=="10032")	{
				parm10032=v;
		}			
		else if(i=="10033")	{
				parm10033=v;
		}			
		else if(i=="10034")	{
				parm10034=v;
		}			
		else if(i=="10035")	{
				parm10035=v;
		}
		else if(i=="10036")	{
				parm10036=v;
		}	
		else if(i=="10037")	{
				parm10037=v;
		}	
		else if(i=="10038")	{
				parm10038=v;
		}	
		else if(i=="10039")	{
				parm10039=v;
		}	
		else if(i=="10040")	{
				parm10040=v;
		}	
		else if(i=="10041")	{
				parm10041=v;
		}	
		else if(i=="10042")	{
				parm10042=v;
		}	
		else if(i=="10043")	{
				parm10043=v;
		}	
		else if(i=="10044")	{
				parm10044=v;
		}	
		else if(i=="10045")	{
				parm10045=v;
		}
		else if(i=="10046")	{
				parm10046=v;
		}
		else if(i=="10047")	{
				parm10047=v;
		}	
		else if(i=="10048")	{
				parm10048=v;
		}	
		else if(i=="10049")	{
				parm10049=v;
		}
		else if(i=="10050")	{
				parm10050=v;
		}
		else if(i=="10051")	{
				parm10051=v;
		}
		else if(i=="10052")	{
				parm10052=v;
		}
		else if(i=="10053")	{
				parm10053=v;
		}
		else if(i=="10054")	{
				parm10054=v;
		}
		else if(i=="10055")	{
				parm10055=v;
		}
		else if(i=="10056")	{
				parm10056=v;
		}
		else if(i=="10057")	{
				parm10057=v;
		}												
		else if(i=="10058")	{
				parm10058=v;
		}	
		else if(i=="10059")	{
				parm10059=v;
		}	
		else if(i=="10060")	{
				parm10060=v;
		}
		else if(i=="10061")	{
				parm10061=v;
		}									
		else if(i=="10062")	{
				parm10062=v;
		}	
		else if(i=="10063")	{
				parm10063=v;
		}	
		else if(i=="10064")	{
				parm10064=v;
		}
		else if(i=="10065")	{
				parm10065=v;
		}
		else if(i=="10066")	{
				parm10066=v;
		}
		else if(i=="10067")	{
				parm10067=v;
		}
		else if(i=="10068")	{
				parm10068=v;
		}
		else if(i=="10069")	{
				parm10069=v;
		}
		else if(i=="10070")	{
				parm10070=v;
		}																																												
		else if(i=="10071")	{
				parm10071=v;
		}
		else if(i=="10072")	{
				parm10072=v;
		}
		else if(i=="10073")	{
				parm10073=v;
		}	
		else if(i=="10074")	{
				parm10074=v;
		}
		else if(i=="10075")	{
				parm10075=v;
		}
		else if(i=="10076")	{
				parm10076=v;
		}
		else if(i=="10077")	{
				parm10077=v;
		}	
		else if(i=="10078")	{
				parm10078=v;
		}	
		else if(i=="10079")	{
				parm10079=v;
		}	
		else if(i=="10080")	{
				parm10080=v;
		}	
		else if(i=="10081")	{
				parm10081=v;
		}
		else if(i=="10082")	{
				parm10082=v;
		}
									
		//alert(i+"="+v);
	}

		if(parm10015=="") {
				parm10015="0";
			}
		if(parm10016=="") {
				parm10016="0";
			}

		if(parm10020=="") {
			parm10020="0";
		}			
		if(parm10021=="") {
			parm10021="0";
		}
		if(parm10022=="") {
			parm10022="0";
		}
		if(parm10023=="") {
			parm10023="0";
		}
		if(parm10024=="") {
			parm10024="0";
		}
		if(parm10025=="") {
			parm10025="0";
		}
		if(parm10026=="") {
			parm10026="0";
		}
		if(parm10027=="") {
			parm10027="0";
		}	
		if(parm10066=="") {
			parm10066="0";
		}
		if(parm10067=="") {
			parm10067="0";
		}		
		if(parm10072=="") {
			parm10072="1";
		}
		//alert("parm10044===="+parm10044);								
		var model4moneyxiao="";	
		var model4moneyda="";
		var model1moneyxiao="";
		var model1moneyda="";
		var model6moneyxiao="";
		var model6moneyda="";
		var model7moneyxiao="";
		var model7moneyda="";	
		var model8moneyxiao="";
		var model8moneyda="";	
		var model12moneyxiao="";
		var model12moneyda="";	
		var model13moneyxiao="";
		var model13moneyda="";
		var model14moneyxiao="";	
		var model14moneyda="";
		
		
		var model4notes="";
		var model1notes="";
		var model6notes="";
		var model7notes="";
		var model8notes="";
		var model12notes="";
		var model13notes="";
	  var model14notes="";		


		var inDbPacketqry = new AJAXPacket("/npage/public/pubBillPrintQryInfo.jsp","���ڽ��в�����Ϣ��ѯ");
		inDbPacketqry.data.add("phone", parm10008);		//�ƶ�����
		inDbPacketqry.data.add("opcode", parm10036);
		inDbPacketqry.data.add("smcodes", parm10007);
		inDbPacketqry.data.add("id_nos", parm10074);
		inDbPacketqry.data.add("contract_nos", parm10075);
		
		core.ajax.sendPacket(inDbPacketqry, doreturnqry);
		inDbPacketqry = null;
		
	
		
		
		var SIM_FEEshue="0";
		var HAND_FEEshue="0";
		var DEPOSITshue="0";
		var INNET_FEEshue="0";

		var SIM_FEEshuilv="0";		//sim����˰��
		var HAND_FEEshuilv="0";  //������˰��
		var DEPOSITshuilv="0";   //Ѻ��˰��
		var INNET_FEEshuilv="0"; //������˰��

		    for(var i=0;i<shuilvarray.length;i++) {
		     if(shuilvarray[i].name=="CC0") {
            SIM_FEEshuilv = shuilvarray[i].value; 
            SIM_FEEshue=(Number(parm10024)/(1+Number(SIM_FEEshuilv))*Number(SIM_FEEshuilv)).toFixed(2);
	       }else if(shuilvarray[i].name=="CC4") {
	          HAND_FEEshuilv =shuilvarray[i].value; 
	          HAND_FEEshue=(Number(parm10021)/(1+Number(HAND_FEEshuilv))*Number(HAND_FEEshuilv)).toFixed(2);
	       }else if(shuilvarray[i].name=="LL0") {
	          DEPOSITshuilv =shuilvarray[i].value; 
	          DEPOSITshue=(Number(parm10023)/(1+Number(DEPOSITshuilv))*Number(DEPOSITshuilv)).toFixed(2);
	       }else if(shuilvarray[i].name=="CC1") {
	          INNET_FEEshuilv =shuilvarray[i].value; 
	          INNET_FEEshue=(Number(parm10020)/(1+Number(INNET_FEEshuilv))*Number(INNET_FEEshuilv)).toFixed(2);
	       }

       }
		
   if(billtypemode=="model12") {
   
   		
   }else {
		var inDbPacketss = new AJAXPacket("<%=request.getContextPath()%>/npage/public/publicPrintBillQryNum_JTTF.jsp","����ȡ��Ʊ��Ϣ�����Ժ�......");
		inDbPacketss.data.add("liushui", parm10030);
		inDbPacketss.data.add("opcode", parm10036);
		inDbPacketss.data.add("workno", parm10001);
		inDbPacketss.data.add("time", "");
		inDbPacketss.data.add("yuanlailiushui", parm10082);
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
		
		}
		
		else if(billtypemode=="model1"){
		 	
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
			inDbPacketss.data.add("huodongdaima", parm10029);
			
		
		}
		
		else if(billtypemode=="model7") {

		
		
		}
		
		if(billtypemode=="model8") {
		
		}
		
		  else if(billtypemode=="model12") {

		}
		 else if(billtypemode=="model13") {
		 
		 
		 }
		 else if(billtypemode=="model14") {
		 	
		 }
		


		inDbPacketss.data.add("regionCode", "<%=regionCode_bill%>");
		inDbPacketss.data.add("groupId", "<%=groupId%>");
		inDbPacketss.data.add("hongziflag", parm10072);																		
		
		core.ajax.sendPacket(inDbPacketss, doReturnmsgYZ);
		inDbPacketss = null;
		}
		
    if(printflag=="1") {
      window.close();
    }else {
		
		   if(billtypemode=="model12") {

					document.all.fapiao.style.display="none";
					

   		
   }
   else if(billtypemode=="model14") {
   				document.all.querenfapiao.style.display="block";
   				document.all.fapiao.style.display="none";
   				document.all.shouju.style.display="none";
   				
   }
   else {
   
				if(billtypemode=="model4" || billtypemode=="model8" || billtypemode=="model6") {

				}else {
				document.all.shouju.style.display="none";
				
				}
					
				}
				
				
			

		
		}
		
					function doReturnmsgYZ(packet)
{

	//liujian 2013-4-16 15:01:39 ��ӷ�Ʊlogo begin
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	
	/*���������
	var billhao = packet.data.findValueByName("billhao");
 	var billdai = packet.data.findValueByName("billdai");
 	var yzacceptsdf = packet.data.findValueByName("yzaccept");
	fapiaohao="12332123232";
  fapiaodai="12332123233";
  yzaccept="12332123234";
  printflag="0";
	*/
	 if(retCode=="000000") {	 
	 	var billhao = packet.data.findValueByName("billhao");
	 	var billdai = packet.data.findValueByName("billdai");
	 	var yzacceptsdf = packet.data.findValueByName("yzaccept");
		fapiaohao=billhao;
	  fapiaodai=billdai;
	  yzaccept=yzacceptsdf;
	  printflag="0";
	  
	  
	 }else {

	  
   alert("��Ʊ����Ԥռʧ�ܣ�������룺"+retCode+"������ԭ��"+retMsg);
   //������ע��
   printflag="1";
	 //rdShowMessageDialog("��Ʊ����Ԥռʧ�ܣ�ԭ��"+retCode+""+retMsg,0);

	 
	window.close(); //������ע��
	 
	 }
}

					function doReturnmsgYZQX(packet)
{

	//liujian 2013-4-16 15:01:39 ��ӷ�Ʊlogo begin
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");

	 if(retCode=="000000") {	 
  	window.close();
	  
	 }else {
  
   alert("��Ʊ����Ԥռȡ��ʧ�ܣ�������룺"+retCode+"������ԭ��"+retMsg);
window.close();
	 
	 
	 
	 }
}

		
function doreturnqry(packet) {
    var id_no = packet.data.findValueByName("id_no");
		var smname=packet.data.findValueByName("smname");
		var smcodessss=packet.data.findValueByName("smcodes");
		var groupnamess=packet.data.findValueByName("group_name");
		var billtypemodess=packet.data.findValueByName("billtypemodel");
		var contract_noss=packet.data.findValueByName("contract_no");
		var usernamesss=packet.data.findValueByName("username");
		var worknamesss=packet.data.findValueByName("work_name");
		var kdsuijimasss=packet.data.findValueByName("kdsuijima");
		var resultsss = packet.data.findValueByName("result");
		var op_name = packet.data.findValueByName("op_name");
		shuilvarray=resultsss;

		
	  id_noss=id_no;
	  smnamess=smname;
	  smcodes=smcodessss;
	  groupnames=groupnamess;
	  billtypemode=billtypemodess;
	  contract_no=contract_noss;
	  usernames=usernamesss;
	  worknames=worknamesss;
  	  kdsuijimas=kdsuijimasss;
  		if(parm10005=="") {
		 parm10005=usernames;
		}
		if(parm10031=="") {
			parm10031=worknames;
       }
    	if(parm10006=="") {
			parm10006=op_name;
       }
      if(parm10073!="") {
      parm10006=parm10073;
      }   
     

	  if(parm10071=="1") {
	  		billtypemode="model1";
	  }
	  if(parm10071=="4") {
	  		billtypemode="model4";
	  		$("#message").text("�Ƿ��ӡԤ��Ʊ���վݣ�");
	  }	  
	  if(parm10071=="6") {
	  		billtypemode="model6";
	  		$("#message").text("�Ƿ��ӡ�����Ʊ���վݣ�");
	  }
	  if(parm10071=="7") {
	  		billtypemode="model7";
	  		$("#message").text("�Ƿ��ӡSIM����Ʊ��");
	  }
	  if(parm10071=="8") {
	  		billtypemode="model8";
	  		$("#message").text("�Ƿ��ӡ����෢Ʊ���վݣ�");
	  }
	  if(parm10071=="12") {
	  		billtypemode="model12";
	  		$("#message").text("�Ƿ��ӡ�ֻ����˻���ֵ�վݣ�");
	  }
	  if(parm10071=="13") {
	  		billtypemode="model13";
	  		$("#message").text("�Ƿ��ӡ��Լ�ײͷѷ�Ʊ��");
	  }
	  if(parm10071=="14") {
	  		billtypemode="model14";
	  }	  	  		  	  	  

 }
		
			function doReturnmsgqx(packet)
{

	//liujian 2013-4-16 15:01:39 ��ӷ�Ʊlogo begin
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	 if(retCode=="000000") {
	 
	 }else {
	 rdShowMessageDialog("��Ʊ����ȡ��Ԥռ,ʧ��ԭ��"+retMsg,0);
	 
	 }
}
function doReturnmsg(packet)
{

	//liujian 2013-4-16 15:01:39 ��ӷ�Ʊlogo begin
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	 if(retCode=="000000") {
	 }else {
	 rdShowMessageDialog("��Ʊ����ռ��ʧ��,ʧ��ԭ��"+retMsg,0);
	 
	 }
}

 function digit_uppercase(n)   
        {  
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
		</script>


