<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  



%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%		

  		String opCode = "7955";
		String opName = "���������ѣ����·�����";
	 	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String powerCode= WtcUtil.repNull((String)session.getAttribute("powerCode")); 
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String  groupId = WtcUtil.repNull((String)session.getAttribute("groupId"));
		//���Ӳ���������վԤԼ��ǰ̨����wanghyd
		String banlitype =request.getParameter("banlitype");
		  

%>
<%
String retFlag="",retMsg="";

  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */

  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	  
	}
  }
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */
%>
<wtc:service name="s1141Qry" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="errCode" retmsg="errMsg"  outnum="14" >
		
		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginNoPass%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>	
			
	</wtc:service>
	<wtc:array id="result22222" scope="end" />
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String[][] tempArr= new String[][]{};
System.out.println(result22222.length+"|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
  if(result22222.length<=0)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s1141Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!"000000".equals(errCode)){%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>" ,0);
			history.go(-1);
		</script>
	<%}
	else
	{
	tempArr = result22222;
	 
	  if(!(tempArr==null)){
	    bp_name = tempArr[0][2];//��������
	    System.out.println(bp_name);
	  }
	
	  if(!(tempArr==null)){
	    bp_add = tempArr[0][3];//�ͻ���ַ
	  }
	 
	  if(!(tempArr==null)){
	    cardId_type = tempArr[0][4];//֤������
	  }
	 
	  if(!(tempArr==null)){
	    cardId_no = tempArr[0][5];//֤������
	  }
	
	  if(!(tempArr==null)){
	    sm_code = tempArr[0][6];//ҵ��Ʒ��
	  }
	
	  if(!(tempArr==null)){
	    region_name = tempArr[0][7];//������
	  }
	 
	  if(!(tempArr==null)){
	    run_name = tempArr[0][8];//��ǰ״̬
	  }
	 
	  if(!(tempArr==null)){
	    vip = tempArr[0][9];//�֣ɣм���
	  }
	 
	  if(!(tempArr==null)){
	    posint = tempArr[0][10];//��ǰ����
	  }
	 
	  if(!(tempArr==null)){
	    prepay_fee = tempArr[0][11];//����Ԥ��
	  }
	 
	  if(!(tempArr==null)){
	    passwordFromSer = tempArr[0][13];  //����
	  }
	}
  }

%>
 <% 
 String passTrans=request.getParameter("cus_pass"); 
System.out.println("passTrans==="+passTrans);
System.out.println("passwordFromSer==="+passwordFromSer);
 

 %>
<%
//******************�õ�����������***************************//
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
<%
String exeDate="";
exeDate = getExeDate("1","1141");

  comImpl co=new comImpl();
  //�ֻ�Ʒ��
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='17' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
   %> 
  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="2">
	<wtc:sql><%=sqlAgentCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end" />
   <%  
  //�ֻ�����
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='17' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
    %> 
  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode2" retmsg="RetMsg2" outnum="3">
	<wtc:sql><%=sqlPhoneType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="phoneTypeStr" scope="end" />
   <% 
  //Ӫ������
  //String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_gift from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='17' and valid_flag='Y' and a.spec_type like 'P%'";
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_gift,nvl(consume_term,0),trim(op_note) from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='17' and valid_flag='Y' and a.spec_type like 'P%'";
  System.out.println("sqlsaleType====="+sqlsaleType);
      %> 
  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode3" retmsg="RetMsg3" outnum="6">
	<wtc:sql><%=sqlsaleType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="saleTypeStr" scope="end" />
 
<%
	/* ningtn �Ų��ܼ����� */
	String password = (String)session.getAttribute("password");
	String[] paraAray4 = new String[7];
	String[][] tempArr4= new String[][]{};
	paraAray4[0] = printAccept;
	paraAray4[1] = "01";
	paraAray4[2] = opcode;
	paraAray4[3] = loginNo;
	paraAray4[4] = password;
	paraAray4[5] = phoneNo;
	paraAray4[6] = "";
	String showText = "";
	

	%>
<wtc:service name="sAdTermQry" routerKey="phone" routerValue="phoneNo"  retcode="retCode4" retmsg="retMsg4"  outnum="3" >
	<wtc:param value="<%=paraAray4[0]%>"/>
			<wtc:param value="<%=paraAray4[1]%>"/>
		<wtc:param value="<%=paraAray4[2]%>"/>
		<wtc:param value="<%=paraAray4[3]%>"/>
		<wtc:param value="<%=paraAray4[4]%>"/>
		<wtc:param value="<%=paraAray4[5]%>"/>
		<wtc:param value="<%=paraAray4[6]%>"/>
	</wtc:service>
	<wtc:array id="result22223" scope="end" />

<%
	if("000000".equals(retCode4)){
		System.out.println("~~~~����sAdTermQry�ɹ�~~~~");
		tempArr4=result22223;
		if(result22223.length>0){	
			showText = tempArr4[0][2];
		}
	}else{
		System.out.println("~~~~����sAdTermQryʧ��~~~~");
%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺" + <%=retCode4%> + "��������Ϣ��" + <%=retMsg4%>,0);
				//rdShowMessageDialog("������룺<%=retCode4%>��������Ϣ��<%=retMsg4%>");
				//history.go(-1);
			</script>
<%
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 


 <script language=javascript>

  onload=function()
  {	
  
  	 
  	 /* ningtn �Ų��ܼ����� */

	var showtext = "<%=showText%>";
	var showMsgObj = document.getElementById("showMsg");
	if(showtext.length > 0){
		showMsgObj.innerHTML = showtext;
	}

  }
 function doProcess(packet){
 
 		errorCode = packet.data.findValueByName("errorCode");
 		
		errorMsg =  packet.data.findValueByName("errorMsg");
		retType = packet.data.findValueByName("retType");
		/*tianyang add for pos�ɷ� start*/
		var verifyType = packet.data.findValueByName("verifyType");
		if(verifyType=="getSysDate"){
			retType = "getSysDate";			
		}
		/*tianyang add for pos�ɷ� end*/
		
		var retResult=packet.data.findValueByName("retResult");;
		self.status="";
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";
		
		ret_code =  errorCode;

		if(retType=="getcard"){
			if( ret_code == "000000" ){
			
				  tmpObj = "sale_code" 
				  backArrMsg = packet.data.findValueByName("backArrMsg");
					retResult = packet.data.findValueByName("retResult");
					
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;	
		        for(i=0;i<backArrMsg.length;i++)
			      {
				      document.all(tmpObj).options[i].text=backArrMsg[i][1];
				      document.all(tmpObj).options[i].value=backArrMsg[i][0];
		 	          document.all(tmpObj).options[i].nv2=backArrMsg[i][2];
			          document.all(tmpObj).options[i].nv3=backArrMsg[i][3];
		 	          document.all(tmpObj).options[i].nv4=backArrMsg[i][4];
			          document.all(tmpObj).options[i].nv5=backArrMsg[i][5];
			          //wangdana add for �ֻ����� @
			          document.all(tmpObj).options[i].nv6=backArrMsg[i][6];
			          document.all(tmpObj).options[i].nv7=backArrMsg[i][7];
                //begin huangrong add �ֻ����ӹ��ܷѣ��ֻ����ӹ��ܷ��������ޣ�WLAN���ܷѣ�WLAN���ܷ���������ֵ�Ļ�ȡ
			          document.all(tmpObj).options[i].nv8=backArrMsg[i][8];
			          document.all(tmpObj).options[i].nv9=backArrMsg[i][9];		
			          document.all(tmpObj).options[i].nv10=backArrMsg[i][10];
			          document.all(tmpObj).options[i].nv11=backArrMsg[i][11];	
			          //end huangrong add �ֻ����ӹ��ܷѣ��ֻ����ӹ��ܷ��������ޣ�WLAN���ܷѣ�WLAN���ܷ���������ֵ�Ļ�ȡ			          	  			          
	          	          
			      }
			}
			else{
			if(ret_code=="44444444"){
			return;
			}else {
				rdShowMessageDialog("ȡ��Ϣ����:"+errorMsg+"!");
				return;	
				}		
			}
			change();
		}else if(retType == "checkAward")
		{
		
				var retCode = packet.data.findValueByName("retCode"); 
				var retMessage = packet.data.findValueByName("retMessage");
			
    		window.status = "";
    		if(retCode!=0){
    	    rdShowMessageDialog(retMessage);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    	
    			return;
    			
    		}
    		document.all.award_flag.value = 1;
    	}
    	/**** tianyang add for pos start ****/
    	else if(retType == "getSysDate")
			{
				var sysDate = packet.data.findValueByName("sysDate");
				document.all.Request_time.value = sysDate;
				return ;
			}
			/**** tianyang add for pos end ****/
    	else{
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI��У��ɹ�1��");
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI��У��ɹ�2��");
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����");
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
					document.frm.confirm.disabled=true;
					return false;
			}
		}
		
 }

function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}


 function change(){
	with(document.frm){

		price.value=sale_code.options[sale_code.selectedIndex].nv2;
		pay_money.value=sale_code.options[sale_code.selectedIndex].nv3;
		consume_term.value=sale_code.options[sale_code.selectedIndex].nv4;
		chg_flag.value=sale_code.options[sale_code.selectedIndex].nv5;
		TVprice.value=sale_code.options[sale_code.selectedIndex].nv6;
		TVtime.value=sale_code.options[sale_code.selectedIndex].nv7;
    //begin huangrong add �ֻ����ӹ��ܷѣ��ֻ����ӹ��ܷ��������ޣ�WLAN���ܷѣ�WLAN���ܷ���������ֵ�Ļ�ȡ
		phoneNetPrice.value=sale_code.options[sale_code.selectedIndex].nv8;
		phoneNetTime.value=sale_code.options[sale_code.selectedIndex].nv9;
		wlanPrice.value=sale_code.options[sale_code.selectedIndex].nv10;
		wlanTime.value=sale_code.options[sale_code.selectedIndex].nv11;
		//end huangrong add �ֻ����ӹ��ܷѣ��ֻ����ӹ��ܷ��������ޣ�WLAN���ܷѣ�WLAN���ܷ���������ֵ�Ļ�ȡ	
		var i=price.value;
		var j=pay_money.value;
		var m=TVprice.value;
		sum_money.value=(parseFloat(i)).toFixed(2);//wangdana
		mach_fee.value=(parseFloat(i)-parseFloat(j)-parseFloat(m)).toFixed(2);
	}
}
 </script>
<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrPhoneType = new Array();//�ֻ��ͺŴ���
  var arrPhoneName = new Array();//�ֻ��ͺ�����
  var arrAgentCode = new Array();//�����̴���
  var selectStatus = 0;
  
  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalePrice=new Array();
  var arrsaleLimit=new Array();
  var arrsaleTerm=new Array();
  var arrsaleChgFlag=new Array();
  var arrsaletype=new Array();
  


 
<%  
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }  
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalePrice["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaleLimit["+l+"]='"+saleTypeStr[l][3]+"';\n");
	out.println("arrsaleTerm["+l+"]='"+saleTypeStr[l][4]+"';\n");
	out.println("arrsaleChgFlag["+l+"]='"+saleTypeStr[l][5]+"';\n");
	
  }  
%>
	
	/*tianyang add POS�ɷ� start*/
	function getSysDate()
	{		
			var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
			myPacket.data.add("verifyType","getSysDate");
			core.ajax.sendPacket(myPacket);
	  	myPacket =null;
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
	function posSubmitForm(){/* POS�ɷ��� ҳ���ύ  start*/
			frm.submit();
			return true;
	}
	/*tianyang add POS�ɷ� end*/
	
	
  //***
  function frmCfm(){  	
  	//alert(document.all.payType.value);
  	if(document.all.payType.value=="BX")
  	{
    		/*set �������*/
				var transerial    = "000000000000";  	                     //����Ψһ�� ������ȡ��
				var trantype      = "00";                                  //��������
				var bMoney        = document.all.sum_money.value;					 //�ɷѽ��
				var tranoper      = "<%=loginNo%>";                        //���ײ���Ա
				var orgid         = "<%=groupId%>";                        //ӪҵԱ��������
				var trannum       = "<%=phoneNo%>";                    		 //�绰����
				getSysDate();       /*ȡbossϵͳʱ��*/
				var respstamp     = document.all.Request_time.value;       //�ύʱ��
				var transerialold = "";			                               //ԭ����Ψһ��,�ڽɷ�ʱ�����
				var org_code      = "<%=orgCode%>";                        //ӪҵԱ����						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = "05";																	/*�������� */         
				var bMoney        = document.all.sum_money.value;         /*���׽�� */         
				var response_time = "";                                   /*ԭ�������� */       
				var rrn           = "";                                   /*ԭ����ϵͳ������ */ 
				var instNum       = "";                                   /*���ڸ������� */     
				var terminalId    = "";                                   /*ԭ�����ն˺� */			
				getSysDate();       //ȡbossϵͳʱ��                                            
				var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
				var workno        = "<%=loginNo%>";                       /*���ײ���Ա */       
				var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
				var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
				var phoneNo       = "<%=phoneNo%>";                   		/*���׽ɷѺ� */       
				var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
  }
 //***IMEI ����У��
 function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     } 
     
       var IMEINo = $("#IMEINo").val();
       var agent_code = $("#agent_code").val();
       var phone_type = $("#phone_type").val();
       var Role_Code_add = $("#Role_Code_add").val();
       var opcode = $("#opcode").val();
      // alert(phone_type);
	
	var myPacket = new AJAXPacket("queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
	myPacket.data.add("imei_no",IMEINo);
	myPacket.data.add("brand_code",agent_code);
	myPacket.data.add("style_code",phone_type);
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",opcode);
	core.ajax.sendPacket(myPacket);
	myPacket =null; 
    
}
 function printCommit()
 { 
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!");
      cust_name.focus();
	  return false;
	}
	if(agent_code.value==""){
	  rdShowMessageDialog("�������ֻ�Ʒ��!");
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("�������ֻ��ͺ�!");
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("������Ӫ������!");
      sale_code.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     } 
	 document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
  }
 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     {
	   frmCfm();
     }
  }
  return true;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   /*
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
   */
   
  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             	//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							  //�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		  //С������
	var opCode="7955" ;                   			 	//��������
	var phoneNo="<%=phoneNo%>";                  //�ͻ��绰
	
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
}

function printInfo(printType)
{
 
  	var cust_info="";  				//�ͻ���Ϣ
		var opr_info="";   				//������Ϣ
		var note_info1=""; 				//��ע1
		var note_info2=""; 				//��ע2
		var note_info3=""; 				//��ע3
		var note_info4=""; 				//��ע4
		var retInfo = "";  				//��ӡ����
 
  
	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay*100/12)/100;
  

//	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
//	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="�û�Ʒ�ƣ�"+document.all.sm_code.value+"               ҵ�����ͣ����������ѣ����·�����"+"|";
  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	opr_info+="�ֻ��ͺ�: "+document.all.phone_typename.value+"      IMEI�룺"+document.frm.IMEINo.value+"|";
 	opr_info+="�ɿ�ϼƣ�"+document.all.sum_money.value+"Ԫ�������ͻ���"+document.all.pay_money.value+"Ԫ";

 	/*begin huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ*/
 	if(document.frm.TVprice.value!="0")
 	{
 		opr_info+="���ֻ����ӹ��ܷ�"+document.all.TVprice.value+"Ԫ";
 	}
 	if(document.frm.phoneNetPrice.value!="0" && document.frm.wlanPrice.value!="0")
 	{
 		opr_info+="���ֻ��������ܷ�"+document.all.phoneNetPrice.value+"��WLAN���ܷ�"+document.all.wlanPrice.value+"Ԫ";
 	}else
 	{
	 	if(document.frm.phoneNetPrice.value!="0")
	 	{
	 		opr_info+="���ֻ��������ܷ�"+document.all.phoneNetPrice.value+"Ԫ";
	 	}
	 	if(document.frm.wlanPrice.value!="0")
	 	{
	 		opr_info+="��WLAN���ܷ�"+document.all.wlanPrice.value+"Ԫ";
	 	} 		
 	}
 	opr_info+="|";	

 	/*end huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ*/	


	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	
	
	retInfo+="      ��ע��"+document.all.opNote.value+"|";
  	if(document.all.chg_flag.value == "1")//���·��أ��ۼ�����
	{
		note_info1+="��ע�����͵�Ԥ�滰�ѷ�"+document.all.consume_term.value+"���·���,ÿ�·���1/"+document.all.consume_term.value+",��"+document.all.consume_term.value+"������(����������)û��������,ϵͳ��һ�����ջ�ʣ�໰�ѡ����λ��������Ԥ���˲�ת��������ǰ�����������Żݵ�ר����������ķ��ý����ȴ��������Ż�ר����֧�������͵�Ԥ�������ڰ�������ר����ҵ������ꡢ�������ȣ��������ֻ����ۻ�������Ļ���δ�����꣬���ܰ�������ҵ��"+"|";	
   		note_info1+="��ʾ�����͵�Ԥ�滰�ѽ���ÿ��1��8ʱǰ���ͣ������ڻ�������ǰ��Ƿ��״̬�����ղ���ʹ���ⲿ��Ԥ�滰�ѣ���ȵ������賿�Ժ󷽿�ʹ�ã�������������нɷѣ�����Ƿ�ѣ����տ�ʹ�����͵�Ԥ�滰�ѡ�"+"|";
   		note_info1+="ҵ����ǰ������ȡ������ΥԼ�涨�����Żݼ۹�����ֻ������ֻ�ԭ�۲���������ʣ��Ԥ����30%����ΥԼ��"+"|";
   		note_info1+="δ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С����λ�ֻ������й��ƶ�ҵ����Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+"|";
	}
	else if(document.all.chg_flag.value == "2") //���
	{
		note_info2+="1��ҵ����Ч��12���£��������£������ͻ���ÿ���������ʹ���ܶ��1/12�������¼��ɿ�ʼʹ�ã�������Ļ����������н��ɡ�����Ҫ��18���£��������£���������ϣ����Ѳ��꣬��˾���ڵ�19���µĵ�һ��һ���Կ۳���2�������ֻ��Żݻ�����͵Ļ��Ѳ��˲�ת��δ�����꣬���ܰ�������ҵ��ҵ��δ����ǰ�������ظ������ҵ������ǩԼ���ն�Ӫ����������Ԥ����˻���ͬʱ������ͬ��ר���������������ר�3�����ڱ�ҵ����ǰ����ȡ��������Ҫ���������ֻ�ʱ�����ۼ۸����ۼ۸��Ե�ʱӪҵ����������Ӫ�������ֻ��۸�Ϊ׼�����Żݹ����֮��Ĳ��������������ȡ��ҵ��ʱʣ��Ԥ�滰��30%��ΥԼ��"+"|";
		note_info2+="�ر���ʾ�������λ������ֻ�������ֻ�������һ��ʹ�ã����ֻ����ֻ����ֿ�ʹ�������Ԥ�滰�Ѳ�������"+"|";
		note_info2+=" "+"|";
		note_info2+=" "+"|";
	}
 	/* ningtn IMEI���°�����*/
 	note_info1 += "�������ֻ���ʧ����Ϊ�𻵵ȸ���ԭ���޷�ʹ�ö���ɻ������룬�뵽Ӫҵ�����¹��������򽫲��ܼ���ʹ��ʣ�໰�ѡ�" + " |";
  	if(document.all.award_flag.value == "1")
	{
		note_info3+= "�Ѳ���������Ʒ�"+"|";
	}
	else
	{
		retInfo+= " "+"|";
	}
   	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}



//-->
</script>

<script language="JavaScript">
<!--
/****************����agent_code��̬����phone_type������************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
    
   myEle = document.createElement("option") ;
    myEle.value = "";
        myEle.text ="--��ѡ��--";
        controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        //alert("test "+GroupArray[x]+" and ");
		myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
   
   document.all.need_award.checked = false;
   document.all.award_flag.value = 0;
 } 
 function typechange(){
 
 	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--��ѡ��--";
        document.all.sale_code.add(myEle1) ;
   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{		//alert(arrsaletype[x1]);
   		//alert(document.all.phone_type.value);
      		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value)
      		{
        		myEle1 = document.createElement("option") ;
        		myEle1.value = arrsalecode[x1];
        		myEle1.text = arrsaleName[x1];
        		document.all.sale_code.add(myEle1) ;
      		}
   	}
   	document.all.need_award.checked = false;
    document.all.award_flag.value = 0;
		salechage();		
 }
 function salechage(){ 
	var getNote_Packet = new AJAXPacket("f7955_getprepay.jsp","���ڻ��Ӫ����ϸ�����Ժ�......");
  getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("agentCode",document.all.agent_code.value);
	getNote_Packet.data.add("phoneType",document.all.phone_type.value);
	getNote_Packet.data.add("saletype","17");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet =null; 
 }


 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 alert("����ѡ�����");
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	var packet = new AJAXPacket("phone_getAwardRpc.jsp","���ڻ�ý�Ʒ��ϸ�����Ժ�......");
  packet.data.add("retType","checkAward");
  packet.data.add("op_code","7955");
  packet.data.add("style_code",document.all.phone_type.value);
	core.ajax.sendPacket(packet);
	packet =null; 
 	 }
 	 document.all.award_flag.value = 0;
 	 
 }

//-->
</script>



</head>


<body >
<form name="frm" method="post" action="f7955Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
     <div class="title">
		<div id="title_zi">���������ѣ����·�����</div>
	 </div>					
			<div id="showMsg"></div>			
        <table  >
		  <tr > 
            <td class="blue">�������ͣ�</td>
            <td class="blue">���������ѣ����·�����--����</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr > 
            <td class="blue">�ͻ�����:</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text"   Class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="����"> 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">�ͻ���ַ:</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  Class="InputGrey"  v_must=1 readonly id="cust_addr" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">֤������:</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  Class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">֤������:</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  Class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">ҵ��Ʒ��:</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  Class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">����״̬:</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  Class="InputGrey"  v_must=1 readonly id="run_type" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">VIP����:</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1  Class="InputGrey" readonly id="vip" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">����Ԥ��:</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  Class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            </tr>
             <tr > 
            <td class="blue">�ֻ�Ʒ��:</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  
			  	onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="�ֻ�������">  
			    <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font class='orange'>*</font>	
			</td>
	 <td class="blue">�ֻ��ͺţ�</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="�ֻ��ͺ�" onchange="typechange()">	
			  	  
              </select>
			  <font class='orange'>*</font>
			</td>
          </tr>
          <tr > 
         
            <td class="blue">Ӫ��������
            </td>
            <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="Ӫ������" onchange="change()">			  
              </select>
			  <font class='orange'>*</font>
			</td>
			<td colspan="2" class="blue">�Ƿ��������<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
			</td>
            
          </tr>
          <tr > 
            <td  class="blue">�����</td>
            <td >
			  <input name="price" type="text"  id="price" v_type="money" v_must=1   Class="InputGrey" readonly v_name="�ֻ��۸�" >
			  <font class='orange'>*</font>	
			</td>
            <td class="blue">���ͻ��ѣ�</td>
            <td>
			  <input name="pay_money" type="text"  id="pay_money" v_type="0_9" v_must=1  Class="InputGrey"  v_name="���ͻ���" readonly>
			  <font class='orange'>*</font>
			</td>
          </tr>
		  <!--�ֻ������������� wangdana-->
          <tr > 
            <td class="blue">�ֻ����ӹ��ܷѣ�</td>
            <td >
			  <input name="TVprice" type="text"  id="TVprice" v_type="money" v_must=1  Class="InputGrey"  readonly v_name="�ֻ����ӹ��ܷ�" >
			  <font class='orange'>*</font>	
			</td>
            <td class="blue">�ֻ������������ޣ�</td>
            <td>
			  <input name="TVtime" type="text"   id="TVtime" v_type="0_9" v_must=1   Class="InputGrey" v_name="����ʱ��" readonly>
			  <font class='orange'>*</font>
			</td>
          </tr>
          
					<!--begin huangrong add �����ѣ������������·ݣ�WLANҵ��Ѻ�WLANҵ��������·ݵ���Ϣչʾ 2011-6-29-->
			    <tr> 
			      <td class="blue">�ֻ��������ܷѣ�</td>
			      <td >
						  <input name="phoneNetPrice"  type="text" class="button" id="phoneNetPrice" v_type="money" v_must=1   readonly v_name="�ֻ��������ܷ�" >
						  <font color="#FF0000">*</font>	
						</td>
			      <td class="blue">�ֻ������������ޣ�</td>
			      <td>
						  <input name="phoneNetTime" type="text"  class="button" id="phoneNetTime" v_type="0_9" v_must=1   v_name="����ʱ��" readonly>
						  <font color="#FF0000">*</font>
						</td>
			    </tr>            
			    <tr > 
			      <td class="blue">WLAN���ܷѣ�</td>
			      <td >
						  <input name="wlanPrice" type="text" class="button" id="wlanPrice" v_type="money" v_must=1   readonly v_name="WLANҵ���" >
						  <font color="#FF0000">*</font>	
						</td>
			      <td class="blue">WLAN�������ޣ�</td>
			      <td>
						  <input name="wlanTime" type="text"  class="button" id="wlanTime" v_type="0_9" v_must=1   v_name="����ʱ��" readonly>
						  <font color="#FF0000">*</font>
						</td>
			    </tr>                  
				  <!--end huangrong add �����ѣ������������·ݣ�WLANҵ��Ѻ�WLANҵ��������·ݵ���Ϣչʾ 2011-6-29-->          

          <tr > 
            <td class="blue">Ӧ����</td>
            <td >
			  <input name="sum_money" type="text"  id="sum_money"  Class="InputGrey" readonly>
			  <font class='orange'>*</font>
			  <input name="mach_fee" type="hidden"  id="mach_fee"  Class="InputGrey" readonly>
			</td>
            <td class="blue">����ޣ�</td>
            <td>
			  <input name="consume_term" type="text"   id="consume_term" v_type="0_9" v_must=1   v_name="�����"  Class="InputGrey" readonly>
			  <input name="chg_flag" type="hidden"   id="chg_flag" v_type="0_9" v_must=1  Class="InputGrey" readonly>
			  (����)<font class='orange'>*</font>
			</td>
          </tr> 
      <!-- tianyang add for pos start -->
			<tr > 
				<td class="blue">�ɷѷ�ʽ��
				</td>
				<td>
					<select name="payType" >
						<option value="0">�ֽ�ɷ�</option>
						<option value="BX">��������POS���ɷ�</option>
						<option value="BY">��������POS���ɷ�</option>
					</select>
					<font class='orange'>*</font>
				</td>
				<TD >&nbsp;</TD>
        <TD >&nbsp;</TD>
			</tr>
      <!-- tianyang add for pos end -->
         <TR > 
			<TD  nowrap> 
				<div align="left" class="blue">IMEI�룺</div>
            </TD>
            <TD > 
				<input name="IMEINo" id="IMEINo" type="text" v_type="0_9" v_name="IMEI��"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()">
                <font class='orange'>*</font>
            </TD>
			<TD>
			</td>
			<td>
			</td>
          </TR>
		  <TR  id=showHideTr > 
			<TD  nowrap> 
				<div align="left" class="blue">����ʱ�䣺</div>
            </TD>
			<TD > 
				<input name="payTime"  type="text" v_name="����ʱ��"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(������)<font class='orange'>*</font>                  
			</TD>
			<TD  nowrap> 
				<div align="left" class="blue">����ʱ��: </div>
			</TD>
			<TD > 
				<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="����ʱ��" value="12" onblur="viewConfirm()">
				(����)<font class='orange'>*</font>
			</TD>
          </TR>
		  <tr > 
            <td height="32"  class="blue">��ע��</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="���������ѣ����·�����" > 
            </td>
          </tr>
          <tr > 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()" disabled >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
                &nbsp; </div></td>
          </tr>
        </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>  
  </td>
  </tr>
  </table>	
  <input type="hidden" name="banlitype" value="<%=banlitype%>">
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" id="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="17" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<!-- tianyang add at 20100201 for POS�ɷ�����*****start*****-->		
	<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
	<input type="hidden" name="MerchantId"  value="">
	<input type="hidden" name="TerminalId"  value="">
	<input type="hidden" name="IssCode"  value="">
	<input type="hidden" name="AcqCode"  value="">
	<input type="hidden" name="CardNo"  value="">
	<input type="hidden" name="BatchNo"  value="">
	<input type="hidden" name="Response_time"  value="">
	<input type="hidden" name="Rrn"  value="">
	<input type="hidden" name="AuthNo"  value="">
	<input type="hidden" name="TraceNo"  value="">
	<input type="hidden" name="Request_time"  value="">
	<input type="hidden" name="CardNoPingBi"  value="">
	<input type="hidden" name="ExpDate"  value="">
	<input type="hidden" name="Remak"  value="">
	<input type="hidden" name="TC"  value="">
	<!-- tianyang add at 20100201 for POS�ɷ�����*****end*******-->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100430 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100430 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

</body>
</html>
