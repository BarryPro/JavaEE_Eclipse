<% /******************** version v2.0 开发商: si-tech * *update:zhanghonga@2008
          -08-19 页面改造,修改样式 * ********************/ %> <%@page
              contentType="text/html;charset=GBK"%> <%@ include
 file="/npage/include/public_title_name.jsp" %> <%@ page import="java.text.*"%>
 <%@ page import="java.math.BigDecimal"%>
             <%@ page import="com.sitech.boss.pub.util.*" %> <%/* *
  注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
    部分变量的命名依据对此变量使用的意义，或用途。 */ %> <% String opCode2 =
(String)request.getParameter("opCode"); if (opCode2 == null){ opCode2 = "1270";
    } %> <%! /**这个方法是用来格式化后面的小写金额的**/ public static String
          formatNumber(String num, int zeroNum) { DecimalFormat form =
   (DecimalFormat)NumberFormat.getInstance(Locale.getDefault()); StringBuffer
patBuf = new StringBuffer("0"); if(zeroNum > 0) { patBuf.append("."); for(int i
                 = 0; i < zeroNum; i++) { patBuf.append("0"); }

        }
        form.applyPattern(patBuf.toString());
        return form.format(Double.parseDouble(num)).toString();
    }
%>

<!-- **** tianyang add for pos ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** tianyang add for pos ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

<%
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String work_name = (String)session.getAttribute("workName");
	String serviceName="";
	String brand_code="";
	String type_code="";
	String prepay_fee="";
	String prepay_money="";
	String sp_money="";
	String chinaFee="";
	String xx_money="";
	String gift_name="";
	String gift_code="";
	String IMEINo="";
	String main_fee="";
	String second_fee="";
	String second_phone="";
	String free_fee="";
	String base_fee="";
%>
<HTML>
<head>
</HEAD>
<BODY>
<FORM action="" method=post name="form1">
</FORM>
<BODY>
</HTML>
<%      
/*--------------------------------组织s1270Cfm的传入参数-------------------------------*/
String thework_no = (String)session.getAttribute("workNo");                                   //操作工号                    0  操作工号 iLoginNo                          
String psw =(String)session.getAttribute("password");                                         //工号密码					1  工号密码 iLoginPwd                           
String theop_code = WtcUtil.repNull(request.getParameter("iOpCode"));                         //操作代码					2  iOpCode                                     
System.out.println("zhangyan~~~~~~~~theop_code~~~~~~"+theop_code);
String iadd_str =WtcUtil.repNull(request.getParameter("iAddStr"));                 						//个性化信息
String link_count="0";
String themob = WtcUtil.repNull(request.getParameter("i1"));                        					//手机号码					3  移动号码 iPhoneNo                           
String maincash = WtcUtil.repNull(request.getParameter("i16"))    ; 					//主套餐代码代码				4  当前主套餐代码 iOldMode                     
if(maincash.indexOf("-")!=-1){
	maincash = maincash.substring(0,maincash.indexOf("-")); 
}
String old_cash = WtcUtil.repNull(request.getParameter("ip"));       					//新主套餐代码				5  新主套餐代码 iNewMode                       
if(old_cash.indexOf(" ")!=-1){
	old_cash = old_cash.substring(0,old_cash.indexOf(" ")); 
}
String maincash_flag = WtcUtil.repNull(request.getParameter("tbselect")).substring(0,1);			//主套餐生效标志			6  主套餐变更的生效方式 iSendFlag    
String addcash_string = WtcUtil.repNull(request.getParameter("kx_habitus_bunch"));         	  //可选套餐的代码串			7  可选套餐的代码串 iAddModeStr               
String do_string=WtcUtil.repNull(request.getParameter("kx_code_bunch"));           					//可选套餐的状态串			8  可选套餐的变更串 iAddChgStr                 

String flag_string=WtcUtil.repNull(request.getParameter("kx_operation_bunch"));      					//可选套餐的生效方式串        9  可选套餐的变更串 iAddSendStr                                       
String favour = WtcUtil.repNull(request.getParameter("favorcode"));                    				//优惠代码					10 优惠代码 iFavourCde        				                 
String realcash = WtcUtil.repNull(request.getParameter("i19"));                     					//实际手续费				 	11 实交手续费 iRealFee                         
String fircash = WtcUtil.repNull(request.getParameter("i20"));                      					//固定手续费				 	12 应交手续费 iShouldFee                       
String sysnote = WtcUtil.repNull(request.getParameter("sysnote"));                  					//系统备注					13 系统日志 iSysNote                           
String donote = WtcUtil.repNull(request.getParameter("tonote"));                    					//操作备注					14 操作日志 iOpNote                            
String stream = WtcUtil.repNull(request.getParameter("stream"));       //系统流水					15 打印流水 iLoginAccept                                                
String ip = WtcUtil.repNull(request.getParameter("ipAddr"));                                           //登陆IP					    16 登录IP  iIpAddr                            										
String add_stream_str=WtcUtil.repNull(request.getParameter("kx_stream_bunch"));      					//原可选套餐的开通流水串   		17 可选套餐的开通流水  iOldAcceptStr          
String main_cash_stream = WtcUtil.repNull(request.getParameter("main_cash_stream"));					//当前主套餐开通流水			18 当前主套餐开通流水  iCurModeAccept         
String next_main_cash = WtcUtil.repNull(request.getParameter("next_main_cash"));    					//下月主套餐        			19 下月主套餐          iNextMode              

System.out.println(" zhangyan~~~next_main_cash="+next_main_cash+"|");
if(next_main_cash.indexOf("-")!=-1){
	next_main_cash = next_main_cash.substring(0,next_main_cash.indexOf("-")); 
}
String next_main_stream = WtcUtil.repNull(request.getParameter("next_main_stream"));					//下月主套餐开通流水			20 下月主套餐开通流水  iNextModeAccept        
String iAddRateStr = WtcUtil.repNull(request.getParameter("iAddRateStr"));										//iAddRateStr说明:  'A001^8032:'  A001是二次批价代码，8032是关联信息如小区代码等
String beforeOpCode = WtcUtil.repNull(request.getParameter("beforeOpCode"));									//冲正时传送对应申请业务的opCode 
String returnPage = WtcUtil.repNull(request.getParameter("returnPage"));											//冲正时传送对应申请业务的opCode 
System.out.println("---------1270_4.jsp------returnPage="+returnPage);
String award_flag=""; //sunzx add at 20070906

String strHasEval = WtcUtil.repNull(request.getParameter("haseval"));													//是否有用户满意度评价 
String strEvalCode = WtcUtil.repNull(request.getParameter("evalcode"));												//用户满意度评价代码 

System.out.println(" zhangyan~~~strHasEval="+strHasEval);
System.out.println(" zhangyan~~~strEvalCode="+strEvalCode);
//增加参数区分网站预约和前台办理 ningtn
String banlitype = WtcUtil.repNull(request.getParameter("banlitype"));
float  handcash = Float.parseFloat(realcash);                     														//手续费单精度

/*********liujian add 阶段活动名称 begin**********************/
//阶段活动名称
String e505_sale_name = WtcUtil.repNull(request.getParameter("e505_sale_name"));
String sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
System.out.println(" zhangyan~~~--------------------liujian-----------------" + e505_sale_name);
System.out.println(" zhangyan~~~--------------------liujian-----------------sale_name=" + sale_name);
//月底线预存
String mon_prepay_limit = WtcUtil.repNull(request.getParameter("mon_prepay_limit"));
/*********liujian add 阶段活动名称 end**********************/

/********tianyang add at 20090928 for POS缴费需求****start*****/
String payType				 = request.getParameter("payType");/**缴费类型 payType=BX 是建行 payType=BY 是工行**/
String MerchantNameChs = request.getParameter("MerchantNameChs");/**从此开始以下为银行参数**/
String MerchantId      = request.getParameter("MerchantId");
String TerminalId      = request.getParameter("TerminalId");
String IssCode         = request.getParameter("IssCode");
String AcqCode         = request.getParameter("AcqCode");
String CardNo          = request.getParameter("CardNo");
String BatchNo         = request.getParameter("BatchNo");
String Response_time   = request.getParameter("Response_time");
String Rrn             = request.getParameter("Rrn");
String AuthNo          = request.getParameter("AuthNo");
String TraceNo         = request.getParameter("TraceNo");
String Request_time    = request.getParameter("Request_time");
String CardNoPingBi    = request.getParameter("CardNoPingBi");
String ExpDate         = request.getParameter("ExpDate");
String Remak           = request.getParameter("Remak");
String TC              = request.getParameter("TC");
String transTotal			 = request.getParameter("transTotal");
/********tianyang add at 20090928 for POS缴费需求****end*******/
System.out.println(" zhangyan~~~payType : " + payType + "MerchantNameChs : " + MerchantNameChs + "Response_time : " + Response_time + " Request_time : " + Request_time);
String flag_code = WtcUtil.repNull(request.getParameter("flag_code"));
String rateCode = WtcUtil.repNull(request.getParameter("rateCode")); 
    
//String rateFlag = rateCode +"$"+flag_code+"$"+"&"; 
String rateFlag = flag_code;	
String sq1="select count(*) from sPrepayPhoneCfg where region_code='"+regionCode+"' "+
			" and op_code='"+theop_code+"' and to_char(sysdate,'yyyymmdd') between trim(sale_code) and mode_limit";
%>
		<wtc:pubselect name="sPubSelect"  routerKey="phone" routerValue="<%=themob%>" outnum="1">
		<wtc:sql><%=sq1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />	
<%
		if(result!=null&&result.length>0){
			link_count = result[0][0]; 
		}
%>
<%
	System.out.println(" zhangyan~~~wwwwwwwww === "+ rateFlag);

/*--------------------------------开始调用s1270Cfm--------------------------------*/
		String paraAray[] = new String[43];	
		paraAray[0] = stream; //15 打印流水                iLoginAccept    stream
		paraAray[1] = ""; //渠道标识
		paraAray[2] = theop_code; //2                          iOpCode   theop_code
		paraAray[3] = thework_no; //0  操作工号                iLoginNo  thework_no
		paraAray[4] = psw; //1  工号密码                iLoginPwd psw
		paraAray[5] = themob; //3  移动号码                iPhoneNo  themob
		paraAray[6] = "";    //移动号码 密码
		paraAray[7] = maincash; //4  当前主产品代码          iOldMode  maincash 
		paraAray[8] = old_cash; //5  新主产品代码            iNewMode  old_cash  
		paraAray[9] = maincash_flag; //6  主产品变更的生效方式    iSendFlag  maincash_flag
		paraAray[10] = do_string; //7  可选产品的代码串        iAddModeStr do_string
		paraAray[11] = addcash_string; //8  可选产品的状态串        iAddStatusStr addcash_string
		paraAray[12] = flag_string; //9  可选产品的生效方式串    iAddSendStr   flag_string
		paraAray[13] = favour; //10 优惠代码                iFavourCode    favour
		paraAray[14] = realcash; //11 实交手续费              iRealFee       realcash
		paraAray[15] = fircash; //12 应交手续费              iShouldFee     fircash
		paraAray[16] = iadd_str ; //13 系统日志                iSysNote       iadd_str
		if(donote.length()>60){
	  		paraAray[17] = donote.substring(0,60); //14 操作日志                iOpNote        donote
		}else{
			paraAray[17] = donote; //14 操作日志                iOpNote        donote
		}
		paraAray[18] = ip; //16 登录IP                  iIpAddr          ip
		paraAray[19] = add_stream_str; //17 可选产品的开通流水      iOldAcceptStr    add_stream_str
		paraAray[20] = main_cash_stream; //18 当前主产品开通流水      iCurModeAccept    main_cash_stream
		paraAray[21] = next_main_cash; //19 下月主产品              iNextMode         next_main_cash
		paraAray[22] = next_main_stream; //20 下月主产品开通流水      iNextModeAccept   next_main_stream
		paraAray[23] = rateFlag; //21 主产品二次批价关联信息串 iAddRateStr       iAddRateStr
		paraAray[24] = beforeOpCode; //22   冲正时传送对应申请业务的opCode 
		
		/********tianyang add at 20090928 for POS缴费需求****start*****/
		paraAray[25] = payType				 ;
		paraAray[26] = MerchantNameChs ;
		paraAray[27] = MerchantId      ;
		paraAray[28] = TerminalId      ;
		paraAray[29] = IssCode         ;
		paraAray[30] = AcqCode         ;
		paraAray[31] = CardNo          ;
		paraAray[32] = BatchNo         ;
		paraAray[33] = Response_time   ;
		paraAray[34] = Rrn             ;
		paraAray[35] = AuthNo          ;
		paraAray[36] = TraceNo         ;
		paraAray[37] = Request_time    ;
		paraAray[38] = CardNoPingBi    ;
		paraAray[39] = ExpDate         ;
		paraAray[40] = Remak           ;
		paraAray[41] = TC              ;
		/********tianyang add at 20090928 for POS缴费需求****end*******/
		/*ningtn 网站承载合约计划*/
		paraAray[42] = banlitype;
		/****liujian add begin****/
		String monitorValue = request.getParameter("monitorValue");
		
		for(int i=0; i<26; i++){
			System.out.println(" zhangyan~~~-----jsp paraAray["+i+"]="+paraAray[i]);
		}
		/****liujian add end****/
		for(int i=25; i<42; i++){
			System.out.println(" zhangyan~~~jsp paraAray["+i+"]="+paraAray[i]);
		}
		
		
		if(theop_code.equals("e721")||theop_code.equals("4265")||theop_code.equals("127b")||theop_code.equals("127a")||theop_code.equals("1206")||theop_code.equals("1198")||theop_code.equals("126c")||theop_code.equals("126i")||theop_code.equals("8035")||theop_code.equals("125c")||theop_code.equals("2282")||theop_code.equals("2265")||theop_code.equals("2284")||theop_code.equals("7118")||theop_code.equals("8071")||theop_code.equals("8043")||theop_code.equals("8045")||theop_code.equals("8028")||theop_code.equals("8024")||theop_code.equals("8091")||theop_code.equals("7964")||theop_code.equals("7966")||theop_code.equals("7374")||theop_code.equals("7382")||theop_code.equals("7976")||theop_code.equals("7982")||theop_code.equals("7899") ||theop_code.equals("7672") || theop_code.equals("8552")||theop_code.equals("7689")||theop_code.equals("e506")||theop_code.equals("e529")){
		  //冲正
		   serviceName = "s127bCfm";
		}else if(theop_code.equals("g122") || theop_code.equals("g124")){
			/*
				g122 购TD商务固话赠通信费
				g124 购TD商务固话赠通信费(铁通)
			*/
			serviceName = "sg122Cfm";
		}else if(theop_code.equals("g123") || theop_code.equals("g125")){
			/*
				g123 购TD商务固话赠通信费冲正
				g125 购TD商务固话赠通信费(铁通)冲正
			*/
			serviceName = "sg123Cfm";
		}else{
			//申请
		 	serviceName = "s127qCfmEx";
		}
	for(int i=0;i<paraAray.length;i++){
		System.out.println(" zhangyan~~~paraAray["+i+"]="+paraAray[i]);
	}		
		//ret = impl.callService(serviceName,paraAray,"2","phone",themob);
%>
		<wtc:service name="<%=serviceName%>" routerKey="phone" routerValue="<%=themob%>" outnum="3" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
		<wtc:param value="<%=paraAray[14]%>"/>
		<wtc:param value="<%=paraAray[15]%>"/>
		<wtc:param value="<%=paraAray[16]%>"/>
		<wtc:param value="<%=paraAray[17]%>"/>
		<wtc:param value="<%=paraAray[18]%>"/>
		<wtc:param value="<%=paraAray[19]%>"/>
		<wtc:param value="<%=paraAray[20]%>"/>
		<wtc:param value="<%=paraAray[21]%>"/>
		<wtc:param value="<%=paraAray[22]%>"/>
		<wtc:param value="<%=paraAray[23]%>"/>
		<wtc:param value="<%=paraAray[24]%>"/>
		<wtc:param value="<%=paraAray[25]%>"/>
		<wtc:param value="<%=paraAray[26]%>"/>
		<wtc:param value="<%=paraAray[27]%>"/>
		<wtc:param value="<%=paraAray[28]%>"/>
		<wtc:param value="<%=paraAray[29]%>"/>
		<wtc:param value="<%=paraAray[30]%>"/>
		<wtc:param value="<%=paraAray[31]%>"/>
		<wtc:param value="<%=paraAray[32]%>"/>
		<wtc:param value="<%=paraAray[33]%>"/>
		<wtc:param value="<%=paraAray[34]%>"/>
		<wtc:param value="<%=paraAray[35]%>"/>
		<wtc:param value="<%=paraAray[36]%>"/>
		<wtc:param value="<%=paraAray[37]%>"/>
		<wtc:param value="<%=paraAray[38]%>"/>
		<wtc:param value="<%=paraAray[39]%>"/>
		<wtc:param value="<%=paraAray[40]%>"/>
		<wtc:param value="<%=paraAray[41]%>"/>
		<wtc:param value="<%=paraAray[42]%>"/>
		<wtc:param value="<%=monitorValue%>"/>
		</wtc:service>
		<wtc:array id="result4" scope="end"/>	
<%	
		System.out.println("zhouby:   " + monitorValue);
		int ret_code = 999999;
		if(retCode!=""){
			ret_code = Integer.parseInt(retCode);
		}		
		System.out.println(" zhangyan~~~#$#$#$#$#$#$#$#$#$#$#$#$#$#" + serviceName + " | " + ret_code + "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#");
%>

<!-- tianyang add for pos start *** boss交易成功 调用银行确认函数 -->
<%
System.out.println("zhangyan~~~~~~~~~~~~~~ret_code~" +ret_code);
//ret_code=0;
if(ret_code==0){%>

<script language="jscript">
if("<%=payType%>"=="BX"){
	BankCtrl.TranOK();
}
if("<%=payType%>"=="BY"){
	var IfSuccess = KeeperClient.UpdateICBCControlNum();
}
</script>
<%}%>
<!-- tianyang add for pos end *** boss交易成功 调用银行确认函数 -->

<%  
		String ret_msg = retMsg;
		System.out.println(" zhangyan~~~ret_code=====222=============="+ret_code);
		

		System.out.println(" zhangyan~~~%%%%%%%调用统一接触开始%%%%%%%%");	
		String cnttLoginAccept = "";
		String opName2 = (String)request.getParameter("opName");
		
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+retCode+"&opName="+opName2+"&workNo="+thework_no+"&loginAccept="+stream+"&pageActivePhone="+themob+"&opBeginTime="+opBeginTime+"&contactId="+themob+"&contactType=user";
    System.out.println(url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
		System.out.println(" zhangyan~~~%%%%%%%调用统一接触结束%%%%%%%%");

	//王良 2008年1月3日 修改增加用户满意度评价设置
  if(0==ret_code && strHasEval.equals("1")){
		String strParaAray[] = new String[6];
	  strParaAray[0] = thework_no; 	//0  操作工号                iLoginNo  thework_no
	  strParaAray[1] = theop_code; 	//1  操作代码                iOpCode   theop_code
	  strParaAray[2] = themob; 			//2  移动号码                iPhoneNo  themob                         
	  strParaAray[3] = strEvalCode; //3  评价代码
	  strParaAray[4] = stream; 			//5  操作流水
	  strParaAray[5] = "0"; 
	  //ret = impl.callService("sCommEvalCfm",strParaAray,"2","phone",themob);
%>
		<wtc:service name="sCommEvalCfm" routerKey="phone" routerValue="<%=themob%>" outnum="2" >
		<wtc:param value="<%=strParaAray[0]%>"/>
		<wtc:param value="<%=strParaAray[1]%>"/>
		<wtc:param value="<%=strParaAray[2]%>"/>
		<wtc:param value="<%=strParaAray[3]%>"/>
		<wtc:param value="<%=strParaAray[4]%>"/>
		<wtc:param value="<%=strParaAray[5]%>"/>
		</wtc:service>
		<wtc:array id="result4" scope="end"/>	
<%
		int iReturnCode = 999999;
		if(retCode!=""){
			iReturnCode = Integer.parseInt(retCode);
		}
    String strReturnMsg = retMsg;
    
    System.out.println(" zhangyan~~~iReturnCode="+iReturnCode);
    System.out.println(" zhangyan~~~strReturnMsg="+strReturnMsg);
	}

//对返回信息的控制
  if(ret_msg.equals("")){
			ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg((new Integer(ret_code)).toString()));
			if( ret_msg.equals("null")){
				ret_msg ="未知错误信息";
			}
		}

/*------------------------------依据调用服务返回结果进行页面跳转------------------------------*/
/* ningtn 网站承载合约计划*/
if(0==ret_code && "1".equals(banlitype)){
	/*提交服务成功 并且是网站预约办理的，调用sE385Cfm服务*/
	if("e505".equals(theop_code)){
		/*
			走公共的1270页面的opcode
			以后可能还会有新的opcode，往里加就行了
		*/
		String iOpCode		= 		request.getParameter("iOpCode");;
		String iLoginNo		= 		thework_no;
		String iLoginPwd	= 		psw;
		String iPhoneNo		= 		themob;	
		String iUserPwd 	= 		"";
		String inOpNote 	= 		donote;
		String iBookingId = 		"";
		String iLoginAccept=  	stream; 
		String booking_url = "/npage/public/pubCfmBookingInfo.jsp?iOpCode="+iOpCode
				+"&iLoginNo="+iLoginNo
				+"&iLoginPwd="+iLoginPwd
				+"&iPhoneNo="+iPhoneNo
				+"&iUserPwd="+iUserPwd
				+"&inOpNote"+inOpNote
				+"&iLoginAccept="+iLoginAccept
				+"&iBookingId="+iBookingId;		
		System.out.println("booking_url="+booking_url);
		%>
		<jsp:include page="<%=booking_url%>" flush="true" />
		<%
		System.out.println("%%%%%%%调用预约服务结束%%%%%%%%"); 
		System.out.println("7955调用sE385Cfm服务结束");
	}
}
%>
<%
		/*************************************获得打印发票的参数****************************************/
		String cardno = WtcUtil.repNull(request.getParameter("i7"));                        //身份证号码
		String name = WtcUtil.repNull(request.getParameter("i4"));                        //用户名称
		String address = WtcUtil.repNull(request.getParameter("i5"));					  //用户地址
		/***********************************************************************************************/
	System.out.println(" zhangyan~~~mylog  iadd_str ="+iadd_str);
	if(theop_code.equals("8042")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<15; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==4){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){second_fee=iadd_str.substring(bb,aa);}
		if(i==6){type_code=iadd_str.substring(bb,aa);}
		//孙振兴添加     START
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		//孙振兴添加     END
		if(i==11){second_phone = iadd_str.substring(bb,aa);}
		if(i==14){award_flag = iadd_str.substring(bb,aa);}
		bb=aa+1;

	}
	
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8043")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<12; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==9){brand_code=iadd_str.substring(bb,aa);}
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==4){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){second_fee=iadd_str.substring(bb,aa);}
		if(i==10){second_phone = iadd_str.substring(bb,aa);}
		bb=aa+1;

	} 
	
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
		if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}

}
if(theop_code.equals("7671")){
	
	int aa=0;
	int bb=0;                    
	//营销代码|品牌名称|应收金额|底线预存|活动预存|机型名称|固话卡款|固话卡消费月份|手机卡款消费期限|IMEI码|手机卡号码|手机卡款|中奖标志|
 	for (int i=1; i<14; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}   //应收金额
		if(i==4){main_fee=iadd_str.substring(bb,aa);}     //底线
		if(i==5){prepay_money=iadd_str.substring(bb,aa);}  //活动
		if(i==6){type_code=iadd_str.substring(bb,aa);}    //机型名称
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		if(i==11){second_phone = iadd_str.substring(bb,aa);} //手机卡号码
		if(i==12){second_fee=iadd_str.substring(bb,aa);}   //手机卡款
		if(i==14){award_flag = iadd_str.substring(bb,aa);}
		bb=aa+1;
	}
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7672")){
	//iAddStr格式 原流水|营销代码|应收金额|底线预存|活动预存|固话款|消费月份|赠手机话费|机型名称|手机卡号码|手机卡话费期限|冲正资费|
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==4){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){prepay_money=iadd_str.substring(bb,aa);} 
		if(i==8){second_fee=iadd_str.substring(bb,aa);}
		if(i==9){brand_code=iadd_str.substring(bb,aa);}
		if(i==10){second_phone = iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
	
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
		if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}

}
if(theop_code.equals("8044")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<15; i++)
	{ //营销代码|品牌名称|应收金额|赠送话费|彩铃预存|机型名称|消费月份|SIM卡号|月底线|IMEI码|购机款|
		
		//00095975|诺基亚|520.00|150.00|18.00|N6030|13.00|89860068081504579634|25.00|358834008977126|0|520.00|10559|0|

		//00095915|诺基亚|520.00|150.00|18.00|N6030|13.00|89860068081504579634|25.00|358834008977126|0|520.00|10559|0|
		//76988402511|00095915|520|150|18|13|25|诺基亚N6030|352|520|358834008977126|14780 动感地带新小区零听卡|
		
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==4){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==3){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){second_fee=iadd_str.substring(bb,aa);}
		if(i==6){type_code=iadd_str.substring(bb,aa);}
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		if(i==11){second_phone = iadd_str.substring(bb,aa);}
		if(i==14){award_flag = iadd_str.substring(bb,aa);}
		bb=aa+1;

	} 
	xx_money=formatNumber(main_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8045")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<12; i++)
	{ //旧流水|营销代码|应收|赠送预存|彩铃专款|消费期限|月底线|机型|购机款|手机原价|IMEI|
		aa=iadd_str.indexOf("|",aa+1);
		if(i==8){brand_code=iadd_str.substring(bb,aa);}
		if(i==4){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==3){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){second_fee=iadd_str.substring(bb,aa);}
		if(i==9){second_phone = iadd_str.substring(bb,aa);}
		if(i==11){IMEINo = iadd_str.substring(bb,aa);}
		bb=aa+1;

	} 
		xx_money=formatNumber(main_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("126h") || theop_code.equals("8023")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<13; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==6){type_code=iadd_str.substring(bb,aa);}
		//孙振兴添加     START
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		if(i==12){award_flag = iadd_str.substring(bb,aa);}
		//孙振兴添加     END
		bb=aa+1;

	} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("126i") || theop_code.equals("8024")){
	
	int aa1=0;
	int bb1=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i1=1; i1<11; i1++)
	{ 
		aa1=iadd_str.indexOf("|",aa1+1);
		
		if(i1==3){prepay_fee=iadd_str.substring(bb1,aa1);}
		if(i1==10){type_code=iadd_str.substring(bb1,aa1);}
		bb1=aa1+1;

	} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8034")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<13; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==6){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==3){prepay_money=iadd_str.substring(bb,aa);}
		if(i==4){sp_money=iadd_str.substring(bb,aa);}
		if(i==5){type_code=iadd_str.substring(bb,aa);}
		if(i==9){gift_name=iadd_str.substring(bb,aa);}
		if(i==8){gift_code=iadd_str.substring(bb,aa);}
		//孙振兴添加     START
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		//孙振兴添加     END
		bb=aa+1;
		

	} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8035")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<13; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}
		if(i==6){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==4){prepay_money=iadd_str.substring(bb,aa);}
		if(i==5){sp_money=iadd_str.substring(bb,aa);}
		if(i==8){gift_name=iadd_str.substring(bb,aa);}
		
		bb=aa+1;
		

	} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8070")||theop_code.equals("8071")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<8; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==4){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==2){prepay_money=iadd_str.substring(bb,aa);}
		if(i==6){IMEINo=iadd_str.substring(bb,aa);}
		
		bb=aa+1;
		

	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("2281")||theop_code.equals("2283")||theop_code.equals("2264")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<9; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==8){brand_code=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("2282")||theop_code.equals("2284")||theop_code.equals("2265")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<11; i1++)
	{ 
		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==2){prepay_fee=iadd_str.substring(bb1,aa1);}
		if(i1==9){brand_code=iadd_str.substring(bb1,aa1);}
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//add sunaj  20090410
if(theop_code.equals("7371")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<9; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==8){brand_code=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7374")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<11; i1++)
	{ 
		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==2){prepay_fee=iadd_str.substring(bb1,aa1);}
		if(i1==9){brand_code=iadd_str.substring(bb1,aa1);}
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//add sunaj  20090414
if(theop_code.equals("7379")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<13; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}   	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}   
        if(i==5){second_fee=iadd_str.substring(bb,aa);} 
        if(i==7){sp_money=iadd_str.substring(bb,aa);} 
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} 
        if(i==12){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7382")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<14; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}   	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}   
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);} 
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);} 
        if(i1==11){prepay_money=iadd_str.substring(bb1,aa1);} 
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//add sunaj  20090516
if(theop_code.equals("7975")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}   	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}   
        if(i==5){second_fee=iadd_str.substring(bb,aa);} 
        if(i==7){sp_money=iadd_str.substring(bb,aa);} 
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} 
        if(i==11){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7976")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<13; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}   	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}   
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);} 
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);} 
        if(i1==10){prepay_money=iadd_str.substring(bb1,aa1);} 
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//购TD固话赠话费 sunaj  20090828 start 20100427 铁通
if(theop_code.equals("7981") || theop_code.equals("8551")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}  //型号  	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}  //应付金额
        if(i==5){second_fee=iadd_str.substring(bb,aa);}  //话费
        if(i==7){sp_money=iadd_str.substring(bb,aa);}    //上网费
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} //市场价
        if(i==11){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7982") || theop_code.equals("8552")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<13; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //型号 	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //应付金额 
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);}  //话费
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);}    //上网费
        if(i1==10){prepay_money=iadd_str.substring(bb1,aa1);} 
        if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//购TD固话赠话费 sunaj  20090828  end
//购TD商务固话赠通信费 sunaj  20090902 start
if(theop_code.equals("7898") || theop_code.equals("g122")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}  //型号  	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}  //应付金额
        if(i==5){second_fee=iadd_str.substring(bb,aa);}  //话费
        if(i==7){sp_money=iadd_str.substring(bb,aa);}    //上网费
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} //市场价
        if(i==11){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7899") || theop_code.equals("g123")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<13; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //型号 	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //应付金额 
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);}  //话费
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);}    //上网费
        if(i1==10){prepay_money=iadd_str.substring(bb1,aa1);} 
        if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//购TD商务固话赠通信费 sunaj  20090902  end

//购TD商务固话，赠通信费(铁通) wangyua  20100512 start
if(theop_code.equals("7688") || theop_code.equals("g124")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}  //型号  	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}  //应付金额
        if(i==5){second_fee=iadd_str.substring(bb,aa);}  //话费
        if(i==7){sp_money=iadd_str.substring(bb,aa);}    //上网费
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} //市场价
        if(i==11){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7689") || theop_code.equals("g125")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<13; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //型号 	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //应付金额 
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);}  //话费
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);}    //上网费
        if(i1==10){prepay_money=iadd_str.substring(bb1,aa1);} 
        if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//购TD商务固话赠通信费 wangyua  20100512  end
if(theop_code.equals("8027")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<7; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
	
		if(i==1){type_code=iadd_str.substring(bb,aa);} //sale_code
		if(i==2){brand_code=iadd_str.substring(bb,aa);}//agent_code
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}//预存款
		if(i==4){type_code=iadd_str.substring(bb,aa);}//phone_type
		if(i==5){prepay_money=iadd_str.substring(bb,aa);}//购机款
		if(i==6){IMEINo=iadd_str.substring(bb,aa);}//ImeiNo
		
		bb=aa+1;
	
	} 
	xx_money=formatNumber(prepay_money,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8028")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<13; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
	 //iAddStr格式 原流水|营销代码|机型名称|赠送话费|购机款|	
		//if(i==1){=iadd_str.substring(bb,aa);}
		if(i==2){type_code=iadd_str.substring(bb,aa);}
		if(i==3){brand_code=iadd_str.substring(bb,aa);}
		if(i==4){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==5){prepay_money=iadd_str.substring(bb,aa);}
		bb=aa+1;

	} 
	xx_money=formatNumber(prepay_money,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
%>

<%
		/***************liujian  e505  e506合约计划购机开始******************/
	if(theop_code.equals("e505")){
		int aa1=0;
		int bb1=0;
	 	for (int i1=1; i1<13; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==3){brand_code=iadd_str.substring(bb1,aa1);}  //型号 	
      if(i1==4){prepay_fee=iadd_str.substring(bb1,aa1);}  //应付金额 
      if(i1==5){second_fee=iadd_str.substring(bb1,aa1);} //底线预存
      if(i1==6){//消费期限
      	sp_money=iadd_str.substring(bb1,aa1);
      }    
      if(i1==7){prepay_money=iadd_str.substring(bb1,aa1); } //活动预存
      if(i1==11){
      	IMEINo=iadd_str.substring(bb1,aa1);
      	System.out.println(" zhangyan~~~------liujian-----------IMEINo=" +IMEINo);
      }
      System.out.println(" zhangyan~~~========liujia=================="+iadd_str);
			bb1=aa1+1;
		} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}

if(theop_code.equals("e506")){
		int aa1=0;
		int bb1=0;
	 	for (int i1=1; i1<13; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //型号 	
      if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //应付金额 
      if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
      System.out.println(" zhangyan~~~=========================="+iadd_str);
			bb1=aa1+1;
		} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
/***************liujian  e528  e529合约计划购机开始******************/
if(theop_code.equals("e528")){
//营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜拆包期限｜购机款｜传0｜imei码
//缴费合计：XX元  含：预存话费XX元；每月返还金额：XX元；一次性返还：XX元；每月赠送费用：XX元。
		int aa1=0;
		int bb1=0;
	 	for (int i1=1; i1<13; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==3){brand_code=iadd_str.substring(bb1,aa1);}  //型号 	
      if(i1==4){prepay_fee=iadd_str.substring(bb1,aa1);}  //应付金额 
      if(i1==5){second_fee=iadd_str.substring(bb1,aa1);}  //底线预存
      if(i1==7){//活动预存
      	prepay_money=iadd_str.substring(bb1,aa1); 
      	//预存款=活动预存+底线预存
      	second_fee = Float.parseFloat(prepay_money) + Float.parseFloat(second_fee) + "";
      }
			if(i1==9){second_phone=iadd_str.substring(bb1,aa1);}//月赠送预存款
      if(i1==11){
      	IMEINo=iadd_str.substring(bb1,aa1);
      	System.out.println(" zhangyan~~~------liujian-----------IMEINo=" +IMEINo);
      }
      System.out.println(" zhangyan~~~========liujia=================="+iadd_str);
			bb1=aa1+1;
		} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}

if(theop_code.equals("e529")){
		int aa1=0;
		int bb1=0;
		//冲正流水｜营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜拆包期限
		//				｜月赠送预存款｜传0｜imei码｜
	 	for (int i1=1; i1<13; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //型号 	
      if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //应付金额 
      if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
      System.out.println(" zhangyan~~~=========================="+iadd_str);
			bb1=aa1+1;
		} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
System.out.println("zhangyan ~~~~~~~~~~~~~~~~~~~~~athe opcode end");
/***************liujian  e528  e529合约计划购机结束******************/

if(theop_code.equals("e720")){
		int aa1=0;
		int bb1=0;
		//冲正流水｜营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜拆包期限
		//				｜月赠送预存款｜传0｜imei码｜
	 	for (int i1=1; i1<12; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==3){brand_code=iadd_str.substring(bb1,aa1);
				System.out.println("zhangyan~~~~~~~~~~brand_code");
			}  //型号 	
			if(i1==7){free_fee=iadd_str.substring(bb1,aa1);}  //优惠总金额 	
			if(i1==9){base_fee=iadd_str.substring(bb1,aa1);}  //优惠比例 	
			if(i1==4){prepay_fee=iadd_str.substring(bb1,aa1);}  //应付金额 
			if(i1==11){IMEINo=iadd_str.substring(bb1,aa1);}
      System.out.println(" zhangyan~~~=========================="+iadd_str);
      System.out.println(" zhangyan~~~===========IMEINo==============="+IMEINo);
			bb1=aa1+1;
		} 
		System.out.println("zhangyan~~~~~~~~~~~~~~~~`"+xx_money);
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}

if(theop_code.equals("e721")){
		int aa1=0;
		int bb1=0;

	 	for (int i1=1; i1<13; i1++)
		{ 
				
			aa1=iadd_str.indexOf("|",aa1+1);
			if (i1==4){brand_code=iadd_str.substring(bb1,aa1);}
			if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //大写金额
			if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}  //IMEI码：
			if(i1==8){free_fee=iadd_str.substring(bb1,aa1);}  //优惠总金额
			if(i1==10){base_fee=iadd_str.substring(bb1,aa1);}  //优惠总金额
      System.out.println(" zhangyan~~~=========================="+iadd_str);
      System.out.println(" zhangyan~~~===========IMEINo==============="+IMEINo);
			bb1=aa1+1;
		} 
		System.out.println("zhangyan~~~~~~~~~~~~~~~~`"+xx_money);
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
%>
<script language="jscript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+='<%=cardno%>'+"|";//身份证号码                                                  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=themob%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=name%>'+"|";//用户名称                                                
	 infoStr+='<%=address%>'+"|";//用户地址
	 infoStr+="现金"+"|";
	 infoStr+='<%=handcash%>'+"|";
	 infoStr+="主资费变更。*手续费："+'<%=realcash%>'+"*流水号："+'<%=stream%>'+"|";
	 var dirtPage="";
	 <%if(theop_code.equals("1255")){%>
		 dirtPate = "/npage/bill/f1255_login.jsp";
	 <%}else{%>
         dirtPate = "/npage/bill/f1270_1.jsp";
	 <%}%>
	 location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill8042(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//身份证号码   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      预存送手机、话费共分享"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=" "+"|";//用户地址
	 infoStr+="手机型号:"+'<%=brand_code%>'+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="缴款合计：<%=prepay_fee%>"+ "元,含主卡预存话费<%=main_fee%>"+"元,副卡预存话费<%=second_fee%>"+"元,副卡号码：<%=second_phone%>,IMEI码：<%=IMEINo%>"+"|";
	  infoStr+="<%=work_name%>"+"|";//开票人

	 if( "<%=award_flag%>" == "1")
	 {
	 		infoStr+="已参与赠送礼品活动"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	     infoStr+="  "+"|";
	     infoStr+="  "+"|";
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 	 
	 var dirtPage="";
	dirtPate = "/npage/bill/f8042_login.jsp?activePhone=<%=themob%>&opCode=8042&opName=预存送手机、话费共分享";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8042&loginAccept=<%=stream%>&dirtPage="+codeChg(dirtPate);
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill8043(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//身份证号码   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      预存送手机、话费共分享冲正"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=" "+"|";//用户地址
	 infoStr+="手机型号:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="退款合计：<%=prepay_fee%>"+ "元,含主卡预存话费<%=main_fee%>"+"元,副卡预存话费<%=second_fee%>"+"元,副卡号码：<%=second_phone%>"+"|";
	  infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	  infoStr+=" "+"|";//收款人
	 
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
        infoStr+=" "+"|";
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 
	 var dirtPage="";
	dirtPate = "/npage/bill/f8042_login.jsp?activePhone=<%=themob%>&opCode=8043&opName=预存送手机、话费共分享冲正";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8043&loginAccept=<%=stream%>&dirtPage="+codeChg(dirtPate);
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill7671()
{		 
	 var infoStr="";  
	 var base_fee=parseFloat("<%=prepay_money%>")+parseFloat("<%=main_fee%>");   
	                                                                       
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      预存赠固话、话费可分享"+"|";  //工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=" "+"|";//用户地址
	 infoStr+=" "+"|";         
	 infoStr+="<%=chinaFee%>"+"|";       //合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";       //小写
	 
	 infoStr+="TD固话品牌型号"+'<%=brand_code%>'+'<%=type_code%>'; 
	 infoStr+=",IMEI码<%=IMEINo%>"+",捆绑手机卡号码<%=second_phone%>"+",缴款合计<%=prepay_fee%>"+"元,"+"含固话卡话费"+base_fee+"元,手机卡话费<%=second_fee%>"+"元。"+"|";

	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 if("<%=award_flag%>" == "1")
	 {
	 		infoStr+="已参与赠送礼品活动"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第16个参数*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";            
	 dirtPate = "/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=预存赠固话、话费可分享";
	 //location = "/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=预存赠固话、话费可分享";
	 location = "/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7671&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=预存赠固话、话费可分享";
	 // location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill7672()
{

	 var infoStr=""; 
	 var base_fee=parseFloat("<%=prepay_money%>")+parseFloat("<%=main_fee%>");  	
	                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      预存赠固话、话费可分享冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=" "+"|";//用户地址
	 infoStr+=" "+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 
	 infoStr+="TD固话品牌型号"+"<%=brand_code%>"+",退款合计<%=prepay_fee%>"+"元,含固话卡话费"+base_fee+
	 "元,手机卡话费<%=second_fee%>"+"元,捆绑手机卡号码<%=second_phone%>"+"|"; 
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage="";          
	 dirtPate = "/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=预存赠固话、话费可分享冲正";  
	 //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=预存赠固话、话费可分享冲正";
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7672&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=预存赠固话、话费可分享冲正";
	 // location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill8044(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//身份证号码   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      欢乐新农村神州行手机营销"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=" "+"|";//用户地址
	 infoStr+="手机型号:"+'<%=brand_code%>'+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 

	 
	 if ("0" == "<%=second_fee%>" ){
	 infoStr+="缴款合计：<%=main_fee%>"+ "元，含购机款 <%=second_phone%>"+"元,预存话费 <%=prepay_fee%>"+"元。IMEI码：<%=IMEINo%>"+"|";
	 	}else{
	 infoStr+="缴款合计：<%=main_fee%>"+ "元，含购机款 <%=second_phone%>"+"元,预存话费 <%=prepay_fee%>"+"元，彩铃专款 <%=second_fee%>"+"元。IMEI码：<%=IMEINo%>"+"|";

		}	 
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 if( "<%=award_flag%>" == "1")
	 {
	 		infoStr+="已参与赠送礼品活动"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }	 
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){

	 		infoStr+=" "+"|";/*占位第16个参数*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 	 
	 var dirtPage="";
	dirtPate = "/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8044%26opName=欢乐新农村神州行手机营销";
	if("<%=link_count%>"=="0"){
		//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8044%26opName=欢乐新农村神州行手机营销";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8044&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8044%26opName=欢乐新农村神州行手机营销";
	}else{
		//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f3250_login.jsp?activePhone=<%=themob%>%26opCode=3250%26opName=可选套餐包年";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8044&loginAccept=<%=stream%>&dirtPage=/npage/bill/f3250_login.jsp?activePhone=<%=themob%>%26opCode=3250%26opName=可选套餐包年";
	}
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill8045(){   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//身份证号码   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      欢乐新农村神州行手机营销冲正"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=" "+"|";//用户地址
	 infoStr+="手机型号:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 

		//王良 2007年9月29日 修改
		
	 if ("0" == "<%=second_fee%>"){
	 infoStr+="退款合计：<%=main_fee%>"+"元，含购机款 <%=second_phone%>"+"元，预存话费 <%=prepay_fee%>"+"元。IMEI码：<%=IMEINo%>"+"|";
		}else{
	 infoStr+="退款合计：<%=main_fee%>"+ "元，含购机款 <%=second_phone%>"+"元，预存话费 <%=prepay_fee%>"+"元，彩铃专款 <%=second_fee%>"+"元。IMEI码：<%=IMEINo%>"+"|";
		}
	
	  infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 
	 var dirtPage="";
	dirtPate = "/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8045%26opName=欢乐新农村神州行手机营销冲正";
	if("<%=link_count%>"=="0"){
		//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8045%26opName=欢乐新农村神州行手机营销冲正";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8045&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8045%26opName=欢乐新农村神州行手机营销冲正";
	}else{
		//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f3250_login.jsp?activePhone=<%=themob%>%26opCode=3250%26opName=可选套餐包年";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8045&loginAccept=<%=stream%>&dirtPage=/npage/bill/f3250_login.jsp?activePhone=<%=themob%>%26opCode=3250%26opName=可选套餐包年";
	}
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill126h(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//身份证号码   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       签约赠机"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=" "+"|";//用户地址
	 infoStr+="手机型号:"+'<%=brand_code%>'+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="缴款合计：  <%=prepay_fee%>"+
		 "元　含:预存话费 <%=prepay_fee%>"+"元"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 infoStr+="IMEI码：<%=IMEINo%>"+"|";
	 if( "<%=award_flag%>" == "1")
	 {
	 		infoStr+="已参与赠送礼品活动"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 
	 /**** tianyang add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** tianyang add for pos end ****/
	 
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f126h_login.jsp?activePhone=<%=themob%>&opCode=126h&opName=签约赠机";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=126h&loginAccept=<%=stream%>&dirtPage="+codeChg(dirtPate);
	//location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f126h_login.jsp?activePhone=<%=themob%>";
}
function printBill126i(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//身份证号码   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       签约赠机冲正"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="手机型号:"+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="退款合计：  <%=prepay_fee%>"+
		 "元　含:预存话费 <%=prepay_fee%>"+"元"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 
	 /**** tianyang add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** tianyang add for pos end ****/
	 
	 
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f126h_login.jsp?activePhone=<%=themob%>&opCode=126i&opName=签约赠机冲正";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=126i&loginAccept=<%=stream%>&dirtPage="+codeChg(dirtPate);
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}



function printBill8094(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       特殊号码资费营销案"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=" "+"|";//用户地址
	 infoStr+=" "+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="预存话费 <%=prepay_fee%>"+"元"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f8094_login.jsp?activePhone=<%=themob%>&opCode=8094";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	
}


function printBill2282(){
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       签约赠礼品冲正"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="礼品名称:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="退款合计：  <%=prepay_fee%>"+
		 "元　含:预存话费 <%=prepay_fee%>"+"元"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f2281_login.jsp";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f2281_login.jsp?activePhone=<%=themob%>%26opCode=2281%26opName=签约赠礼品  ";
}
function printBill2283(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       全球通签约送礼"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="礼品名称:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="缴款合计：  <%=prepay_fee%>"+
		 "元　含:预存话费 <%=prepay_fee%>"+"元"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f2283_login.jsp?activePhone=<%=themob%>%26opCode=2283%26opName=全球通签约送礼";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f2283_login.jsp?activePhone=<%=themob%>%26opCode=2283%26opName=全球通签约送礼";
}
function printBill2284(){
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       全球通签约送礼冲正"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="礼品名称:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="退款合计：  <%=prepay_fee%>"+
		 "元　含:预存话费 <%=prepay_fee%>"+"元"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f2283_login.jsp?activePhone=<%=themob%>%26opCode=2284%26opName=全球通签约送礼冲正";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f2283_login.jsp?activePhone=<%=themob%>%26opCode=2284%26opName=全球通签约送礼冲正";
}
//add sunaj 20090410
function printBill7371(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       预存优惠上网费用营销案"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//用户名称                                                       
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//移动号码                                           
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="预存话费 <%=prepay_fee%>"+"元|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 var dirtPage="";
	 /*
	dirtPate = "/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7371%26opName=预存优惠上网费用营销案";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7371%26opName=预存优惠上网费用营销案";
	*/
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=thework_no%>");
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","<%=name%>");
	$(billArgsObj).attr("10006","预存优惠上网费用营销案");
	$(billArgsObj).attr("10008","<%=themob%>");
	$(billArgsObj).attr("10015","<%=xx_money%>");//小写
	$(billArgsObj).attr("10016","<%=xx_money%>");//合计金额(大写) 传小写，公共页转换
	$(billArgsObj).attr("10017","*");//本次缴费：现金
	$(billArgsObj).attr("10020","");//入网费
	$(billArgsObj).attr("10021","<%=handcash%>");//手续费
	$(billArgsObj).attr("10022","");//选号费
	$(billArgsObj).attr("10023","");//押金
	$(billArgsObj).attr("10024","");//SIM卡费
	$(billArgsObj).attr("10025","<%=prepay_fee%>");//预存金额
	$(billArgsObj).attr("10026","");//机器费
	$(billArgsObj).attr("10027","");//其他费
	$(billArgsObj).attr("10028","");//参与的营销活动名称
	$(billArgsObj).attr("10047","");//活动代码
	$(billArgsObj).attr("10030","<%=stream%>");//业务流水
	$(billArgsObj).attr("10036","7371");
	$(billArgsObj).attr("10031","<%=work_name%>");//开票人
	
	var printInfo = "";
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？";
	var path = path + "&infoStr="+printInfo+"&loginAccept=<%=stream%>&opCode=7371&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop); 
	location = "/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7371%26opName=预存优惠上网费用营销案";
}
function printBill7374(){
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       预存优惠上网费用营销案冲正"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//用户名称                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//移动号码                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="预存话费 <%=prepay_fee%>"+"元"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 var dirtPage="";
	 
	/*
	dirtPate = "/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7374%26opName=预存优惠上网费用营销案冲正";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7374%26opName=预存优惠上网费用营销案冲正";
	*/
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=thework_no%>");
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","<%=name%>");
	$(billArgsObj).attr("10006","预存优惠上网费用营销案冲正");
	$(billArgsObj).attr("10008","<%=themob%>");
	$(billArgsObj).attr("10015","-<%=xx_money%>");//小写
	$(billArgsObj).attr("10016","-<%=xx_money%>");//合计金额(大写) 传小写，公共页转换
	$(billArgsObj).attr("10017","*");//本次缴费：现金
	$(billArgsObj).attr("10020","");//入网费
	if("<%=handcash%>">0.01){
		$(billArgsObj).attr("10021","-<%=handcash%>");//手续费
	}else{
		$(billArgsObj).attr("10021","<%=handcash%>");//手续费
	}
	$(billArgsObj).attr("10022","");//选号费
	$(billArgsObj).attr("10023","");//押金
	$(billArgsObj).attr("10024","");//SIM卡费
	$(billArgsObj).attr("10025","-<%=prepay_fee%>");//预存金额
	$(billArgsObj).attr("10026","");//机器费
	$(billArgsObj).attr("10027","");//其他费
	$(billArgsObj).attr("10028","");//参与的营销活动名称
	$(billArgsObj).attr("10047","");//活动代码
	$(billArgsObj).attr("10030","<%=stream%>");//业务流水
	$(billArgsObj).attr("10036","7374");
	$(billArgsObj).attr("10031","<%=work_name%>");//开票人
	$(billArgsObj).attr("10072","2"); //冲正2
	
	var printInfo = "";
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？";
	var path = path + "&infoStr="+printInfo+"&loginAccept=<%=stream%>&opCode=7374&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop); 
	location = "/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7374%26opName=预存优惠上网费用营销案冲正";
}
//add sunaj 20090414
function printBill7379(){
     var prepayfee=parseFloat("<%=prepay_fee%>")-parseFloat("<%=prepay_money%>");
     //alert("prepayfee========"+prepayfee);
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       预存优惠购卡"+"|";//工号                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含购网卡款"+'<%=prepay_money%>'+"元，预存话费"+prepayfee+"元  ";
	 infoStr+="终端型号："+'<%=brand_code%>'+"  IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人

	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f7379_login.jsp?activePhone=<%=themob%>%26opCode=7379%26opName=预存优惠购卡营销案";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7379_login.jsp?activePhone=<%=themob%>%26opCode=7379%26opName=预存优惠购卡营销案";
}
function printBill7382(){
     var prepayfee=parseFloat("<%=prepay_fee%>")-parseFloat("<%=prepay_money%>");
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       预存优惠购卡冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计：<%=prepay_fee%>元，含购网卡款<%=prepay_money%>元，预存话费"+prepayfee+"元  ";
	 infoStr+="终端型号：<%=brand_code%>"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f7379_login.jsp?activePhone=<%=themob%>%26opCode=7382%26opName=预存优惠购卡营销案冲正";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7379_login.jsp?activePhone=<%=themob%>%26opCode=7382%26opName=预存优惠购卡营销案冲正";
}
function printBill7975(){
   var prepayfee=parseFloat("<%=second_fee%>")+parseFloat("<%=sp_money%>");
     //alert("prepayfee========"+prepayfee);
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       商务宝"+"|";//工号                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含预存话费"+prepayfee+"元  ";
	 infoStr+="商务宝型号："+'<%=brand_code%>'+"  IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人

	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f7975_login.jsp?activePhone=<%=themob%>%26opCode=7975%26opName=商务宝营销案";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7975_login.jsp?activePhone=<%=themob%>%26opCode=7975%26opName=商务宝营销案";
}
function printBill7976(){
     var prepayfee=parseFloat("<%=second_fee%>")+parseFloat("<%=sp_money%>");
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       商务宝冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计：<%=prepay_fee%>元，含预存话费"+prepayfee+"元  ";
	 infoStr+="商务宝型号：<%=brand_code%>"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f7975_login.jsp?activePhone=<%=themob%>%26opCode=7976%26opName=商务宝营销案冲正";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7975_login.jsp?activePhone=<%=themob%>%26opCode=7976%26opName=商务宝营销案冲正";
}
function printBill8027(){
	   
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     买手机，送话费"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="手机型号:"+'<%=brand_code%>'+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	
	
	  infoStr+="缴款合计：  <%=prepay_money%>"+
		 "元　赠送预存话费 <%=prepay_fee%>"+"元"+"|";

	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 infoStr+="IMEI码：<%=IMEINo%>"+"|";
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=买手机、送话费";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=买手机、送话费";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8027&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=买手机、送话费";
}
function printBill7981(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       购TD固话赠话费"+"|";//工号                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 if('<%=sp_money%>' > 0)
	 {
	 	infoStr+="上网费"+'<%=sp_money%>'+"元，";
	 }
	 infoStr+="TD固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=购TD固话赠话费";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=购TD固话赠话费";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7981&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=购TD固话赠话费";
}
function printBill8551(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       购TD固话赠话费(铁通)"+"|";//工号                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 if('<%=sp_money%>' > 0)
	 {
	 	infoStr+="上网费"+'<%=sp_money%>'+"元，";
	 }
	 infoStr+="TD固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=购TD固话赠话费(铁通)";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=购TD固话赠话费(铁通)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8551&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=购TD固话赠话费(铁通)";
}
function printBill7982(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       购TD固话赠话费冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 if('<%=sp_money%>' >0)
	 {
	 	infoStr+="上网费"+'<%=sp_money%>'+"元，";
	 }
	 infoStr+="TD固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f7981_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=购TD固话赠话费";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7982&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=购TD固话赠话费";
}
function printBill8552(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       购TD固话赠话费(铁通)冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="退款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 if('<%=sp_money%>' >0)
	 {
	 	infoStr+="上网费"+'<%=sp_money%>'+"元，";
	 }
	 infoStr+="TD固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f8551_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=购TD固话赠话费(铁通)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8552&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=购TD固话赠话费(铁通)";
}
function printBill7898(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       预存话费赠TD商务固话"+"|";//工号                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 if('<%=sp_money%>' > 0)
	 {
	 	infoStr+="上网费"+'<%=sp_money%>'+"元，";
	 }
	 infoStr+="TD商务固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";
	 dirtPate = "/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=预存话费赠TD商务固话";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=预存话费赠TD商务固话";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7898&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=预存话费赠TD商务固话";
}
function printBill7899(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       预存话费赠TD商务固话冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 if('<%=sp_money%>' >0)
	 {
	 	infoStr+="上网费"+'<%=sp_money%>'+"元，";
	 }
	 infoStr+="TD商务固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f7898_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=预存话费赠TD商务固话";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7899&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=预存话费赠TD商务固话";
}
function printBill7688(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       预存话费赠TD商务固话(铁通)"+"|";//工号                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 if('<%=sp_money%>' > 0)
	 {
	 	infoStr+="上网费"+'<%=sp_money%>'+"元，";
	 }
	 infoStr+="TD商务固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=预存话费赠TD商务固话(铁通)";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=预存话费赠TD商务固话(铁通)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7688&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=预存话费赠TD商务固话(铁通)";
}
function printBill7689(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       预存话费赠TD商务固话(铁通)冲正"+"|";//工号                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=""+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="交款合计："+'<%=prepay_fee%>'+"元，含话费"+'<%=second_fee%>'+"元，";
	 if('<%=sp_money%>' >0)
	 {
	 	infoStr+="上网费"+'<%=sp_money%>'+"元，";
	 }
	 infoStr+="TD商务固话型号："+'<%=brand_code%>'+"，IMEI号："+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第15个参数*/
	 		infoStr+=" "+"|";/*占位第16个参数*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f7688_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=预存话费赠TD商务固话(铁通)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7689&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=预存话费赠TD商务固话(铁通)";
}
function printBill8028(){
	   
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     买手机，送话费冲正"+"|";//工号                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="手机型号:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	
	 infoStr+="缴款合计：  <%=prepay_money%>"+ "元　赠送话费 <%=prepay_fee%>"+ "元"+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 infoStr+=" "+"|";
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f8027.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=买手机、送话费";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8028&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=买手机、送话费";
}



function printBillE720(){

	 var infoStr="";                           
                                            
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=sale_name%><%=opName2%>"+"|";//工号      
                                         
   	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="|";
	
	infoStr+="<%=chinaFee%>"+"|";
	infoStr+="<%=xx_money%>"+"|";

	infoStr+="手机型号："+"<%=brand_code%>"+"     IMEI码："+"<%=IMEINo%>"+"~"
		+"合约期内总通信费用优惠总额度为"+"<%=free_fee%>"+"元；"
		+"通信费用优惠比例为客户移动电话号码月实际消费额度的"+"<%=base_fee%>"+"%。"+"|";
	infoStr+="|";
	infoStr+="<%=xx_money%>"+"  预存话费"+"<%=xx_money%>"+"元；"+"|";
	infoStr+="|";
 	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e720&loginAccept=<%=stream%>&dirtPage=/npage/se720/fE720Login.jsp?activePhone=<%=themob%>%26opCode=e720%26opName=购机入网-让利计划";
}


function printBillE721(){

	 var infoStr="";                           
                                            
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=sale_name%><%=opName2%>"+"|";//工号      
                                         
   	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="|";
	
	infoStr+="<%=chinaFee%>"+"|";
	infoStr+="<%=xx_money%>"+"|";

	infoStr+="手机型号："+"<%=brand_code%>"
		+"~"
		+"合约期内总通信费用优惠总额度为"+"<%=free_fee%>"+"元；"
		+"通信费用优惠比例为客户移动电话号码月实际消费额度的"+"<%=base_fee%>"+"%。"+"|";
	infoStr+="|";
	infoStr+="<%=xx_money%>"+"  预存话费"+"<%=xx_money%>"+"元；"+"|";
	infoStr+="|";
 	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e721&loginAccept=<%=stream%>&dirtPage=/npage/se720/fE720Login.jsp?activePhone=<%=themob%>%26opCode=e721%26opName=购机入网-让利计划冲正";
}

function printBillE528() {
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=sale_name%><%=opName2%>"+"|";//工号                                                 
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="手机型号:"+'<%=brand_code%>'+"~";
	 infoStr+="IMEI号："+'<%=IMEINo%>'+"~";
	 infoStr+="缴款合计：<%=prepay_fee%>" + "元  含：预存话费" + '<%=second_fee%>' + "元；每月返还金额：" + '<%=mon_prepay_limit%>' + "元；" + "~" ;
	 infoStr+="一次性返还：" + '<%=prepay_money%>' + "元；每月赠送费用：" + '<%=second_phone%>' + "元。" + "|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 infoStr+=" "+"|";
	 
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e528&loginAccept=<%=stream%>&dirtPage=/npage/se528/se528_login.jsp?activePhone=<%=themob%>%26opCode=e528%26opName=自备机合约计划";
}
function printBillE529() {
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=sale_name%><%=opName2%>"+"|";//工号                                                 
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+='<%=themob%>'+"|";//用户名称                                                
	 infoStr+=""+"|";//用户地址
	 infoStr+="|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=xx_money%>"+"|";//小写 
	 infoStr+="手机型号:"+'<%=brand_code%>'+"~";
	 //infoStr+="IMEI号："+'<%=IMEINo%>'+"~";
	 //含：预存话费" + '<%=second_fee%>' + "元；每月返还金额：" + '<%=mon_prepay_limit%>' + "元；一次性返还：" + '<%=prepay_money%>' + "元；每月赠送费用：" + '<%=second_phone%>' + "元。"
	 infoStr+="退款合计：<%=prepay_fee%>" + "元" + "|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 infoStr+=" "+"|";
	 
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e528&loginAccept=<%=stream%>&dirtPage=/npage/se528/se528_login.jsp?activePhone=<%=themob%>%26opCode=e528%26opName=自备机合约计划";
}
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
</script>

<jsp:include page="fe505_1270_4.jsp">
	<jsp:param name="prepay_money" value="<%=prepay_money%>"  />
	<jsp:param name="second_fee" value="<%=second_fee%>"  />
	<jsp:param name="thework_no" value="<%=thework_no%>"  />
	<jsp:param name="stream" value="<%=stream%>"  />
	<jsp:param name="e505_sale_name" value="<%=e505_sale_name%>"  />
	<jsp:param name="opName2" value="<%=opName2%>"  />
	<jsp:param name="name" value="<%=name%>"  />
	<jsp:param name="themob" value="<%=themob%>"  />
	<jsp:param name="chinaFee" value="<%=chinaFee%>"  />
	<jsp:param name="xx_money" value="<%=xx_money%>"  />
	<jsp:param name="brand_code" value="<%=brand_code%>"  />
	<jsp:param name="IMEINo" value="<%=IMEINo%>"  />
	<jsp:param name="prepay_fee" value="<%=prepay_fee%>"  />
	<jsp:param name="work_name" value="<%=work_name%>"  />
	<jsp:param name="payType" value="<%=payType%>"  />
	<jsp:param name="MerchantNameChs" value="<%=MerchantNameChs%>"  />
	<jsp:param name="CardNoPingBi" value="<%=CardNoPingBi%>"  />
	<jsp:param name="MerchantId" value="<%=MerchantId%>"  />
	<jsp:param name="BatchNo" value="<%=BatchNo%>"  />
	<jsp:param name="IssCode" value="<%=IssCode%>"  />
	<jsp:param name="TerminalId" value="<%=TerminalId%>"  />
	<jsp:param name="AuthNo" value="<%=AuthNo%>"  />
	<jsp:param name="Response_time" value="<%=Response_time%>"  />
	<jsp:param name="Rrn" value="<%=Rrn%>"  />
	<jsp:param name="TraceNo" value="<%=TraceNo%>"  />
	<jsp:param name="AcqCode" value="<%=AcqCode%>"  />
	<jsp:param name="transTotal" value="<%=transTotal%>"  />
	<jsp:param name="returnPage" value="<%=returnPage%>"  />
</jsp:include>

<jsp:include page="fg122_1270_4.jsp">
	<jsp:param name="prepay_money" value="<%=prepay_money%>"  />
	<jsp:param name="second_fee" value="<%=second_fee%>"  />
	<jsp:param name="thework_no" value="<%=thework_no%>"  />
	<jsp:param name="stream" value="<%=stream%>"  />
	<jsp:param name="e505_sale_name" value="<%=e505_sale_name%>"  />
	<jsp:param name="opName2" value="<%=opName2%>"  />
	<jsp:param name="name" value="<%=name%>"  />
	<jsp:param name="themob" value="<%=themob%>"  />
	<jsp:param name="chinaFee" value="<%=chinaFee%>"  />
	<jsp:param name="xx_money" value="<%=xx_money%>"  />
	<jsp:param name="brand_code" value="<%=brand_code%>"  />
	<jsp:param name="IMEINo" value="<%=IMEINo%>"  />
	<jsp:param name="prepay_fee" value="<%=prepay_fee%>"  />
	<jsp:param name="work_name" value="<%=work_name%>"  />
	<jsp:param name="payType" value="<%=payType%>"  />
	<jsp:param name="MerchantNameChs" value="<%=MerchantNameChs%>"  />
	<jsp:param name="CardNoPingBi" value="<%=CardNoPingBi%>"  />
	<jsp:param name="MerchantId" value="<%=MerchantId%>"  />
	<jsp:param name="BatchNo" value="<%=BatchNo%>"  />
	<jsp:param name="IssCode" value="<%=IssCode%>"  />
	<jsp:param name="TerminalId" value="<%=TerminalId%>"  />
	<jsp:param name="AuthNo" value="<%=AuthNo%>"  />
	<jsp:param name="Response_time" value="<%=Response_time%>"  />
	<jsp:param name="Rrn" value="<%=Rrn%>"  />
	<jsp:param name="TraceNo" value="<%=TraceNo%>"  />
	<jsp:param name="AcqCode" value="<%=AcqCode%>"  />
	<jsp:param name="returnPage" value="<%=returnPage%>"  />
	<jsp:param name="sp_money" value="<%=sp_money%>"  />
</jsp:include>


<%if(ret_code==0&&(handcash>0.0||theop_code.equals("1255")||theop_code.equals("1259"))){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8042")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8042();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8043")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8043();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8044")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8044();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8045")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8045();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("126h")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill126h();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("126i")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill126i();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8023")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8023();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8024")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8024();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("8034")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8034();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8035")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8035();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("8070")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8070();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8071")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8071();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("2264")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill2264();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("2265")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill2265();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("2281")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill2281();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("2282")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill2282();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("2283")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill2283();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("2284")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill2284();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7371")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7371();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7374")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7374();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7379")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7379();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7382")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7382();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7975")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7975();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7976")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7976();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7981")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7981();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7982")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7982();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8551")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8551();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8552")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8552();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7671")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7671();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7672")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7672();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7898")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7898();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7899")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7899();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8094")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！请返回.......');
location="/npage/bill/f8094_login.jsp?activePhone=<%=themob%>&opCode=8094&opName=特殊号码资费营销案  ";
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8091")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！请返回.......');
location="/npage/bill/f8094_login.jsp?activePhone=<%=themob%>&opCode=8091&opName=特殊号码资费营销案  ";
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("8027")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8027();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8028")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill8028();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7688")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7688();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7689")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBill7689();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("e505")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBillE505();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("e506")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBillE506();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("e720")){%>
<script language="jscript">
	rdShowMessageDialog('操作成功！打印发票.......');
	printBillE720();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("e721")){%>
<script language="jscript">
	rdShowMessageDialog('操作成功！打印发票.......');
	printBillE721();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("e528")){%>
<script language="jscript">
if('<%=prepay_fee%>' == '0' || '<%=prepay_fee%>' == '0.00') {
	rdShowMessageDialog('操作成功！');
	location = "/npage/se528/se528_login.jsp?activePhone=<%=themob%>&opCode=e528&opName=自备机合约计划";
}else {
	rdShowMessageDialog('操作成功！打印发票.......');
	printBillE528();
}
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("e529")){%>
<script language="jscript">
	if('<%=prepay_fee%>' == '0' || '<%=prepay_fee%>' == '0.00') {
		rdShowMessageDialog('操作成功！');
		location = "/npage/se528/se528_login.jsp?activePhone=<%=themob%>&opCode=e529&opName=自备机合约计划冲正";
	}else {
		rdShowMessageDialog('操作成功！打印发票.......');
		printBillE529();
	}
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("g122")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBillG122();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("g123")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBillG123();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("g124")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBillG124();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("g125")){%>
<script language="jscript">
rdShowMessageDialog('操作成功！打印发票.......');
printBillG125();
</script>
<%}%>

<%if(ret_code==0){%>
<script language='jscript'>
rdShowMessageDialog('操作成功！',2);
if("<%=returnPage%>"!="")
{
  location="<%=returnPage%>";

}
else
{
  removeCurrentTab();
  
}
</script>
<%}%>
<%if(!(ret_code==0)){%>
<script language='jscript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。");
	
	<%
		if(theop_code.equals("e505") || theop_code.equals("e506")) {
	%>
			//location = "/npage/se505/se505_login.jsp?activePhone=<%=themob%>&opCode=<%=theop_code%>&opName=<%=opName2%>"
			if("<%=returnPage%>"!=""){
        location="<%=returnPage%>";
      }else{
        removeCurrentTab();
      }
	<%
		}else if(theop_code.equals("e528") || theop_code.equals("e529")) {
	%>
			location = "/npage/se528/se528_login.jsp?activePhone=<%=themob%>&opCode=<%=theop_code%>&opName=<%=opName2%>"
	<%		
		}else {
	%>
			history.go(-2);
	<%		
		} 
	%>
</script>
<%}%>

