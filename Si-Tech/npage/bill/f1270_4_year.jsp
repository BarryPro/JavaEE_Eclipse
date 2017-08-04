<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-18 页面改造,修改样式
     *
     ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.ReqUtil" %>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html; charset=GBK" %>
<%!
    //splitString()用于截取字符串，因jdk老版本没有String.split()函数
    public Vector splitString(String sign, String sourceString) {
        Vector splitArrays = new Vector();
        int i = 0;
        int j = 0;
        if (sourceString.length() == 0) {
            return splitArrays;
        }
        while (i <= sourceString.length()) {
            j = sourceString.indexOf(sign, i);
            if (j < 0) {
                j = sourceString.length();
            }
            splitArrays.addElement(sourceString.substring(i, j));
            i = j + 1;
        }
        return splitArrays;
    }

    //格式化数据
    public static String formatNumber(String num, int zeroNum) {
        DecimalFormat form = (DecimalFormat) NumberFormat.getInstance(Locale.getDefault());
        StringBuffer patBuf = new StringBuffer("0");
        if (zeroNum > 0) {
            patBuf.append(".");
            for (int i = 0; i < zeroNum; i++) {
                patBuf.append("0");
            }

        }
        form.applyPattern(patBuf.toString());
        return form.format(Double.parseDouble(num)).toString();
    }
%>
<%
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
    String work_no = (String) session.getAttribute("workNo");
    String work_name = (String) session.getAttribute("workName");
    String pass = (String) session.getAttribute("password");
    String ipAddr = (String)session.getAttribute("ipAddr");

/*--------------------------------传入参数 参考f1270_4.jsp -------------------------------*/
    String theop_code = ReqUtil.get(request, "iOpCode");                    //操作代码	2  iOpCode                                     
    String iadd_str = ReqUtil.get(request, "iAddStr");                      //个性化信息
    String themob = ReqUtil.get(request, "i1");                             //手机号码	3  移动号码 iPhoneNo                           
    String maincash = ReqUtil.get(request, "i16");                          //主套餐代码代码 4  当前主套餐代码 iOldMode                     
    
    maincash=maincash.substring(0,maincash.indexOf("--"));    //update by qiansheng 
    
    String old_cash = ReqUtil.get(request, "ip");           //新主套餐代码	 5  新主套餐代码 iNewMode                       
    old_cash=old_cash.substring(0,old_cash.indexOf(" "));
    String maincash_flag = ReqUtil.get(request, "tbselect").substring(0, 1);//主套餐生效标志	6  主套餐变更的生效方式 iSendFlag              
    String addcash_string = ReqUtil.get(request, "kx_habitus_bunch");   //可选套餐的代码串	 7  可选套餐的代码串 iAddModeStr               
    String do_string = ReqUtil.get(request, "kx_code_bunch");             //可选套餐的状态串			8  可选套餐的变更串 iAddChgStr                 
    String flag_string = ReqUtil.get(request, "kx_operation_bunch");      //可选套餐的生效方式串        9 可选套餐的变更串 iAddSendStr                                       
    String favour = ReqUtil.get(request, "favorcode");               //优惠代码			10 优惠代码 iFavourCde                         
    String realcash = ReqUtil.get(request, "i19");                     //实际手续费	 	11 实交手续费 iRealFee                         
    String fircash = ReqUtil.get(request, "i20");                      //固定手续费	 	12 应交手续费 iShouldFee                       
    String sysnote = ReqUtil.get(request, "sysnote");                  //系统备注		13 系统日志 iSysNote                           
    String donote = ReqUtil.get(request, "tonote");                    //操作备注		14 操作日志 iOpNote                            
    String stream = ReqUtil.get(request, "stream");                    //系统流水		15 打印流水 iLoginAccept                                                
    String ip = WtcUtil.repNull((String) session.getAttribute("ipAddr"));                                           //登陆IP		    16 登录IP  iIpAddr                            										
    String add_stream_str = ReqUtil.get(request, "kx_stream_bunch");      //原可选套餐的开通流水串     17 可选套餐的开通流水  iOldAcceptStr          
    String main_cash_stream = ReqUtil.get(request, "main_cash_stream");//当前主套餐开通流水			18 当前主套餐开通流水  iCurModeAccept         
    String next_main_cash = ReqUtil.get(request, "next_main_cash");    //下月主套餐        			19         下月主套餐          iNextMode              
    String next_main_stream = ReqUtil.get(request, "next_main_stream");//下月主套餐开通流水			20 下月主套餐开通流水  iNextModeAccept 
    String iAddRateStr = ReqUtil.get(request, "iAddRateStr");//iAddRateStr说明:  'A001^8032:'  A001是二次批价代码，8032是关联信息如小区代码等
    float handcash = Float.parseFloat(realcash);                     //手续费单精度 
	String cnttOpName = ReqUtil.get(request, "cnttOpName");
    String flag_code = ReqUtil.get(request, "flag_code");
    String rateCode = ReqUtil.get(request, "rateCode");

    String rateFlag = rateCode + "$" + flag_code + "$" + "&";
    String thework_no = work_no;
%>
<%
		/*****     end     ******/

    String service_name = "";
    String pay_type = "", year_fee = "", prepay_fee = "", month_num = "", card_type = "", card_name = "", old_accept = "", contract_no = "", iOpType = "", bind_cust_name = "";
    Vector vec;
    /**拆分iAddStr**/
    vec = (Vector) splitString("|", iadd_str);
    if (theop_code.equals("1255") || theop_code.equals("1259")) {
        //iAddStr格式 pay_type|year_fee|prepay_fee|year_month|card_type|card_name 其中card_type、card_name用于随E行包年
        pay_type = (String) vec.get(0);//包年付费代码 iPayType
        year_fee = (String) vec.get(1);//包年应缴金额 iYearFee
        prepay_fee = (String) vec.get(2);//包年实缴金额            iPrepayFee
        month_num = (String) vec.get(3);//包年月数                iMonthNum
        card_type = (String) vec.get(4);//数据卡类型              iCardType  
        card_name = (String) vec.get(5);//数据卡名称              iCardName
    } else if (theop_code.equals("1201")) {
        //iAddStr格式 pay_type|year_fee|prepay_fee|year_month|card_type|card_name|bind_cust_name 其中card_type、card_name用于随E行包年
        pay_type = (String) vec.get(0);//包年付费代码 iPayType
        year_fee = (String) vec.get(1);//包年应缴金额 iYearFee
        prepay_fee = (String) vec.get(2);//包年实缴金额            iPrepayFee
        month_num = (String) vec.get(3);//包年月数                iMonthNum
        card_type = (String) vec.get(4);//数据卡类型              iCardType  
        card_name = (String) vec.get(5);//数据卡名称              iCardName
        bind_cust_name = (String) vec.get(6);//被绑定的手机用户名              
    } else if (theop_code.equals("1257") || theop_code.equals("1258") || theop_code.equals("125a")) {
        //iAddStr格式 pay_type|year_fee|prepay_fee|iOldAccept|iContractNo|iOpType 
        pay_type = (String) vec.get(0);//包年付费代码 iPayType
        year_fee = (String) vec.get(1);//包年应缴金额 iYearFee
        prepay_fee = (String) vec.get(2);//包年实缴金额            iPrepayFee
        old_accept = (String) vec.get(3);//包年流水                iOldAccept
        contract_no = (String) vec.get(4);//包年专用账户            iContractNo
        iOpType = (String) vec.get(5);//操作类型                iOpType     C:取消 D:冲正
    }
    String errCode = "";
    String errMsg = "";
    String paraAray[] = new String[]{};
    if (theop_code.equals("1255") || theop_code.equals("1259") || theop_code.equals("1201")) {           				
        paraAray = new String[28];
                                                                         	
        service_name = "s1255Cfm";
                                                                         	
        paraAray[0] = work_no;                // 0  操作工号                iLoginNo
                       	
        paraAray[1] = pass;                // @wt          1  工号密码                iLoginPwd
            	
        paraAray[2] = theop_code;                //@wt          2                          iOpCode
         	
        paraAray[3] = themob;                //@wt          3  移动号码                iPhoneNo
            	
        paraAray[4] = maincash;//  @wt          4  当前主套餐代码          iOldMode
                        	
        paraAray[5] = old_cash;//@wt          5  新主套餐代码            iNewMode
                          	
        paraAray[6] = maincash_flag;//@wt          6  主套餐变更的生效方式    iSendFlag
                    	
        paraAray[7] = addcash_string;//@wt          7  可选套餐的代码串        iAddModeStr
                 	
        paraAray[8] = do_string;//@wt          8  可选套餐的状态串        iAddStatusStr
                    	
        paraAray[9] = flag_string;//@wt          9  可选套餐的生效方式串    iAddSendStr
                    	
        paraAray[10] = favour;//@wt          10 优惠代码                iFavourCde
                         	
        paraAray[11] = realcash;//@wt          11 实交手续费              iRealFee
                         	
        paraAray[12] = fircash;//@wt          12 应交手续费              iShouldFee
                        	
        paraAray[13] = sysnote;//@wt          13 系统日志                iSysNote
                          	
        paraAray[14] = donote;//@wt          14 操作日志                iOpNote
                            	
        paraAray[15] = stream;//@wt          15 打印流水                iLoginAccept
                       	
        paraAray[16] = ipAddr;//@wt          16 登录IP                  iIpAddr
                            	
        paraAray[17] = add_stream_str;//@wt          17 可选套餐的开通流水      iOldAcceptStr
              	
        paraAray[18] = main_cash_stream;//@wt          18 当前主套餐开通流水      iCurModeAccept
           	
        paraAray[19] = next_main_cash;//@wt          19 下月主套餐              iNextMode
                  	
        paraAray[20] = next_main_stream;//@wt          20 下月主套餐开通流水      iNextModeAccept
          	
        paraAray[21] = pay_type;//@wt          21 包年付费代码            iPayType
                         	
        paraAray[22] = year_fee;//@wt          22 包年应缴金额            iYearFee
                         	
        paraAray[23] = prepay_fee;//@wt          23 包年实缴金额            iPrepayFee
                     	
        paraAray[24] = month_num;//@wt          24 包年月数                iMonthNum
                       	
        paraAray[25] = card_type;//25 数据卡类型              iCardType
                                    	
        paraAray[26] = card_name;//26 数据卡名称              iCardName
                                    	
        paraAray[27] = rateFlag;//27 iAddRateStr   保留字段
                                                	
 %>
                                                                                                        	
			<wtc:service name="s1255Cfm" routerKey="phone" routerValue="<%=themob%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
				<wtc:param value="<%=paraAray[15]%>"/>
				<wtc:param value=" " />
				<wtc:param value="<%=paraAray[2]%>"/>
				<wtc:param value="<%=paraAray[0]%>"/>
				<wtc:param value="<%=paraAray[1]%>"/>
				<wtc:param value="<%=paraAray[3]%>"/>
			    <wtc:param value=" " />  						 
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
			</wtc:service>
			<wtc:array id="s1255CfmArr" scope="end"/>
<%   
			errCode = retCode1!=""?retCode1:errCode;
			errMsg = retMsg1;    

    } else if (theop_code.equals("1257") || theop_code.equals("1258") || theop_code.equals("125a")) {
        paraAray = new String[29];
        service_name = "s1257Cfm";
        paraAray[3] = work_no;                // 0  操作工号                iLoginNo
        paraAray[4] = pass;                // @wt          1  工号密码                iLoginPwd
        paraAray[2] = theop_code;                //@wt          2                          iOpCode
        paraAray[5] = themob;                //@wt          3  移动号码                iPhoneNo
        paraAray[7] = maincash;//  @wt          4  当前主套餐代码          iOldMode
        paraAray[8] = old_cash;//@wt          5  新主套餐代码            iNewMode
        paraAray[9] = maincash_flag;//@wt          6  主套餐变更的生效方式    iSendFlag
        paraAray[10] = addcash_string;//@wt          7  可选套餐的代码串        iAddModeStr
        paraAray[11] = do_string;//@wt          8  可选套餐的状态串        iAddStatusStr
        paraAray[12] = flag_string;//@wt          9  可选套餐的生效方式串    iAddSendStr
        paraAray[13] = favour;//@wt          10 优惠代码                iFavourCde
        paraAray[14] = realcash;//@wt          11 实交手续费              iRealFee
        paraAray[15] = fircash;//@wt          12 应交手续费              iShouldFee
        paraAray[16] = sysnote;//@wt          13 系统日志                iSysNote
        paraAray[17] = donote;//@wt          14 操作日志                iOpNote
        paraAray[0] = stream;//@wt          15 打印流水                iLoginAccept
        paraAray[18] = ipAddr;//@wt          16 登录IP                  iIpAddr
        paraAray[19] = add_stream_str;//@wt          17 可选套餐的开通流水      iOldAcceptStr
        paraAray[20] = main_cash_stream;//@wt          18 当前主套餐开通流水      iCurModeAccept
        paraAray[21] = next_main_cash;//@wt          19 下月主套餐              iNextMode
        paraAray[22] = next_main_stream;//@wt          20 下月主套餐开通流水      iNextModeAccept
        paraAray[23] = pay_type;//@wt          21 包年付费代码            iPayType
        paraAray[24] = year_fee;//@wt          22 包年应缴金额            iYearFee
        paraAray[25] = prepay_fee;//@wt          23 包年实缴金额            iPrepayFee
        paraAray[26] = old_accept;//@wt          24 包年流水                iOldAccept
        paraAray[27] = contract_no;//25 包年专用账户            iContractNo
        //paraAray[26] = iOpType;//26 操作类型                iOpType     C:取消 D:冲正
        paraAray[28] = rateFlag;//27 iAddRateStr   保留字段
        
        
        for(int i=0; i<29; i++){
        
        	System.out.println("mylog - -- - - "+ i +"   ---"+paraAray[i]);
        
        
        }
        
        
 %>
			<wtc:service name="s1257CfmPM" routerKey="phone" routerValue="<%=themob%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
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
			</wtc:service>
			<wtc:array id="s1257CfmArr" scope="end"/>
<% 
			errCode = retCode1!=""?retCode1:errCode;
			errMsg = retMsg1; 
    }
    
    System.out.println("---------------------------errCode---------------------"+errCode);
    System.out.println("---------------------------errMsg----------------------"+errMsg);
    /***********记录统一接触开始************/
		
		String cnttLoginAccept =stream;//服务没有返回流水
		String cnttRetCode = String.valueOf(errCode);	
		String cnttWorkNo = work_no;
		String cnttActivePhone = themob;
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+cnttRetCode+"&opName="+cnttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
    /*************************************获得打印发票的参数****************************************/
    String cardno = ReqUtil.get(request, "i7");                        //身份证号码
    //themob = ReqUtil.get(request,"i1");						  //移动号码
    String name = ReqUtil.get(request, "i4");                        //用户名称
    String address = ReqUtil.get(request, "i5");                      //用户地址
    //realcash = ReqUtil.get(request,"i19");   				  //手续费
    //stream = ReqUtil.get(request,"stream");                    //系统流水 
    float fPrepayFee = Float.parseFloat(prepay_fee);//包年金额
    //String chinaFee = ((String[][]) (callView.view_sToChinaFee(formatNumber(prepay_fee, 2)).get(0)))[0][2];//大写金额
 %>
			<wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=themob%>" outnum="3" >
			<wtc:param value="<%=formatNumber(prepay_fee, 2)%>"/>
			</wtc:service>
			<wtc:array id="sToChinaFeeArr" scope="end"/>
<%    
		String chinaFee = "";
		if(sToChinaFeeArr.length>0){
			chinaFee = sToChinaFeeArr[0][2];
		}
    //用户名称  手机号 机型
    String conf_flag = "", bind_phone_no = "", cust_name = "", phone_no = "", machine_name = "";
    if (theop_code.equals("1201")) {
        vec = (Vector) splitString("~", card_name);
        machine_name = (String) vec.get(0);
        conf_flag = (String) vec.get(1);
        bind_phone_no = (String) vec.get(2);
        if (conf_flag.equals("01")) {
            cust_name = bind_cust_name;
            phone_no = bind_phone_no;
        } else {
            cust_name = name;
            phone_no = themob;
        }
    }

/***********************************************************************************************/
%>
<script language="jscript">
    function printBill() {
        var infoStr = "";
        infoStr += "<%=work_no%>  <%=stream%>" + "  随意行包年" + "|";//工号                                          
        infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";//年
        infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";//月
        infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";//日

        infoStr += "<%=cust_name%>" + "|";//用户名称 
        infoStr += " " + "|";//卡号

        infoStr += "<%=phone_no%>" + "|";//移动号码 
        infoStr += " " + "|";//协议号码                                                          
        infoStr += " " + "|";//支票号码  

        infoStr += "<%=chinaFee%>" + "|";//合计金额(大写)
        infoStr += "<%=formatNumber(prepay_fee,2)%>" + "|";//小写

        infoStr += "交纳金额：  <%=formatNumber(prepay_fee,2)%>" +
                   "~~型号：<%=card_type%>  <%=machine_name%>" + "|";//项目

        infoStr += "<%=work_name%>" + "|";//开票人
        infoStr += " " + "|";//收款人

        var dirtPage = "/npage/bill/f1201_login.jsp";

        location = "/npage/public/hljBillPrint.jsp?retInfo=" + infoStr + "&dirtPage=" + dirtPage;
    }
</script>
<%if(errCode.equals("000000") && theop_code.equals("1201")) {%>
<script language="javascript">
    rdShowMessageDialog("包年申请操作成功！打印发票.......",2);
    printBill();
</script>
<%} else if(errCode.equals("000000")) {%>
<script language="javascript">
    rdShowMessageDialog("<%=cnttOpName%>操作成功！",2);
    removeCurrentTab();
</script>
<%} else {%>
<script language="jscript">
    rdShowMessageDialog("包年申请操作失败!<br>errCode:<%=errCode%>" + "<br>服务信息：<%=errMsg%>",0);
    history.go(-1);
</script>
<%}%>

