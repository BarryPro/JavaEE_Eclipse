<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-5
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%		
	String opCode = "8030";
	String opName = "集团用户预存话费赠机";    
	String loginNo = (String)session.getAttribute("workNo");					//操作工号
	String regionCode = (String)session.getAttribute("regCode");				//地市
	String phoneNo =(String) request.getParameter("phoneNo");				//手机号码
	String opcode = request.getParameter("opcode");								//op_code
	String groupId = (String)session.getAttribute("groupId");
	String orgCode = (String)session.getAttribute("orgCode");
	String op_strong_pwd = (String) session.getAttribute("password");
%>

<%
	String retFlag="",retMsg="";
	String[] paraAray1 = new String[3];
	
	String passwordFromSer="";
	String dept=request.getParameter("dept");
	String s_type="C";
 
	paraAray1[0] = phoneNo;		/* 手机号码   */ 
	paraAray1[1] = opcode; 	    /* 操作代码   */
	paraAray1[2] = loginNo;	    /* 操作工号   */

  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	  
	}
  }
 /* 输出参数 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别，当前积分,可用预存
 */

  //retList = impl.callFXService("s8030Init", paraAray1, "21","phone",phoneNo);
  
%>

    <wtc:service name="s8030Init" outnum="21" retmsg="msg1" retcode="code1" routerKey="phoneNo" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />	
			<wtc:param value="<%=paraAray1[2]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />

<%  
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
  String errCode = code1;
  String errMsg = msg1;
  if(result_t == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8030Init查询号码基本信息为空!<br>errCode " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码<%=errCode%>，错误信息<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
	    bp_name = result_t[0][2];//机主姓名
	    bp_add = result_t[0][3];//客户地址
	    cardId_type = result_t[0][4];//证件类型
	    cardId_no = result_t[0][5];//证件号码
	    sm_code = result_t[0][6];//业务品牌
	    region_name = result_t[0][7];//归属地
	    run_name = result_t[0][8];//当前状态
	    vip = result_t[0][9];//ＶＩＰ级别
	    posint = result_t[0][10];//当前积分
	    prepay_fee = result_t[0][11];//可用预存
	    vUnitId = result_t[0][12];//集团ID
	    vUnitName = result_t[0][13];//集团名称
	    vUnitAddr = result_t[0][14];//单位地址
	    vUnitZip = result_t[0][15];//单位邮编
	    vServiceNo = result_t[0][16];//集团工号
	    vServiceName = result_t[0][17];//集团工号名称
	    vContactPhone = result_t[0][18];//联系电话
	    vContactPost = result_t[0][19];//个人邮编
	    passwordFromSer = result_t[0][20];  //密码
	}
  }

%>
 <%  //优惠信息//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   

  String[][] favInfo = (String[][])session.getAttribute("favInfo"); //数据格式为String[0][0]---String[n][0]
  String handFee_Favourable = "readOnly";        //a230  手续费
  int infoLen = favInfo.length;
  String tempStr = "";
 %>
<%
//******************得到下拉框数据***************************//
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<%
	String exeDate="";
	exeDate = getExeDate("1","1141");

 	// comImpl co=new comImpl();
  //手机品牌
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='5' and a.brand_code=b.brand_code and valid_flag='Y' and b.is_valid='1' and substr(spec_type,1,1)='"+s_type+"'";
  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='5' and a.brand_code=b.brand_code and valid_flag='Y' and b.is_valid='1' and substr(spec_type,1,1)='"+s_type+"'";
  //营销代码
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='5' and valid_flag='Y' and substr(spec_type,1,1)='"+s_type+"'";
  //终端用途
  String sqltermType = "select unique item_code,item_name   from sSaletermCODE a ";
   //产品代码
  String sqlprodType = "select unique a.operation_code,a.product_code,a.operation_name,a.product_name from dbcustadm.ssaleproductcode  a where a.active_flag='1' ";
 
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlAgentCode%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlPhoneType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>
	 	

		<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaleType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>	 	
	 	
	 	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqltermType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>	 		 		 
	 		 		 	 
	 	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlprodType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t5" scope="end"/>	 		 		 	 
	 	
<%
	String[][] agentCodeStr = result_t1;
	String[][] phoneTypeStr = result_t2;
	String[][] saleTypeStr = result_t3;
	String[][] termTypeStr = result_t4;
	String[][] prodTypeStr = result_t5;

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>集团用户预存话费优惠购机</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 <script language=javascript>

 function doProcess(packet){
 		errorCode = packet.data.findValueByName("errorCode");
		errorMsg =  packet.data.findValueByName("errorMsg");
		retType = packet.data.findValueByName("retType");
		backArrMsg = packet.data.findValueByName("backArrMsg");
		retResult = packet.data.findValueByName("retResult");
		self.status="";
		
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";
		ret_code =  parseInt(errorCode);
		
		if(retType=="getcard"){
			if( ret_code == 0 ){
				  tmpObj = "sale_code" 
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length+1;	
	
				document.all(tmpObj).options[0].text="--请选择--";
				document.all(tmpObj).options[0].value="";
				document.all(tmpObj).options[0].nv2="0";
			    document.all(tmpObj).options[0].nv3="0";

		        for(i=1;i<backArrMsg.length+1;i++)
			    {
				    document.all(tmpObj).options[i].text=backArrMsg[i-1][1];
				    //document.all(tmpObj).options[i].text=backArrMsg[i-1][0]+"-->"+backArrMsg[i-1][1];
				    document.all(tmpObj).options[i].value=backArrMsg[i-1][0];
		 	        document.all(tmpObj).options[i].nv2=backArrMsg[i-1][2];
			        document.all(tmpObj).options[i].nv3=backArrMsg[i-1][3];
			    }
			    
  
			}else{
				rdShowMessageDialog("取信息错误"+errorMsg+"!",0);
				return;			
			}
			change();
		}
		else if(retType == "checkAward")
		{
				var retCode = packet.data.findValueByName("retCode"); 
				var retMessage = packet.data.findValueByName("retMessage");
    		window.status = "";
    		if(retCode!=0){
    			rdShowMessageDialog(retMessage,0);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    		}
    		document.all.award_flag.value = 1;
    	}else{
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！",0);
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！",0);
					document.frm.confirm.disabled=true;
					return false;
			}
		}
 }
 function change(){
	with(document.frm){

		price.value=sale_code.options[sale_code.selectedIndex].nv2;
		pay_money.value=sale_code.options[sale_code.selectedIndex].nv3;
		var i=price.value;
		var j=pay_money.value;
		sum_money.value=(parseFloat(i)+parseFloat(j)).toFixed(2);
		var getInstal_Packet = new AJAXPacket("f8030_getprepay.jsp","正在校验请稍候......");
		getInstal_Packet.data.add("salecode",sale_code.options[sale_code.selectedIndex].value);
		getInstal_Packet.data.add("ajaxType","grp_cfg");
		core.ajax.sendPacket(getInstal_Packet,doGrpCfg);
		getInstal_Packet = null;
	}
	/*判断用户是否可以使用POS机分期付款 ningtn*/
	$("#instalTd").hide();
	$("#installmentTd").hide();
	checkInstal(document.frm.price.value,document.frm.pay_money.value);
}

function doGrpCfg(packet)
{
	var retcode = packet.data.findValueByName("errorCode");
	var retMsg = packet.data.findValueByName("errorMsg");
	if (retcode!="000000")
	{		
		rdShowMessageDialog(retcode+":"+retMsg);
   		document.getElementById("sale_code").selectedIndex=0;
   		//document.getElementById("sale_code")[0].text="--请选择--";
   		document.all.price.value="";
   		document.all.pay_money.value="";
   		document.all.sum_money.value="";
		return false;
	}
}

var bankInstalArr = new Array();
function checkInstal(vMachFee,vPrePay){
		/********
			两个入参
			vMachFee 购机款
			vPrePay 缴费合计
		*/
		/*先清一下缴费方式，并且初始化缴费方式*/
		$("#payTypeSelect").find("option:gt(2)").remove();
		$("#payTypeSelect")[0].selectedIndex=0;
		//var selectSql = "Select to_char(bank_code),to_char(bank_name),to_char(bank_paytype),to_char(instal_numbers),to_char(income_ratios) FROM ssaleinstal WHERE machine_fee <= :vMachFee AND begine_fee<=:vPrePay AND end_fee>:vPrepay";
		var v_regionCode = "<%=regionCode%>";
		var selectSql = "select to_char(bank_code), "
                    +" to_char(bank_name), "
                    +" to_char(bank_paytype), "
                    +" to_char(instal_numbers), "
                    +" to_char(income_ratios) "
                    +"  FROM ssaleinstal "
                    +" WHERE machine_fee <= :vMachFee "
                    +"   AND begine_fee <= :vPrePay "
                    +"   AND end_fee > :vPrePay "
                    +"   and region_code in('"+v_regionCode+"','99') "
                    +"   and func_code='8030'";
		var params = "vMachFee=" + vMachFee + ",vPrePay=" + vPrePay+ ",vPrePay=" + vPrePay;
		var getInstal_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","正在校验请稍候......");
		getInstal_Packet.data.add("selectSql",selectSql);
		getInstal_Packet.data.add("params",params);
		getInstal_Packet.data.add("wtcOutNum","5");
		core.ajax.sendPacket(getInstal_Packet,doQryInstalBack);
		getInstal_Packet = null;
	}
	function doQryInstalBack(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		var result = packet.data.findValueByName("result");
		if(retcode == "000000"){
			if(result.length > 0){
				/*证明有可以进行分期付款的配置*/
				bankInstalArr = result;
				/******
					同一银行的开始结束金额没有重叠
					所以如果有多条(大于一条)信息一定是多个银行
				*/
				$.each(bankInstalArr,function(i,n){
					var optionInsertStr = "<option value='"+ n[2] +"' >"+n[1]+"信用卡分期付款</option>";
					$("#payTypeSelect").append(optionInsertStr);
				});
			}
		}
	}
 </script>
<script language="JavaScript">
/*
	营销案消费时间下拉列表change方法
	20121119 gaopeng 修改 界面中的“机卡绑定（即拆包）”去掉 
	增加“专款返还方式”的选择，选项有:不绑定不可累计、机卡绑定不可累计、不绑定可累积和机卡绑定可累积
	其中当选择“分36个月消费”时，营业员只可以看见机卡绑定不可累计和机卡绑定可累积这两个选项。 
*/
function dispPkt()
{
	/*
	document.getElementById("pktTitle").style.display="none";
	document.getElementById("checkPkt").style.display="none";
	document.getElementById("checkPkt").checked==false;
	document.frm.checkPkt.disabled=false;
	document.getElementById("pktFlag").value='1';
	*/
	/*20121119 gaopeng  关于哈尔滨分公司集团部开展《集团高端客户专享》营销活动的请示 begin
	*/
	$("#pktTitle").hide();
	$("#pCardSel").hide();
	$("#pCardSel").empty();
	
	var sale_month=document.frm.sale_month.value;

	if ( sale_month=="12f"||sale_month=="18f"||sale_month=='24f' ||sale_month=='36f'  )
	{
		$("#pCardSel").append("<option value='' >--请选择--</option>");
		$("#pCardSel").append("<option value='23' >不绑定可累积</option>");
		$("#pCardSel").append("<option value='24' >不绑定不可累计</option>");
		$("#pCardSel").append("<option value='13' >机卡绑定可累积</option>");
		$("#pCardSel").append("<option value='14' >机卡绑定不可累计</option>");
		/*
		document.getElementById("pktTitle").style.display="";
		document.frm.checkPkt.style.display="";
		*/
		$("#pktTitle").show();
		$("#pCardSel").show();
		//分36个月消费 只显示 机卡绑定不可累计 和 机卡绑定可累积 (20130220 gaopeng 新增判断，非哈尔滨地市只可以看见:机卡绑定不可累计和机卡绑定可累积)
		if (sale_month=='36f' || ("<%=regionCode%>"!="01" && "<%=regionCode%>"!="03"))
		{
			/*
			document.frm.checkPkt.checked=true;
			document.frm.checkPkt.disabled=true;
			*/
			$("#pCardSel").find("option").each(function()
			{
				var thisvals = $(this);
				if(thisvals.val()=="23" || thisvals.val()=="24")
				{
					thisvals.remove();
				}
			}
			);
		}
	}	
}


<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;
  
  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalePrice=new Array();
  var arrsaleLimit=new Array();
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
	
  }  
%>
	
  //***
  function frmCfm(){
		///////<!-- ningtn add for pos start @ 20100722 -->
		document.all.payType.value = document.all.payTypeSelect.value;
		if(document.all.payType.value=="BX")
  		{
    		/*set 输入参数*/
			var transerial    = "000000000000";  	                    //交易唯一号 ，将会取消
			var trantype      = "00";         //交易类型
			var bMoney        = document.all.sum_money.value; 				//缴费金额
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var tranoper      = "<%=loginNo%>";                       //交易操作员
			var orgid         = "<%=groupId%>";                       //营业员归属机构
			var trannum       = "<%=phoneNo%>";                       //电话号码
			getSysDate();       /*取boss系统时间*/
			var respstamp     = document.all.Request_time.value;      //提交时间
			var transerialold = "";																		//原交易唯一号,在缴费时传入空
			var org_code      = "<%=orgCode%>";                       //营业员归属						
			CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
			if(ccbTran=="succ") posSubmitForm();
  		}
		else if(document.all.payType.value=="BY")
		{
			var transType     = "05";					/*交易类型 */         
			var bMoney        = document.all.sum_money.value;         /*交易金额 */
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
			var response_time = "";                								 		/*原交易日期 */				
			var rrn           = "";                           				/*原交易系统检索号 */ 
			var instNum       = "";                                   /*分期付款期数 */     
			var terminalId    = "";                    								/*原交易终端号 */			
			getSysDate();       																			//取boss系统时间                                            
			var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
			var workno        = "<%=loginNo%>";                        /*交易操作员 */       
			var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
			var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
			var phoneNo       = "<%=phoneNo%>";                       /*交易缴费号 */       
			var toBeUpdate    = "";						                        /*预留字段 */         
			var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
			
			//调用POS机办理业务返回值入库服务 20121011 gaopeng 银行卡业务单边帐处理需求
				if(icbcTran=="succ"){
					SsPosPayPre();
				}
				//一会儿展开
				if(icbcTran=="succ") posSubmitForm();
			
			if(icbcTran=="succ") posSubmitForm();
		}else if(document.all.payType.value=="EI"){
		  var installmentNum = $("input[@name='installmentList'][@checked]").val();
		  var installmentIncome= $("input[@name='installmentList'][@checked]").attr("income");//贴息比例
		  $("#installmentNumStr").val(installmentNum);
		  $("#installmentIncomeStr").val(installmentIncome);
			var transType     = "12";					/*交易类型 */         
			var bMoney        = document.all.sum_money.value;          /*交易金额：应付金额 */
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
			var response_time = " ";                                  /*原交易日期 */					       
			var rrn           = " ";                                  /*原交易系统检索号 */ 
			var instNum       = installmentNum;                       /*分期付款期数 */     
			var terminalId    = " ";                                  /*原交易终端号 */			
			getSysDate();       //取boss系统时间                                            
			var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
			var workno        = "<%=loginNo%>";                        /*交易操作员 */       
			var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
			var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
			var phoneNo       = "<%=phoneNo%>";                       /*交易缴费号 */       
			var toBeUpdate    = "";						                        /*预留字段 */         
			var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
			//调用POS机办理业务返回值入库服务 20121011 gaopeng 银行卡业务单边帐处理需求
			if(icbcTran=="succ"){
				SsPosPayPre();
			}
			if(icbcTran=="succ") posSubmitForm();
		}else{
			posSubmitForm();
		}
		
		//////<!-- ningtn add for pos end @ 20100722 -->
  }
  
    /**调用POS机办理业务返回值入库服务 20121011 gaopeng 银行卡业务单边帐处理需求 start**/
  function SsPosPayPre()
  {
  		var MydataPacket = new AJAXPacket("/npage/sg175/fg175_1.jsp","正在处理POS数据，请稍候......");
			//流水号
			MydataPacket.data.add("iLoginAccept","<%=printAccept%>");
			//渠道标识
			MydataPacket.data.add("iChnSource","01");
			//操作代码
			MydataPacket.data.add("iOpCode","<%=opcode%>");
			//工号
			MydataPacket.data.add("iLoginNo","<%=loginNo%>");
			//工号密码
			MydataPacket.data.add("iLoginPwd","<%=op_strong_pwd%>");
			//用户号码
			MydataPacket.data.add("iPhoneNo","<%=phoneNo%>");
			//号码密码
			MydataPacket.data.add("iUserPwd","");
			//缴费类型
			MydataPacket.data.add("iPayType",document.all.payType.value);
			//缴费金额
			MydataPacket.data.add("iPayFee",document.all.sum_money.value);
			//卡序列号
			MydataPacket.data.add("iCatdNo",document.all.CardNo.value);
			//分期付款期数
			MydataPacket.data.add("iInstNum",$("#iInstNum").val());
			//原交易日期
			var response_time = " ";                		
			MydataPacket.data.add("iResponseTime",response_time);
			//原交易终端号
			MydataPacket.data.add("iTerminalId",document.all.TerminalId.value);
			//原交易系统检索号
			MydataPacket.data.add("iRrn",document.all.Rrn.value);
			//提交日期
			MydataPacket.data.add("iRequestTime",document.all.Request_time.value);
			//预留字段
			MydataPacket.data.add("iOtherS","");
			
			core.ajax.sendPacket(MydataPacket,dsPosPayPre12);
			
			MydataPacket = null;
  	
  }
  function dsPosPayPre12(packet)
  {
		var ErrorCode = packet.data.findValueByName("retCode12");
		var ErrorMsg = packet.data.findValueByName("retMsg12");
		if(ErrorCode!="0" && ErrorCode!="000000")
		{
			rdShowMessageDialog(ErrorMsg,1);
		}
  	else
  		{
  			return true;
  		}
  }
	/**调用POS机办理业务返回值入库服务 20121011 gaopeng 银行卡业务单边帐处理需求 end**/

  
  /* ningtn add for pos start @ 20100722 */
	function posSubmitForm(){
		var tmpStr = $("#transTotal").val();
		tmpStr = replaceStr(tmpStr);
		$("#transTotal").val(tmpStr);
		frm.submit();
		return true;
	}
	function replaceStr(str){
		str = str.replace(/\s+/g, " ");
		return str;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","正在获得系统时间，请稍候......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
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
	/* ningtn add for pos start @ 20100722 */
 //***
 function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",0);
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     } 

	var myPacket = new AJAXPacket("queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;  
    
}

 function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}

/*
	免填单打印方法
*/ 
 function printCommit()
 { 
 	getAfterPrompt();
 	/*拆包处理
 	if (document.all.checkPkt.checked==true)
 	{
 		document.all.pktFlag.value='0';	
 	}
 	else
 	{
 		document.all.pktFlag.value='1';	
 	}

 	if ( document.frm.sale_month.value=="36f")//36个月的就是拆
	{
		document.getElementById("pktFlag").value='0';
	}	
 	*/
 	/********* tianyang add for 支票缴费 start ************/
	with(document.frm){
		if (payTypeSelect.value=="9")
		{
			if(currentMoney.value=="")
			{
				rdShowMessageDialog("请校验支票号码！");
				checkNo.focus();
				return false;
			}
			if (parseFloat(currentMoney.value)<parseFloat(sum_money.value))
			{
				rdShowMessageDialog("请注意，支票金额不足！");
				checkNo.focus();
				return false;
			}
		}
	}
	/********* tianyang add for 支票缴费 end ************/
 	
 	
  //校验
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("请输入姓名!",0);
      cust_name.focus();
	  return false;
	}
	if(vTargetCode.value==""){
	  rdShowMessageDialog("终端用途不能不空!",0);
      phone_type.focus();
	  return false;
	}
	if(vProductCode.value==""){
	  rdShowMessageDialog("集团产品不能为空!",0);
      vProductCode.focus();
	  return false;
	}
	
	if(agent_code.value==""){
	  rdShowMessageDialog("请输入手机品牌!",0);
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("请输入手机型号!",0);
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("请输入营销代码!",0);
      sale_code.focus();
	  return false;
	}
	if(vProductId.value==""){
	  rdShowMessageDialog("集团产品ID不能为空!",0);
      vProductId.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",0);
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     } 
	 if (sale_month.value == "") {
      rdShowMessageDialog("营销案消费时间不能为空，请重新输入 !!",0);
      sale_month.focus();
      confirm.disabled = true;
	  return false;
     }
     /*20121120 gaopeng 关于哈尔滨分公司集团部开展《集团高端客户专享》营销活动的请示 */
    if(sale_month.value.indexOf("f")!=-1 && pCardSel.value=="")
    {
    	rdShowMessageDialog("请选择专款返还方式 !!",0);
    	pCardSel.focus();
    	return false;
    } 
	document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
	
	document.all.consum_note.value = document.all.sale_month.options[document.all.sale_month.selectedIndex].text;
  }
 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
     {
	   frmCfm();
     }
  }
  return true;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
    var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo();
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =document.all.login_accept.value;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                           //操作代码
     var phoneNo = "<%=phoneNo%>";                             //客户电话
         /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */
     
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
}

function printInfo(printType)
{
	//获取专款返还方式 gaopeng 关于哈尔滨分公司集团部开展《集团高端客户专享》营销活动的请示
	var pCardSelval = $("#pCardSel").val();
  vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay/12);

  	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		  
	var retInfo = "";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="联系人电话："+'<%=vContactPhone%>'+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	opr_info+="邮政编码："+'<%=vContactPost%>'+"|";
	opr_info+="单位地址："+'<%=vUnitAddr%>'+"|";
	opr_info+="邮政编码："+'<%=vUnitZip%>'+"|";
	opr_info+="客户经理："+'<%=vServiceName%>'+"|";
	
	opr_info+="业务种类集团客户手机："+"|";
  	opr_info+="业务流水："+document.all.login_accept.value+"|";
  	opr_info+="手机型号："+document.all.phone_typename.value+"      IMEI号码"+document.all.IMEINo.value+"|";
 	
 	
 	/*if(document.all.payTypeSelect.value=="9"){//tianyang add for 支票
 		opr_info+="预存话费：支票"+document.all.pay_money.value+"元"+"|";
 	}else if(document.all.payTypeSelect.value=="BX"||document.all.payTypeSelect.value=="BY"){
 		opr_info+="预存话费：刷卡"+document.all.pay_money.value+"元"+"|";
 	}else{
 		opr_info+="预存话费：现金"+document.all.pay_money.value+"元"+"|";
 	}*/
 	
 	if(document.all.payTypeSelect.value=="9"){//tianyang add for 支票
 		opr_info+="缴费合计：支票"+document.all.pay_money.value+"元"+"|";
 	}else if(document.all.payTypeSelect.value=="BX"||document.all.payTypeSelect.value=="BY"){
 		opr_info+="缴费合计：刷卡"+document.all.pay_money.value+"元"+"|";
 	}else{
 		opr_info+="缴费合计：现金"+document.all.pay_money.value+"元"+"|";
 	}
 	
 	
	opr_info+="业务执行时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	/****begin 增加分期付款的内容@2013/3/26 ****/
	if(document.all.payTypeSelect.value!= "0" && document.all.payTypeSelect.value != "9" && document.all.payTypeSelect.value != "BX" && document.all.payTypeSelect.value != "BY"){
		var v_payTypeSelectName = $("#payTypeSelect").find("option:selected").text();
		var payTypeSelectName  = v_payTypeSelectName.substr(0,v_payTypeSelectName.length-7);//银行名称
		var instalNum = $("input[@name='installmentList'][@checked]").val();
 	  opr_info+="您使用分期付款方式结算，总额"+document.all.sum_money.value+"元，"+payTypeSelectName+"账期"+instalNum+"个月"+"|";
 	}
 	/****end 增加分期付款的内容@2013/3/26 ****/
	note_info1+="备注：手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动拆分的条数收费。"+"|";
	/* ningtn 20100805 R_HLJMob_liubq_CRM_PD3_2010_0464  */
	/* huangrong update 备注信息  */
	note_info2 += "办理的用户不限定资费，但所存的预存款不可以用做包年的底线但可以支付底线外的部分；" 
					+"预存款为协议消费，指定消费期限内不允许销号、退款、转让，系统自动提示不允许办理该业务；"
					+"公免、公务、测试号、商务电话、IP超市、托收用户不参与此活动；"
					+"不允许在协议期限内客户多次办理此项业务；办理赠机业务不限制客户资费，"
					+"参与过其他预存话费赠机、预存话费赠礼等活动的集团客户，"
					+"在消费期限内不能参与集团客户预存话费赠机活动；"
					+"集团客户预存话费赠机活动预存款具有优先使用权。"
					+"并且不改变客户的资费套餐；赠机预存款只享受赠机业务的优惠，"
					+"不参与其它礼品类优惠；商旅套餐、吉祥号码等有底限消费的，"
					+"底限消费可以使用赠机预存款。" + "|";	
	var sale_month_value = $("#sale_month").val();
	if("12w" == sale_month_value){
		note_info3 += "话费12个月内消费完毕，不限制每月消费，到期后剩余话费一次性扣除。" + "|";
	}else if("18w" == sale_month_value){
		note_info3 += "话费18个月内消费完毕，不限制每月消费，到期后剩余话费一次性扣除。" + "|";
	}else if("24w" == sale_month_value){
		note_info3 += "话费24个月内消费完毕，不限制每月消费，到期后剩余话费一次性扣除。" + "|";
	}else if("36w" == sale_month_value){
		note_info3 += "话费36个月内消费完毕，不限制每月消费，到期后剩余话费一次性扣除，手机终端不允许拆包，拆包后话费将冻结不能使用。" + "|";
	}
	/*20121119 gaopeng 关于哈尔滨分公司集团部开展《集团高端客户专享》营销活动的请示 修改免填单内容*/
	//如果消费期限中有“f”
	else if(sale_month_value.indexOf("f")!=-1)
		{
			var monthnum = sale_month_value.replace("f","");
			/*不绑定可累积*/
			if(pCardSelval=="23"){
			note_info3 += "话费分"+monthnum+"个月返还，月返还金额为1/"+monthnum+"，"
				+"如用户销号，剩余话费系统自动扣除，不退、不转。"
				+"当月消费不完，可累积至次月。" + "|";
			}	
			/*不绑定不可累计*/
			if(pCardSelval=="24"){
			note_info3 += "话费分"+monthnum+"个月返还，月返还金额为1/"+monthnum+"，"
				+"如用户销号，剩余话费系统自动扣除，不退、不转。"
				+"当月消费不完，不可累积至次月。" + "|";
			}	
			/*机卡绑定可累积*/
			if(pCardSelval=="13"){
			note_info3 += "话费分"+monthnum+"个月返还，月返还金额为1/"+monthnum+"，"
				+"如用户销号，剩余话费系统自动扣除，不退、不转。"
				+"手机终端不允许拆包，拆包后话费不予返还。 当月消费不完，可累积至次月。" + "|";
			}	
			/*机卡绑定不可累计*/
			if(pCardSelval=="14"){
			note_info3 += "话费分"+monthnum+"个月返还，月返还金额为1/"+monthnum+"，"
				+"如用户销号，剩余话费系统自动扣除，不退、不转。"
				+"手机终端不允许拆包，拆包后话费不予返还。当月消费不完，不可累积至次月。" + "|";
			}		
			
		}
	

	/* ningtn 20100805 R_HLJMob_liubq_CRM_PD3_2010_0464  */
	if(document.all.payTypeSelect.value=="9"){//tianyang add for 支票
 		note_info4+="通过支票缴费方式办理的集团客户预存话费赠机（集团预存赠礼）业务，只能当日冲正"+"|";//tianyang add for 支票	
 	}
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

	if(document.all.award_flag.value == "1")
	{
		retInfo+= "已参与赠送礼品活动"+"|";
	}
	else
	{
		retInfo+= " "+"|";
	}
    return retInfo;	
}



//-->
</script>

<script language="JavaScript">
<!--
/****************根据agent_code动态生成phone_type下拉框************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
    
   myEle = document.createElement("option") ;
    myEle.value = "";
        myEle.text ="--请选择--";
        controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
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
        myEle1.text ="--请选择--";
        document.all.sale_code.add(myEle1) ;

   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{ 
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
 
 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowMessageDialog("请先选择机型",0);
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("phone_getAwardRpc.jsp","正在获得奖品明细，请稍候......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","8030");
 	 	 packet.data.add("style_code",document.all.phone_type.value );
 	 	 
 	 	 core.ajax.sendPacket(packet);
 	 	 packet = null;
 	 	 
 	 }
 	 document.all.award_flag.value = 0;
 	 
 }

 function salechage(){
	var getNote_Packet = new AJAXPacket("f8030_getprepay.jsp","正在获得营销明细，请稍候......");
  getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("agentCode",document.all.agent_code.value);
	getNote_Packet.data.add("phoneType",document.all.phone_type.value);
	getNote_Packet.data.add("saletype","5");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet = null;
 }

/********* tianyang add for 支票缴费 start ************/
function selType()
{
  var payTypeSelectVal = $("#payTypeSelect").val();
  if(payTypeSelectVal != "0" && payTypeSelectVal != "9" && payTypeSelectVal != "BX" && payTypeSelectVal != "BY"){
			$.each(bankInstalArr,function(i,n){
				if(payTypeSelectVal == n[2]){
					var tmpNumArr = n[3].substr(0,n[3].length-1).split("|");
					var tmpIncomeArr = n[4].substr(0,n[4].length-1).split("|");
					$("#installmentTd").empty();
					$.each(tmpNumArr,function(j,m){
						var tmpStr = "";
								/*
            			如果选择的是分期付款的话
            			增加分期付款分期数和贴息比例
            		*/
						if(j == 0){
							tmpStr = "<input type='radio' name='installmentList' value='"+m+"' income='"+tmpIncomeArr[j]+"' checked='checked'/>"+m+"期";
						}else{
							tmpStr = "<input type='radio' name='installmentList' value='"+m+"' income='"+tmpIncomeArr[j]+"'/>"+m+"期";
						}
						$("#installmentTd").append(tmpStr);
						$("#instalTd").show();
						$("#installmentTd").show();
					});
				}
			});
		}else{
		  with(document.frm)
    	{
    		if ( payTypeSelect.value=="9" ){
    			CheckId.style.display="block";
    			CheckId2.style.display="block";
    		}else{
    			CheckId.style.display="none";
    			CheckId2.style.display="none";
    		}
    	}
			/*隐藏*/
			$("#instalTd").hide();
			$("#installmentTd").hide();
		}
}
function getBankCode()
{
 		 var h=480;
		 var w=650;
		 var t=screen.availHeight/2-h/2;
		 var l=screen.availWidth/2-w/2;

	      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
          var returnValue=window.showModalDialog('/npage/public/getBankCode.jsp?region_code=<%=orgCode.substring(0,2)%>&district_code=<%=orgCode.substring(2,4)%>&bank_name='+frm.BankName.value+'&bank_code='+frm.BankCode.value,"",prop);

          document.frm.currentMoney.value='';
 		  if(returnValue==null)
	     {
					rdShowMessageDialog("你输入的条件没有查到相应的银行！");
					document.frm.BankCode.value="";
					document.frm.BankName.value="";
					return false;
		  }

 		  if(returnValue=="")
	     {
					rdShowMessageDialog("您没有选择银行！");
					document.frm.BankCode.value="";
					document.frm.BankName.value="";
					return false;
		  }
		 else
		 {
			 var chPos_str = returnValue.indexOf(",");
			 document.frm.BankCode.value=returnValue.substring(0,chPos_str);
			 document.frm.BankName.value=returnValue.substring(chPos_str+1);
   		 }
}
function getcheckfee()
{
	var bankcode = document.all.BankCode.value;
	var checkno = document.all.checkNo.value;
	if (bankcode=="")
	{
		rdShowMessageDialog("请输入或查询银行!");
 	    return false;
	}
	if (checkno=="")
	{
		rdShowMessageDialog("请输入支票号码!");
		document.all.checkNo.value="";
	    document.all.checkNo.focus();
	     return false;
    }
 	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var str=window.showModalDialog('/npage/public/getcheckfee.jsp?bankcode='+bankcode+'&checkno='+checkno,"",prop);
	if( str==null )
		{
 	   		rdShowMessageDialog("没有找到该支票的余额！");
		    document.frm.currentMoney.value = "";
	   		document.frm.checkNo.focus();
	   		return false;
		}

		document.frm.currentMoney.value = str;
	    return true;
 }
 /********* tianyang add for 支票缴费 end ************/
//-->
</script>


</head>


<body>
<form name="frm" method="post" action="f8030Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">集团用户预存话费优惠购机</div>
	</div>

        <table cellspacing="0">
		  <tr bgcolor="E8E8E8"> 
            <td class="blue" class="blue">操作类型</td>
            <td class="blue">集团用户预存话费优惠购机--申请</td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
          </tr>        
		  <tr> 
            <td class="blue">集团ID</td>
            <td class="blue">
			  <input name="vUnitId" value="<%=vUnitId%>" type="text" v_must=1 Class="InputGrey" readOnly id="vUnitId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">集团名称</td>
            <td class="blue">
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1  Class="InputGrey" readOnly id="vUnitName"  > 
			  <font class="orange">*</font>
            </td>
            </tr>

			<tr> 
            <td class="blue">终端用途</td>
            <td class="blue">
			  <select   name="vTargetCode"  >
                <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < termTypeStr.length ; i ++){%>
                <option value="<%=termTypeStr[i][0]%>"><%=termTypeStr[i][1]%>
                </option>
                <%}%>
               </select>
			  <font class="orange">*</font>
            </td>
            <td class="blue">集团产品分类</td>
            <td class="blue">
			  <select   name="vProductCode"  >
                <option value ="">--请选择--</option>
                
                <%for(int i = 0 ; i < prodTypeStr.length ; i ++){%>
                <option value="<%=prodTypeStr[i][1]%>"><%=prodTypeStr[i][3]%>
                	</option>
                <%}%>
               </select>
			  <font class="orange">*</font>
            </td>
            </tr>
			<tr> 
            <td class="blue">集团产品ID</td>
            <td class="blue">
			  <input name="vProductId" value="" type="text"  id="vProductId" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">&nbsp;</td>
            <td class="blue">&nbsp;</td>
            </tr>
		  
		  
		  <tr> 
            <td class="blue">客户姓名</td>
            <td class="blue">
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cust_name" maxlength="20" v_name="姓名"> 
			  <font class="orange">*</font>
            </td>
            <td class="blue">客户地址</td>
            <td class="blue">
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cust_addr" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">证件类型</td>
            <td class="blue">
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cardId_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">证件号码</td>
            <td class="blue">
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1  Class="InputGrey" readOnly id="cardId_no" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">业务品牌</td>
            <td class="blue">
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1  Class="InputGrey" readOnly id="sm_code" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">运行状态</td>
            <td class="blue">
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1  Class="InputGrey" readOnly id="run_type" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr> 
            <td class="blue">VIP级别</td>
            <td class="blue">
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1  Class="InputGrey" readOnly id="vip" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            <td class="blue">可用预存</td>
            <td class="blue">
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1  Class="InputGrey" readOnly id="prepay_fee" maxlength="20" > 
			  <font class="orange">*</font>
            </td>
            </tr>
            
			
			
			
			
			<tr> 
            <td class="blue">手机品牌</td>
            <td class="blue">
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">  
			    <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font class="orange">*</font>	
			</td>
	 <td class="blue">手机型号</td>
            <td class="blue">
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="手机型号" onchange="typechange()">	
			  	  
              </select>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr> 
         
            <td class="blue">营销方案</td>
            <td class="blue" >
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="营销代码" onchange="change()">			  
              </select>
			  <font class="orange">*</font>
			</td>
			<td class="blue">营销案消费时间</td>
            <td class="blue" colspan="3">
			  <select size=1 name="sale_month" id="sale_month" 
			  	v_must=1 v_name="营销案消费时间" onchange='dispPkt()'>
			  <option value ="">--请选择--</option>
			  <option value ="12w">12个月消费完</option>
			  <option value ="18w">18个月消费完</option>
			  <option value ="24w">24个月消费完</option>
			  <option value ="36w">36个月消费完</option>
			  <option value ="12f">分12个月消费</option>
			  <option value ="18f">分18个月消费</option>
			  <option value ="24f">分24个月消费</option>
			  <option value ="36f">分36个月消费</option>
              </select>
			  <font class="orange">*</font>
			</td>
            
          </tr>
          <tr> 
            <td class="blue" >购机款</td>
            <td class="blue" >
			  <input name="price" type="text"  id="price" v_type="money" v_must=1    Class="InputGrey" readOnly v_name="手机价格" >
			  <font class="orange">*</font>	
			</td>
            <td class="blue">预存话费</td>
            <td class="blue">
			  <input name="pay_money" type="text"   id="pay_money" v_type="0_9" v_must=1   v_name="预存话费"  Class="InputGrey" readOnly>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr> 
            <td class="blue" >应付金额</td>
            <td class="blue" >
			  <input name="sum_money" type="text"  id="sum_money"  Class="InputGrey" readOnly>
			  <font class="orange">*</font>
			</td>
            <td class="blue" colspan="2">
            	是否参与赠礼
            	<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />&nbsp&nbsp
				<!-- 20121119 gaopeng 关于哈尔滨分公司集团部开展《集团高端客户专享》营销活动的请示 去掉机卡绑定
				<font class='blue' id="pktTitle" name="pktTitle" 	style="display:none">机卡绑定</font>
				-->
					<!--拆包1, 不拆包0 是否拆包后来胡雪莲改成叫机卡绑定-->
					<!--20121119 gaopeng 关于哈尔滨分公司集团部开展《集团高端客户专享》营销活动的请示 去掉机卡绑定(这里去掉复选框)
					<input type="checkbox" id='checkPkt' name="checkPkt" 	onclick="chkPkt()" style='display:none'/>
					<input type="hidden" name="pktFlag" value="1" />
					-->
			</td>
          </tr> 
          	<!-- ningtn add for pos start @ 20100722 -->
			<tr>
			<td class="blue">缴费方式</td>
			<td >
				<select name="payTypeSelect" id="payTypeSelect" onChange="selType()" style="width:150px">
					<option value="0">现金缴费</option>
					<option value="9">支票缴费</option>
					<option value="BX">建设银行POS机缴费</option>
					<option value="BY">工商银行POS机缴费</option>
				</select>
			</td>
			<td class="blue" id="instalTd" style="display:none;">
					分期
			</td>
			<td id="installmentTd" style="display:none;">
			</td>	
			</tr>
			<!-- ningtn add for pos end @ 20100722 -->
			<!-- tianyang add for 支票缴费 start -->
			<tr id="CheckId" style="display:none">
				<td class="blue" noWrap>银行代码</td>
				<td noWrap>
				<input name="BankCode" size="12" maxlength="12">
				<input name="BankName" size="13" onKeyDown="if(event.keyCode==13)getBankCode();" >
				<input name="bank1CodeQuery" type=button class="b_text" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value="查询" >
				</td>
				<td class="blue" noWrap>支票号码</td>
				<td noWrap>
				<input type="text" name="checkNo" maxlength="20" value="" onKeyDown="if(event.keyCode==13)getcheckfee();" onChange="document.frm.currentMoney.value=''">
				<input name=checkfeequery type=button class="b_text" style="cursor:hand" onClick="getcheckfee()" value="查询">
				</td>
	
			</tr>
			<tr id="CheckId2" style="display:none">
				<td class="blue" noWrap>可用金额</td>
				<td noWrap colspan="3">
				<input type="textarea" readonly name="currentMoney">
				</td>
			</tr>
			<!-- tianyang add for 支票缴费 end -->
          <TR bgcolor="#EEEEEE"> 
			<td class="blue"  nowrap> 
				<div align="left">IMEI码</div>
            </TD>
            <td class="blue" > 
				<input name="IMEINo"  type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei"  type="button" value="校验" onclick="checkimeino()" class="b_text">
                <font class="orange">*</font>
            </TD>
      <!--20121119 gaopeng 关于哈尔滨分公司集团部开展《集团高端客户专享》营销活动的请示  
				增加“专款返还方式”的选择，选项有:不绑定不可累计、机卡绑定不可累计、不绑定可累积和机卡绑定可累积
			 -->
			<td class="blue">
				<font class='blue' id="pktTitle" name="pktTitle" 	style="display:none">专款返还方式</font>
			</td>
			<td class="blue">
				<select id="pCardSel" name="pCardSel" style="display:none">
				 	
				</select>
			</td>
          </TR>
		  <TR bgcolor="#EEEEEE" id=showHideTr > 
			<td class="blue"  nowrap> 
				<div align="left">付机时间</div>
            </TD>
			<td class="blue" > 
				<input name="payTime"  type="text" v_name="付机时间"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(年月日)<font class="orange">*</font>                  
			</TD>
			<td class="blue"  nowrap> 
				<div align="left">保修时限 </div>
			</TD>
			<td class="blue" > 
				<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="保修时限" value="12" onblur="viewConfirm()">
				(个月)<font class="orange">*</font>
			</TD>
          </TR>
		  <tr bgcolor="E8E8E8"> 
            <td class="blue" height="32">备注</td>
            <td class="blue" colspan="3" height="32">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="集团用户预存话费优惠购机" class="InputGrey" readOnly> 
            </td>
          </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
          <tr> 
            <td class="blue" colspan="4"> <div align="center"> 
                <input name="confirm" type="button"  index="2" value="确认&打印" onClick="printCommit()" class="b_foot_long">
                &nbsp; 
                <input name="reset" type="reset"  value="清除" class="b_foot">
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button"  value="返回" class="b_foot"s>
                &nbsp; </div></td>
          </tr>
        </table>

    <input type="hidden" name="consum_note" value="">
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="5" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<!-- ningtn add for pos start @ 20100722 -->		
	<input type="hidden" name="payType"  value=""><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 EI 工商银行分期付款 -->			
	<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
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
	<!-- ningtn add for pos end @ 20100722 -->
	<%@ include file="/npage/include/footer.jsp" %>
	<!--  add for 工商pos分期付款  @ 2013/3/25  -->
	<input type="hidden" id="iInstNum" name="iInstNum" value=""/>
	<input type="hidden" name="transTotal" id="transTotal"  value=""><!-- 交易总账 -->
	<input type="hidden" name="bMoney"  value=""><!-- 交易金额 -->
	<input type="hidden" name="installmentNumStr" id="installmentNumStr" value=""><!-- 工行分期付款期数 -->
	<input type="hidden" name="installmentIncomeStr" id="installmentIncomeStr" value=""><!-- 工行分期付款 贴息比例 -->
</form>
</body>
<!-- **** ningtn add for pos @ 20100722 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>