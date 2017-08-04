<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 统一预存赠礼2289
   * 版本: 1.0
   * 日期: 2008/12/31
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="2289";
	String opName="统一预存赠礼";
  String loginNoPass = (String)session.getAttribute("password");
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionNo=orgCode.substring(0,2);//huangrong add
	String regionCode = (String)session.getAttribute("regCode");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");  				//数据格式为String[0][0]---String[n][0]
	String groupId = (String)session.getAttribute("groupId");
	String flag= request.getParameter("flag");//huangrong add 是否参与预约标记
	int recordNum=0;
	int i=0;

//  comImpl co1 = new comImpl();
//	String paraStr[]=new String[1];
	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
//  paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
//	ArrayList retList = new ArrayList();
//	String[][] tempArr= new String[][]{};

	String retFlag="",retMsg="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	String point_note="",open_time="";
	String  start_time="";//huangrong add
	
	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode = request.getParameter("opcode");
	String cus_pass = request.getParameter("cus_pass");
	/*begin huangrong add 查询用户所属地市和入网时间 2011-4-26 16:53*/
	String Infosql="SELECT subStr(belong_code,1,2),ceil(months_between(SYSDATE,open_time)) FROM dCustMsg  WHERE phone_no='"+iPhoneNo+"'";
	String cust_belongCode="";
	String cust_openTime="";	
	int opTimeTotal=0;
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="InfoRetCode" retmsg="InfoRetMsg" outnum="2">
	<wtc:sql><%=Infosql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="InfosqlStr" scope="end" />

<%
	if(InfoRetCode.equals("000000"))
	{
		if(InfosqlStr!=null && InfosqlStr.length>0)
	  	{
				cust_belongCode=InfosqlStr[0][0];
				cust_openTime=InfosqlStr[0][1];
				opTimeTotal=Integer.parseInt(cust_openTime);
			}	
	}else
	{
%>	
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=InfoRetCode%>，错误信息：<%=InfoRetMsg%>",0);
				history.go(-1);
			</script>
<%
	}
		/*end huangrong add 查询用户所属地市和入网时间 2011-4-26 16:53*/
//	SPubCallSvrImpl co2 = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = flag;//huangrong add
	System.out.println("inputParsm[0] = iPhoneNo  "+ iPhoneNo);
	System.out.println("inputParsm[1] = loginNo   "+ loginNo);
	System.out.println("inputParsm[2] = orgCode   "+ orgCode);
	System.out.println("inputParsm[3] = iOpCode   "+ iOpCode);


//	  retList = co2.callFXService("s2289Qry", inputParsm, "30","phone",iPhoneNo);
%>
<%/*wangdana  统一预存赠礼专款限制查询*******************/%>
<wtc:service name="q_s2289Query" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode2" retmsg="retMsg2">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr2" scope="end"/>
<%
if (retCode2.equals( "000000") ){
}
else{%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=retCode2%>，错误信息：<%=retMsg2%>",0);
				history.go(-1);
			</script>
      <%}
%>
<%/*wangdana  统一预存赠礼专款限制查询*******************/%>

	<wtc:service name="s2289Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="32" retcode="retCode" retmsg="retMsg1">

					<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNoPass%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=orgCode%>"/>
			<wtc:param value="<%=flag%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String errCode = retCode;
  String errMsg = retMsg1;

  System.out.println("errCode="+errCode);
  System.out.println("errMsg ="+errMsg);

  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s2289Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals( "000000") && tempArr.length>0){
	  	if(!(tempArr==null)){
		    bp_name = tempArr[0][3];           //机主姓名
		    bp_add = tempArr[0][4];            //客户地址
		    passwordFromSer = tempArr[0][2];   //密码
		    sm_code = tempArr[0][11];          //业务类别
		    sm_name = tempArr[0][12];          //业务类别名称
		    hand_fee = tempArr[0][13];     	   //手续费
		    favorcode = tempArr[0][14];     	//优惠代码
		    rate_code = tempArr[0][5];    		 //资费代码
		    rate_name = tempArr[0][6];    		//资费名称
		    next_rate_code = tempArr[0][7];		//下月资费代码
		    next_rate_name = tempArr[0][8];		//下月资费名称
		    bigCust_flag = tempArr[0][9];		//大客户标志
		    bigCust_name = tempArr[0][10];		//大客户名称
		    lack_fee = tempArr[0][15];			//总欠费
		    prepay_fee = tempArr[0][16];		//总预交
		    cardId_type = tempArr[0][17];		//证件类型
		    cardId_no = tempArr[0][18];			//证件号码
		    cust_id = tempArr[0][19];			//客户id
		    cust_belong_code = tempArr[0][20];	//客户归属id
		    group_type_code = tempArr[0][21];	//集团客户类型
		    group_type_name = tempArr[0][22];	//集团客户类型名称
		    imain_stream = tempArr[0][23];		//当前资费开通流水
		    next_main_stream = tempArr[0][24];	//预约资费开通流水
		    print_note = tempArr[0][25];		//工单广告
		    contract_flag = tempArr[0][27];		//是否托收账户
		    high_flag = tempArr[0][28];			//是否中高端用户
		    point_note = tempArr[0][29];		//积分清零提示
		    open_time = tempArr[0][30];			//开户时间
		    start_time= tempArr[0][31];     //huangrong add 预约生效时间
	 	}
	}else{%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%}
 }

/*** 20091119 fengry begin for 伊春4即有礼 ***/
	String Timesql = "select COUNT(*) from dcustmsg where phone_no = '"+iPhoneNo+"' and to_char(sysdate,'yyyymmdd') - to_char(open_time,'yyyymmdd') = 0";
  System.out.println("Timesql==="+Timesql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="TimeRetCode" retmsg="TimeRetMsg" outnum="1">
	<wtc:sql><%=Timesql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="TimeStr" scope="end" />
<%
System.out.println("TimeStr[0][0]==="+TimeStr[0][0]);
System.out.println("TimeRetCode==="+TimeRetCode);
System.out.println("TimeRetMsg==="+TimeRetMsg);


	String Goodsql = "select COUNT(*) from dual where substr('"+iPhoneNo+"',8,4) like '%4%' and not exists(select 1 from dgoodphoneres where phone_no='"+iPhoneNo+"' )";
  System.out.println("Goodsql==="+Goodsql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="GoodRetCode" retmsg="GoodRetMsg" outnum="1">
	<wtc:sql><%=Goodsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="GoodStr" scope="end" />
<%
System.out.println("GoodStr[0][0]==="+GoodStr[0][0]);
System.out.println("GoodRetCode==="+GoodRetCode);
System.out.println("GoodRetMsg==="+GoodRetMsg);
/*** 20091119 end ***/

String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>统一预存赠礼</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
//begin huangrong add for 是否参与抽奖只对牡丹江显示
	onload=function()
	  {
	  	document.all.take_prize[0].checked=true;  		  	
	  	if("<%=regionNo%>"=="03")
	  	{
	  		var td2=document.getElementById("td2");
	  		td2.style.display="";
	  		var td3=document.getElementById("td3");
	  		td3.style.display="";
	  		var td1=document.getElementById("td1");
	  		td1.colSpan="1";
	  	}
	  }
//end huangrong add for 是否参与抽奖只对牡丹江显示	  
  var arrbrandcode = new Array();//手机型号代码
  var arrbrandname = new Array();//手机型号名称
  var arrbrandmoney = new Array();//代理商代码

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  var arrtypemoney=new Array();
  var arrsalemoney=new Array();

  var arrdetbase=new Array();
  var arrdetfree=new Array();
  var arrdetfavour=new Array();
  var arrdetconsume=new Array();
  var arrdetmonbase=new Array();
  var arrdetmode=new Array();
  var arrdetsummoney=new Array();
  var arrdetsalecode=new Array();


  //--------2---------验证按钮专用函数-------------

function frmCfm()
{
		///////<!-- ningtn add for pos start @ 20100430 -->
		document.all.payType.value = document.all.payTypeSelect.value;
		if(document.all.payType.value=="BX")
  	{
    		/*set 输入参数*/
				var transerial    = "000000000000";  	                    //交易唯一号 ，将会取消
				var trantype      = "00";         //交易类型
				var bMoney        = document.all.Prepay_Fee.value; 				//缴费金额
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
				var tranoper      = "<%=loginNo%>";                       //交易操作员
				var orgid         = "<%=groupId%>";                       //营业员归属机构
				var trannum       = "<%=iPhoneNo%>";                      //电话号码
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
				var bMoney        = document.all.Prepay_Fee.value;         /*交易金额 */
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
				var phoneNo       = "<%=iPhoneNo%>";                       /*交易缴费号 */       
				var toBeUpdate    = "";						                        /*预留字段 */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
		
		//////<!-- ningtn add for pos end @ 20100430 -->
}
	/* ningtn add for pos start @ 20100430 */
	function posSubmitForm(){
		frm.submit();
		return true;
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
	/* ningtn add for pos start @ 20100430 */
 function chkType()
 {			
 			//yuanqs add 2010/10/28 15:16:46 分层需求 begin
 			var regionCode = "<%=regionCode%>";
 			var sqlStr22="";
			// 大兴安岭申请签约赠礼   哈尔滨高端预存赠礼   鹤岗新客户成长礼
			if((document.all.OLD_PROJECT_TYPE.value == "0011" && "<%=regionCode%>"=="12") || (document.all.OLD_PROJECT_TYPE.value == "0025" && "<%=regionCode%>"=="01") || (document.all.OLD_PROJECT_TYPE.value == "0026" && "<%=regionCode%>"=="08")){
				sqlStr22 = document.frm.openTime.value;
			}
	
			var myPacket = new AJAXPacket("getDetailNote2289.jsp","正在查询请稍候......");
			myPacket.data.add("sqlStr","");
			myPacket.data.add("sale_project_code",document.frm.projectType.value);
			myPacket.data.add("sqlStr22",sqlStr22);
			myPacket.data.add("retType",'01');
			core.ajax.sendPacket(myPacket);
			//rdShowMessageDialog("3");
			myPacket=null;
			
			//yuanqs add 2010/10/28 15:17:04 分层需求 end
	
		 	document.all.Gift_Code.value ="";
		 	document.all.Gift_Name.value ="";
		 	document.all.Base_Fee.value ="";
		 	document.all.Free_Fee.value ="";
		 	document.all.Mark_Subtract.value ="";
		 	document.all.Consume_Term.value ="";
		 	document.all.Mon_Base_Fee.value ="";
		 	document.all.Prepay_Fee.value ="";
		 	document.all.New_Mode_Name.value ="";
		 	document.all.do_note.value ="";
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

		//rdShowMessageDialog("retType="+retType);
		ret_code =  parseInt(errorCode);
		
		//yuanqs add 2010/10/28 15:43:53 分层需求 begin
		if(retType=="01") {
				var detailCount = packet.data.findValueByName("detailCount");
				var js_detail_msg = packet.data.findValueByName("js_detail_msg");
				showMsg(js_detail_msg, detailCount);
		}
		//yuanqs add 2010/10/28 15:44:04 分层需求 end
		if(retType=="getProjectType")
		{
			//rdShowMessageDialog("getProjectType");
			//rdShowMessageDialog("ret_code="+ret_code);
			if(ret_code!=0){
				rdShowMessageDialog("取信息错误:"+errorMsg+"!");
				return;
			}
			document.all.OLD_PROJECT_TYPE.value=retResult;
			//rdShowMessageDialog("retResult="+retResult);
			//rdShowMessageDialog("document.all.OLD_PROJECT_TYPE.value="+document.all.OLD_PROJECT_TYPE.value);
		 }

 }

//yuanqs add 2010/10/29 10:35:38 分层需求
function showMsg(js_detail_msg, detailCount) {
		var msgStr = "";
		if(1==detailCount) {				
				msgStr = "备注：" + js_detail_msg[0][1];
		} else {
				var msgStr = "方案名称<br>";
				for(var p=0; p<js_detail_msg.length; p++) {
						msgStr = msgStr + (p+1) + "：" + js_detail_msg[p][0] + "<br>";
				}
		}
		$("#msgDiv").children("span").html(msgStr);
		
			var msgNode = $("#msgDiv").css("border","1px solid #999").width("260px")
                            .css("position","absolute").css("z-index","99")
                            .css("background-color","#dff6b3").css("padding","8");
    	var pt = $("#projectType");
    	msgNode.css("left",pt.offset().left + 300 + "px").css("top",pt.offset().top + 0 + "px");
    	msgNode.show();
}
function hideMessage() {
		$("#msgDiv").hide();
}
//yuanqs add 2010/10/29 15:27:18 分层需求 end

 function getInfo_code()
{
//	rdShowMessageDialog("1");
	var myPacket = new AJAXPacket("queryProjectType.jsp","取project_type信息，请稍候......");
	myPacket.data.add("retType","getProjectType");
	myPacket.data.add("sale_project_code",(document.frm.projectType.value).trim());
//	rdShowMessageDialog("2");
	core.ajax.sendPacket(myPacket);
//	rdShowMessageDialog("3");
	myPacket=null;


// add by dujl*************************************************
	// wanglei modify sql and 简化代码
	var regionCode = "<%=regionCode%>";
	var pageTitle = "营销方案选择";
	var fieldName = "方案代码|方案名称|底线预存|活动预存|扣减积分|消费期限|月底线|总预存|备注|系统使用|";//弹出窗口显示的列、列名
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "10|0|1|2|3|4|5|6|7|8|9|";//返回字段
	var retToField = "Gift_Code|Gift_Name|Base_Fee|Free_Fee|Mark_Subtract|Consume_Term|Mon_Base_Fee|Prepay_Fee|New_Mode_Name|OLD_PROJECT_TYPE|";//返回赋值的域
	
	var sale_project_codess = document.frm.projectType.value;
	//rdShowMessageDialog(document.all.OLD_PROJECT_TYPE.value);
	var sqlStr11="";
	var sqlStr22="";
	

	// 大兴安岭申请签约赠礼   哈尔滨高端预存赠礼   鹤岗新客户成长礼
	if((document.all.OLD_PROJECT_TYPE.value == "0011" && "<%=regionCode%>"=="12") || (document.all.OLD_PROJECT_TYPE.value == "0025" && "<%=regionCode%>"=="01") || (document.all.OLD_PROJECT_TYPE.value == "0026" && "<%=regionCode%>"=="08")){
		sqlStr11 =document.frm.openTime.value;
	}
	//begin huangrong add 根据用户入网时间和选择的方案类型选择性的展示具体的方案代码 2011-4-26 16:56	 

	if(document.frm.projectType.value=="241738" || document.frm.projectType.value=="241743")
	{
		if("<%=opTimeTotal%>"<=12)
		{
			rdShowMessageDialog("该用户入网时间不足一年,不能办理！"+document.frm.projectType[document.frm.projectType.selectedIndex].text);
			return false;
		}else
		{				
			sqlStr22="<%=opTimeTotal%>";	
		}
	}	
	//end huangrong add 根据用户入网时间和选择的方案类型选择性的展示具体的方案代码 2011-4-26 16:56	
	if(MySimpSel(pageTitle,fieldName,"",selType,retQuence,retToField,80,sqlStr11,sqlStr22,sale_project_codess));
	//document.all.do_note.value = "统一预存赠礼，方案代码："+document.all.Gift_Code.value;
	// rdShowMessageDialog(document.all.OLD_PROJECT_TYPE.value);
}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth,sqlStr11,sqlStr22,sale_project_codess)
{
    var path = "fPubSimpSel2289.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+ "&sqlStr11=" + sqlStr11+ "&sqlStr22=" + sqlStr22+ "&sale_project_codess=" + sale_project_codess;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
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
	return true;
}

 //begin huangrong for  关于哈尔滨分公司申请开发营业款自动稽核系统的请示 
function do_chnPayLimit(packet)
{	
	 	var errorCode = packet.data.findValueByName("retCode");
		var errorMsg =  packet.data.findValueByName("retMsg");
		if(errorCode!="000000"){
			rdShowMessageDialog("调用服务bs_ChnPayLimit失败！<br>错误代码："+errorCode+"，错误信息："+errorMsg);
			return false;
		}
		var pay_flag =  packet.data.findValueByName("pay_flag");
		var outPledge = packet.data.findValueByName("outPledge");
		var total_pay= packet.data.findValueByName("total_pay");
		document.all.payFlag.value=pay_flag;
		
		if(pay_flag=="1")
		{
			rdShowMessageDialog("本网点代办押金额度为："+outPledge+"<br>当前日累积营业额为："+total_pay+"<br>本次缴纳费用为："+document.all.Prepay_Fee.value+"<br>请及时进行资金上缴，否则将无法正常办理缴费！");
		}
} 
 //end huangrong for 关于哈尔滨分公司申请开发营业款自动稽核系统的请示 

function printCommit()
{
	getAfterPrompt();
 	if(!checkElement(document.all.phoneNo)) return;
	if(document.all.Gift_Code.value==""){
		rdShowMessageDialog("请输入营销代码!");
		document.all.Gift_Code.focus();
		return false;
	}
	if (document.all.i9.value == "Y")
	{
		rdShowMessageDialog("托收用户不允许办理此业务！");
		return false;
	}
	if (document.all.oSmCode.value == "dn" && document.all.OLD_PROJECT_TYPE.value == "0002")
	{
		rdShowMessageDialog("动感地带用户不允许办理此业务！");
		return false;
	}
	if (document.all.oSmCode.value != "dn" && document.all.OLD_PROJECT_TYPE.value == "0002" && parseInt(document.all.Mark_Subtract.value,10)>parseInt(document.all.oMarkPoint.value,10))
	{
		rdShowMessageDialog("用户积分小于扣减积分，不允许办理此业务！");
		return false;
	}
	if (document.all.oSmCode.value == "zn" && document.all.OLD_PROJECT_TYPE.value == "0008" && parseInt(document.all.Mark_Subtract.value,10)<0)
	{
		rdShowMessageDialog("神州行用户不允许办理此业务,请办理预存赠礼业务！");
		return false;
	}
	if (document.all.OLD_PROJECT_TYPE.value == "0008" && parseInt(document.all.Mark_Subtract.value,10)<0 && "<%=point_note%>" !="no" )
	{
		rdShowMessageDialog("<%=point_note%>");
	}
	if (document.all.oSmCode.value != "dn" && document.all.OLD_PROJECT_TYPE.value == "0019" )
	{
		rdShowMessageDialog("只有动感地带用户可以办理此业务！");
		return false;
	}
//20091119 begin
	if (document.all.OLD_PROJECT_TYPE.value == "0029")
	{
		if (<%=TimeStr[0][0]%> != "1")
		{
			rdShowMessageDialog("只有当天新开户入网用户可以办理此业务！");
			return false;
		}
		else
		{
			if (<%=GoodStr[0][0]%> != "1")
			{
				rdShowMessageDialog("用户号码不满足该业务");
				return false;
			}
		}
	}
	
	//begin huangrong for 关于哈尔滨分公司申请开发营业款自动稽核系统的请示 
		var sum_money=document.all.Prepay_Fee.value;
		var packet_chnPayLimit = new AJAXPacket("ajax_chnPayLimit.jsp");
    packet_chnPayLimit.data.add("sum_money", sum_money);
    core.ajax.sendPacket(packet_chnPayLimit,do_chnPayLimit);
    packet_chnPayLimit = null;
    var payFlag=document.all.payFlag.value;
    if(payFlag!="0" && payFlag!="1")
    {
    	rdShowMessageDialog("获取代办押金标识失败!");
    	return false;
    }
	//end huangrong for 关于哈尔滨分公司申请开发营业款自动稽核系统的请示 
	document.all.commit.disabled = true;//为防止二次确认

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

  	var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             	//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode="2289" ;                   			 	//操作代码
	var phoneNo="<%=iPhoneNo%>";                  //客户电话

		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo(printType)
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容

	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phoneNo.value+"|";
	cust_info+="客户姓名："+document.all.oCustName.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";
	cust_info+="证件号码："+document.all.i7.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="用户品牌："+document.all.oSmName.value+"    业务类型：统一预存赠礼"+"|";
  	opr_info+="业务流水："+document.all.login_accept.value+"|";
  	if(document.all.OLD_PROJECT_TYPE.value=="0008")
  	{
		opr_info+="方案名称："+document.all.Gift_Name.value+"|";
		opr_info+="预存金额："+document.all.Prepay_Fee.value+"元"+"  其中底线预存："+document.all.Base_Fee.value+"元，活动预存："+document.all.Free_Fee.value+"元"+"|";
	}

	else
	{
		retInfo+=" "+"|";
		retInfo+=" "+"|";
	}
	//begin huangrong add for 如果参与预约统一预存则在免填单中体现
	if("<%=flag%>"=="1")
	{
		note_info1+="您预约申请"+document.all.Gift_Name.value+"营销案，将于<%=start_time%>生效。"+"|";
	}
	//end huangrong add for 如果参与预约统一预存则在免填单中体现
	var gift_code = Number(document.all.Gift_Code.value);
	if("<%=regionCode%>"=="11" && document.all.OLD_PROJECT_TYPE.value=="0001" )
	{
		note_info1+="欢迎您参加预存分月赠礼活动，您的预存话费将分"+document.all.Consume_Term.value+"个月返回完毕，本次缴纳的预存款在消费完毕前不退不转。"+"|";
	}
	else if("<%=regionCode%>"=="13" && document.all.OLD_PROJECT_TYPE.value=="0004" )
	{
		 note_info2+="此活动预存期限"+document.all.Consume_Term.value+"个月，期间不能参加其他活动，预存款不退不转，不能转签资费。"+"|";
	}
	else if("<%=regionCode%>"=="13" && document.all.OLD_PROJECT_TYPE.value=="0005" && document.all.Gift_Code.value =="0001" )
	{
		note_info3+="此活动预存期限8个月，每月返还10元，期间不能参加其他活动，预存款在活动期间内消费完，不退不转。"+"|";
	}
	else if("<%=regionCode%>"=="13" && document.all.OLD_PROJECT_TYPE.value=="0006" && gift_code>=1 && gift_code <=8 )
	{
		note_info3+="此活动预存期限12个月，每月返还10元，期间不能参加其他活动，预存款在活动期间内消费完，不退不转。"+"|";
	}
	else if(document.all.OLD_PROJECT_TYPE.value=="0008" && parseInt(document.all.Mark_Subtract.value,10)>=0 )
	{
		note_info4+="欢迎您参加“预存赠礼”活动，您本次预存话费"+document.all.Prepay_Fee.value+"元，必须在业务生效当天起"+document.all.Consume_Term.value+"个月内消费完毕，"+
		"到期未消费完的剩余话费将一次性扣除。本次预存话费中("+document.all.Free_Fee.value+")元为活动预存话费，可以在约定期限内自由使用。"+
		"本次预存话费中（"+document.all.Base_Fee.value+"）元为底线预存话费，每月返还("+document.all.Mon_Base_Fee.value+")元且需当月消费完毕,如当月消费不足底线("+document.all.Mon_Base_Fee.value+")元，"+
		"剩余部分不可累积至次月使用，并在到期后一次性扣除。底线预存从业务生效当天起累计返还"+document.all.Consume_Term.value+"个月。"+
		"本业务到期前若申请取消，按违约规定赠送您的礼品需按礼品原价补交现金，并按剩余预存款的30%收取违约金。"+
		"本次活动未涉及的资费，按现行的移动电话资费标准执行。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+"|";
	}
	else if(document.all.OLD_PROJECT_TYPE.value=="0008" && parseInt(document.all.Mark_Subtract.value,10)<0 )
	{
		note_info4+="欢迎您参加“预存赠积分”活动，您本次预存话费"+document.all.Prepay_Fee.value+"元，必须在业务生效当天起"+document.all.Consume_Term.value+"个月内消费完毕，到期未消费完的剩余话费将一次性扣除。"+
		"本次预存话费中("+document.all.Free_Fee.value+")元为活动预存话费，可以在约定期限内自由使用。"+
		"本次预存话费中（"+document.all.Base_Fee.value+"）元为底线预存话费，每月返还("+document.all.Mon_Base_Fee.value+")元"+
		"且需当月消费完毕,如当月消费不足底线("+document.all.Mon_Base_Fee.value+")元，剩余部分不可累积至次月使用，并在到期后一次性扣除。"+
		"底线预存从业务生效当天起累计返还"+document.all.Consume_Term.value+"个月。本业务到期前若申请取消，按违约规定赠送您的积分需按每100分积分5元现金补交，并按剩余预存款的30%交纳违约金。";
		if("<%=point_note%>" !="no")
		{
			retInfo+="<%=point_note%>"+"，请在此之前兑换积分。";
		}
		note_info4+="本次活动未涉及的资费，按现行的移动电话资费标准执行。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+"|";
	}
	else if (document.all.OLD_PROJECT_TYPE.value == "0019" && document.all.Gift_Code.value == "0001")
	{
		note_info4+="欢迎您参加“动感地带预存有礼”活动，您本次预存话费中300元为底线预存话费，立即生效，"+
				"返还50元/月（可充缴彩铃、包年费等专款外相关费用）共返还6个月，"+
				"如当月消费不足底线50元，剩余部分不可累积至次月使用，"+
				"到期未消费完的剩余话费将一次性扣除。如消费大于50元/月时，需客户自行补足当月预存。不可参与其他同类预存赠礼活动。"+"|";

	}
	// add by dujl at 20090804 start***************************/
	else if (document.all.OLD_PROJECT_TYPE.value == "0020" && document.all.Gift_Code.value == "0002")
	{
		note_info4+="欢迎您参加“动感地带2009高校迎新预存赠礼”活动，您本次预存话费中500元为底线预存话费，立即生效，"+
				"返还50元/月,共返还10个月，"+
				"如当月消费不足底线50元（可充缴彩铃、包年费等专款外相关费用），剩余部分不可累积至次月使用，"+
				"到期未消费完的剩余话费将一次性扣除。如消费大于50元/月时，需客户自行补足当月预存。不可参与其他同类预存赠礼活动。"+"|";
	}
	else if (document.all.OLD_PROJECT_TYPE.value == "0020" && document.all.Gift_Code.value == "0001")
	{
		note_info4+="欢迎您参加“动感地带2009高校迎新预存赠礼”活动，您本次预存话费中800元为底线预存话费，立即生效，"+
				"返还50元/月（可充缴彩铃、包年费等专款外相关费用）,共返还16个月，"+
				"如当月消费不足底线50元，剩余部分不可累积至次月使用，"+
				"到期未消费完的剩余话费将一次性扣除。如消费大于50元/月时，需客户自行补足当月预存。不可参与其他同类预存赠礼活动。"+"|";
	}
	// add by dujl at 20090804  end****************************/
	// add by dujl at 20090410******************************
	else if (document.all.OLD_PROJECT_TYPE.value == "0011" )
	{
		note_info4+="尊敬的客户，欢迎您参与签约赠礼活动，您所缴纳的预存款 120元每月返还10元。"+
					"12个月内消费完， 没消费完将一次性扣除。如果在签约期限不满12个月离网， 预存款不予退还。"+
					"如申请解约，将扣除剩余预存款的30%违约金，礼品按照原价格收回现金。"+"|";
	}
	//****** add by fengry at 20090923 start ******/
	else if("<%=regionCode%>" == "07" && document.all.OLD_PROJECT_TYPE.value == "0001")
	{
		note_info4+="欢迎您参加“预存赠礼”活动，您本次预存话费"+document.all.Prepay_Fee.value+"元，必须在业务生效当月起"+document.all.Consume_Term.value+
		"个月内消费完毕，到期未消费完的剩余话费将一次性扣除。本次预存话费中"+document.all.Base_Fee.value+"元为底线预存话费，每月返还"+document.all.Mon_Base_Fee.value+
		"元且需当月消费完毕，如当月消费不足底线"+document.all.Mon_Base_Fee.value+"元，剩余部分不可累计至次月使用，并在到期后一次性扣除。底线预存从业务生效当天起累计返还"+document.all.Consume_Term.value+
		"个月。本业务到期前若申请取消，按违约规定赠送您的礼品需按礼品原价补交现金，并按剩余预存款的30%收取违约金。"+
		"您参与本次活动后，业务未到期前不得再次参与其它预存赠礼活动。"+
		"本次活动未涉及的资费，按现行的移动电话资费标准执行。在协议有效期内若遇国家资费标准调整按国家新的资费政策执行。"+"|";
	}
	else if("<%=regionCode%>" == "01" && document.all.OLD_PROJECT_TYPE.value == "0021")
	{
		note_info4+="温馨提示："+"|";
		note_info4+="欢迎您参加入网预存赠礼活动，您本次预存话费"+document.all.Prepay_Fee.value+"元，必须在业务生效当天起"+document.all.Consume_Term.value+
		"个月内消费完毕，到期未消费完的剩余话费将一次性扣除。本次预存话费中"+document.all.Base_Fee.value+"元为底线预存话费，每月返还"+document.all.Mon_Base_Fee.value+
		"元且需当月消费完毕，如当月消费不足底线"+document.all.Mon_Base_Fee.value+"元，剩余部分不可累积至次月使用，并在到期后一次性扣除。底线预存从业务生效当天起累计返还"+document.all.Consume_Term.value+
		"个月。本业务到期前若申请取消，按违约规定赠送您的礼品需按礼品原价补交现金，并按剩余预存款的30%收取违约金。"+
		"本次活动未涉及的资费，按现行的移动电话资费标准执行。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+
		"本活动预存款不退不转，预存话费需在规定时间内消费完毕，业务未到期不可以参加其他有约束的优惠活动，不能重复参加本活动。"+"|";
	}
	else if("<%=regionCode%>" == "01" && document.all.OLD_PROJECT_TYPE.value == "0022")
	{
		note_info4+="温馨提示："+"|";
		note_info4+="欢迎您参加预存赠礼活动，您本次预存话费"+document.all.Prepay_Fee.value+"元，必须在业务生效当天起"+document.all.Consume_Term.value+
		"个月内消费完毕，到期未消费完的剩余话费将一次性扣除。本次预存话费中"+document.all.Base_Fee.value+"元为底线预存话费，每月返还"+document.all.Mon_Base_Fee.value+
		"元且需当月消费完毕，如当月消费不足底线"+document.all.Mon_Base_Fee.value+"元，剩余部分不可累积至次月使用，并在到期后一次性扣除。底线预存从业务生效当天起累计返还"+document.all.Consume_Term.value+
		"个月。本业务到期前若申请取消，按违约规定赠送您的礼品需按礼品原价补交现金，并按剩余预存款的30%收取违约金。"+
		"本次活动未涉及的资费，按现行的移动电话资费标准执行。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+
		"本活动预存款不退不转，预存话费需在规定时间内消费完毕，业务未到期不可以参加其他有约束的优惠活动，不能重复参加本活动。"+"|";
	}
	else if("<%=regionCode%>" == "01" && document.all.OLD_PROJECT_TYPE.value == "0025")
	{
		note_info4+="温馨提示："+"|";
		note_info4+="欢迎您参加预存赠礼活动，您本次预存话费"+document.all.Prepay_Fee.value+"元，必须在业务生效当天起"+document.all.Consume_Term.value+
		"个月内消费完毕，到期未消费完的剩余话费将一次性扣除。本次预存话费中"+document.all.Free_Fee.value+"元为活动预存话费，可以在约定期限内自由使用。本次预存话费中"+
		+document.all.Base_Fee.value+"元为底线预存话费，每月返还"+document.all.Mon_Base_Fee.value+
		"元且需当月消费完毕，如当月消费不足底线"+document.all.Mon_Base_Fee.value+"元，剩余部分不可累积至次月使用，并在到期后一次性扣除。底线预存从业务生效当天起累计返还"+document.all.Consume_Term.value+
		"个月。本业务到期前若申请取消，按违约规定赠送您的礼品需按礼品原价补交现金，并按剩余预存款的30%收取违约金。"+
		"本次活动未涉及的资费，按现行的移动电话资费标准执行。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+
		"本活动预存款不退不转，预存话费需在规定时间内消费完毕，业务未到期不可以参加其他有约束的优惠活动，不能重复参加本活动。"+"|";
	}
	//****** add by fengry at 20090923 end ******/
	//****** add by fengry at 20091013 start ******/
	else if(document.all.OLD_PROJECT_TYPE.value == "0027")
	{
		note_info4+="欢迎您参加“预存赠礼”活动，您本次预存话费"+document.all.Prepay_Fee.value+"元，必须在业务生效当天起"+document.all.Consume_Term.value+
		"个月内消费完毕，到期未消费完的剩余话费将一次性扣除。本次预存话费中"+
		+document.all.Base_Fee.value+"元为底线预存话费，每月返还"+document.all.Mon_Base_Fee.value+
		"元且需当月消费完毕，如当月消费不足底线"+document.all.Mon_Base_Fee.value+"元，剩余部分不可累计至次月使用，并在到期后一次性扣除。底线预存从业务办理当天起累计返还"+document.all.Consume_Term.value+
		"个月。本业务到期前若申请取消，剩余预存款一次性扣除不再返还，此业务到期前不允许过户，如过户需取消此业务。"+
		"您参与本次活动后，业务未到期前不得再次参与其它预存赠礼活动。"+
		"本次活动未涉及的资费，按现行的移动电话资费标准执行。在协议有效期内若遇国家资费标准调整按国家新的资费政策执行。"+"|";
	}
	//****** add by fengry at 20091013 end ******/
	/******* add by ningtn @ 20100422  start ****/
	else if(document.all.OLD_PROJECT_TYPE.value == "aaaa"){
		note_info4 += document.all.New_Mode_Name.value + "|";
	}
	/******* add by ningtn @ 20100422  end   ****/
	else
	{
		note_info1+="备注：参与活动预存专款过期无效，不退不转"+"|";
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

</head>
<body>
<form name="frm" method="post" action="f2289Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
		<input type="hidden" name="openTime" value="<%=open_time%>">

	<div class="title">
		<div id="title_zi">自2010年4月10日开始办理的业务,如用户需要领奖,请到6842新版促销品统一付奖界面为用户领奖。
			(如无6842的权限，请与工号管理员联系添加。)</div>
	</div>
	<div class="title">
		<div id="title_zi">2010年4月10日前办理的业务,如用户需要领奖,请到2266促销品统一付奖界面为用户领奖。</div>
	</div>

	<div class="title">
		<div id="title_zi">业务明细</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">方案类型</td>
		<td colspan="3">
			<select id=projectType name=projectType onblur="hideMessage();" onChange="chkType()" style="width:300px;" >
		    <%
		    //yuanqs add onblur="hideMessage();" 2010/11/3 9:48:45 
		    	String[] inParas1 = new String[2];
		    	inParas1[0] =
				"select trim(a.project_code),trim(a.project_name) " +
				"  from ssaleproject a, ssaleop b " +
				" where a.project_code = b.project_code " +
				"   and a.region_code in( :region_code, '**') " +
				"   and b.op_code = :op_code " +
				"   and a.project_status = 'Y' " +
				"   and a.start_date <=sysdate and a.end_date >=sysdate " +
				"   and exists (select 1 from sSaleGrade c ,sSaleGradePackage d " +
				"   where c.project_code = a.project_code  and c.grade_status='Y'  and d.status ='Y' " +
				"   and c.project_code = d.project_code and c.grade_code = d.grade_code and d.region_code='"+regionCode+"') order by a.op_time desc ";
				// yuanqs add order by 2010/11/3 9:49:10 
				inParas1[1] = "region_code="+regionCode+",op_code="+opCode;
				//System.out.println("op_code=2289:方案类型 = "+ inParas1[0] );
				//System.out.println("regionCode="+ regionCode+",op_code="+opCode);
%>
			<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
				<wtc:param value="<%=inParas1[0]%>"/>
				<wtc:param value="<%=inParas1[1]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end"/>
<%

				recordNum = result.length;
				System.out.println("recordNum======="+recordNum);
				for(i=0;i<recordNum;i++)
				{
					out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][0]+"-->"+result[i][1] + "</option>");
				}
		   %>
		   </select>
		</td>
	</tr>
	<tr>
		<td class="blue">手机号码</td>
		<td width="39%">
			<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
		</td>
		<td class="blue">机主姓名</td>
		<td>
			<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">业务品牌</td>
		<td>
			<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
		</td>
		<td class="blue">资费名称</td>
		<td>
			<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" size ="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">帐号预存</td>
		<td>
			<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
		</td>
		<td class="blue">当前积分</td>
		<td>
			<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">方案代码</td>
		<td>
			<input class="InputGrey" type="text" name="Gift_Code" id="Gift_Code" readonly>
			<input class="b_text" type="button" name="qryId_No" value="查询" onClick="getInfo_code()" >
				<font color="orange">*</font>
		</td>
		<td class="blue">方案名称</td>
		<td>
			<input name="Gift_Name" type="text" class="InputGrey" id="Gift_Name" v_type="string" v_must=1 value=""  size="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">底线预存</td>
		<td>
			<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
		</td>
		<td class="blue">活动预存</td>
		<td>
			<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">扣减积分</td>
		<td>
			<input name="Mark_Subtract" type="text" class="InputGrey" id="Mark_Subtract"   readonly>
		</td>
		<td class="blue">消费期限</td>
		<td>
			<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">月底线</td>
		<td>
			<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" readonly>
		</td>
		<td class="blue">应收金额</td>
		<td >
			<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee"   readonly>
		</td>
	</tr>
	<!-- ningtn add for pos start @ 20100430 -->
	<TR>
		<TD class="blue">缴费方式</TD>
		<TD colspan="3" id="td1">
			<select name="payTypeSelect" >
				<option value="0">现金缴费</option>
				<option value="BX">建设银行POS机缴费</option>
				<option value="BY">工商银行POS机缴费</option>
			</select>
		</TD>
		<!--begin huangrong add-->
		<td class="blue" id="td2" style='display:none'>是否参与抽奖</td>
		<td id="td3" style='display:none'>
			<input type="radio" name="take_prize" value="0">否&nbsp;&nbsp;
			<input type="radio" name="take_prize" value="1">是
		</td>
		<!--end huangrong add-->
	</TR>
	<!-- ningtn add for pos end @ 20100430 -->
	<tr>
		<!-- dujl 修改class="button" 20090428 -->
		<td class="blue">备    注</td>
		<td colspan="3" >
			<input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="60" >

		</td>
	</tr>
</table>
<!-- ningtn 2011-7-12 08:33:59 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="确认&打印" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp;
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
			&nbsp;
		</td>
	</tr>
</table>

<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="2289">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16" value="<%=rate_code%>">
			<input type="hidden" name="ip" value="">
      <input type="hidden" name="flag" value="<%=flag%>"><!--huangrong add -->
      <input type="hidden" name="payFlag" value=" "><!--huangrong add for 关于哈尔滨分公司申请开发营业款自动稽核系统的请示 -->
			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="<%=bp_name%>">
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">
			<input type="hidden" name="i9" value="<%=contract_flag%>">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value=" ">
			<input type="hidden" name="return_page" value="/npage/s1141/f2289_login.jsp">
			<input type="hidden" name="login_accept" value="<%=printAccept%>">
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">

			<input type="hidden" name="OLD_PROJECT_TYPE" >
			<!-- ningtn add for pos start @ 20100430 -->		
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
			<!-- ningtn add for pos end @ 20100430 -->
</div>
<!-- yuanqs add 2010/10/29 10:37:01 分层需求 begin -->
	<div id="msgDiv">
	    <span></span>
	</div>
<!-- yuanqs add 2010/10/29 10:37:01 分层需求 end -->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100430 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100430 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
<!-- ningtn 2011-7-12 08:35:36 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
