<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
    //得到输入参数
    Logger logger = Logger.getLogger("f1106_2.jsp");
    ArrayList retArray = new ArrayList();
    String return_code,return_message,total_date,login_accept,delay_time;
    String[][] result = new String[][]{};
 	S1100View callView = new S1100View();

    String workno = request.getParameter("workno");                 //操作员工号
    String ip_Addr = request.getParameter("ip_Addr");               //操作员工号
    String opcode = "1106";                                         //操作代码
    String belongCode = request.getParameter("belongCode");         //归属代码
    
    String custId = request.getParameter("custId");                 //客户ID
    String custPwd = Encrypt.encrypt(Pub_lxd.repStr(request.getParameter("custPwd")," "));            	//客户密码，加密后的    

    String idIccid = Pub_lxd.repStr(request.getParameter("idIccid"),"");//证件号码
    String idType = request.getParameter("idType");                 //证件类型
    idType = idType.substring(0,idType.indexOf("|"));
    String custName = Pub_lxd.repStr(request.getParameter("custName"),"");  //客户名称
    String custAddr = Pub_lxd.repStr(request.getParameter("custAddr"),"");  //客户地址
   
    String operType = request.getParameter("operType");             //业务品牌
    String innetCode = request.getParameter("innetCode");           //入网代码
    innetCode = innetCode.substring(0,innetCode.indexOf("-"));

    String machCode = request.getParameter("machCode");             //机器代码
    if((machCode.trim()).compareTo("") == 0)
    {     machCode = " ";         }    
    String simType = request.getParameter("simType");               //SIM卡类型
    String simNo = request.getParameter("simNo");                   //SIM卡号
    String phoneNo = request.getParameter("phoneNo");               //手机号码
    String payWay = request.getParameter("payWay");                 //资费方式
    String serviceResult = request.getParameter("serviceResult");   //特服定购
    
    String userId = request.getParameter("userID");                 //用户ID
    String userPwd =Pub_lxd.repStr(request.getParameter("prt_password")," ");            	//用户密码,加密后的
    
    String accountId = request.getParameter("accountID");           //帐户ID
    //String accountPwd = request.getParameter("accountPwd");       //帐户密码
    String accountPwd = userPwd;  //将用户密码设为帐户的默认密码
    String cfmAccPwd = request.getParameter("cfmAccPwd");           //确认密码
    String billType = request.getParameter("upBillType");           //出帐周期
     //-----------------
    String postFlag = "0";             //邮寄标志
    String postType = " ";             //邮寄类型
    String postName = " ";            //收件人名称
    String postFax = " ";               //邮寄传真
    String postMail = " ";             //邮寄Email
    String postAdd = " ";            //邮寄地址
    String postZip = " ";               //邮寄邮编
    
    String assuId = " ";                 //担保人证件号码
    String assuName = " ";             //担保人名称
    String assuPhone = " ";           //担保人电话
    String assuAddr = " ";            //担保人通讯地址
    //-----------------
    //String innetFee = request.getParameter("innetFee");             //入网费
    String handFee = request.getParameter("handFee");               //手续费
    String choiceFee = request.getParameter("choiceFee");           //选号费
    String prepayFee = request.getParameter("prepayFee");           //预付费
    String machFee = request.getParameter("machFee");               //机器费
    String simFee = request.getParameter("simFee");                 //SIM卡费
    
    //String hid_innetFee = request.getParameter("hid_innetFee");     //修改入网费
    String hid_HandFee = request.getParameter("hid_HandFee");       //修改手续费
    String hid_ChoiceFee = request.getParameter("hid_ChoiceFee");   //修改选号费
    String hid_MachFee = request.getParameter("hid_MachFee");       //修改机器费
    String hid_SimFee = request.getParameter("hid_SimFee");         //修改SIM卡费    
    
    String favourableTime = request.getParameter("favourableTime");         //当前系统时间
    String hid_favourableTime = request.getParameter("hid_favourableTime");         //优惠时间
    
    String cashPay = request.getParameter("cashPay");               //现金交款
    String bankCode = request.getParameter("bankCode");             //银行代码
    if((bankCode.trim()).compareTo("") == 0)
    {   bankCode = "zzz";              }    
    String checkNo = request.getParameter("checkNo");               //支票号码
    if((checkNo.trim()).length()==0)
    {   checkNo = "zzz";              }
    String checkPay = request.getParameter("checkPay");             //支票交款
    if((checkPay.trim()).compareTo("") == 0)
    {   checkPay = "0.00";             }
    String sumPay = request.getParameter("sumPay");                 //合计费用
    
    String sysNote = request.getParameter("sysNote");               //系统备注
    String opNote = request.getParameter("opNote");                 //操作备注                  

    String payCode = request.getParameter("payCode");               //主资费代码
    String additiveCode = request.getParameter("additiveCode");     //附加资费代码
	String rentpayCode = request.getParameter("rentpayCode");       //租机时的可选资费代码
	String bindModeCode=request.getParameter("bindModeCode");       //绑定附加资费
    
    String serviceNow = request.getParameter("serviceNow");         //立即生效特服    
	String serviceAfter = request.getParameter("serviceAfter");     //预约生效特服 
	String serviceAddNo = request.getParameter("serviceAddNo");     //附加号码特服 
	String sysAccept = request.getParameter("sysAccept");     		//得到操作流水

	String machineType=request.getParameter("hidMachineType");      //得到机器代码
	String tfFlag=request.getParameter("tfFlag");                   //特服选择标志
	machineType+=tfFlag;

 //---------------------------------------------
	//组织打印信息
 	if(cashPay==null || cashPay.trim().equals("")) cashPay="0";
	if(checkPay==null || checkPay.trim().equals("")) checkPay="0";


    //====================1======================
    String chinaFee = "";
  
    //====================2======================
	String busi_sumPay=String.valueOf(Double.parseDouble(handFee)+Double.parseDouble(choiceFee)+Double.parseDouble(machFee)+Double.parseDouble(simFee));
	String printInfo = "";
	if(Double.parseDouble(busi_sumPay)>0.01)
	{
		printInfo="30|8|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo += "38|8|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo += "43|8|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";

	    printInfo = printInfo + "15|10|10|0|" + phoneNo + "|";   //手机号
		printInfo = printInfo + "10|11|10|0|" + custName + "|";  //用户名
		printInfo = printInfo + "10|13|10|0|"+ custAddr + "|";    //地址 

		if(Double.parseDouble(cashPay)<0.01)
          printInfo = printInfo + "10|15|10|0|"+ "支票" + "|";    //交款方式
		else if(Double.parseDouble(checkPay)<0.01)
          printInfo = printInfo + "10|15|10|0|"+ "现金" + "|";    //交款方式
		else 
          printInfo = printInfo + "10|15|10|0|"+ "现金-支票" + "|";    //交款方式

		printInfo = printInfo + "55|17|10|0|" + Pub_lxd.formatNumber(busi_sumPay,2) + "|";   //小写		
        try
        {
            retArray = callView.view_sToChinaFee(busi_sumPay);
            result = (String[][])retArray.get(0);
            chinaFee = result[0][2];
        }catch(Exception e){
            logger.error("Call sunView is Error,Can't get chinaFee!");
        }				
		printInfo = printInfo + "20|17|10|0|" + chinaFee + "|";                 //大写

        printInfo = printInfo + "5|19|9|0|" + "长白行普通开户（业务发票）" + "|"; //业务项目
 		printInfo = printInfo + "5|20|9|0|手续费：" + Pub_lxd.formatNumber(handFee,2) + "|";          //手续费
		printInfo = printInfo + "50|20|9|0|选号费：" + Pub_lxd.formatNumber(choiceFee,2) + "|";        //选号费
 		printInfo = printInfo + "5|21|9|0|机器费：" + Pub_lxd.formatNumber(machFee,2) + "|";          //机器费
		printInfo = printInfo + "50|21|9|0|SIM卡费：" + Pub_lxd.formatNumber(simFee,2) + "|";          //SIM卡费
		printInfo = printInfo + "5|22|9|0|流水号：" + sysAccept + "|";        //流水号
		printInfo = printInfo + "50|22|9|0|用户密码：" + userPwd + "|";        //流水号		
	}

	//====================3======================prepayFee
	String fee_sumPay=String.valueOf(Double.parseDouble(prepayFee));
 	String printInfo1 = "";
	if(Double.parseDouble(fee_sumPay)>0.01)
	{
		printInfo1="30|8|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo1 += "38|8|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo1 += "43|8|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";

	    printInfo1 = printInfo1 + "15|10|10|0|" + phoneNo + "|";   //手机号
		printInfo1 = printInfo1 + "10|11|10|0|" + custName + "|";  //用户名
		printInfo1 = printInfo1 + "10|13|10|0|"+ custAddr + "|";    //地址
		
		if(Double.parseDouble(cashPay)<0.01)
          printInfo1 = printInfo1 + "10|15|10|0|"+ "支票" + "|";    //交款方式
		else if(Double.parseDouble(checkPay)<0.01)
          printInfo1 = printInfo1 + "10|15|10|0|"+ "现金" + "|";    //交款方式
		else 
          printInfo1 = printInfo1 + "10|15|10|0|"+ "现金-支票" + "|";    //交款方式

		printInfo1 = printInfo1 + "55|17|10|0|" + Pub_lxd.formatNumber(fee_sumPay,2) + "|";   //小写		
        try
        {
            retArray = callView.view_sToChinaFee(fee_sumPay);
            result = (String[][])retArray.get(0);
            chinaFee = result[0][2];
        }catch(Exception e){
            logger.error("Call sunView is Error,Can't get chinaFee!");
        }				
		printInfo1 = printInfo1 + "20|17|10|0|" + chinaFee + "|";                 //大写

        printInfo1 = printInfo1 + "5|19|9|0|" + "长白行普通开户（缴费发票）" + "|"; //业务项目
		printInfo1 = printInfo1 + "5|20|9|0|入网预存费：" + Pub_lxd.formatNumber(fee_sumPay,2) + "|";         //入网费
 		printInfo1 = printInfo1 + "50|20|9|0|流水号：" + sysAccept + "|";        //流水号
		printInfo1 = printInfo1 + "5|21|9|0|用户密码：" + userPwd + "|";        //流水号	
	} 
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
        String pCust_Passwd = custPwd; 
        String pUser_Passwd = userPwd;
        String pCon_Passwd = accountPwd; 
        String pCBXCustInfo = "";
        
        String checkRadio=Pub_lxd.repNull(request.getParameter("checkRadio"));
		String spayType="0";
		if(!(checkRadio.trim().equals(""))) spayType="6";

        //客户信息串:业务品牌代码~服务类型~信誉度~用户属性~
           //信誉度代码~信誉度值~付费代码~付费类型~帐务类型~
           //权限值~入网类型~机器代码~其它属性~支票号码~银行代码       
         String pCust_List = operType + "~" + "01" + "~" + "0" + "~" +"000" + "~" + 
                "E" + "~" + "0" + "~" + "0" + "~" + spayType + "~" + billType + "~" + 
                "1" + "~" + innetCode + "~" + machCode + "~" + "01" + "~" + checkNo + "~" + bankCode + "~"; 
        //担保信息串:担保号码~担保人姓名~担保人证件~担保人电话~担保人地址~
        String pAssure_List = "";
 
        //邮寄帐单信息串:邮寄帐单标志~邮寄帐单类型~邮寄帐单地址~邮寄帐单邮编~邮寄帐单传真~邮寄帐单Mail~                
        String pPost_List = "";
         
        //费用信息串:现金交款~支票交款~预存款~SIM卡费~机器费~入网费~选号费~其它费~手续费~       
        String pFee_List = cashPay + "~" + checkPay + "~" + prepayFee + "~" +
                 simFee + "~" + machFee + "~" + "0.00" + "~" + choiceFee + "~" +
                 "0.00" + "~" + handFee + "~"; 
        //特服信息串（立即生效特服）            
        String pFunc_List = serviceNow;   
        //优惠信息串
        String  pfavourable_List = "";
 
		if(Float.parseFloat(machFee) - Float.parseFloat(hid_MachFee) != 0)          //机器费优惠
        {   pfavourable_List = pfavourable_List + "a001&" + hid_MachFee  + "&" + machFee + "&~";            }
        if(Float.parseFloat(simFee) - Float.parseFloat(hid_SimFee) != 0)            //Sim卡优惠
        {   pfavourable_List = pfavourable_List + "a003&" + hid_SimFee + "&" + simFee + "&~";           }
        if(Float.parseFloat(choiceFee) - Float.parseFloat(hid_ChoiceFee) != 0)      //选号费优惠
        {   pfavourable_List = pfavourable_List + "a004&" + hid_ChoiceFee  + "&" + choiceFee + "&~";        }  
        if(Float.parseFloat(handFee) - Float.parseFloat(hid_HandFee) != 0)          //手续费优惠
        {   pfavourable_List = pfavourable_List + "a007&" + hid_HandFee  + "&" + handFee + "&~";            }
 
		//套餐信息串
        String pPackage_List = payCode + "~" + additiveCode + "~"+rentpayCode+"~"+bindModeCode+"~";
        //特服信息串（预约特服）  
        String pUnUsedFunc_List = serviceAfter;
        //特服信息串（短号码特服）  
        String pAddAddFunc_List = serviceAddNo;   
        //客户信息追加的字符串
        pCBXCustInfo = custName + "~" + custAddr + "~" + idType + "~" + idIccid + "~" ;       
		//随e性信息串:凭证系列号~ Gprs套餐 ~ WLAN套餐
    	String E_DataList = "";        
 	    try               
 	    {                 
       	retArray = callView.view_s1104Cfm(pLogin_No, pip_Addr, pOp_Code, pSys_Note,pOp_Note,pPhone_No, pSim_Type,pSim_No,pBelong_Code, pCust_Id, pId_No,pCon_Id,pCust_Passwd, pUser_Passwd,pCon_Passwd, pCust_List,pAssure_List,pPost_List, pFee_List, pFunc_List,pPackage_List,pfavourable_List,pUnUsedFunc_List,pAddAddFunc_List,pCBXCustInfo,sysAccept,E_DataList,machineType,"0", " "," "," "," "," ","N");

        	result = (String[][])retArray.get(0);
      	}catch( Exception e){
       		logger.error("Call sunView is Failed!");
     	}       
        String ret_code = result[0][0];      
        String retMessage = result[0][1];
        String retQuence = result[0][2]; 
              
		if(ret_code.compareTo("000000") != 0)
		{
%>
            <script language='jscript'>
                rdShowMessageDialog('<%=retMessage%>' + '[' + '<%=ret_code%>' + ']',0);
                history.go(-1);
            </script>
<%		}
        else
        {
%>        
            <script language='jscript'>
 				   var h=150;
				   var w=350;
				   var t=screen.availHeight/2-h/2;
				   var l=screen.availWidth/2-w/2;
				   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
				   var path = "spubPrint.jsp?DlgMsg=" + "长白行普通开户成功！";
				   var path = path + "&printInfo=" + "<%=printInfo%>"+ "&printInfo1=" + "<%=printInfo1%>" + "&submitCfm=" + "Single";
				   var ret=window.showModalDialog(path,"",prop); 	
				   location = "f1106_1.jsp";                
            </script>
<%            
        }
%>