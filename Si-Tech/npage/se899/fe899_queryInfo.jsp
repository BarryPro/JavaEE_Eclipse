<%
    /*************************************
    * ��  ��: �����ն����۳��� e899
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-7-6
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String work_name = WtcUtil.repNull((String)session.getAttribute("workName"));
	String password = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String phoneNo = (String)request.getParameter("phoneNo");
	String orderNo = (String)request.getParameter("orderNo");
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
  
	<wtc:service name="se899Init"  routerKey="region" routerValue="<%=regionCode%>"   retcode="errcode" retmsg="errmsg" outnum="15">
	<wtc:param value="<%=printAccept%>" />
	<wtc:param value="01" />
	<wtc:param value="<%=opCode%>" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="<%=password%>" />
	<wtc:param value="<%=phoneNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=orderNo%>" />
	</wtc:service>
	<wtc:array id="retList" scope="end"/>

<%
	System.out.println("retList.length: "+retList.length);
	System.out.println("errcode: "+errcode);
	System.out.println("errmsg: "+errmsg);
%>
<HEAD>
  <TITLE>�����ն����۳����ѯ</TITLE>
</HEAD>
<script>
	function goBack(){
	  window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
	}
</script>
<% if (!"000000".equals(errcode)) {%>
    <script language="javascript">
    	rdShowMessageDialog("������룺<%=errcode%><br>������Ϣ��<%=errmsg%>",0);
    	window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
    </script>
<%}else{%>
<body>
<FORM method="post" name="frme899_query">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" id="machineTypeNo" name="machineTypeNo" value="" />
<input type="hidden" id="qryPhoneNo" name="qryPhoneNo" value="" />
<input type="hidden" id="selOpCode" name="selOpCode" value="" />
<input type="hidden" id="selOpName" name="selOpName" value="" />
<input type="hidden" id="selCustName" name="selCustName" value="" />
<input type="hidden" id="selSalePrice" name="selSalePrice" value="" />
<input type="hidden" id="prepayMoney" name="prepayMoney" value="" />
<input type="hidden" id="baseFee" name="baseFee" value="" />
<input type="hidden" id="brandName" name="brandName" value="" />
<input type="hidden" id="machineColor" name="machineColor" value="" />
<input type="hidden" id="qryOrderNo" name="qryOrderNo" value="" />
<input type="hidden" id="wlanPrice" name="wlanPrice" value="" />
<input type="hidden" id="xx_money" name="xx_money" value="" />
<input type="hidden" id="chinaFee" name="chinaFee" value="" />
<input type="hidden" id="phone_money" name="phone_money" value="" />
<input type="hidden" id="prepay_fee" name="prepay_fee" value="" />
<input type="hidden" id="chkPhoneMoneyFlag" name="chkPhoneMoneyFlag" value="" />
<input type="hidden" id="v_pay_money_cut" name="v_pay_money_cut" value="" />
<input type="hidden" id="v_TVprice_cut" name="v_TVprice_cut" value="" />
<input type="hidden" id="v_phoneNetPrice_cut" name="v_phoneNetPrice_cut" value="" />
<input type="hidden" id="v_wlanPrice_cut" name="v_wlanPrice_cut" value="" />
<input type="hidden" id="chinaFeeOne7955" name="chinaFeeOne7955" value="" />
<input type="hidden" id="v_phoneMoneyToTwo" name="v_phoneMoneyToTwo" value="" />
<input type="hidden" id="chinaFeeTwo7955" name="chinaFeeTwo7955" value="" />
<input type="hidden" id="v_prepayFeeToTwo" name="v_prepayFeeToTwo" value="" />
<input type="hidden" id="chinaFeeD069" name="chinaFeeD069" value="" />
<input type="hidden" id="v_prepayMoney_cut" name="v_prepayMoney_cut" value="" />
<input type="hidden" id="opAccept" name="opAccept" value="" />
<div id="Operation_Table">
  <div class="title">
  	<div id="title_zi">�����ն����۳����ѯ</div>
  </div>
  <table cellspacing="0">
    <tr>
      <th></th>
      <th>������</th>
	    <th>�绰��</th>
      <th>��ϵ�˺�</th>
      <th>���֤��</th>
      <th>����ʱ��</th>
      <th>���ʹ���</th>
    </tr>
    
  <%
  if(retList.length==0){
		out.println("<tr height='25' align='center'><td colspan='8'>");
		out.println("û���κμ�¼��");
		out.println("</td></tr>");
	}else if(retList.length>0){
  	for(int y=0;y<retList.length;y++){
      String tdClass = "";
      if (y%2==0){
          tdClass = "Grey";
      }
    %>
  	  <tr>
  	    <td class="<%=tdClass%>"><input type="radio" id="queryRadio" name="queryRadio" value="" v_qryOrderNo="<%=retList[y][0]%>" v_machineColor="<%=retList[y][5]%>" v_machineTypeNo="<%=retList[y][6]%>" v_phoneNo="<%=retList[y][1]%>" v_selOpCode="<%=retList[y][12]%>" v_selOpName="<%=retList[y][10]%>" v_selCustName="<%=retList[y][11]%>" v_selSalePrice="<%=retList[y][9]%>" v_prepayMoney="<%=retList[y][7]%>" v_baseFee="<%=retList[y][8]%>" v_brandName="<%=retList[y][13]%>" v_wlanPrice="<%=retList[y][14]%>" onclick="seleQryInfo(this)"  /></td>
  	    <td class="<%=tdClass%>"><%=retList[y][0].equals("")?"&nbsp;":retList[y][0]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][1].equals("")?"&nbsp;":retList[y][1]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][2].equals("")?"&nbsp;":retList[y][2]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][3].equals("")?"&nbsp;":retList[y][3]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][4].equals("")?"&nbsp;":retList[y][4]%></td>
  	    <td class="<%=tdClass%>"><%=retList[y][6].equals("")?"&nbsp;":retList[y][6]%></td>
  	   </tr>
    <%
      }
    }
  %>
  </table>
</div>
<div>
  <div class="title">
    <div id="title_zi">ѡ���������</div>
  </div>
  <TABLE cellSpacing=0>
    <TR id="newPassTr"> 
      <td  class="blue">IMEI��У��</td>
      <td>
         <input type="text" name="iMeiNo" id="iMeiNo" value=""  />
         <input type='button' class='b_text' id='chkIMeiNoBut' name='chkIMeiNoBut' onClick='chkIMeiNo()' value='У��' />
      </td>
    </TR>
  </TABLE>
   <table cellspacing=0>
    <tr id="footer"> 
      <td>
        <input class="b_foot" name="subUptBtn" id="subUptBtn" onClick="subInfo()" type="button" value="ȷ��" />
        <input class="b_foot" name="back" onClick="goBack()" type="button" value="����" />
        <input class="b_foot" name="back" onClick="removeCurrentTab()" type="button" value="�ر�" />
      </td>
    </tr>
  </table>
</div>

<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="javascript">
  window.onload=function(){
    $("#subUptBtn").attr("disabled","true");
  }
  
  /*У��IMEI��*/
  function chkIMeiNo(){
    var machineColor = $("#machineColor").val();
    
    var iMeiNo = $("input[name='iMeiNo']").val();   
    if(iMeiNo==""){
    rdShowMessageDialog("������IMEI�룡",1);
    return false;
    }
    if(isSeleQryFlay=="N"){
      rdShowMessageDialog("��ѡ���б��е�һ�",1);
      return false;
    }              
    var checkPwd_Packet = new AJAXPacket("fe899_ajax_checkImeiNo.jsp","���ڽ���IMEI��У�飬���Ժ�......");
    checkPwd_Packet.data.add("iMeiNo",iMeiNo);
    checkPwd_Packet.data.add("machineColor",machineColor);
    checkPwd_Packet.data.add("res_code",$("#machineTypeNo").val());
    core.ajax.sendPacket(checkPwd_Packet,doChkIMeiNo);
    checkPwd_Packet = null;
  }
  
  var passValidateFlag = "N";
	function doChkIMeiNo(packet){
	  var retMsg = packet.data.findValueByName("retmsg");
    var retCode = packet.data.findValueByName("retcode");
    var retchkImeiMsg = packet.data.findValueByName("retchkImeiMsg");
    if(retCode == "000000"){
      if(retchkImeiMsg!="0"){ 
        rdShowMessageDialog("IMEI��У��ɹ���",2);
        passValidateFlag = "Y";
        $("#subUptBtn").attr("disabled","");
      }else{
        rdShowMessageDialog("IMEI��У��ʧ�ܣ����������룡",0);
        $("#subUptBtn").attr("disabled","true");
        return false;
      }
    }else{
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
      $("#subUptBtn").attr("disabled","true");
	    return false;
    }
	}

  var isSeleQryFlay = "N";
  /*ѡ�����ύ�Ĳ�Ʒ*/
  function seleQryInfo(obj){
    isSeleQryFlay = "Y";
    $("#machineTypeNo").val(obj.v_machineTypeNo);
    $("#qryPhoneNo").val(obj.v_phoneNo);
    $("#selOpCode").val(obj.v_selOpCode);
    $("#selOpName").val(obj.v_selOpName);
    $("#selCustName").val(obj.v_selCustName);
    $("#selSalePrice").val(obj.v_selSalePrice);
    $("#prepayMoney").val(obj.v_prepayMoney);
    $("#baseFee").val(obj.v_baseFee);
    $("#brandName").val(obj.v_brandName);
    $("#machineColor").val(obj.v_machineColor);
    $("#qryOrderNo").val(obj.v_qryOrderNo);
    $("#wlanPrice").val(obj.v_wlanPrice);
    
  }
  
  /*�ύ*/
  function subInfo(){
    var qryPhoneNo = $("#qryPhoneNo").val();
    var iMeiNo  = $("#iMeiNo").val();
    var machineTypeNo = $("#machineTypeNo").val();
    var machineColor =$("#machineColor").val();
    var qryOrderNo =$("#qryOrderNo").val();
    if(isSeleQryFlay=="N"){
      rdShowMessageDialog("��ѡ���б��е�һ�",1);
		  return false;
    }
    /*���Թ���*/
    //printBillE505();
    //printBill7955();
    //printBillD069();
    //return false;
    /*���Թ���*/
    
    var packet = new AJAXPacket("/npage/se899/fe899_ajax_subInfo.jsp","���ڽ�������У�飬���Ժ�......");
    packet.data.add("opCode","<%=opCode%>");	
    packet.data.add("qryPhoneNo",qryPhoneNo);	
    packet.data.add("iMeiNo",iMeiNo);	
    packet.data.add("machineTypeNo",machineTypeNo);	
    packet.data.add("machineColor",machineColor);	
    packet.data.add("qryOrderNo",qryOrderNo);	
		core.ajax.sendPacket(packet, doSubInfo);
		checkPwd_Packet=null;
		
  }
  
  function doSubInfo(packet){
    var retCode = packet.data.findValueByName("retcode");
    var retMsg = packet.data.findValueByName("retmsg");
    var opAccept = packet.data.findValueByName("opAccept");//������ˮ
    $("#opAccept").val(opAccept);  
    var selOpCode = $("#selOpCode").val();
    if(retCode!="000000"){
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
      window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
    }else{
        rdShowMessageDialog("�����ɹ���",2);
        //window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
        var selSalePrice = $("#selSalePrice").val();//Ӧ����� 
        if(selOpCode=="e505"){
          toChinaFee(selSalePrice);
          printBillE505();
        }else if(selOpCode=="7955"){
          printBill7955();
        }else if(selOpCode=="d069"){
          printBillD069();
        }else{
          window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
        }
    }
  }
  
  function toChinaFee(selSalePrice){
    var myPacket = new AJAXPacket("fe899_ajax_toChinaFee.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
  	myPacket.data.add("selSalePrice",selSalePrice);
  	core.ajax.sendPacket(myPacket,doToChinaFee);
  	myPacket=null; 
  }
  
  function doToChinaFee(packet){
    var retCode = packet.data.findValueByName("retcode");
    var retMsg = packet.data.findValueByName("retmsg");
    var v_xx_money = packet.data.findValueByName("v_xx_money");
    var v_chinaFee = packet.data.findValueByName("chinaFee");//Ӧ������д
    $("#chinaFee").val(v_chinaFee);
    $("#xx_money").val(v_xx_money);
  }
  
  function toChinaFeeD069(prepayMoney){
    var myPacket = new AJAXPacket("fe899_ajax_toChinaFeeD069.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
    myPacket.data.add("prepayMoney",prepayMoney);
    core.ajax.sendPacket(myPacket,doToChinaFeeD069);
    myPacket=null; 
  }
  
  function doToChinaFeeD069(packet){
    var chinaFeeD069 = packet.data.findValueByName("chinaFeeD069");//Ӧ������д
    var v_prepayMoney_cut = packet.data.findValueByName("v_prepayMoney_cut");
    $("#chinaFeeD069").val(chinaFeeD069);
    $("#v_prepayMoney_cut").val(v_prepayMoney_cut);
  }
  
  function toChinaFeeOne7955(phone_money){
    var myPacket = new AJAXPacket("fe899_ajax_toChinaFeeOne7955.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
  	myPacket.data.add("phone_money",phone_money);
  	core.ajax.sendPacket(myPacket,doToChinaFeeOne7955);
  	myPacket=null; 
  }
  
  function doToChinaFeeOne7955(packet){
    var chinaFeeOne7955 = packet.data.findValueByName("chinaFeeOne7955");
    var v_phoneMoneyToTwo = packet.data.findValueByName("v_phoneMoneyToTwo");//Ӧ������д
    $("#chinaFeeOne7955").val(chinaFeeOne7955);
    $("#v_phoneMoneyToTwo").val(v_phoneMoneyToTwo);
  }
  
  function toChinaFeeTwo7955(prepay_fee){
    var myPacket = new AJAXPacket("fe899_ajax_toChinaFeeTwo7955.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
  	myPacket.data.add("prepay_fee",prepay_fee);
  	core.ajax.sendPacket(myPacket,doToChinaFeeTwo7955);
  	myPacket=null; 
  }
  
  function doToChinaFeeTwo7955(packet){
    var chinaFeeTwo7955 = packet.data.findValueByName("chinaFeeTwo7955");
    var v_prepayFeeToTwo = packet.data.findValueByName("v_prepayFeeToTwo");//Ӧ������д
    $("#chinaFeeTwo7955").val(chinaFeeTwo7955);
    $("#v_prepayFeeToTwo").val(v_prepayFeeToTwo);
  }
  
  function printBillE505() {
    var opAccept = $("#opAccept").val();  //������ˮ
    var selOpName = $("#selOpName").val();
    var selCustName = $("#selCustName").val();
    var qryPhoneNo = $("#qryPhoneNo").val();
    var iMeiNo = $("input[name='iMeiNo']").val();
    var selSalePrice = $("#selSalePrice").val();//�ɷѺϼ�
    var prepayMoney = $("#prepayMoney").val();//�Ԥ��
    var baseFee = $("#baseFee").val();//����Ԥ��
    var brandName = $("#brandName").val();//�ֻ��ͺ�
    var chinaFee = $("#chinaFee").val();
    var xx_money = $("#xx_money").val();
    var v_opName ="��Լ�ƻ�����";
    
    var sum_money = parseFloat(prepayMoney)+parseFloat(baseFee);    
    var infoStr="";        
    infoStr+="<%=workNo%>  "+opAccept+"     "+selOpName+v_opName+"|";//����                                                 
    infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
    infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    infoStr+=selCustName+"|";//�û�����                                                 
    infoStr+=" "+"|";//��ͬ����                                                          
    infoStr+=qryPhoneNo+"|";//�ƶ�����                                              
    infoStr+=""+"|";//�û���ַ
    infoStr+="|";
    
    infoStr+= chinaFee +"|";//�ϼƽ��(��д)10
    infoStr+= xx_money+"|";//Сд 
    
    infoStr+="�ֻ��ͺ�:"+brandName+"~";
    infoStr+="IMEI�ţ�"+iMeiNo+"~";
    
    infoStr+="�ɿ�ϼƣ�  "+selSalePrice+ "Ԫ     ��Ԥ�滰�ѣ�" + sum_money + "Ԫ" + "|";
    infoStr+="<%=work_name%>"+"|";//��Ʊ��
    infoStr+=" "+"|";//�տ���
    infoStr+=" "+"|";
    location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e899&loginAccept="+opAccept+"&dirtPage=/npage/se899/fe899_main.jsp?activePhone="+qryPhoneNo+"%26opCode=e899%26opName=�����ն����۳���";
}

  function printBillD069(){
    
    var selOpName = $("#selOpName").val();
    var selCustName = $("#selCustName").val();//�û�����
    var qryPhoneNo = $("#qryPhoneNo").val();
    var iMeiNo = $("input[name='iMeiNo']").val();
    var prepayMoney = $("#prepayMoney").val();//Ӧ�ս��
    var brandName = $("#brandName").val();//�ֻ��ͺ�
    var baseFee = $("#baseFee").val();//Ԥ�滰��
    var TVprice = $("#selSalePrice").val();//�ֻ����ӷ�  
    var opAccept = $("#opAccept").val(); //������ˮ
    
    toChinaFeeD069(prepayMoney);
    var chinaFeeD069 = $("#chinaFeeD069").val();
    var v_prepayMoney_cut = $("#v_prepayMoney_cut").val();
    
    rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
    var infoStr=""; 
    
    infoStr+="<%=workNo%>  <%=printAccept%>"+"       ��Լ�ƻ�Ԥ�湺��"+"|";//����
    infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
    infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
    infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
    infoStr+=selCustName+"|";//�û�����
    infoStr+=qryPhoneNo+"|";//����
    infoStr+=qryPhoneNo+"|";//�ƶ�����
    infoStr+=" "+"|";//Э�����
    infoStr+=" "+"|";//֧Ʊ���� 
    infoStr+=chinaFeeD069+"|";//�ϼƽ��(��д)
    infoStr+=v_prepayMoney_cut+"|";//Сд
    //ҵ����Ŀ
    infoStr+="�ֻ��ͺţ�"+brandName+"   "+
     "IMEI�룺"+iMeiNo+"~"+"�ɷѺϼƣ�"+chinaFeeD069+"Ԫ"+"    ��Ԥ�滰�ѣ�"+baseFee+"Ԫ"+"    �ֻ����ӷѣ�"+TVprice+"Ԫ"+"|";
    
    
    infoStr+="<%=work_name%>"+"|";//��Ʊ��
    infoStr+=" "+"|";//�տ���
    infoStr+=" "+"|";//�տ���
    infoStr+=" "+"|";//�տ���
    dirtPate = "<%=request.getContextPath()%>/npage/se899/fe899_main.jsp?activePhone="+qryPhoneNo+"%26opCode=e899%26opName=�����ն����۳���";
    window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e899&loginAccept="+opAccept+"&dirtPage="+dirtPate;	
  }

 function printBill7955() {
  var sum_money = $("#prepayMoney").val();//Ӧ�ս��
  var pay_money = $("#baseFee").val();//���ͻ��ѣ�Ԥ�滰�ѣ�
  var TVprice = $("#selSalePrice").val();//�ֻ����ӹ��ܷ�
  var phoneNetPrice = $("#selOpName").val();//�ֻ��������ܷ�
  var selCustName = $("#selCustName").val();//�û�����
  var brandName = $("#brandName").val();//�ֻ��ͺ�
  var wlanPrice = $("#wlanPrice").val();//WLAN���ܷ�
  
  var qryPhoneNo = $("#qryPhoneNo").val();
  var iMeiNo = $("input[name='iMeiNo']").val();
  var chinaFee = $("#chinaFee").val();
  var xx_money = $("#xx_money").val();
  var v_opName ="��Լ�ƻ�����";
  
  checkPhoneMoney(sum_money,pay_money,TVprice,phoneNetPrice,wlanPrice);
  //checkPhoneMoney(sum_money,pay_money,TVprice,200.3456,11);
  
  var prepay_fee = $("#prepay_fee").val();
  var phone_money = $("#phone_money").val();
  var chkPhoneMoneyFlag = $("#chkPhoneMoneyFlag").val();
  
  toChinaFeeOne7955(phone_money);
  toChinaFeeTwo7955(prepay_fee);
  
  if(chkPhoneMoneyFlag=="Y"){
    /*** ��һ�ŷ�Ʊ ***/
    //TVprice = "111";
    //phoneNetPrice="222.22222";
    //wlanPrice = "33.8907";
		rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
		printInfo(TVprice,phoneNetPrice,wlanPrice);	
  }else{
    rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
		printInfo1(TVprice,phoneNetPrice,wlanPrice);	
  }
  }

function printInfo(TVprice,phoneNetPrice,wlanPrice)
{
   var selCustName = $("#selCustName").val();
   var brandName = $("#brandName").val();//�ֻ��ͺ�
   var iMeiNo = $("input[name='iMeiNo']").val();
   var qryPhoneNo = $("#qryPhoneNo").val();
   var chinaFeeOne7955 = $("#chinaFeeOne7955").val();
   var v_phoneMoneyToTwo = $("#v_phoneMoneyToTwo").val();
   
   var chinaFeeTwo7955 = $("#chinaFeeTwo7955").val();
   var v_prepayFeeToTwo = $("#v_prepayFeeToTwo").val();
   var v_pay_money_cut = $("#v_pay_money_cut").val();
   var v_TVprice_cut = $("#v_TVprice_cut").val();
   var v_phoneNetPrice_cut = $("#v_phoneNetPrice_cut").val();
   var v_wlanPrice_cut = $("#v_wlanPrice_cut").val();   
   var opAccept = $("#opAccept").val(); //������ˮ
   
   var infoStr = "";		  
   infoStr+="<%=workNo%>  <%=work_name%>"+"       ���������ѣ����·�����2-1"+"|";//����
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+=selCustName +"|";
   infoStr+=" "+"|";//��ͬ����
   infoStr+=qryPhoneNo +"|";
   infoStr+=" "+"|";//Э�����
   infoStr+=" "+"|";
   infoStr+=chinaFeeOne7955+"|";//�ϼƽ��(��д)
   infoStr+=v_phoneMoneyToTwo+"|";//Сд
   infoStr+=" �ֻ��ͺţ�"+brandName+"  IMEI�룺"+iMeiNo+"~";
   infoStr+="|";
   infoStr+="<%=work_name%>"+"|";//��Ʊ��
   infoStr+=" "+"|";//�տ���
   infoStr+=" "+"|";//�տ���
	 infoStr+=" "+"|";

   rdShowMessageDialog("��ӡ�ڶ��ŷ�Ʊ��",2);
   var infoStr2 = "";	
   infoStr2+="<%=workNo%>  <%=work_name%>"+"       ���������ѣ����·�����2-2"+"|";//����
   infoStr2+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr2+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr2+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr2+=selCustName+"|";
   infoStr2+=" "+"|";//��ͬ���� 
   infoStr2+=qryPhoneNo+"|";
   infoStr2+="1"+"|";//Э�����
   infoStr2+=" "+"|";
   infoStr2+=chinaFeeTwo7955+"|";//�ϼƽ��(��д)
   infoStr2+=v_prepayFeeToTwo+"|";//Сд
   infoStr2+="�ֻ��ͺţ�"+brandName+"  IMEI�룺"+iMeiNo+"~";
	 infoStr2+="ҵ����ϸ"+"  Ԥ�滰��: "+v_pay_money_cut+"Ԫ"; 
	               
	 	
	 	//begin huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ
	 	if(TVprice !="0")
	 	{
	 		infoStr2+="���ֻ����ӹ��ܷ�"+v_TVprice_cut+"Ԫ";
	 	}
	 	if(phoneNetPrice !="0" && wlanPrice !="0")
	 	{
	 		infoStr2+="���ֻ��������ܷ�"+v_phoneNetPrice_cut+"Ԫ��WLAN���ܷ�"+v_wlanPrice_cut+"Ԫ";
	 	}
	  if(phoneNetPrice!="0" && wlanPrice =="0" )
	  {
	  	infoStr2+="���ֻ��������ܷ�"+v_phoneNetPrice_cut+"Ԫ";
	  }
	 	if(phoneNetPrice =="0" && wlanPrice !="0" )
	 	{
	 		infoStr2+="��WLAN���ܷ�"+v_wlanPrice_cut+"Ԫ";
	 	}	
	 	//end huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ	 
	 	
   infoStr2+="|";
   infoStr2+="<%=work_name%>"+"|";//��Ʊ��
   infoStr2+=" "+"|";//�տ���
   infoStr2+=""+"|";			 	
	 infoStr2+=" "+"|";
 		  dirtPate = "<%=request.getContextPath()%>/npage/se899/fe899_main.jsp?activePhone="+qryPhoneNo+"%26opCode=e899%26opName=�����ն����۳���";
  window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&infoStr2="+infoStr2+"&op_code=e899&prNum=2&loginAccept="+opAccept+"&dirtPage="+dirtPate;	
}

function printInfo1(TVprice,phoneNetPrice,wlanPrice)
{
  var selCustName = $("#selCustName").val();
  var brandName = $("#brandName").val();//�ֻ��ͺ�
  var iMeiNo = $("input[name='iMeiNo']").val();
  var qryPhoneNo = $("#qryPhoneNo").val();
  var chinaFeeTwo7955 = $("#chinaFeeTwo7955").val();
  var v_prepayFeeToTwo = $("#v_prepayFeeToTwo").val();
  var v_pay_money_cut = $("#v_pay_money_cut").val();
  var v_TVprice_cut = $("#v_TVprice_cut").val();
  var v_phoneNetPrice_cut = $("#v_phoneNetPrice_cut").val();
  var v_wlanPrice_cut = $("#v_wlanPrice_cut").val();       
  var opAccept = $("#opAccept").val(); //������ˮ        
  
  var infoStr = "";		  
  infoStr+="<%=workNo%>  <%=work_name%>"+"       ���������ѣ����·�����2-2"+"|";//����
  infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  infoStr+=selCustName+"|";//�û����� 
  infoStr+=" "+"|";//��ͬ���� 
  infoStr+=qryPhoneNo+"|";
  infoStr+="1"+"|";//Э�����
  infoStr+=" "+"|";
  infoStr+=chinaFeeTwo7955+"|";//�ϼƽ��(��д)
  infoStr+=v_prepayFeeToTwo+"|";//Сд
  
  infoStr+="�ֻ��ͺţ�"+brandName+"  IMEI�룺"+iMeiNo+"~";
  infoStr+="ҵ����ϸ"+"  Ԥ�滰��: "+v_pay_money_cut+"Ԫ";   
              
  	 	if(TVprice !="0")
  {
  	infoStr+="���ֻ����ӹ��ܷ�"+v_TVprice_cut+"Ԫ";
  }
  if(phoneNetPrice!="0" && wlanPrice!="0")
  {
  	infoStr+="���ֻ��������ܷ�"+v_phoneNetPrice_cut+"Ԫ��WLAN���ܷ�"+v_wlanPrice_cut+"Ԫ";
  }
  if(phoneNetPrice!="0" && wlanPrice=="0" )
  {
  	infoStr+="���ֻ��������ܷ�"+v_phoneNetPrice_cut+"Ԫ";
  }
  if(phoneNetPrice =="0" && wlanPrice !="0" )
  {
  	infoStr+="��WLAN���ܷ�"+v_wlanPrice_cut+"Ԫ";
  }	
  //end huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ	 
  
  infoStr+="|";
  
  infoStr+="<%=work_name%>"+"|";//��Ʊ��
  infoStr+=" "+"|";//�տ���
  infoStr+=""+"|";			 	
  	infoStr+=" "+"|";
       	
    dirtPate = "<%=request.getContextPath()%>/npage/se899/fe899_main.jsp?activePhone="+qryPhoneNo+"%26opCode=e899%26opName=�����ն����۳���";
  window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e899&loginAccept="+opAccept+"&dirtPage="+dirtPate;	
}

  /*У��phoneMoney���ж�*/
  function checkPhoneMoney(sum_money,pay_money,TVprice,phoneNetPrice,wlanPrice){
    var myPacket = new AJAXPacket("fe899_ajax_checkPhoneMoney.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
  	myPacket.data.add("sum_money",sum_money);
  	myPacket.data.add("pay_money",pay_money);
  	myPacket.data.add("TVprice",TVprice);
  	myPacket.data.add("phoneNetPrice",phoneNetPrice);
  	myPacket.data.add("wlanPrice",wlanPrice);
  	core.ajax.sendPacket(myPacket,doCheckPhoneMoney);
  	myPacket=null; 
  }
  
  function doCheckPhoneMoney(packet){
    var v_prepay_fee = packet.data.findValueByName("prepay_fee");
    var v_phone_money = packet.data.findValueByName("phone_money");
    var v_chkPhoneMoneyFlag = packet.data.findValueByName("chkPhoneMoneyFlag");
    var v_pay_money_cut = packet.data.findValueByName("pay_money_cut");
    var v_TVprice_cut = packet.data.findValueByName("TVprice_cut");
    var v_phoneNetPrice_cut = packet.data.findValueByName("phoneNetPrice_cut");
    var v_wlanPrice_cut = packet.data.findValueByName("wlanPrice_cut");
    $("#prepay_fee").val(v_prepay_fee);
    $("#phone_money").val(v_phone_money);
    $("#chkPhoneMoneyFlag").val(v_chkPhoneMoneyFlag);
    $("#v_pay_money_cut").val(v_pay_money_cut);
    $("#v_TVprice_cut").val(v_TVprice_cut);
    $("#v_phoneNetPrice_cut").val(v_phoneNetPrice_cut);
    $("#v_wlanPrice_cut").val(v_wlanPrice_cut);
  }


</script>
</BODY>
</HTML>
<%}%>