<%
    /*************************************
    * 功  能: 网上终端销售出库 e899
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
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
  <TITLE>网上终端销售出库查询</TITLE>
</HEAD>
<script>
	function goBack(){
	  window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
	}
</script>
<% if (!"000000".equals(errcode)) {%>
    <script language="javascript">
    	rdShowMessageDialog("错误代码：<%=errcode%><br>错误信息：<%=errmsg%>",0);
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
  	<div id="title_zi">网上终端销售出库查询</div>
  </div>
  <table cellspacing="0">
    <tr>
      <th></th>
      <th>定单号</th>
	    <th>电话号</th>
      <th>联系人号</th>
      <th>身份证号</th>
      <th>操作时间</th>
      <th>机型代码</th>
    </tr>
    
  <%
  if(retList.length==0){
		out.println("<tr height='25' align='center'><td colspan='8'>");
		out.println("没有任何记录！");
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
    <div id="title_zi">选择操作类型</div>
  </div>
  <TABLE cellSpacing=0>
    <TR id="newPassTr"> 
      <td  class="blue">IMEI码校验</td>
      <td>
         <input type="text" name="iMeiNo" id="iMeiNo" value=""  />
         <input type='button' class='b_text' id='chkIMeiNoBut' name='chkIMeiNoBut' onClick='chkIMeiNo()' value='校验' />
      </td>
    </TR>
  </TABLE>
   <table cellspacing=0>
    <tr id="footer"> 
      <td>
        <input class="b_foot" name="subUptBtn" id="subUptBtn" onClick="subInfo()" type="button" value="确认" />
        <input class="b_foot" name="back" onClick="goBack()" type="button" value="返回" />
        <input class="b_foot" name="back" onClick="removeCurrentTab()" type="button" value="关闭" />
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
  
  /*校验IMEI码*/
  function chkIMeiNo(){
    var machineColor = $("#machineColor").val();
    
    var iMeiNo = $("input[name='iMeiNo']").val();   
    if(iMeiNo==""){
    rdShowMessageDialog("请输入IMEI码！",1);
    return false;
    }
    if(isSeleQryFlay=="N"){
      rdShowMessageDialog("请选择列表中的一项！",1);
      return false;
    }              
    var checkPwd_Packet = new AJAXPacket("fe899_ajax_checkImeiNo.jsp","正在进行IMEI码校验，请稍候......");
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
        rdShowMessageDialog("IMEI码校验成功！",2);
        passValidateFlag = "Y";
        $("#subUptBtn").attr("disabled","");
      }else{
        rdShowMessageDialog("IMEI码校验失败！请重新输入！",0);
        $("#subUptBtn").attr("disabled","true");
        return false;
      }
    }else{
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      $("#subUptBtn").attr("disabled","true");
	    return false;
    }
	}

  var isSeleQryFlay = "N";
  /*选择需提交的产品*/
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
  
  /*提交*/
  function subInfo(){
    var qryPhoneNo = $("#qryPhoneNo").val();
    var iMeiNo  = $("#iMeiNo").val();
    var machineTypeNo = $("#machineTypeNo").val();
    var machineColor =$("#machineColor").val();
    var qryOrderNo =$("#qryOrderNo").val();
    if(isSeleQryFlay=="N"){
      rdShowMessageDialog("请选择列表中的一项！",1);
		  return false;
    }
    /*测试过程*/
    //printBillE505();
    //printBill7955();
    //printBillD069();
    //return false;
    /*测试过程*/
    
    var packet = new AJAXPacket("/npage/se899/fe899_ajax_subInfo.jsp","正在进行密码校验，请稍候......");
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
    var opAccept = packet.data.findValueByName("opAccept");//操作流水
    $("#opAccept").val(opAccept);  
    var selOpCode = $("#selOpCode").val();
    if(retCode!="000000"){
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
    }else{
        rdShowMessageDialog("操作成功！",2);
        //window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
        var selSalePrice = $("#selSalePrice").val();//应付金额 
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
    var myPacket = new AJAXPacket("fe899_ajax_toChinaFee.jsp","正在获取信息，请稍候......");
  	myPacket.data.add("selSalePrice",selSalePrice);
  	core.ajax.sendPacket(myPacket,doToChinaFee);
  	myPacket=null; 
  }
  
  function doToChinaFee(packet){
    var retCode = packet.data.findValueByName("retcode");
    var retMsg = packet.data.findValueByName("retmsg");
    var v_xx_money = packet.data.findValueByName("v_xx_money");
    var v_chinaFee = packet.data.findValueByName("chinaFee");//应付金额大写
    $("#chinaFee").val(v_chinaFee);
    $("#xx_money").val(v_xx_money);
  }
  
  function toChinaFeeD069(prepayMoney){
    var myPacket = new AJAXPacket("fe899_ajax_toChinaFeeD069.jsp","正在获取信息，请稍候......");
    myPacket.data.add("prepayMoney",prepayMoney);
    core.ajax.sendPacket(myPacket,doToChinaFeeD069);
    myPacket=null; 
  }
  
  function doToChinaFeeD069(packet){
    var chinaFeeD069 = packet.data.findValueByName("chinaFeeD069");//应付金额大写
    var v_prepayMoney_cut = packet.data.findValueByName("v_prepayMoney_cut");
    $("#chinaFeeD069").val(chinaFeeD069);
    $("#v_prepayMoney_cut").val(v_prepayMoney_cut);
  }
  
  function toChinaFeeOne7955(phone_money){
    var myPacket = new AJAXPacket("fe899_ajax_toChinaFeeOne7955.jsp","正在获取信息，请稍候......");
  	myPacket.data.add("phone_money",phone_money);
  	core.ajax.sendPacket(myPacket,doToChinaFeeOne7955);
  	myPacket=null; 
  }
  
  function doToChinaFeeOne7955(packet){
    var chinaFeeOne7955 = packet.data.findValueByName("chinaFeeOne7955");
    var v_phoneMoneyToTwo = packet.data.findValueByName("v_phoneMoneyToTwo");//应付金额大写
    $("#chinaFeeOne7955").val(chinaFeeOne7955);
    $("#v_phoneMoneyToTwo").val(v_phoneMoneyToTwo);
  }
  
  function toChinaFeeTwo7955(prepay_fee){
    var myPacket = new AJAXPacket("fe899_ajax_toChinaFeeTwo7955.jsp","正在获取信息，请稍候......");
  	myPacket.data.add("prepay_fee",prepay_fee);
  	core.ajax.sendPacket(myPacket,doToChinaFeeTwo7955);
  	myPacket=null; 
  }
  
  function doToChinaFeeTwo7955(packet){
    var chinaFeeTwo7955 = packet.data.findValueByName("chinaFeeTwo7955");
    var v_prepayFeeToTwo = packet.data.findValueByName("v_prepayFeeToTwo");//应付金额大写
    $("#chinaFeeTwo7955").val(chinaFeeTwo7955);
    $("#v_prepayFeeToTwo").val(v_prepayFeeToTwo);
  }
  
  function printBillE505() {
    var opAccept = $("#opAccept").val();  //操作流水
    var selOpName = $("#selOpName").val();
    var selCustName = $("#selCustName").val();
    var qryPhoneNo = $("#qryPhoneNo").val();
    var iMeiNo = $("input[name='iMeiNo']").val();
    var selSalePrice = $("#selSalePrice").val();//缴费合计
    var prepayMoney = $("#prepayMoney").val();//活动预存
    var baseFee = $("#baseFee").val();//底线预存
    var brandName = $("#brandName").val();//手机型号
    var chinaFee = $("#chinaFee").val();
    var xx_money = $("#xx_money").val();
    var v_opName ="合约计划购机";
    
    var sum_money = parseFloat(prepayMoney)+parseFloat(baseFee);    
    var infoStr="";        
    infoStr+="<%=workNo%>  "+opAccept+"     "+selOpName+v_opName+"|";//工号                                                 
    infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
    infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    infoStr+=selCustName+"|";//用户名称                                                 
    infoStr+=" "+"|";//合同号码                                                          
    infoStr+=qryPhoneNo+"|";//移动号码                                              
    infoStr+=""+"|";//用户地址
    infoStr+="|";
    
    infoStr+= chinaFee +"|";//合计金额(大写)10
    infoStr+= xx_money+"|";//小写 
    
    infoStr+="手机型号:"+brandName+"~";
    infoStr+="IMEI号："+iMeiNo+"~";
    
    infoStr+="缴款合计：  "+selSalePrice+ "元     含预存话费：" + sum_money + "元" + "|";
    infoStr+="<%=work_name%>"+"|";//开票人
    infoStr+=" "+"|";//收款人
    infoStr+=" "+"|";
    location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e899&loginAccept="+opAccept+"&dirtPage=/npage/se899/fe899_main.jsp?activePhone="+qryPhoneNo+"%26opCode=e899%26opName=网上终端销售出库";
}

  function printBillD069(){
    
    var selOpName = $("#selOpName").val();
    var selCustName = $("#selCustName").val();//用户姓名
    var qryPhoneNo = $("#qryPhoneNo").val();
    var iMeiNo = $("input[name='iMeiNo']").val();
    var prepayMoney = $("#prepayMoney").val();//应收金额
    var brandName = $("#brandName").val();//手机型号
    var baseFee = $("#baseFee").val();//预存话费
    var TVprice = $("#selSalePrice").val();//手机电视费  
    var opAccept = $("#opAccept").val(); //操作流水
    
    toChinaFeeD069(prepayMoney);
    var chinaFeeD069 = $("#chinaFeeD069").val();
    var v_prepayMoney_cut = $("#v_prepayMoney_cut").val();
    
    rdShowMessageDialog("提交成功! 下面将打印发票！",2);
    var infoStr=""; 
    
    infoStr+="<%=workNo%>  <%=printAccept%>"+"       合约计划预存购机"+"|";//工号
    infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//年
    infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";//月
    infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日
    infoStr+=selCustName+"|";//用户名称
    infoStr+=qryPhoneNo+"|";//卡号
    infoStr+=qryPhoneNo+"|";//移动号码
    infoStr+=" "+"|";//协议号码
    infoStr+=" "+"|";//支票号码 
    infoStr+=chinaFeeD069+"|";//合计金额(大写)
    infoStr+=v_prepayMoney_cut+"|";//小写
    //业务项目
    infoStr+="手机型号："+brandName+"   "+
     "IMEI码："+iMeiNo+"~"+"缴费合计："+chinaFeeD069+"元"+"    含预存话费："+baseFee+"元"+"    手机电视费："+TVprice+"元"+"|";
    
    
    infoStr+="<%=work_name%>"+"|";//开票人
    infoStr+=" "+"|";//收款人
    infoStr+=" "+"|";//收款人
    infoStr+=" "+"|";//收款人
    dirtPate = "<%=request.getContextPath()%>/npage/se899/fe899_main.jsp?activePhone="+qryPhoneNo+"%26opCode=e899%26opName=网上终端销售出库";
    window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e899&loginAccept="+opAccept+"&dirtPage="+dirtPate;	
  }

 function printBill7955() {
  var sum_money = $("#prepayMoney").val();//应收金额
  var pay_money = $("#baseFee").val();//赠送话费（预存话费）
  var TVprice = $("#selSalePrice").val();//手机电视功能费
  var phoneNetPrice = $("#selOpName").val();//手机上网功能费
  var selCustName = $("#selCustName").val();//用户姓名
  var brandName = $("#brandName").val();//手机型号
  var wlanPrice = $("#wlanPrice").val();//WLAN功能费
  
  var qryPhoneNo = $("#qryPhoneNo").val();
  var iMeiNo = $("input[name='iMeiNo']").val();
  var chinaFee = $("#chinaFee").val();
  var xx_money = $("#xx_money").val();
  var v_opName ="合约计划购机";
  
  checkPhoneMoney(sum_money,pay_money,TVprice,phoneNetPrice,wlanPrice);
  //checkPhoneMoney(sum_money,pay_money,TVprice,200.3456,11);
  
  var prepay_fee = $("#prepay_fee").val();
  var phone_money = $("#phone_money").val();
  var chkPhoneMoneyFlag = $("#chkPhoneMoneyFlag").val();
  
  toChinaFeeOne7955(phone_money);
  toChinaFeeTwo7955(prepay_fee);
  
  if(chkPhoneMoneyFlag=="Y"){
    /*** 第一张发票 ***/
    //TVprice = "111";
    //phoneNetPrice="222.22222";
    //wlanPrice = "33.8907";
		rdShowMessageDialog("提交成功! 下面将打印发票！",2);
		printInfo(TVprice,phoneNetPrice,wlanPrice);	
  }else{
    rdShowMessageDialog("提交成功! 下面将打印发票！",2);
		printInfo1(TVprice,phoneNetPrice,wlanPrice);	
  }
  }

function printInfo(TVprice,phoneNetPrice,wlanPrice)
{
   var selCustName = $("#selCustName").val();
   var brandName = $("#brandName").val();//手机型号
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
   var opAccept = $("#opAccept").val(); //操作流水
   
   var infoStr = "";		  
   infoStr+="<%=workNo%>  <%=work_name%>"+"       购机赠话费（按月返还）2-1"+"|";//工号
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+=selCustName +"|";
   infoStr+=" "+"|";//合同号码
   infoStr+=qryPhoneNo +"|";
   infoStr+=" "+"|";//协议号码
   infoStr+=" "+"|";
   infoStr+=chinaFeeOne7955+"|";//合计金额(大写)
   infoStr+=v_phoneMoneyToTwo+"|";//小写
   infoStr+=" 手机型号："+brandName+"  IMEI码："+iMeiNo+"~";
   infoStr+="|";
   infoStr+="<%=work_name%>"+"|";//开票人
   infoStr+=" "+"|";//收款人
   infoStr+=" "+"|";//收款人
	 infoStr+=" "+"|";

   rdShowMessageDialog("打印第二张发票！",2);
   var infoStr2 = "";	
   infoStr2+="<%=workNo%>  <%=work_name%>"+"       购机赠话费（按月返还）2-2"+"|";//工号
   infoStr2+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr2+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr2+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr2+=selCustName+"|";
   infoStr2+=" "+"|";//合同号码 
   infoStr2+=qryPhoneNo+"|";
   infoStr2+="1"+"|";//协议号码
   infoStr2+=" "+"|";
   infoStr2+=chinaFeeTwo7955+"|";//合计金额(大写)
   infoStr2+=v_prepayFeeToTwo+"|";//小写
   infoStr2+="手机型号："+brandName+"  IMEI码："+iMeiNo+"~";
	 infoStr2+="业务明细"+"  预存话费: "+v_pay_money_cut+"元"; 
	               
	 	
	 	//begin huangrong add 当手机电视功能费，手机上网功能费，WLAN功能费有不为0的时候才展示
	 	if(TVprice !="0")
	 	{
	 		infoStr2+="，手机电视功能费"+v_TVprice_cut+"元";
	 	}
	 	if(phoneNetPrice !="0" && wlanPrice !="0")
	 	{
	 		infoStr2+="，手机上网功能费"+v_phoneNetPrice_cut+"元，WLAN功能费"+v_wlanPrice_cut+"元";
	 	}
	  if(phoneNetPrice!="0" && wlanPrice =="0" )
	  {
	  	infoStr2+="，手机上网功能费"+v_phoneNetPrice_cut+"元";
	  }
	 	if(phoneNetPrice =="0" && wlanPrice !="0" )
	 	{
	 		infoStr2+="，WLAN功能费"+v_wlanPrice_cut+"元";
	 	}	
	 	//end huangrong add 当手机电视功能费，手机上网功能费，WLAN功能费有不为0的时候才展示	 
	 	
   infoStr2+="|";
   infoStr2+="<%=work_name%>"+"|";//开票人
   infoStr2+=" "+"|";//收款人
   infoStr2+=""+"|";			 	
	 infoStr2+=" "+"|";
 		  dirtPate = "<%=request.getContextPath()%>/npage/se899/fe899_main.jsp?activePhone="+qryPhoneNo+"%26opCode=e899%26opName=网上终端销售出库";
  window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&infoStr2="+infoStr2+"&op_code=e899&prNum=2&loginAccept="+opAccept+"&dirtPage="+dirtPate;	
}

function printInfo1(TVprice,phoneNetPrice,wlanPrice)
{
  var selCustName = $("#selCustName").val();
  var brandName = $("#brandName").val();//手机型号
  var iMeiNo = $("input[name='iMeiNo']").val();
  var qryPhoneNo = $("#qryPhoneNo").val();
  var chinaFeeTwo7955 = $("#chinaFeeTwo7955").val();
  var v_prepayFeeToTwo = $("#v_prepayFeeToTwo").val();
  var v_pay_money_cut = $("#v_pay_money_cut").val();
  var v_TVprice_cut = $("#v_TVprice_cut").val();
  var v_phoneNetPrice_cut = $("#v_phoneNetPrice_cut").val();
  var v_wlanPrice_cut = $("#v_wlanPrice_cut").val();       
  var opAccept = $("#opAccept").val(); //操作流水        
  
  var infoStr = "";		  
  infoStr+="<%=workNo%>  <%=work_name%>"+"       购机赠话费（按月返还）2-2"+"|";//工号
  infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  infoStr+=selCustName+"|";//用户名称 
  infoStr+=" "+"|";//合同号码 
  infoStr+=qryPhoneNo+"|";
  infoStr+="1"+"|";//协议号码
  infoStr+=" "+"|";
  infoStr+=chinaFeeTwo7955+"|";//合计金额(大写)
  infoStr+=v_prepayFeeToTwo+"|";//小写
  
  infoStr+="手机型号："+brandName+"  IMEI码："+iMeiNo+"~";
  infoStr+="业务明细"+"  预存话费: "+v_pay_money_cut+"元";   
              
  	 	if(TVprice !="0")
  {
  	infoStr+="，手机电视功能费"+v_TVprice_cut+"元";
  }
  if(phoneNetPrice!="0" && wlanPrice!="0")
  {
  	infoStr+="，手机上网功能费"+v_phoneNetPrice_cut+"元，WLAN功能费"+v_wlanPrice_cut+"元";
  }
  if(phoneNetPrice!="0" && wlanPrice=="0" )
  {
  	infoStr+="，手机上网功能费"+v_phoneNetPrice_cut+"元";
  }
  if(phoneNetPrice =="0" && wlanPrice !="0" )
  {
  	infoStr+="，WLAN功能费"+v_wlanPrice_cut+"元";
  }	
  //end huangrong add 当手机电视功能费，手机上网功能费，WLAN功能费有不为0的时候才展示	 
  
  infoStr+="|";
  
  infoStr+="<%=work_name%>"+"|";//开票人
  infoStr+=" "+"|";//收款人
  infoStr+=""+"|";			 	
  	infoStr+=" "+"|";
       	
    dirtPate = "<%=request.getContextPath()%>/npage/se899/fe899_main.jsp?activePhone="+qryPhoneNo+"%26opCode=e899%26opName=网上终端销售出库";
  window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e899&loginAccept="+opAccept+"&dirtPage="+dirtPate;	
}

  /*校验phoneMoney的判断*/
  function checkPhoneMoney(sum_money,pay_money,TVprice,phoneNetPrice,wlanPrice){
    var myPacket = new AJAXPacket("fe899_ajax_checkPhoneMoney.jsp","正在获取信息，请稍候......");
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