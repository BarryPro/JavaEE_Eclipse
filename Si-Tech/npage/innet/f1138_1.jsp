<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%

		
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
		String workName = WtcUtil.repNull((String)session.getAttribute("workName"));	
		String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String powerCode= WtcUtil.repNull((String)session.getAttribute("powerCode")); 
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String  groupId = WtcUtil.repNull((String)session.getAttribute("groupId"));
		
        String rowNum = "16";
        String sys_Date = "";
%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
<HTML><HEAD><TITLE>������Ʊ����</TITLE>
</HEAD>

<script type="text/javascript" src="/njs/si/validate_class.js"></script>

<SCRIPT type=text/javascript>

var printInfo="";
var printInfo1="";
var  billArgsObj = new Object();
onload=function()
{

}
//---------1------RPC������------------------
function doProcess(packet)
{
    //RPC������findValueByName
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");
    self.status="";
	if(retCode=="")
	{
       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�",0);
       return false;
	}
	if(retType == "innetInfo")
	{
		if(retCode == "000000")
		{
			/*
			var Op_time = "";
			var Function_name = "";
			var Sm_Name = "";
			var Cust_name = "";
			var Cust_address = "";
			var Id_name = "";
			var Id_iccid = "";
			var Phone_no = "";
			var Hand_Fee = "";
			var Choice_Fee = "";
			var Sim_Fee = "";
			var Machine_Fee = "";
			var Innet_Fee = "";
			var PrePay_Fee = "";
			var Cash_pay = "";
			var Check_pay = "";
			var payMode = "";
			var Op_note = "";
			 */

			document.frm1138.innetTime.value = packet.data.findValueByName("Op_time");
			document.frm1138.opName.value = packet.data.findValueByName("Function_name");
			document.frm1138.smCode.value = packet.data.findValueByName("Sm_Name");
			document.frm1138.custName.value = packet.data.findValueByName("Cust_name");
			document.frm1138.custAddr.value = packet.data.findValueByName("Cust_address");
			document.frm1138.iccType.value = packet.data.findValueByName("Id_name");
			document.frm1138.iccId.value = packet.data.findValueByName("Id_iccid");

			document.frm1138.beginPhoneNo.value = packet.data.findValueByName("Phone_no");
			document.frm1138.handFee.value = packet.data.findValueByName("Hand_Fee");
			document.frm1138.choiceFee.value = packet.data.findValueByName("Choice_Fee");
			document.frm1138.simFee.value = packet.data.findValueByName("Sim_Fee");
			document.frm1138.machFee.value = packet.data.findValueByName("Machine_Fee");

			document.frm1138.innetFee.value = packet.data.findValueByName("Innet_Fee");
			document.frm1138.preFee.value = packet.data.findValueByName("PrePay_Fee");
			document.frm1138.cashFee.value = packet.data.findValueByName("Cash_pay");
			document.frm1138.checkFee.value = packet.data.findValueByName("Check_pay");
			document.frm1138.h_payMode.value = packet.data.findValueByName("payMode");
  			document.frm1138.sysNote.value = packet.data.findValueByName("Op_note"); 
 			document.frm1138.vLogin_no.value = packet.data.findValueByName("vLogin_no");
 		}
		else
		{
    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			document.frm1138.opAccept.select();
		    document.frm1138.opAccept.focus();
			return false;
		}
	}


	if(retType == "flowNo")
	{
        if(retCode=="000000")
		{
           document.frm1138.opAccept.value=packet.data.findValueByName("flowNo");
		   document.frm1138.opAccept.focus();
		}
		else
		{
		   rdShowMessageDialog(retMessage,0);
		   document.frm1138.srv_no.select();
		   document.frm1138.srv_no.focus();
		}
	}

}

//---------------------------------------------
function printCommit()
{
	//������ˮ�õ�������Ϣ
    if(document.frm1138.opAccept.value.trim().length == 0)
    {
    	rdShowMessageDialog("�����뿪���ķ�����ˮ��",1);
    	document.frm1138.opAccept.focus();
    	return false;
    }
	else
	{
      if(parseInt(document.frm1138.opAccept.value)==0)
	  {
        rdShowMessageDialog("������ˮΪ0�����ܲ���Ʊ��",1);
    	document.frm1138.opAccept.focus();
    	return false;
	  }
	}
	 var busi_sumPay = 1*document.frm1138.cashFee.value+1*document.frm1138.checkFee.value+1*document.frm1138.preFee.value;
	if(busi_sumPay>0.01)
	{
	    showPrtDlg("Bill","ȷ��Ҫ����Ʊ��","Yes");
		document.frm1138.action="spubPrint_1138.jsp";
		document.frm1138.submit();
	}else{
		 rdShowMessageDialog("���ο���û�в������ã���˲��ܷ�Ʊ��ӡ��");
	}
}

//-----------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   getPrintInfo();
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	  //var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + DlgMessage;
			//��Ʊ��Ŀ�޸�Ϊ��·��
	var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + DlgMessage;

	var path = path + "&loginAccept="+document.frm1138.opAccept.value+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);
}

//---------------------------------
function getPrintInfo()
{
    //====================1======================
 	//var busi_sumPay=1*frm1138.innetFee.value+1*frm1138.choiceFee.value+1*frm1138.simFee.value+1*frm1138.machFee.value;
	//liucm��,�ϼƽ�����Ԥ��var busi_sumPay = 1*frm1138.cashFee.value+1*frm1138.checkFee.value;
  	var fee_sumPay=1*document.frm1138.preFee.value;
    var busi_sumPay = 1*document.frm1138.cashFee.value+1*document.frm1138.checkFee.value;+1*document.frm1138.preFee.value;
	var note = document.frm1138.sysNote.value;
		$(billArgsObj).attr("10001",document.frm1138.Login_no.value);       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",document.frm1138.custName.value); //�ͻ�����
 		$(billArgsObj).attr("10006","������Ʊ����"); //ҵ�����
 		$(billArgsObj).attr("10008",document.frm1138.beginPhoneNo.value ); //�û�����
 		$(billArgsObj).attr("10015", busi_sumPay.toFixed(2)); //���η�Ʊ���(Сд)��
 		$(billArgsObj).attr("10016", busi_sumPay.toFixed(2)); //��д���ϼ�
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		
 				
 		$(billArgsObj).attr("10017",sumtypes1); //���νɷ��ֽ�
 		$(billArgsObj).attr("10018",sumtypes2); //֧Ʊ
 		$(billArgsObj).attr("10019",sumtypes3); //ˢ��
 		$(billArgsObj).attr("10020",parseFloat(document.frm1138.innetFee.value).toFixed(2)); //������
 		$(billArgsObj).attr("10021",parseFloat(document.frm1138.handFee.value).toFixed(2)); //������
 		$(billArgsObj).attr("10022",parseFloat(document.frm1138.choiceFee.value).toFixed(2)); //ѡ�ŷ�
 		$(billArgsObj).attr("10024",parseFloat(document.frm1138.simFee.value).toFixed(2)); //SIM����
 		$(billArgsObj).attr("10025",fee_sumPay.toFixed(2)); //Ԥ�滰��
 		$(billArgsObj).attr("10026",parseFloat(document.frm1138.machFee.value).toFixed(2) ); //������
 		$(billArgsObj).attr("10030",document.frm1138.opAccept.value ); //��ˮ��--ҵ����ˮ
 		$(billArgsObj).attr("10036","<%=opCode%>"); //��������

	//====================2======================prepayFee
		var pay_money = parseFloat(document.frm1138.cashFee.value)+parseFloat(document.frm1138.checkFee.value);
		document.frm1138.pay_money.value=pay_money;
		printInfo1=document.frm1138.beginPhoneNo.value+"|"+document.frm1138.opAccept.value+"|"+document.frm1138.vLogin_no.value +"|"+document.frm1138.innetTime.value+"|"+pay_money+"|";
 		
}

//-----------------------------------
function getInfo()
{
	//������ˮ�õ�������Ϣ
    if(document.frm1138.opAccept.value.trim().length == 0)
    {
    	rdShowMessageDialog("�����뿪���ķ�����ˮ��",1);
    	document.frm1138.opAccept.focus();
    	return false;
    }
	else
	{
      if(parseInt(document.frm1138.opAccept.value)==0)
	  {
        rdShowMessageDialog("������ˮΪ0�����ܲ���Ʊ��",1);
    	document.frm1138.opAccept.focus();
    	return false;
	  }
	} 
	
	document.all.print.disabled=false;
    var getIdPacket = new AJAXPacket("f1138_3.jsp","���ڻ�ÿ�����Ϣ�����Ժ�......");
	getIdPacket.data.add("retType","innetInfo");
	getIdPacket.data.add("opAccept",document.frm1138.opAccept.value);
			core.ajax.sendPacket(getIdPacket);
			getIdPacket = null;
}

function getInfoBySrvNo()
{
   //���ݷ������õ���ˮ��
    if(document.frm1138.srv_no.value.trim().length > 0)
    {

		 /* �Ŷθ���20090422 liyan */
		//if(checkElement("srv_no")==false) return false;


		var getIdPacket = new AJAXPacket("f1138_4.jsp","���ڻ����ˮ�ţ����Ժ�......");
		getIdPacket.data.add("retType","flowNo");
		getIdPacket.data.add("srv_no",document.frm1138.srv_no.value);
			core.ajax.sendPacket(getIdPacket);
			getIdPacket = null;
	}
	else {
		 rdShowMessageDialog("�����������룡",1);
		}
}

function chgFlowNo()
{
  document.all.srv_no.value="";
  document.all.print.disabled=true;
}
//========================================
</SCRIPT>

<!--**************************************************************************************-->


<body >
<FORM method=post name="frm1138" action="f1138_2.jsp" onKeyUp="chgFocus(frm1138)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������Ʊ����</div>
</div> 

      <table cellspacing="0" >
        <tr>
          <td >
              <TABLE >
               
                <TR >
                  <TD class="blue">
                    �������
                  </TD>
                  <TD >
                    <input class="button" name=srv_no index="0" onKeyUp="if(event.keyCode==13)getInfoBySrvNo();" v_must=0 v_maxlength=16 v_type=mobphone  v_name="�������" maxlength=11>
                    <input name=infoQuery2 type=button class="b_text" onClick="getInfoBySrvNo()" style="cursor:hand" value="��ѯ��ˮ" v_must=0 v_maxlength=16 v_type=mobphone  v_name="�������">
                  </TD>
                  <td class="blue">
                   ������ˮ
                  </td>
                  <td >
                    <input class="button" name=opAccept v_type=int v_must=1 v_maxlength=14 v_name="������ˮ" onKeyUp="if(event.keyCode==13){getInfo();}else{chgFlowNo();}" maxlength="14" index="1">
                    <font color="orange">*</font>
                    <input name=infoQuery type=button class="b_text" onClick="getInfo()" style="cursor:hand" value="��ѯ��ϸ">
                  </td>
                </TR>

                <TR >
                  <TD class="blue">
                    ��������
                  </TD>
                  <TD >
                    <input  name=opName readonly class=InputGrey>
                  </TD>
                  <td class="blue">
                    ����ʱ��
                  </td>
                  <td >
                    <input  name=innetTime readonly class=InputGrey>
                  </td>
                </TR>
                <TR >
                  <td class="blue">
                    ҵ������
                  </td>
                  <td >
                    <input class=InputGrey name=smCode readonly>
                  </td>
                  <td class="blue">
                    �ͻ�����
                  </td>
                  <td >
                    <input class=InputGrey name=custName size=35 readonly>
                  </td>
                </TR>
                <TR >
                  <td class="blue">
                  �ͻ�֤������
                  </td>
                  <td >
                    <input class=InputGrey name=iccType readonly>
                  </td>
                  <td class="blue">
                    �ͻ�֤������
                  </td>
                  <td >
                    <input class=InputGrey name=iccId readonly>
                  </td>
                </TR>
                <TR >
                  <td class="blue">
                   �������
                  </td>
                  <td >
                    <input class=InputGrey name=beginPhoneNo readonly size=25>
                  </td>
                  <td class="blue">
                    �ͻ���ַ
                  </td>
                  <td >
                    <input class=InputGrey name=custAddr size=35 readonly>
                  </td>
                </TR>
                <TR >
                  <td class="blue">
                   ������
                  </td>
                  <td >
                    <input class=InputGrey name=handFee readonly>
                  </td>
                  <TD class="blue">������</TD>
                  <TD >
                    <input class=InputGrey name=innetFee readonly>
                  </TD>
                </TR>
                <TR bgc>
                  <td class="blue">
                    Ԥ���
                  </td>
                  <td >
                    <input class=InputGrey name=preFee readonly>
                  </td>
                  <TD class="blue">
                    ѡ�ŷ�
                  </TD>
                  <TD >
                    <input class=InputGrey name=choiceFee readonly>
                  </TD>
                </TR>
                <TR >
                  <td class="blue">
                    SIM����
                  </td>
                  <td >
                    <input class=InputGrey name=simFee readonly>
                  </td>
                  <TD class="blue">
                   ������
                  </TD>
                  <TD >
                    <input class=InputGrey name=machFee readonly>
                  </TD>
                </TR>
                <TR >
                  <td class="blue">
                   �ֽ𽻿�
                  </td>
                  <td >
                    <input class=InputGrey name=cashFee readonly>
                  </td>
                  <td class="blue">
                   ֧Ʊ����
                  </td>
                  <td >
                    <input class=InputGrey name=checkFee readonly>
                  </td>
                </TR>
                  <TR >
                  <TD class="blue">
                    ϵͳ��ע
                  </TD >
                  <TD colspan=3>
                    <input class=InputGrey name=sysNote size=60 readonly maxlength="30">
                  </TD>
                </TR>
               
                   <TR id="footer">
                   <TD colspan=4>
                       <input class="b_foot" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" type=button value=��ӡ index="2" disabled>
                    <input class="b_foot" name=reset1  type=button value=��� onclick="frm1138.reset();" index="3">
                    <input class="b_foot" name=back  onClick="window.close()" type=button value=�ر� index="4">
        </TD>
    </TR>
              </TABLE>



  	<!------------------------>
	<input type="hidden" name="Login_no" value="<%=workNo%>">  		<!--��½����-->
	<input type="hidden" name="Org_code" value="<%=orgCode%>"> 		<!--��������-->
	<input type="hidden" name="Ip_addr" value="<%=ip_Addr%>">		<!--IP��ַ-->
  	<input type="hidden" name="sysAccept" value="<%=printAccept%>">							<!--ϵͳ��ˮ��---->
  	<input type="hidden" name="printInfo" >							<!--��ӡ��Ϣ---->
	<input type="hidden" name="printInfo1" >							<!--��ӡ��Ϣ---->
	<input type="hidden" name="vLogin_no" >							<!--����ʱ��Ĺ���---->
	<input type="hidden" name="h_payMode" value="1">
	<input type="hidden" name="pay_money">
  	<!------------------------>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
