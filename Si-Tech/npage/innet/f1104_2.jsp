<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.03
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
  /**  //从session里取数据
  ArrayList arr = (ArrayList)session.getAttribute("allArr");
  String[][] agentInfo = (String[][])arr.get(2);
  String[][] baseInfo = (String[][])arr.get(0);
  String[][] the_pass = (String[][])arr.get(4);
  String login_pass = the_pass[0][0];
  String orgCode = baseInfo[0][16];                  //工号归属
  String org_id = baseInfo[0][23];
  String ip_Addr22 = agentInfo[0][2];
  String groupId = baseInfo[0][21];
  String Department = baseInfo[0][16];
  String belongCode = Department.substring(0,7);
  
  String thework_no = request.getParameter("workno");
  String stream=request.getParameter("sysAccept");
  String themob=request.getParameter("phoneNo");
  String theop_code="1104";
  **/
  
  
  
      
    String opCode = "1104";
    String opName = "普通开户";
    String login_pass = (String)session.getAttribute("password");
    String org_id =(String)session.getAttribute("orgId");
    String ip_Addr22 =(String)session.getAttribute("ipAddr");
    String groupId =(String)session.getAttribute("groupId");
    String orgCode =(String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String belongCode =orgCode.substring(0,7);
    String thework_no = request.getParameter("workno");
    String stream=request.getParameter("sysAccept");
    String themob=request.getParameter("phoneNo");
    String theop_code="1104";
  
  
  

  %>
  <%

  //得到输入参数
   // Logger logger = Logger.getLogger("f1104_2.jsp");
   // ArrayList retArray = new ArrayList();
   // String return_code,return_message,total_date,login_accept,delay_time;
    String total_date,login_accept,delay_time;
  //  String[][] result = new String[][]{};
  //  S1100View callView = new S1100View();
    String[] ret = new String[]{};
  //  SPubCallSvrImpl impl = new SPubCallSvrImpl(); 
    
    String workno = request.getParameter("workno");                 //操作员工号
    String ip_Addr = request.getParameter("ip_Addr");               //操作员工号
    String opcode = "1104";                                         //操作代码
    String custId = request.getParameter("custId");                 //客户ID
    String custPwd =WtcUtil.repStr(request.getParameter("custPwd")," ");  //客户密码
    String idIccid = request.getParameter("idIccid");               //证件号码
    String idType = request.getParameter("idType");                 //证件类型
    System.out.println("idType  在f1104_2.jsp里面得到的值 "+idType);
    String custName = request.getParameter("custName");             //客户名称
    String custAddr = request.getParameter("custAddr");             //客户地址
    //客户信息拼串
    //custName = custName.replaceAll("~","");
    //custAddr = custAddr.replaceAll("~","");
    //idType = idType.replaceAll("~","");
    //idIccid = idIccid.replaceAll("~","");
    String cust_infoa=custName+"~"+custAddr+"~"+idType+"~"+idIccid+"~";
  String operType = request.getParameter("operType");             //业务品牌
    String innetCode = request.getParameter("innetCode");           //入网代码 代码入-网费-入网预存
    innetCode = innetCode.substring(0,innetCode.indexOf("-"));
    String credId = request.getParameter("hid_CredId");       //凭证序列号    
    String machCode = request.getParameter("machCode");             //机器代码
    if((machCode.trim()).compareTo("") == 0)
    {     machCode = " ";         }    
    String simType = request.getParameter("simType");               //SIM卡类型
    String simNo = request.getParameter("simNo");                   //SIM卡号
    String phoneNo = request.getParameter("phoneNo");  
    System.out.println("ssssssssssssssssssssssss");             //手机号码
    System.out.println(phoneNo);
    String payWay = request.getParameter("payWay");                 //资费方式
  String serviceResult = request.getParameter("serviceResult");   //特服定购
    String userId = request.getParameter("userID");                 //用户ID
    String userPwd =WtcUtil.repStr(request.getParameter("userPwd")," "); //用户密码
    String accountId = request.getParameter("accountID");           //帐户ID
    String accountPwd = userPwd;
    String billType = request.getParameter("upBillType");           //出帐周期
    String postFlag = request.getParameter("postFlag");             //邮寄标志
    String postType = request.getParameter("postType");             //邮寄类型
    String postName = request.getParameter("postName");             //收件人名称
    String postFax = request.getParameter("postFax");               //邮寄传真

    if(postFax==null)
    { postFax = " ";    
    }
    String postMail = request.getParameter("postMail");             //邮寄Email
    if(postMail==null)
    { postMail = " ";   }   
    String postAdd = request.getParameter("postAdd");               //邮寄地址
    if(postAdd==null)
    { postAdd = " ";    }    
    String postZip = request.getParameter("postZip");               //邮寄邮编
    if(postZip==null)
    { postZip = " ";    }    
    String assuIdType = request.getParameter("assuIdType");         //担保人证件类型
    if(assuIdType.indexOf("|") > -1)
    {
      assuIdType = assuIdType.substring(0,assuIdType.indexOf("|"));
    }
    String assuId = request.getParameter("assuId");                 //担保人证件号码
    String assuName = request.getParameter("assuName");             //担保人名称
    String assuPhone = request.getParameter("assuPhone");           //担保人电话
    String assuZip = request.getParameter("assuZip");             //担保人邮编
    String assuAddr = request.getParameter("assuAddr");             //担保人通讯地址
    if((assuId.compareTo("") != 0)&&(assuPhone.compareTo("")==0))
    { assuPhone = " ";    }
    if((assuId.compareTo("") != 0)&&(assuName.compareTo("")==0))
    { assuName = " ";   }
    if((assuId.compareTo("") != 0)&&(assuZip.compareTo("")==0))
    { assuZip = " ";    }
    if((assuId.compareTo("") != 0)&&(assuAddr.compareTo("")==0))
    { assuAddr = " ";   }      
    String innetFee = request.getParameter("innetFee");             //入网费
    String handFee = request.getParameter("handFee");               //手续费
    String choiceFee = request.getParameter("choiceFee");           //选号费
    String prepayFee = request.getParameter("prepayFee");           //预付费
    String machFee = request.getParameter("machFee");               //机器费
    String simFee = request.getParameter("simFee");                 //SIM卡费
    String choicePreFee= request.getParameter("choicePreFee"); 
    
    String hid_innetFee = request.getParameter("hid_innetFee");     //修改入网费
    String hid_HandFee = request.getParameter("hid_HandFee");       //修改手续费
    String hid_ChoiceFee = request.getParameter("hid_ChoiceFee");   //修改选号费
    String hid_MachFee = request.getParameter("hid_MachFee");       //修改机器费
    String hid_SimFee = request.getParameter("hid_SimFee");         //修改SIM卡费    
    String favourableTime = request.getParameter("favourableTime");         //当前系统时间
    String hid_favourableTime = request.getParameter("hid_favourableTime"); //优惠时间
    String strCardSum = request.getParameter("largess_card_sum");         //赠送充值卡的数
    
    String cashPay = request.getParameter("cashPay");               //现金交款
    String bankCode = request.getParameter("bankCode");             //银行代码
    if((bankCode.trim()).compareTo("") == 0)    
    {   bankCode = "zzz";              }    
    String checkNo = request.getParameter("checkNo");               //支票号码
    if((checkNo.trim()).compareTo("") == 0)
    {   checkNo = "zzz";              }
    String checkPay = request.getParameter("checkPay");             //支票交款
    if((checkPay.trim()).compareTo("") == 0)
    {   checkPay = "0.00";             }
    String sumPay = request.getParameter("sumPay");                 //合计费用
    
    String sysNote = request.getParameter("sysNote");               //系统备注
    String opNote = request.getParameter("opNote");                 //操作备注      
    if(opNote.equals("")){opNote="普通开户";}            

    String payCode = request.getParameter("payCode");               //主资费代码
    String additiveCode = request.getParameter("additiveCode");     //可选资费代码
    String rentpayCode = request.getParameter("rentpayCode");       //租机时的附加资费代码
  String bindModeCode=request.getParameter("bindModeCode");       //绑定附加资费
  String bindModeName=request.getParameter("bindModeName");       //绑定附加资费
  String innetPreFee = request.getParameter("innetPreFee");   //入网预存费

String strHasEval = request.getParameter("haseval");//是否有用户满意度评价 
String strEvalCode = request.getParameter("evalcode");//用户满意度评价代码 

System.out.println("test"); 
  //给主资费和可选资费拼串，第一个是主，后面的是可选
  String[] tp_rentpayCode = new String[50];
  tp_rentpayCode[0]=payCode;
  StringTokenizer additiveCodeToken = new StringTokenizer(additiveCode,"~");
  int additiveCodeLength = additiveCodeToken.countTokens();
  for(int i=1;i<=additiveCodeLength;i++)
  {
    tp_rentpayCode[i] = (String)additiveCodeToken.nextElement();
    System.out.println("tp_rentpayCode[i]tp_rentpayCode[i]="+tp_rentpayCode[i]);
  }
  String[] tp_rentpayCode_1 = new String[]{};//产品价格因字串
  String[] tp_rentpayCode_2 = new String[]{};//产品属性串
  String[] tp_rentpayCode_3 = new String[]{};//产品类型
  String[] tp_rentpayCode_4 = new String[]{};//服务代码
  String[] tp_rentpayCode_5 = new String[]{};//服务属性串
  String serviceNow = request.getParameter("serviceNow");         //立即生效特服    
  String serviceAfter = request.getParameter("serviceAfter");     //预约生效特服 
  String serviceAddNo = request.getParameter("serviceAddNo");     //附加号码特服 
  String sysAccept = request.getParameter("sysAccept");         //得到操作流水

  String machineType=request.getParameter("hidMachineType");      //得到机器代码
  String tfFlag=request.getParameter("tfFlag");                   //特服选择标志
  machineType+=tfFlag;
  String pack_creditNo=WtcUtil.repStr(request.getParameter("pack_creditNo"),"0");//营销包凭证号

    String pLogin_No = workno;
        String pip_Addr = ip_Addr;  
        String pOp_Code = opcode;  
        String pSys_Note = sysNote;  
        String pOp_Note = opNote;    
        String pPhone_No = phoneNo;
        String pSim_Type = simType;
        String pSim_No = simNo;         
        String pBelong_Code = belongCode;
        String pCust_Id = custId;    
        String pId_No = userId;      
        String pCon_Id = accountId; 
    String pCust_Passwd = (String)Encrypt.encrypt(custPwd);   
        String pUser_Passwd = (String)Encrypt.encrypt(userPwd);
        String pCon_Passwd = (String)Encrypt.encrypt(accountPwd); 
        String pCBXCustInfo = "";
        String checkRadio=WtcUtil.repNull(request.getParameter("checkRadio"));
        String cardtype_bz=request.getParameter("cardtype_bz");//空卡标志
    String spayType="0";
    if(!(checkRadio.trim().equals(""))) spayType="6";
        //客户信息串:业务品牌代码~服务类型~信誉度~用户属性~
        //信誉度代码~信誉度值~付费代码~付费类型~帐务类型~
        //权限值~入网类型~机器代码~其它属性~支票号码~银行代码       
        String custGrade = request.getParameter("custGrade"); //用户属性(服务中的attr_code)
        //operType = operType.replaceAll("~","");
        //custGrade = custGrade.replaceAll("~","");
        //spayType = spayType.replaceAll("~","");
       // billType = billType.replaceAll("~","");
       // innetCode = innetCode.replaceAll("~","");
       // machCode = machCode.replaceAll("~","");
       // checkNo = checkNo.replaceAll("~","");
       // bankCode = bankCode.replaceAll("~","");
        //custGrade = custGrade.replaceAll("~","");
        String serviceType=request.getParameter("serviceType");
       // serviceType = serviceType.replaceAll("~","");
        String xinYiDu=request.getParameter("xinYiDu");
       // xinYiDu = xinYiDu.replaceAll("~","");
        String pCust_List = operType + "~" + serviceType + "~" + xinYiDu + "~" +custGrade+"000Y" + "~" + 
                "E" + "~" + "0" + "~" + "0" + "~" + spayType + "~" + billType + "~" + 
                "1" + "~" + innetCode + "~" + machCode + "~" + "01" + "~" + checkNo + "~" + bankCode + "~"+custGrade+"~"; 
        //担保信息串:担保人姓名~担保人证件类型~担保人证件~担保人电话~担保人地址~担保人邮编~
        //assuName = assuName.replaceAll("~","");
        //assuIdType = assuIdType.replaceAll("~","");
       // assuId = assuId.replaceAll("~","");
       // assuPhone = assuPhone.replaceAll("~","");
       // assuAddr = assuAddr.replaceAll("~","");
       // assuZip = assuZip.replaceAll("~","");
        
        String pAssure_List = assuName + "~" + assuIdType + "~" + assuId + "~" +
                assuPhone + "~" + assuAddr + "~" + assuZip + "~"; 
        //邮寄帐单信息串:邮寄帐单标志~邮寄帐单类型~邮寄帐单地址~邮寄帐单邮编~邮寄帐单传真~邮寄帐单Mail~                
        String pPost_List = "";
        //postFlag = postFlag.replaceAll("~","");
        //postType = postType.replaceAll("~","");
       // postAdd = postAdd.replaceAll("~","");
       // postZip = postZip.replaceAll("~","");
       // postFax = postFax.replaceAll("~","");
       // postMail = postMail.replaceAll("~","");
        if(postFlag.compareTo("0") != 0)
        {    
            pPost_List = postFlag + "~" + postType + "~" + postAdd + "~" + 
                postZip + "~" + postFax + "~" + postMail + "~";
        }        
        //费用信息串:现金交款~支票交款~预存款~SIM卡费~机器费~入网费~选号费~其它费~手续费~    
        
        //checkPay = checkPay.replaceAll("~","");
       // prepayFee = prepayFee.replaceAll("~","");
       // simFee = simFee.replaceAll("~","");
       // machFee = machFee.replaceAll("~","");
       // choiceFee = choiceFee.replaceAll("~","");
       // handFee = handFee.replaceAll("~","");
       // innetFee = innetFee.replaceAll("~","");
    String cashPayService =   String.valueOf(Double.parseDouble(cashPay) - Double.parseDouble(prepayFee));
        //cashPayService = cashPayService.replaceAll("~","");
        String pFee_List = cashPayService + "~" + checkPay + "~" + prepayFee + "~" +
                 simFee + "~" + machFee + "~" + "0.00" + "~" + choiceFee + "~" +
                 "0.00" + "~" + handFee + "~"; 
        //优惠信息串
        String  pfavourable_List = "";
    pfavourable_List = simFee + "~" + machFee  +"~" +innetFee+ "~"+choiceFee+"~"+handFee+"~"; 
         //套餐信息串
        //payCode = payCode.replaceAll("~","");
       // additiveCode = additiveCode.replaceAll("~","");
        //rentpayCode = rentpayCode.replaceAll("~","");
       // bindModeCode = bindModeCode.replaceAll("~",""); 
    String pPackage_List = payCode + "~" + additiveCode + "~"+rentpayCode+"~"+bindModeCode+"~";
        //特服信息串（立即生效特服）            
        String pFunc_List = serviceNow;        
        //特服信息串（预约特服）  
        String pUnUsedFunc_List = serviceAfter;
        //特服信息串（短号码特服）  
        String pAddAddFunc_List = serviceAddNo;
        //随e性信息串:凭证系列号~ Gprs套餐 ~ WLAN套餐
        //credId = credId.replaceAll("~",""); 
        String E_DataList = credId + "~~~";
        if(credId.compareTo("") == 0)
        { E_DataList = "";  }
    
    String str1=WtcUtil.repStr(request.getParameter("str1")," ");
    String str2=WtcUtil.repStr(request.getParameter("str2")," ");
    String str3=WtcUtil.repStr(request.getParameter("str3")," ");
    String ss= request.getParameter("str3");
    String str4=WtcUtil.repStr(request.getParameter("str4")," ");
    String str5=WtcUtil.repStr(request.getParameter("str5")," ");
    String str6=WtcUtil.repStr(request.getParameter("str6")," ");

  //  SPubCallSvrImpl callSvrImpl = new SPubCallSvrImpl();
    ArrayList paraStrIn = new ArrayList();
    String outParaNums;

    String customType = request.getParameter("customType");
    String chinaInfoList;
    if (request.getParameter("innettype").equals("02")){
      chinaInfoList=request.getParameter("szxsim")+"~"+request.getParameter("szxcode")+"~"+request.getParameter("czkye");
    }
    else{
      chinaInfoList="";
    }
    String is_sms_call = "N";
    String is_not_adward = "";
    String has_cailing = "";
    String has_card = "";
    String cardStatus=request.getParameter("cardstatus");
    //if(Float.parseFloat(innetPreFee)>0.00)
    //{
        is_not_adward = request.getParameter("is_not_adward");  //是否参与抽奖
    //}else{
      //is_not_adward = "L";
    //}
    has_cailing = request.getParameter("has_cailing");  //免费体验彩铃
    has_card = request.getParameter("largess_card");  //赠送充值卡
    String twoFlag = is_sms_call + is_not_adward + has_cailing+has_card;
    System.out.println("twoFlag="+twoFlag);
    System.out.println("has_cailing="+has_cailing);
    //客户信息串的补充处理
    pCust_List = pCust_List+request.getParameter("innettype")+"~";

    //**************为服务压入参数*********************/
   
    
    //String retMessage = "";
    //int ret_code=0;
    String[] retArr=null;
    String serviceName="s1104Cfm";
    String outParaNum="2";
    String vAwardMsg="";
/**   try{             //  被wtc替换  2008.09.03  liutong
      
      retArr = callSvrImpl.callService(serviceName, paraStrIn, outParaNum);
      callSvrImpl.printRetValue();
          ret_code = callSvrImpl.getErrCode();
          retMessage = callSvrImpl.getErrMsg();
    
        
      
      vAwardMsg = retArr[1];
    }catch(Exception e){
      logger.error("Call service(s1104Cfm) is Failed!");
    }
**/
String tmpttt="";
System.out.println("开始调用服务s1104Cfm  in f1104_2.jsp ****************************************");
%>
       <wtc:service name="s1104Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="50" >
				<wtc:params value="<%=new String[]{sysAccept}%>"/>
				<wtc:params value="<%=new String[]{pOp_Code}%>"/>
				<wtc:params value="<%=new String[]{pLogin_No}%>"/>
				<wtc:params value="<%=new String[]{login_pass}%>"/>
				<wtc:params value="<%=new String[]{orgCode}%>"/>
				<wtc:params value="<%=new String[]{org_id}%>"/>
				<wtc:params value="<%=new String[]{ip_Addr22}%>"/>
				<wtc:params value="<%=new String[]{pSys_Note}%>"/>
				<wtc:params value="<%=new String[]{pOp_Note}%>"/>
				<wtc:params value="<%=new String[]{pPhone_No}%>"/>
				<wtc:params value="<%=new String[]{pSim_Type}%>"/>
				<wtc:params value="<%=new String[]{pSim_No}%>"/>
				<wtc:params value="<%=new String[]{pBelong_Code}%>"/>
				<wtc:params value="<%=new String[]{pCust_Id}%>"/>
				<wtc:params value="<%=new String[]{groupId}%>"/>
				<wtc:params value="<%=new String[]{pId_No}%>"/>
				<wtc:params value="<%=new String[]{pCon_Id}%>"/>
				<wtc:params value="<%=new String[]{pCust_Passwd}%>"/>
				<wtc:params value="<%=new String[]{pUser_Passwd}%>"/>
				<wtc:params value="<%=new String[]{pCon_Passwd}%>"/>
				<wtc:params value="<%=new String[]{pCust_List}%>"/>
				<wtc:params value="<%=new String[]{pAssure_List}%>"/>
				<wtc:params value="<%=new String[]{pPost_List}%>"/>
				<wtc:params value="<%=new String[]{pFee_List}%>"/>
				<wtc:params value="<%=new String[]{pfavourable_List}%>"/>
				<wtc:params value="<%=new String[]{E_DataList}%>"/>
				<wtc:params value="<%=new String[]{machineType}%>"/>
				<wtc:params value="<%=new String[]{pack_creditNo}%>"/>
				<wtc:params value="<%=new String[]{cust_infoa}%>"/>
				<wtc:params value="<%=new String[]{customType}%>"/>
				<wtc:params value="<%=new String[]{str1}%>"/>
				<wtc:params value="<%=new String[]{str2}%>"/>
				<wtc:params value="<%=new String[]{str3}%>"/>
				<wtc:params value="<%=new String[]{str4}%>"/>
				<wtc:params value="<%=new String[]{str5}%>"/>
				<wtc:params value="<%=new String[]{chinaInfoList}%>"/>
				<wtc:params value="<%=new String[]{twoFlag}%>"/>
				<wtc:params value="<%=tp_rentpayCode%>"/>
				<wtc:params value="<%=new String[]{tmpttt}%>"/>
				<wtc:params value="<%=new String[]{tmpttt}%>"/>
				<wtc:params value="<%=new String[]{tmpttt}%>"/>
				<wtc:params value="<%=new String[]{tmpttt}%>"/>
				<wtc:params value="<%=new String[]{tmpttt}%>"/>
				<wtc:params value="<%=new String[]{serviceNow}%>"/>
				<wtc:params value="<%=new String[]{serviceAfter}%>"/>
				<wtc:params value="<%=new String[]{serviceAddNo}%>"/>
				<wtc:params value="<%=new String[]{tmpttt}%>"/>
				<wtc:params value="<%=new String[]{cardtype_bz}%>"/>
				<wtc:params value="<%=new String[]{cardStatus}%>"/>
				
  </wtc:service>
      <wtc:array id="result" scope="end" />

<%
System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String retCodeForCntt = ret_code ;
		String retMsgForCntt=retMessage;
		String loginAccept =""; 
		
		if(ret_code.equals("0")||ret_code.equals("000000")){
			if(result.length>0){
			   loginAccept=result[0][0];
			}
		}
		
		String url = "/npage/contact/onceCnttInfo.jsp?opCode="+pOp_Code+"&retCodeForCntt="+retCodeForCntt+"&retMsgForCntt="+retMsgForCntt+"&opName="+opName+"&workNo="+pLogin_No+"&loginAccept="+loginAccept+"&pageActivePhone="+pPhone_No+"&opBeginTime="+opBeginTime+"&contactId="+pPhone_No+"&contactType=cust";
		System.out.println("url="+url);
		
		%>
		<jsp:include page="<%=url%>" flush="true" />
		<%
System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	
	
	
	
	
System.out.println(ret_code);
          if(ret_code.equals("0")||ret_code.equals("000000")){
          System.out.println("调用服务s1104Cfm in f1104_2.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
            vAwardMsg=result[0][0];
            
        }else{
          System.out.println(ret_code+"     System.out.println(ret_code);");
          System.out.println(retMessage+"     System.out.println(retMessage);");
          System.out.println("调用服务s1104Cfm in f1104_2.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
      }


  //===========================================
  //组织打印数据开始
  if(cashPay==null || cashPay.trim().equals("")) cashPay="0";
  if(checkPay==null || checkPay.trim().equals("")) checkPay="0";
  String chinaFee = "";
  String busi_sumPay=String.valueOf(Double.parseDouble(innetPreFee)+Double.parseDouble(handFee)+Double.parseDouble(choiceFee)+Double.parseDouble(machFee)+Double.parseDouble(simFee)+Double.parseDouble(choicePreFee));
  String printInfo = "";
    String fee_sumPay=String.valueOf(Double.parseDouble(prepayFee));
  String note = custId + phoneNo + "普通开户" + "现金款:" + WtcUtil.formatNumber(cashPay,2) + "支票款:" + WtcUtil.formatNumber(checkPay,2);
  if(Double.parseDouble(busi_sumPay)>0.01)
  {
    printInfo="64|5|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
    printInfo += "72|5|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
    printInfo += "77|5|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";
    printInfo = printInfo + "16|5|9|0|" + workno + "|";            //工号
    printInfo = printInfo + "24|5|9|0|" + sysAccept + "|";         //流水
    if(operType.equals("dn")){
      printInfo = printInfo + "35|5|9|0|" + "动感地带普通开户交费明细" + "|";  
    }else if(operType.equals("gn")){
      printInfo = printInfo + "35|5|9|0|" + "全球通普通开户交费明细" + "|";  //全球通开户交费明细
    }else if(operType.equals("zn")){  
      printInfo = printInfo + "35|5|9|0|" + "神州行普通开户交费明细" + "|";
    }

      printInfo = printInfo + "16|8|10|0|" + custName + "|";         //用户名
    printInfo = printInfo + "16|11|10|0|" + phoneNo + "|";         //手机号
    printInfo = printInfo + "50|11|10|0|" + userId + "|";        //协议号码
    if((checkNo.trim()).compareTo("zzz") == 0)
    {   checkNo = "";              }
    printInfo = printInfo + "73|11|10|0|" + checkNo + "|";       //支票号码
    printInfo = printInfo + "65|14|10|0|" + WtcUtil.formatNumber(sumPay,2) + "|"; //小写    
    /**try                   //  被wtc替换  2008.09.03  liutong
        {
            retArray = callView.view_sToChinaFee(sumPay);
            result = (String[][])retArray.get(0);
            chinaFee = result[0][2];
        }catch(Exception e){
            logger.error("Call sunView is Error,Can't get chinaFee!");
        }   **/
      System.out.println("开始调用服务sToChinaFee  in f1104_2.jsp ****************************************");
%>
<wtc:service name="sToChinaFee" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="retMessage1"  outnum="3" >
      <wtc:param value="<%=sumPay%>"/>
      </wtc:service>
      <wtc:array id="result1" scope="end" />
<%        
         if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("调用服务sToChinaFee in f1104_2.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
          chinaFee=result1[0][2];
            
        }else{
      System.out.println("调用服务sToChinaFee in f1104_2.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
      }
        
    printInfo = printInfo + "22|14|10|0|" + chinaFee + "|";                       //大写

    printInfo = printInfo + "21|20|9|0|机器费：  " + WtcUtil.formatNumber(machFee,2) + "|";          //机器费
    printInfo = printInfo + "21|21|9|0|SIM卡费： " + WtcUtil.formatNumber(simFee,2) + "|";           //SIM卡费
    printInfo = printInfo + "50|21|9|0|入网预存费：" + WtcUtil.formatNumber(fee_sumPay,2) + "|";     //入网预存
    printInfo = printInfo + "21|22|9|0|现金款：  " + WtcUtil.formatNumber(cashPay,2) + "|";          //现金款
    printInfo = printInfo + "50|22|9|0|支票款：    " + WtcUtil.formatNumber(checkPay,2) + "|";       //支票款
    
    if ((has_card.trim()).compareTo("Y") == 0){//赠送充值卡的数量
      printInfo = printInfo + "21|24|9|0|您获赠"+strCardSum + "张10元面值充值卡,请您凭发票和密码于入网当月内到当地指定营业厅领取。"+"|";      
      printInfo = printInfo + "21|25|9|0|备注：    " + note + "|";                       //备注
    }else{
      printInfo = printInfo + "21|24|9|0|备注：    " + note + "|";                       //备注
    }
    
    //printInfo = printInfo + "21|25|9|0|中奖信息：" + vAwardMsg +"|";
    printInfo = printInfo + "21|25|9|0|" + vAwardMsg +"|";

    //20091014 fengry begin for 大兴安岭入网有礼
    if(result[0][1].equals("感谢您参与国家.爱，2009倾情欢乐送礼品兑换活动，活动预存不予退还，请在活动期间内兑换礼品，逾期作废。"))
    {
        printInfo = printInfo + "21|26|9|0|" + result[0][1] +"|";
    }
    System.out.println("result[0][1]="+result[0][1]);
    //20091014 end

  }
  String printInfo1 = "";
  //=========================================
  //组织打印数据结束
  
  //王良 2008年1月3日 修改增加用户满意度评价设置
  if(ret_code.equals("0") && strHasEval.equals("1")){      //判断方式修改  ret_code原为int 
    String strParaAray[] = new String[6];
    strParaAray[0] = thework_no;  //0  操作工号                iLoginNo  thework_no
    strParaAray[1] = theop_code;  //1  操作代码                iOpCode   theop_code
    strParaAray[2] = themob;      //2  移动号码                iPhoneNo  themob                         
    strParaAray[3] = strEvalCode; //3  评价代码
    strParaAray[4] = stream;      //5  操作流水
    strParaAray[5] = "0"; 
    
/**   ret = impl.callService("sCommEvalCfm",strParaAray,"2","phone",themob);

    int iReturnCode = impl.getErrCode();
    String strReturnMsg = impl.getErrMsg();
    
    System.out.println("iReturnCode="+iReturnCode);
    System.out.println("strReturnMsg="+strReturnMsg);
**/
%>
      <wtc:service name="sCommEvalCfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="iReturnCode" retmsg="strReturnMsg"  outnum="2" >
      <wtc:params value="<%=strParaAray%>"/>
      </wtc:service>
      <wtc:array id="result1" scope="end" />
<%
    if(iReturnCode.equals("0")||iReturnCode.equals("000000")){
          System.out.println("调用服务sCommEvalCfm in f1104_2.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
            
            
        }else{
      System.out.println("调用服务sCommEvalCfm in f1104_2.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
      }


  }

  
    if(!ret_code.equals("000000"))                          //判断方式修改  原为int 
    {
%>
           <script language='jscript'> 
                rdShowMessageDialog("<%=retMessage%>",0);
                history.go(-1);
           </script>
<%    
    }
        else
        {
        
%>        
            <script language='jscript'>
         var h=210;
         var w=350;
         var t=screen.availHeight/2-h/2;
         var l=screen.availWidth/2-w/2;
         var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
         var path = "spubPrint_1104.jsp?DlgMsg=" + "全球通普通开户成功！";
         var path = path + "&printInfo=<%=printInfo%>&printInfo1=<%=printInfo1%>&submitCfm=Single";
         var ret=window.showModalDialog(path,"",prop);  
                     location = "f1104_1.jsp";
            </script>
<%            

        }
%>
