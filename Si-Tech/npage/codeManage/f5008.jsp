<%
/********************
 version v2.0
开发商: si-tech
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
		  String opCode = request.getParameter("opCode");
		  String opName = request.getParameter("opName");
	    String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	    String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
	    String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	    String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	    
	    String regionCode =(String)session.getAttribute("regCode");
	    String regionName = "";    
		
			
	//进行工号权限检验
%>

<%

	String errorMsg ="";
	String tmpStr="";
	String sql1 ="select district_code,district_code||'-->'||trim(district_name) from sDisCode where region_code='"+ regionCode +"' order by district_code";

String sql2 ="select district_code,to_char(INTEREST_RATE),to_char(INSURANCE_FEE), to_char(TEST_FEE),to_char(CONTRACT_HAND),to_char( LOCK_MONTH),ownpsw,to_char(ID_NUM),to_char(ASSURE_NUM),to_char(DEAD_DELAY_RATE),dead_delay_begin,check_flag, to_char(NOUSER_DAY),to_char(NOUSER_MONEY),to_char(PREDEL_MONTH),to_char(PREDEL_DEPOSIT),to_char(INNET_PREDEL_MONTHS) from sBaseCode where region_code='"+ regionCode +"' order by district_code";
String sql3 ="select region_name from sregioncode where region_code ='"+regionCode+"'";	    
String sql4 ="select * from sgoodphonetype order by good_type";
String sql5 ="select district_code,to_char(INTEREST_RATE),to_char(INSURANCE_FEE), to_char(TEST_FEE),to_char(CONTRACT_HAND),to_char( LOCK_MONTH),ownpsw,to_char(ID_NUM),to_char(ASSURE_NUM),to_char(DEAD_DELAY_RATE),dead_delay_begin,check_flag, to_char(NOUSER_DAY),to_char(NOUSER_MONEY),to_char(PREDEL_MONTH),to_char(PREDEL_DEPOSIT),to_char(INNET_PREDEL_MONTHS),GOOD_TYPE from sBaseCodegood where region_code='"+ regionCode +"' and good_type='1011' order by district_code";
//String sql5 ="select district_code,to_char(INTEREST_RATE),to_char(INSURANCE_FEE), to_char(TEST_FEE),to_char(CONTRACT_HAND),to_char( LOCK_MONTH),ownpsw,to_char(ID_NUM),to_char(ASSURE_NUM),to_char(DEAD_DELAY_RATE),dead_delay_begin,check_flag, to_char(NOUSER_DAY),to_char(NOUSER_MONEY),to_char(PREDEL_MONTH),to_char(PREDEL_DEPOSIT),to_char(INNET_PREDEL_MONTHS),GOOD_TYPE from sBaseCodegood where region_code='"+ regionCode +"' and district_code='01' and rownum=1 order by district_code";
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="2">
	<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="disCodeData" scope="end" />
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode2" retmsg="RetMsg2" outnum="17">
	<wtc:sql><%=sql2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="baseCodeDetailData" scope="end" />
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode3" retmsg="RetMsg3" outnum="1">
	<wtc:sql><%=sql3%></wtc:sql>
</wtc:pubselect>
<wtc:array id="regiNaArr" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode4" retmsg="RetMsg4" outnum="5">
	<wtc:sql><%=sql4%></wtc:sql>
</wtc:pubselect>
<wtc:array id="chooPhonType" scope="end" />
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode5" retmsg="RetMsg5" outnum="18">
	<wtc:sql><%=sql5%></wtc:sql>
</wtc:pubselect>
<wtc:array id="baseCodeDetailDatatesu" scope="end" />
<%
regionName= regiNaArr[0][0];
%>
<%if(!RetCode1.equals("000000") ){%>
<script language="JavaScript">
<!--

	rdShowMessageDialog("<%=RetMsg1%>");
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>基本资费配置管理</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>



<script language="JavaScript">
		 $(function() {
        init();
       });
<!--
	//定义应用全局的变量
	var SUCC_CODE	= "0";   		//自己应用程序定义
	var ERROR_CODE  = "1";			//自己应用程序定义
	var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

	var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";


	var INDEX_DisCode		= 0;
	    INDEX_InterestRate	= 1;
	    INDEX_InsuranceFee	= 2;
	    INDEX_TestFee		= 3;
	    INDEX_ContractHand	= 4;
	    INDEX_LockMonth		= 5;
	    INDEX_OwnPsw		= 6;
	    INDEX_IdNum			= 7;
		INDEX_AssureNum		= 8;
		INDEX_DeadDelayRate	= 9;
	    INDEX_DeadDelayBegin= 10;
	    INDEX_CheckFlag		= 11;
	    INDEX_NoUserDay		= 12;
	    INDEX_NoUserMoney	= 13;
		INDEX_PreDelMonth	= 14;
		INDEX_PreDelDeposit	= 15;
		INDEX_InnetPredelMonths	= 16;
		INDEX_GoodType= 17;
		
						<%
		String sloArray ="new Array(";//普通号码
		for(int isa=1; isa<=baseCodeDetailData.length;isa++) {
		sloArray+="new Array()";
		if(baseCodeDetailData.length>1 && isa<baseCodeDetailData.length) {
		sloArray+=",";
		}
		}
		sloArray+=");";
		
		String sloArray2 ="new Array(";//优良号码
		for(int isa2=1; isa2<=baseCodeDetailDatatesu.length;isa2++) {
		sloArray2+="new Array()";
		if(baseCodeDetailDatatesu.length>1 && isa2<baseCodeDetailDatatesu.length) {
		sloArray2+=",";
		}
		}
		sloArray2+=");";
%>		
	   var baseCodeDetailArr = <%=sloArray%>;
    <% for(int i=0; i<baseCodeDetailData.length; i++){ 
    	for(int j=0; j<baseCodeDetailData[i].length; j++){
    %>
    		baseCodeDetailArr[<%=i%>][<%=j%>] = "<%=baseCodeDetailData[i][j]%>";
    <%	}
    }
    %>
		
		 function choosePhone() {
      var choPhone = document.frm.choPhone[document.frm.choPhone.selectedIndex].value;
      enabledInput();
    			if( choPhone == "p" )
			{
				document.frm.choPhoneType.disabled=true;		
		 
	   baseCodeDetailArr = <%=sloArray%>;
    <% for(int i=0; i<baseCodeDetailData.length; i++){ 
    	for(int j=0; j<baseCodeDetailData[i].length; j++){
    %>
    		baseCodeDetailArr[<%=i%>][<%=j%>] = "<%=baseCodeDetailData[i][j]%>";
    <%	}
    }
    %>
    chg_disCode();
    pselectInit();
			}
			    if( choPhone == "y" )
			{
				//document.frm.choPhoneType.disabled=false;	
				 
					   baseCodeDetailArr = <%=sloArray2%>;
    <% for(int i=0; i<baseCodeDetailDatatesu.length; i++){ 
    	for(int j=0; j<baseCodeDetailDatatesu[i].length; j++){
    %>
    		baseCodeDetailArr[<%=i%>][<%=j%>] = "<%=baseCodeDetailDatatesu[i][j]%>";
    <%	}
    }
    %>
   chg_disCode();
  // fslect();
			}
 }

    
            



	function fillSelectUseValue_noArr(fillObject,indValue)
	{	
			for(var i=0;i<document.all(fillObject).options.length;i++){
				if(document.all(fillObject).options[i].value == indValue){
					document.all(fillObject).options[i].selected = true;
					break;
				}
			}							
	}

	function init()
	{

		chg_scopeType();
		chg_opType();
		choosePhone();
		
	}

	function chg_opType()
	{
		with(document.frm)
		{
			var op_type = opType[opType.selectedIndex].value;
			
			enabledInput();
			
			
			
				 var cho_Phone = choPhone[choPhone.selectedIndex].value;	
				 if( cho_Phone == "p" )
					{
						chg_disCode();
					}
					 if( cho_Phone == "y" )
					{
						
			if( op_type == oprType_Add )
			{
				clearInput();			
			}else {
			choosePhoneType();
			}
					}
			if( op_type == oprType_Add )
			{
				clearInput();			
			}

						
		}
		
	}	

	function chg_scopeType()
	{
	  with(document.frm)
	  {
		var scope_type = scopeType[scopeType.selectedIndex].value;
		if( scope_type == "0" )//地市
		{
			disCode.disabled = true;
		}
		else
		{
			disCode.disabled = false;
		}
		
		
	  }
	}
	
	function enabledInput()
	{
	
		with(document.frm)
		{
			var op_type = opType[opType.selectedIndex].value;
			
			if( (op_type == oprType_Add) ||
				(op_type == oprType_Upd)
			)
			{
				interestRate.disabled =  false;
				insuranceFee.disabled =  false;
				testFee.disabled =  false;
				contractHand.disabled =  false;
				lockMonth.disabled =  false;
				idNum.disabled =  false;
				assureNum.disabled =  false;
				deadDelayRate.disabled =  false;
				deadDelayBegin.disabled =  false;
				noUserDay.disabled =  false;
				noUserMoney.disabled =  false;
				predelMonth.disabled =  false;
				predelDeposit.disabled =  false;
				innetPredelMonths.disabled = false;

				
				 	var cho_Phone = choPhone[choPhone.selectedIndex].value;	
				 if( cho_Phone == "p" )
					{
					pselectInit();
					choPhoneType.disabled=true;
					}
					 if( cho_Phone == "y" )
					{
					//pselectInit();
					choPhoneType.disabled=false;
					}
			}
			else
			{
				interestRate.disabled =  true;
				insuranceFee.disabled =  true;
				testFee.disabled =  true;
				contractHand.disabled =  true;
				lockMonth.disabled =  true;
				idNum.disabled =  true;
				assureNum.disabled =  true;
				deadDelayRate.disabled =  true;
				deadDelayBegin.disabled =  true;
				noUserDay.disabled =  true;
				noUserMoney.disabled =  true;
				predelMonth.disabled =  true;
				predelDeposit.disabled =  true;
				innetPredelMonths.disabled = true;
        var cho_Phone = choPhone[choPhone.selectedIndex].value;	
				if(op_type == oprType_Del) {
				
									 if( cho_Phone == "y" )
					{
					//pselectInit();
					choPhoneType.disabled=false;
					}else {
					choPhoneType.disabled=true;
					}
				}
				if(op_type == oprType_Qry) {
					 if( cho_Phone == "y" )
					{
					//pselectInit();
					choPhoneType.disabled=false;
					}else {
					choPhoneType.disabled=true;
					}
				}

			}						
		}
	}
	
	function clearInput()
	{
		with(document.frm)
		{
			var op_type = opType[opType.selectedIndex].value;
			if( (op_type == oprType_Add) 
			)
			{		
				interestRate.value 	=  "0.00";
				insuranceFee.value 	=  "0.00";
				testFee.value 		=  "0.00";
				contractHand.value	=  "0.00";
				lockMonth.value 	=  "0";
				idNum.value 		=  "0";
				assureNum.value 	=  "0";
				deadDelayRate.value =  "0.00";
				deadDelayBegin.value=  "";
				noUserDay.value 	=  "0";
				noUserMoney.value 	=  "0.00";
				predelMonth.value 	=  "3";
				predelDeposit.value =  "0.00";
				innetPredelMonths.value = 0;
			}else{
				interestRate.value 	=  "";
				insuranceFee.value 	=  "";
				testFee.value 		=  "";
				contractHand.value	=  "";
				lockMonth.value 	=  "";
				idNum.value 		=  "";
				assureNum.value 	=  "";
				deadDelayRate.value =  "";
				deadDelayBegin.value=  "";
				noUserDay.value 	=  "";
				noUserMoney.value 	=  "";
				predelMonth.value 	=  "";
				predelDeposit.value =  "";	
				innetPredelMonths.value = "";		
			}
			
		}		
	}


	function chg_disCode()
	{
	  with(document.frm)
	  {
		clearInput();

	   if( disCode.selectedIndex > -1 )
	   {

		var tmpDisCode = disCode[disCode.selectedIndex].value;

		for( var i=0; i<baseCodeDetailArr.length; i++ )
		{		

			if( (tmpDisCode == baseCodeDetailArr[i][INDEX_DisCode])
			)
			{

				interestRate.value =	baseCodeDetailArr[i][INDEX_InterestRate];		
				insuranceFee.value =	baseCodeDetailArr[i][INDEX_InsuranceFee];		
				testFee.value =	baseCodeDetailArr[i][INDEX_TestFee];
				contractHand.value =	baseCodeDetailArr[i][INDEX_ContractHand];
				lockMonth.value =	baseCodeDetailArr[i][INDEX_LockMonth];
				fillSelectUseValue_noArr("ownPsw",baseCodeDetailArr[i][INDEX_OwnPsw]);
				idNum.value =	baseCodeDetailArr[i][INDEX_IdNum];
				assureNum.value =	baseCodeDetailArr[i][INDEX_AssureNum];		
				deadDelayRate.value =	baseCodeDetailArr[i][INDEX_DeadDelayRate];
				deadDelayBegin.value =	baseCodeDetailArr[i][INDEX_DeadDelayBegin];
				fillSelectUseValue_noArr("checkFlag",baseCodeDetailArr[i][INDEX_CheckFlag]);
				noUserDay.value =	baseCodeDetailArr[i][INDEX_NoUserDay];
				noUserMoney.value =	baseCodeDetailArr[i][INDEX_NoUserMoney];
				predelMonth.value =	baseCodeDetailArr[i][INDEX_PreDelMonth];
				predelDeposit.value =	baseCodeDetailArr[i][INDEX_PreDelDeposit];
				innetPredelMonths.value = baseCodeDetailArr[i][INDEX_InnetPredelMonths];
				goodtypes.value = baseCodeDetailArr[i][INDEX_GoodType];		
				break;
			}
		
		}
fslect();
	   }	
	   	
	  }	
	
	}

	function PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{
	 
	    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
	    //var path = "../public/fPubSimpSel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;  
	
	    retInfo = window.showModalDialog(path);
		if(typeof(retInfo) == "undefined")     
	    {   return false;   }
	    var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");
	        
	    }
	}

	

	

	function judge_valid()
	{
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;

		if( (op_type == oprType_Add) || (op_type == oprType_Upd) )
		{
			if( !doValid() ) return false;
			
			if(!checkElement("interestRate")) return false;
			if(!checkElement("insuranceFee")) return false;
			if(!checkElement("testFee")) return false;
			if(!checkElement("contractHand")) return false;
			if(!checkElement("lockMonth")) return false;
			if(!checkElement("idNum")) return false;
			if(!checkElement("assureNum")) return false;
			if(!checkElement("deadDelayRate")) return false;
//			if(!checkElement("deadDelayBegin")) return false;
			if(!checkElement("noUserDay")) return false;
			if(!checkElement("noUserMoney")) return false;
			if(!checkElement("predelMonth")) return false;
			if(!checkElement("predelDeposit")) return false;
			if(!checkElement("innetPredelMonths")) return false;
		}				
		return true;
	}


	function resetJsp()
	{
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
	
		if( op_type == oprType_Add )
		{	
		clearInput();
		}	
		
	}
	
	function commitJsp()
	{
		var tmpStr="";
		var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
		var procSql = "";
		
		if( op_type == oprType_Qry )
		{
			rdShowMessageDialog("查询不能确认!");
			return false;					
		}else if( op_type == oprType_Upd )
		{
			if( document.frm.disCode.selectedIndex == -1 )
			{
				rdShowMessageDialog("请配置区县代码的数据!");
				return false;
			}
		}
	/*		
		if( !judge_valid() )
		{
			return false;
		}
		*/
		if( (op_type == oprType_Add) || (op_type == oprType_Upd) )
		{
    		if(!check(document.frm)){
    				return false;
    		}
			var choPhone = document.frm.choPhone[document.frm.choPhone.selectedIndex].value;
		    if( choPhone == "y" )
			{
                var choPhoneType = document.frm.choPhoneType[document.frm.choPhoneType.selectedIndex].value;
                if(choPhoneType == "0") {
                rdShowMessageDialog("请选择号码类型!");
                return false;
                }
	        }
	        //diling add@2011/10/21 对增加，修改中号码冷冻天数增加限制：号码冷冻天数必须大于7天
	        if(document.getElementById("lockMonth").value<=7){
			    rdShowMessageDialog("号码冷冻天数必须大于7天!请重新输入！");
				return false;
			}	
		}

		


		//8.提交页面
		document.frm.confirm.disabled = true;
		page = "f5008_confirm.jsp";
		frm.action=page;
		frm.method="post";
	  	frm.submit();
						 		
	
	}
	
				
//-->
   function fslect() {
   var selecs = document.getElementById('choPhoneType');
   var selput = document.frm.goodtypes.value;
	for (var i=0;i<selecs.length;i++)
	{	
		if(selecs(i).value==selput) {
		selecs(i).selected=true;
		break;
		}

	}

	 }
	 function pselectInit() {
	 var selecs = document.getElementById('choPhoneType');
	 	for (var i=0;i<selecs.length;i++)
	{	
		if(selecs(i).value==0) {
		selecs(i).selected=true;
		break;
		}

	}
	 }
  function choosePhoneType() {		
      var disCodes1 = $("#disCode").val();
      var choPhoneTypes1 = $("#choPhoneType").val();
			var getdataPacket = new AJAXPacket("f5008_qry.jsp","正在获得操作代码路径，请稍候......");
			getdataPacket.data.add("disCode",disCodes1);
			getdataPacket.data.add("choPhoneType",choPhoneTypes1);
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
  }
  		function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			

			if(retCode == "000000"){
			var INTEREST_RATE = packet.data.findValueByName("INTEREST_RATE");
			var INSURANCE_FEE = packet.data.findValueByName("INSURANCE_FEE");
			var TEST_FEE = packet.data.findValueByName("TEST_FEE");
			var CONTRACT_HAND = packet.data.findValueByName("CONTRACT_HAND");
			var LOCK_MONTH = packet.data.findValueByName("LOCK_MONTH");
			var ownpsw = packet.data.findValueByName("ownpsw");
			var ID_NUM = packet.data.findValueByName("ID_NUM");
			var ASSURE_NUM = packet.data.findValueByName("ASSURE_NUM");
			var DEAD_DELAY_RATE = packet.data.findValueByName("DEAD_DELAY_RATE");
			var dead_delay_begin = packet.data.findValueByName("dead_delay_begin");
			var check_flag = packet.data.findValueByName("check_flag");
			var NOUSER_DAY = packet.data.findValueByName("NOUSER_DAY");
			var NOUSER_MONEY = packet.data.findValueByName("NOUSER_MONEY");
			var PREDEL_MONTH = packet.data.findValueByName("PREDEL_MONTH");
			var PREDEL_DEPOSIT = packet.data.findValueByName("PREDEL_DEPOSIT");
			var INNET_PREDEL_MONTHS = packet.data.findValueByName("INNET_PREDEL_MONTHS");
			
			//clearInput();
			document.getElementById('interestRate').value=INTEREST_RATE;
			document.getElementById('insuranceFee').value=INSURANCE_FEE;
			document.getElementById('testFee').value=TEST_FEE;
			document.getElementById('contractHand').value=CONTRACT_HAND;
			document.getElementById('lockMonth').value=LOCK_MONTH;
			//document.getElementById('ownPsw').value=ownpsw;
			document.getElementById('idNum').value=ID_NUM;
			document.getElementById('assureNum').value=ASSURE_NUM;
			document.getElementById('deadDelayRate').value=DEAD_DELAY_RATE;
			document.getElementById('deadDelayBegin').value=dead_delay_begin;
			//document.getElementById('checkFlag').value=check_flag;
			document.getElementById('noUserDay').value=NOUSER_DAY;
			document.getElementById('noUserMoney').value=NOUSER_MONEY;
			document.getElementById('predelMonth').value=PREDEL_MONTH;
			document.getElementById('predelDeposit').value=PREDEL_DEPOSIT;
			document.getElementById('innetPredelMonths').value=INNET_PREDEL_MONTHS;
			fillSelectUseValue_noArr("ownPsw",ownpsw);
			fillSelectUseValue_noArr("checkFlag",check_flag);
			

			}else{
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
		}

</script>


</head>


<body >
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %> 
			<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
<table >
   

        
          <tr > 
            <td class="blue">操作类型</td>
            <td ><select name="opType" class="button" id="select" onChange="chg_opType()">
                <option value="a">增加</option>
                <option value="u">修改</option>
                <option value="d">删除</option>
                <option value="q" selected>查询 </select> </td>
            <td class="blue">地市代码</td>
            <td><input name="regionName" type="text" class="button" style="width:177px;" id="regionName" value="<%=regionName%>" maxlength="2" readonly> 
            </td>
          </tr>
          <tr   > 
            <td class="blue">操作范围</td>
            <td colspan="3"><select name="scopeType" class="button" id="scopeType" onChange="chg_scopeType()">
                <option value="0" selected>地市</option>
                <option value="1">区县</option>
              </select></td>

          </tr>
          <tr   > 
            <td class="blue">区县代码</td>
            <td colspan="3"><select name="disCode" class="button" id="disCode" onchange="chg_disCode()">
                <%
        	for(int i=0;i<disCodeData.length; i++){
			out.println("<option class='button' value='"+disCodeData[i][0]+"'>"+disCodeData[i][1]+"</option>");
			}
		  %>
              </select></td>

          </tr>
       <tr>
       	          	 <td class="blue">号码种类</td>
            <td  colspan="3"><select name="choPhone" class="button" id="choPhone" onChange="choosePhone()">
                <option value="p" selected>普通号码</option>
                <option value="y">优良号码</option>
              </select></td>
      </tr>
          <tr   > 
            <td colspan="4" class="blue">修整信息如下</td>
          </tr>
             <tr>

              <td class="blue">号码类型</td> 
            <td colspan="3"><select name="choPhoneType" class="button" id="choPhoneType" onChange="choosePhoneType()">
            	<option value="0" selected>----请选择----</option>
           <%
        	for(int i=0;i<chooPhonType.length; i++){
			    out.println("<option class='button' value='"+chooPhonType[i][0]+"'>"+chooPhonType[i][0]+"----"+chooPhonType[i][1]+"</option>");
			    }
		      %>
              </select></td>
       

          </tr>
                    <tr > 
            <td class="blue">号码冷冻天数</td>
            <td><input name="lockMonth" type="text" class="button"  style="width:177px;" id="lockMonth" maxlength="10" v_must=1 v_type=0_9 v_minlength=1 v_maxlength=10 v_name="号码冷冻天数" onblur="checkElement(this)"></td>
            <td class="blue">密码标志</td>
            <td><select name="ownPsw" class="button" id="ownPsw">
                <option value="0" selected>否</option>
                <option value="1">是</option>
              </select></td>
          </tr>
          <tr   > 
            <td class="blue">银行利率</td>
            <td><input name="interestRate" type="text" class="button" style="width:177px;" id="interestRate" maxlength="8" v_must=1 v_type=cfloat v_maxlength=8 v_name="银行利率" onblur="checkElement(this)"></td>
            <td class="blue">保险费</td>
            <td><input name="insuranceFee" type="text" class="button" style="width:177px;" id="insuranceFee" maxlength="10" v_must=1 v_type=cfloat v_maxlength=10 v_name="保险费" onblur="checkElement(this)"></td>
          </tr>
          <tr   > 
            <td class="blue">验机费</td>
            <td><input name="testFee" type="text" class="button" style="width:177px;" id="testFee" maxlength="10" v_must=1 v_type=cfloat v_maxlength=10 v_name="验机费" onblur="checkElement(this)"></td>
            <td class="blue">托收手续费</td>
            <td><input name="contractHand" type="text" class="button" style="width:177px;" id="contractHand" maxlength="10" v_must=1 v_type=cfloat v_maxlength=10 v_name="托收手续费" onblur="checkElement(this)"></td>
          </tr>

          <tr   > 
            <td class="blue">购机数</td>
            <td><input name="idNum" type="text" class="button" style="width:177px;" id="idNum" maxlength="10" v_must=1 v_type=0_9 v_minlength=1 v_maxlength=10 v_name="购机数" onblur="checkElement(this)"></td>
            <td class="blue">担保数</td>
            <td><input name="assureNum" type="text" class="button" style="width:177px;" id="assureNum" maxlength="10" v_must=1 v_type=0_9 v_minlength=1 v_maxlength=10 v_name="担保数" onblur="checkElement(this)"></td>
          </tr>
          <tr  > 
            <td class="blue">滞纳金率</td>
            <td><input name="deadDelayRate" type="text" class="button" style="width:177px;" id="deadDelayRate" maxlength="8" v_must=1 v_type=cfloat v_maxlength=10 v_name="滞纳金率" onblur="checkElement(this)"></td>
            <td class="blue">滞纳金起算日</td>
            <td><input name="deadDelayBegin" type="text" class="button" style="width:177px;" id="deadDelayBegin" maxlength="8" v_must=1 v_type=date  v_name="滞纳金起算日" onblur="checkElement(this)"></td>
          </tr>
          <tr   > 
            <td class="blue">支票标志</td>
            <td><select name="checkFlag" class="button" id="checkFlag">
                <option value="0" selected>否</option>
                <option value="1">是</option>
              </select></td>
            <td class="blue">预销入网月数</td>
            <td><input name="innetPredelMonths" type="text" class="button" style="width:177px;" id="innetPredelMonths" maxlength="3" v_must=1 v_type=0_9 v_minlength=1 v_maxlength=3 v_name="预销入网月数" onblur="checkElement(this)"></td>
          </tr>
          <tr   > 
            <td class="blue">无主停机天数</td>
            <td><input name="noUserDay" type="text" class="button" style="width:177px;" id="noUserDay" maxlength="5" v_must=1 v_type=0_9 v_minlength=1 v_maxlength=5 v_name="无主停机天数" onblur="checkElement(this)"></td>
            <td class="blue">无主停机金额</td>
            <td><input name="noUserMoney" type="text" class="button" style="width:177px;" id="noUserMoney" maxlength="10" v_must=1 v_type=cfloat v_maxlength=10 v_name="无主停机金额" onblur="checkElement(this)"></td>
          </tr>
          <tr   > 
            <td class="blue">预拆月数</td>
            <td><input name="predelMonth" type="text" class="button" style="width:177px;" id="predelMonth" maxlength="5" v_must=1 v_type=0_9 v_minlength=1 v_maxlength=5 v_name="预拆月数" onblur="checkElement(this)"></td>
            <td class="blue">预销押金</td>
            <td><input name="predelDeposit" type="text" class="button" style="width:177px;" id="predelDeposit" maxlength="10" v_must=1 v_type=cfloat v_maxlength=10 v_name="预销押金" onblur="checkElement(this)"></td>
          </tr>

        	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input name="confirm" type="button" class="b_foot" value="确认" onClick="commitJsp()">	
				&nbsp;
				 <input name="reset" type="button" class="b_foot" value="清除" onClick="resetJsp()">
				&nbsp;
				<input name="back" onClick="window.close()" type="button" class="b_foot" value="返回">
			</div>
			</td>
		</tr>
	</table>
  </table>
    <input type="hidden" name="goodtypes" id="goodtypes" >
  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
  	  	
	<input type="hidden" name="opNote" id="opNote" value="">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
