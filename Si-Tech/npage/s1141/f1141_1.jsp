<%
/********************
 version v2.0
开发商: si-tech
update:liutong@20080905
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  /**ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfoSession = (String[][])arrSession.get(0);
  String[][] otherInfoSession = (String[][])arrSession.get(2);
  String[][] pass = (String[][])arrSession.get(4);

  String loginNo = baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String powerCode= otherInfoSession[0][4];
  String orgCode = baseInfoSession[0][16];
  String ip_Addr = request.getRemoteAddr();
  String regionCode = orgCode.substring(0,2);
  String regionName = otherInfoSession[0][5];
  String loginNoPass = pass[0][0];
  String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
  **/

	String opCode = "1141";
	String opName = "预存话费优惠购机";
	String loginNo =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String powerCode =(String)session.getAttribute("powerCode");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr =(String)session.getAttribute("ip_Addr");
	String op_code=request.getParameter("opCode");
  String loginPwd    = (String)session.getAttribute("password");
	String groupId = (String)session.getAttribute("groupId");
%>
<%
	String retFlag="",retMsg="";
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retList = new ArrayList();
	String[] paraAray1 = new String[3];
	String phoneNo = request.getParameter("srv_no");
	String opcode = request.getParameter("opcode");
	String passwordFromSer="";


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
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别，当前积分,可用预存
 */

/** retList = impl.callFXService("s1141Qry", paraAray1, "14","phone",phoneNo);


  int errCode = impl.getErrCode();
  String errMsg = impl.getErrMsg();
  **/


  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String[][] tempArr= new String[][]{};
%>
			<wtc:service name="s1141Qry" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="14" >
					
		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>	
				
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%
System.out.println("1141!~~~s1141Qry~~~errCode="+errCode);

if(errCode.equals("0")||errCode.equals("000000")){
System.out.println("调用服务s1141Qry in f1141_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");

 if(result == null)
  {
				if(!retFlag.equals("1"))
				{
					System.out.println("retFlag=   "+retFlag);
				   retFlag = "1";
				   retMsg = "s1141Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
			    }
  }
  else
  {
							  	System.out.println("errCode=  "+errCode);
							  	System.out.println("errMsg=   "+errMsg);
							  	System.out.println("________________________-- result.length  "+  result.length);
		System.out.println("_________________________________________________________________________");
	    for(int i=0;i<result.length;i++){
	      for(int j=0;j<result[i].length;j++){
	      System.out.println("result["+i+"]["+j+"]"+"   "+result[i][j]);

	      }


	    }
System.out.println("_________________________________________________________________________");



							  tempArr = result;
							  if(!(tempArr==null)){
							    bp_name = result[0][2];//机主姓名
							    System.out.println(bp_name);
							  }
							 // tempArr = (String[][])retList.get(3);
							  if(!(tempArr==null)){
							    bp_add = result[0][3];//客户地址
							  }
							 // tempArr = (String[][])retList.get(4);
							  if(!(tempArr==null)){
							    cardId_type =result[0][4];//证件类型
							  }
							 /// tempArr = (String[][])retList.get(5);
							  if(!(tempArr==null)){
							    cardId_no = result[0][5];//证件号码
							  }
							//  tempArr = (String[][])retList.get(6);
							  if(!(tempArr==null)){
							    sm_code =result[0][6];//业务品牌
							  }
							 // tempArr = (String[][])retList.get(7);
							  if(!(tempArr==null)){
							    region_name = result[0][7];//归属地
							  }
							//  tempArr = (String[][])retList.get(8);
							  if(!(tempArr==null)){
							    run_name = result[0][8];//当前状态
							  }
							//  tempArr = (String[][])retList.get(9);
							  if(!(tempArr==null)){
							    vip = result[0][9];//ＶＩＰ级别
							  }
							//  tempArr = (String[][])retList.get(10);
							  if(!(tempArr==null)){
							    posint = result[0][10];//当前积分
							  }
							//  tempArr = (String[][])retList.get(11);
							  if(!(tempArr==null)){
							    prepay_fee = result[0][11];//可用预存
							  }
						//	  tempArr = (String[][])retList.get(13);
							  if(!(tempArr==null)){
							    passwordFromSer = result[0][13];  //密码
							  }

  }



}else{
System.out.println("调用服务s1141Qry in f1141_1.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
				history.go(-1);
			</script>
<%
}

//******************得到下拉框数据***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
String exeDate="";
exeDate = getExeDate("1","1141");

 // comImpl co=new comImpl();
  //手机品牌
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='1' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("*******************************************************************");
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  System.out.println("*******************************************************************");
 // ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
  //String[][] agentCodeStr = (String[][])agentCodeArr.get(0);

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
<wtc:sql><%=sqlAgentCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end" />

<%
  //先判断一下是不是服务调用失败
          if(retCode1.equals("0")||retCode1.equals("000000")){
          System.out.println("调用服务sPubSelect in f1141_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");


 	     	}else{
 			System.out.println("调用服务sPubSelect in f1141_1.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");

					%>
						<script language="JavaScript">
							rdShowMessageDialog("服务调用失败！");
							history.go(-1);
						</script>
					<%

 			}


  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='1' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  //ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
  //String[][] phoneTypeStr = (String[][])phoneTypeArr.get(0);

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="4">
<wtc:sql><%=sqlPhoneType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="phoneTypeStr" scope="end" />

<%

          if(retCode2.equals("0")||retCode2.equals("000000")){
          System.out.println("调用服务sPubSelect in f1141_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");


 	     	}else{
 			System.out.println("调用服务sPubSelect in f1141_1.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");

					%>
						<script language="JavaScript">
							rdShowMessageDialog("服务调用失败！");
							history.go(-1);
						</script>
					<%

 			}



  //营销代码
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_limit from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='1' and valid_flag='Y' and a.spec_type like 'P%'";
  System.out.println("sqlsaleType====="+sqlsaleType);
 // ArrayList saleTypeArr = co.spubqry32("4",sqlsaleType);
 // String[][] saleTypeStr = (String[][])saleTypeArr.get(0);

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="5">
<wtc:sql><%=sqlsaleType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="saleTypeStr" scope="end" />

<%

          if(retCode2.equals("0")||retCode2.equals("000000")){
          System.out.println("调用服务sPubSelect in f1141_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");


 	     	}else{
 			System.out.println("调用服务sPubSelect in f1141_1.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");

					%>
						<script language="JavaScript">
							rdShowMessageDialog("服务调用失败！");
							history.go(-1);
						</script>
					<%

 			}


%>
<%
	/* ningtn 号簿管家需求 */
	String password = (String)session.getAttribute("password");
	String[] paraAray4 = new String[7];
	paraAray4[0] = printAccept;
	paraAray4[1] = "01";
	paraAray4[2] = opCode;
	paraAray4[3] = loginNo;
	paraAray4[4] = password;
	paraAray4[5] = phoneNo;
	paraAray4[6] = "";
	String showText = "";
%>
	<wtc:service name="sAdTermQry" routerKey="regionCode" routerValue="<%=regionCode%>"  
				 retcode="retCode4" retmsg="retMsg4"  outnum="3" >
		<wtc:param value="<%=paraAray4[0]%>"/>
		<wtc:param value="<%=paraAray4[1]%>"/>
		<wtc:param value="<%=paraAray4[2]%>"/>
		<wtc:param value="<%=paraAray4[3]%>"/>
		<wtc:param value="<%=paraAray4[4]%>"/>
		<wtc:param value="<%=paraAray4[5]%>"/>
		<wtc:param value="<%=paraAray4[6]%>"/>
	</wtc:service>
	<wtc:array id="result4" scope="end" />
<%
	if("000000".equals(retCode4)){
		System.out.println("~~~~调用sAdTermQry成功~~~~");
		if(result4 != null && result4.length > 0){
			showText = result4[0][2];
		}
	}else{
		System.out.println("~~~~调用sAdTermQry失败~~~~");
%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=retCode4%>，错误信息：<%=retMsg4%>");
				history.go(-1);
			</script>
<%
	}
%>
<html>
<head>
<title>预存话费优惠购机</title>


 <script language=javascript>

  onload=function()
  {

  }
  
  /*zhangyan add*/
function getUsedPoint()
{
	/*校验*/
	if(document.all.agent_code.value=="")
	{
		rdShowMessageDialog("请选择手机品牌!");
		document.all.agent_code.focus();
		return false;
	}
	
	if(document.all.phone_type.value=="")
	{
		rdShowMessageDialog("请选择手机型号!");
		document.all.phone_type.focus();
		return false;
	}
	
	if(document.all.sale_code.value=="")
	{
		rdShowMessageDialog("请选择营销代码!");
		document.all.sale_code.focus();
		return false;
	}	
	
	/*指定Ajax调用页*/
	var packet = new AJAXPacket("f1141Ajax.jsp","请稍后...");
		
	/*给ajax页面传递参数*/
	packet.data.add("opCode","<%=opCode%>" );
	packet.data.add("ajaxType","getM" );
	packet.data.add("phoneNo","<%=phoneNo%>" );
	/*购机款*/
	packet.data.add("machPrice",document.all.price.value );
	/*消费积分*/
	packet.data.add("markPoint",  parseInt(document.all.used_point.value ,10));
	
	/*调用页面,并指定回调方法*/
	core.ajax.sendPacket(packet,setMarkPoint,true);
	packet=null;
}

/*zhangyan add*/
function setMarkPoint(packet)
{
	/*规则来自change()函数 , 计算应付金额的初始值*/
	document.all.price.value
		=document.all.sale_code.options[document.all.sale_code.selectedIndex].nv2;
	document.all.pay_money.value
		=document.all.sale_code.options[document.all.sale_code.selectedIndex].nv3;

	//wangdana add for  手机电视
	document.all.TVprice.value
		=document.all.sale_code.options[document.all.sale_code.selectedIndex].nv4;
	document.all.TVtime.value
		=document.all.sale_code.options[document.all.sale_code.selectedIndex].nv5;		
	
		var i=document.all.price.value;
		var j=document.all.pay_money.value;
		var y=document.all.TVprice.value;
		var z=document.all.TVtime.value;
		document.all.sum_money.value=(parseFloat(i)+parseFloat(j)+parseFloat(y)).toFixed(2);//wangdana update for 手机电视费
		
	
	var rtCode=packet.data.findValueByName("rtCode"); 	
	var rtMsg=packet.data.findValueByName("rtMsg"); 	
	
	if ( rtCode=="000000" )
	{
		//document.all.used_point.disabled=true;
		/*积分对应的钱数*/
		var	rstMarkQry	=packet.data.findValueByName("rstMarkQry"); 
		/*表单赋值*/
		document.all.point_money.value	= rstMarkQry;		
		
		var sum_money=document.all.sum_money.value ;
		
		/*应收金额-积分兑换的钱数*/
		sum_money=parseFloat(sum_money-rstMarkQry).toFixed(2);
		document.all.sum_money.value=sum_money;
	}
	else
	{
		document.all.used_point.value="0";
		rdShowMessageDialog(rtCode+":"+rtMsg);
		return false;
	}
}

 function doProcess(packet){

 		errorCode = packet.data.findValueByName("errorCode");
		errorMsg =  packet.data.findValueByName("errorMsg");
		retType = packet.data.findValueByName("retType");
		retResult= packet.data.findValueByName("retResult");
		self.status="";
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";

		ret_code =  parseInt(errorCode);
		//alert("111111111111111111111111" +errorCode );
		//alert("111111111111111111111111" +errorMsg );
		//alert("111111111111111111111111----------"            +   verifyType );
		//	alert("111111111111111111111111" +backArrMsg );
		if(retType=="getcard"){
			if( ret_code == "000000"){
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
					
					//wangdana add for 手机电视
					document.all(tmpObj).options[i].nv4=backArrMsg[i][4];
					document.all(tmpObj).options[i].nv5=backArrMsg[i][5];			        
			        
			        
			      }
			}
			else{
				rdShowMessageDialog("取信息错误:"+errorMsg+"!");
				return;
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
    			return ;
    		}
    		document.all.award_flag.value = 1;
    	}
    	else{
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！");
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！");
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
					return  ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！");
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！");
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
 	
  	/*zhangyan add 手机品牌变化时消费积分清零*/
 	document.all.used_point.value="0";
 	document.all.sum_money.value="0.00";
 		
	with(document.frm){

		price.value=sale_code.options[sale_code.selectedIndex].nv2;
		pay_money.value=sale_code.options[sale_code.selectedIndex].nv3;

		//wangdana add for  手机电视
		TVprice.value=sale_code.options[sale_code.selectedIndex].nv4;
		TVtime.value=sale_code.options[sale_code.selectedIndex].nv5;		
		
		var i=price.value;
		var j=pay_money.value;
		var y=TVprice.value;
		var z=TVtime.value;
		sum_money.value=(parseFloat(i)+parseFloat(j)+parseFloat(y)).toFixed(2);//wangdana update for 手机电视费
	}
}


function addmonth(now_yyyymmdd,num){
		var num_int = Number(num);
		var year_str = now_yyyymmdd.substr(0,4);
		var month_str = now_yyyymmdd.substr(4,2);
		var day_str = now_yyyymmdd.substr(6,2);
		var month_nu = Number(month_str);
		
		var year_add = (month_nu+num_int)/12;
		var month_new = (month_nu+num_int)%12;
	
	  var year_new = Number(year_str)+Number((year_add+'').substr(0,(year_add+'').indexOf('.')));
	  var month_new_str = month_new+'';
	  if(month_new_str.length==1)
	  {
	  	month_new_str ='0'+month_new_str; 
	  }
	  return (year_new+"") + (month_new_str+"");
		
}
 </script>
<script language="JavaScript">

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
		///////<!-- ningtn add for pos start @ 20100408 -->
		document.all.payType.value = document.all.payTypeSelect.value;
		//document.all.used_point.disabled=false;
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
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
		
		//////<!-- ningtn add for pos end @ 20100408 -->

  }
  
	/* ningtn add for pos start @ 20100408 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","正在获得系统时间，请稍候......");
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
	/* ningtn add for pos start @ 20100408 */
 //***IMEI 号码校验
 function checkimeino()
{
	if(document.frm.phone_type.value==""){
		rdShowMessageDialog("请先选择手机品牌及型号！");
		return false;
		}
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     }


	//alert(document.all.agent_code.options[document.all.agent_code.selectedIndex].value);
	//alert(document.all.phone_type.options[document.all.phone_type.selectedIndex].value);
	//alert(document.all.IMEINo.value);

	var myPacket = new AJAXPacket("queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code", (document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket=null;

}
 function printCommit()
 {

 	getAfterPrompt();
  //校验
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("请输入姓名!");
      cust_name.focus();
	  return false;
	}
	if(agent_code.value==""){
	  rdShowMessageDialog("请输入手机品牌!");
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("请输入手机型号!");
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("请输入营销代码!");
      sale_code.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     }
	 document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var printStr = printInfo(printType);

	var mode_code=null;
	var fav_code=null;
	var area_code=null;

	var sysAccept = document.all.login_accept.value;
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{

	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay*100/12)/100;

     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";

	 var retInfo = "";

	cust_info+="手机号码：   "+document.all.phone_no.value+"|";
	cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
	cust_info+="客户地址：   "+document.all.cust_addr.value+"|";
	cust_info+="证件号码：   "+document.all.cardId_no.value+"|";

	opr_info+="业务类型：预存话费优惠购机"+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	opr_info+="手机型号: "+document.all.phone_typename.value+"      IMEI码："+document.frm.IMEINo.value+"|";
 	opr_info+="缴款合计："+document.all.sum_money.value+"元、含预存话费"+document.all.pay_money.value+"元，每月返还金额"+month_fee+"元"+"返还截止到"+"<%=exeDate%>"+"，|";
 	opr_info+="手机电视功能费"+document.all.TVprice.value+"元，每月返还金额"+document.all.TVprice.value/document.all.TVtime.value+"元"+"返还截止到"+addmonth("<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>",document.all.TVtime.value)+"|";


  
	note_info1+="备注："+document.all.opNote.value+"|";

  	if(document.all.award_flag.value == "1")
	{
		//retInfo+= "已参与赠送礼品活动"+"|";
		note_info1+= "已参与赠送礼品活动"+"|";
	}
	else
	{
		//retInfo+= " "+"|";
		note_info1+= " "+"|";
	}
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}



//-->
</script>

<script language="JavaScript">
<!--
/****************根据agent_code动态生成phone_type下拉框************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
  	/*zhangyan add 手机品牌变化时消费积分清零*/
 	document.all.used_point.value="0";
 	document.all.sum_money.value="0.00";	
 	 document.frm.confirm.disabled=true;
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
 	
  	/*zhangyan add 手机品牌变化时消费积分清零*/
 	document.all.used_point.value="0";
 	document.all.sum_money.value="0.00";
 		
  document.frm.confirm.disabled=true;
 	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--请选择--";
        document.all.sale_code.add(myEle1) ;
      //  alert("sssssssssss");
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

	var getNote_Packet = new AJAXPacket("f1141_getprepay.jsp","正在获得营销明细，请稍候......");
    getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("agentCode",document.all.agent_code.value);
	getNote_Packet.data.add("phoneType",document.all.phone_type.value);
	getNote_Packet.data.add("saletype","1");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet=null;
 }


 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowMessageDialog("请先选择机型");
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("phone_getAwardRpc.jsp","正在获得奖品明细，请稍候......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","1141");
 	 	 packet.data.add("style_code",document.all.phone_type.value );

 	 	 core.ajax.sendPacket(packet);
 	 	 packet=null;

 	 }
 	 //document.all.award_flag.value = 0;
 }

//-->
/* ningtn 号簿管家需求 */
	$(document).ready(function(){
		var showtext = "<%=showText%>";
		var showMsgObj = $("#showMsg");
		showMsgObj.hide();
		if(showtext.length > 0){
			showMsgObj.children("div").text(showtext);
			showMsgObj.show();
		}
	});
</script>


</head>


<body>
<form name="frm" method="post" action="f1141Cfm.jsp" onKeyUp="chgFocus(frm)">

   <%@ include file="/npage/include/header.jsp" %>
   <!-- /* ningtn 号簿管家需求 */  -->
<div class="title" id="showMsg">
	<div id="title_zi">
	
	</div>
</div>
		<div class="title">
			<div id="title_zi">预存话费优惠购机</div>
		</div>
        <table  cellspacing="0">
		  <tr>
            <td class="blue">操作类型</td>
            <td colspan="3">预存话费优惠购机--申请</td>
          </tr>
          <tr >
            <td  class="blue">客户姓名</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly Class="InputGrey"     id="cust_name" maxlength="20" v_name="姓名">

            </td>
            <td class="blue">客户地址</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1  readonly Class="InputGrey"     id="cust_addr" size="40">

            </td>
            </tr>
            <tr>
            <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1  readonly Class="InputGrey"     id="cardId_type" maxlength="20" >

            </td>
            <td class="blue">证件号码</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1  readonly Class="InputGrey"     id="cardId_no" maxlength="20" >

            </td>
            </tr>
            <tr>
            <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1  readonly Class="InputGrey"     id="sm_code" maxlength="20" >

            </td>
            <td class="blue">运行状态</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1  readonly Class="InputGrey"     id="run_type" maxlength="20" >

            </td>
            </tr>
            <tr>
            <td class="blue">VIP级别</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1  readonly Class="InputGrey"     id="vip" maxlength="20" >

            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1  readonly Class="InputGrey"     id="prepay_fee" maxlength="20" >

            </td>
            </tr>
             <tr>
            <td class="blue">手机品牌</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1
			  	onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">
			    <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font color="red">*</font>
			</td>
	 <td class="blue">手机型号</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1  onchange="typechange()">

              </select>
			  <font color="red">*</font>
			</td>
          </tr>
          <tr>

            <td class="blue">营销方案
            </td>
            <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="营销代码" onchange="change()">
              </select>
			  <font color="red">*</font>
			</td>
			<td colspan="2" class="blue">是否参与赠礼<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
			</td>

          </tr> 
          <tr>
            <td  class="blue">购机款</td>
            <td >
			  <input name="price" type="text"  id="price" v_type="money" v_must=1    readonly Class="InputGrey"     v_name="手机价格" >

			</td>
            <td class="blue">预存话费</td>
            <td>
			  <input name="pay_money" type="text"  Class="InputGrey" id="pay_money" v_type="0_9" v_must=1   v_name="预存话费" readonly>

			</td>
          </tr>
		<!--手机电视需求新增 wangdana-->
		<tr>
			<td  class="blue">手机电视功能费</td>
			<td >
				<input name="TVprice" type="text"  id="TVprice" v_type="money" v_must=1    readonly Class="InputGrey"     v_name="手机电视功能费" >
			</td>
			<td class="blue">手机电视消费期限</td>
			<td>
				<input name="TVtime" type="text"  Class="InputGrey" id="TVtime" v_type="0_9" v_must=1   v_name="消费时长" readonly>
			</td>
		</tr>
          
          <tr>
 			<!--zhangyan -->
			<td class="blue">消费积分</td>
      		<td> 
				<input name="used_point" type="text"  id="used_point" value='0'
					v_must='1' v_type='0_9' onchange='getUsedPoint()'  >
			</td>
            <td  class="blue">应付金额</td>
            <td  >
			  	<input name="sum_money" type="text"  id="sum_money" readonly Class="InputGrey">
			</td>
          </tr>
					<!-- ningtn add for pos start @ 20100408 -->
					<TR>
						<!--zhangyan add-->
						<td class="blue">当前积分</td>			
			            <td>
						  	<input name="posint" type="text"  
						  	id="posint" readonly Class="InputGrey" value="<%=posint%>"/>
						</td>
						<TD class="blue">缴费方式</TD>
						<TD >
							<select name="payTypeSelect" >
								<option value="0">现金缴费</option>
								<option value="BX">建设银行POS机缴费</option>
								<option value="BY">工商银行POS机缴费</option>
							</select>
						</TD>
					</TR>
					<!-- ningtn add for pos end @ 20100408 -->
         <TR>
			<TD  nowrap class="blue">
				<div align="left">IMEI码</div>
            </TD>
            <TD colspan="3">
				<input name="IMEINo" class="button" type="text" v_type="0_9"   maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
                <font color="red">*</font>
            </TD>

          </TR>
		  <TR id=showHideTr >
			<TD  nowrap class="blue">
				<div align="left">付机时间</div>
            </TD>
			<TD >
				<input name="payTime" class="button" v_must=1 type="text" v_type="date" v_format="yyyyMMdd"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>" onblur="checkElement(document.all.payTime)">
				(年月日)<font color="red">*</font>
			</TD>
			<TD  nowrap class="blue">
				<div align="left">保修时限 </div>
			</TD>
			<TD >
				<input name="repairLimit" v_type="date.month" class="button" size="10" v_must=1 type="text"  value="12" onblur="if(checkElement(this)){viewConfirm()}">
				(个月)<font color="red">*</font>
			</TD>
          </TR>
		  <tr>
            <td height="32"   class="blue">用户备注</td>
            <td colspan="3">
             <input name="opNote" type="text" class="button" id="opNote" size="60" maxlength="60" value="预存话费优惠购机" >
            </td>
          </tr>
        </table>
        <!-- ningtn 2011-7-12 08:33:59 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
        <table>
          <tr>
            <td colspan="4" id="footer"> <div align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()" disabled >
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp;
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
                &nbsp; </div></td>
          </tr>
        </table>
 			
  
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
   
	<input type="hidden" name="point_money" value="0" >
	<input type="hidden" name="phone_typename" value="" >
	<input type="hidden" name="op_code" value="<%=op_code%>" >
	
	<!-- ningtn add for pos start @ 20100408 -->		
	<input type="hidden" name="payType"  value=""><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->			
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
	<!-- ningtn add for pos end @ 20100408 -->
     <%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100408 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
<%@ include file="/npage/public/hwObject.jsp" %>
</html>
