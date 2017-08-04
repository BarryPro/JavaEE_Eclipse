<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
	//xl add for hxl 回收时缴费输入框为只读属性
	String s_read_only="";

 	String print_flag = request.getParameter("print_flag");
	String login_aceept = request.getParameter("login_aceept");
	String invoice_money = WtcUtil.repNull(request.getParameter("invoice_money"));
	if(invoice_money!=null &&!("".equals(invoice_money)) )
	{
		s_read_only="readonly";
	}
	//根据busy_type来更改opCode和opName
 	String opCode = "";
	String opName = "";
	String timeResult[][];
  String busy_type= WtcUtil.repNull(request.getParameter("busy_type"));

  /*************add by zhanghonga@2008-09-22,根据busy_type来更改opCode和opName,避免统一接触的opcode,opname记录错误*****************/
  switch(Integer.parseInt(busy_type)){   
 
  	case 2 :
  					opCode = "d340";
  					opName = "集团账号缴费";
  					break;
  	 
  }
  System.out.println("########################################s1300Cfm->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/

  String contractno = request.getParameter("contractno");	
  //xl add for 预开发票回收时调用
  
  
  String phoneNo1 = request.getParameter("phonenoGroup");
  String phoneNo = "";
  String[] inParas = new String[2];
  if(phoneNo1!=null && (!phoneNo1.equals("")) && (contractno == null || contractno.equals("") ) )
  {
	  
		//String sql_contractno = "select to_char(contract_no) from dcustmsg where phone_no = '?'  ";	
		inParas[0]="select to_char(contract_no) from dcustmsg where phone_no = :phoneNo";
		inParas[1]="phoneNo="+phoneNo1;
	  %>
		<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode41" retmsg="retMsg41" outnum="1">
		    <wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
		</wtc:service>
		<wtc:array id="result41" scope="end" />
<%
		
		if(result41!=null){
			if (result41.length>0) {
			   contractno = result41[0][0];
			}
		}
 
  }
	
 	String op_code  =request.getParameter("op_code");
 	String ispopmarket="0";//0 没有经分的营销信息弹出，1 已经在经分营销窗口有信息，不弹出popup_windows
 	String hUserCheckCond = "";		/*判断用户密码是否简单*/
 	String hHasCheckCond = "";
	String dVipType = "0";
	String pay_code_num = "0";
	String num = "0";
  if (request.getParameter("ispopmarket") != null) {
     ispopmarket=request.getParameter("ispopmarket");
  }
	System.out.println("000---contractno=["+contractno+"]");
	System.out.println("000---phoneNo=["+phoneNo+"]");

 
	String[] inParas1 =new String[]{""};//芦学琛20060301add,用于查询开户时间
	String[] inParas2 = new String[]{""};
	String showopentime = "";
	String ret_showflag = "";
	String val_showflag =  "";
	int showflag = 0;

	String count_num="0";
	String contract_num="0";
	String busy_name="";
	String return_page="";
	String contractCount = "-1";
 
 
    String[][] if_zgqk  = null;
    //xl add for hanfeng 查询品牌PB不可以办理
	  String s_sm_code="";
	  String[] strSqlText = new String[2];
	  strSqlText[0]="select  sm_code from dgrpusermsg where account_id= :s_con_id";
	  strSqlText[1]="s_con_id="+contractno;
	//end of PB
		System.out.println("222---contractno=["+contractno+"]");
		inParas[0] = "select to_char(nvl(count(*),0)) from dConShort where contract_no = :contractno";
		inParas[1]="contractno="+contractno;
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode16" retmsg="retMsg16" outnum="1">
		    <wtc:param value="<%=strSqlText[0]%>"/>
			<wtc:param value="<%=strSqlText[1]%>"/>
	</wtc:service>
	<wtc:array id="result_sm" scope="end" />
<%
	if(result_sm.length>0)
	{
		s_sm_code=result_sm[0][0];
	}
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode4" retmsg="retMsg4" outnum="1">
		    <wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end" />
<%
		if(result!=null){
			if (result.length>0) {
			   count_num = result[0][0];
			}
		}

		System.out.println("count_num=["+count_num+"]");
		if(count_num.equals("0")) {
			inParas[0] = "select to_char(nvl(count(*),0)) from dconusermsg where contract_no = :contractno and serial_no='0'";
			inParas[1]="contractno="+contractno;
		%>
			<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode4" retmsg="retMsg4" outnum="1">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
		<%
			
		if(result!=null){
				if (result.length>0) {
				   contract_num = result[0][0];
				}
			}
		}
		System.out.println("contract_num=["+contract_num+"]");
 
	if(busy_type.equals("2")) {
	System.out.println("\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabwwwwwwwwwwwwww\n");
		busy_name="按集团账号缴费";
		return_page="s1300_group.jsp";
//	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaac");
	}

 

  String workno = (String)session.getAttribute("workNo");
  String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
  /*tianyang add for pos */
  String groupId = (String)session.getAttribute("groupId");
	String nopass = (String)session.getAttribute("password");
	String regionCode = org_code.substring(0,2);
	String districtCode = org_code.substring(2,4);  // liyan 增加操作员县区代码

		//优惠信息
		//解析营业员优惠权限
    String Delay_Favourable = "readonly";        //a040  滞纳金费优惠
    String Predel_Favourable = "readonly";       //a041  补收月租费优惠
    String printNote ="0";

    String[][] favInfo = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[favInfo.length];
		 
		for(int i = 0 ;i < favStr.length; i++){
			favStr[i] = favInfo[i][0].trim();
			 
			if(favStr[i].equals("a040") )    Delay_Favourable = "";
      if(favStr[i].equals("a041"))     Predel_Favourable = "";
			if(favStr[i].equals("a092"))	   printNote ="1";
		}

	String TGroupFlag="" ;
	String TBigFlag  ="";
	String BigFlag = "0";

	StringBuffer accountstr  = new StringBuffer(80);   //多账户字符串
	StringBuffer namestr=new StringBuffer(80);        //多账户名称字符串
	StringBuffer accounttypestr=new StringBuffer(80);        //帐户类型
	StringBuffer paytypestr=new StringBuffer(80);        //付费方式
	StringBuffer shoudpaystr=new StringBuffer(80);        //欠费

	inParas = new String[5];
	inParas[0] = phoneNo;
	inParas[1] = contractno;
	inParas[2] = busy_type;
	inParas[3] = org_code;
 
	inParas[4] = workno;

	String[][] result1  = null ;
	String[][] result2  =null;
	String[][] result3  = null;
	String[][] result4  = null;
	String iretCode = "";
	String iretMsg = "";
    String s_zq="";
 

  String[][] result5  = null;
  if(busy_type.equals("2")){
	   //value  = viewBean.callService("1", org_code.substring(0,2),  "s1300_Valid1", "19"  ,  lens_1 , inParas,map) ;
	   //xl add for xuxza 增加判断是否政企客户 0-不改 1-政企客户 只能现金 13073144668

%>
	<wtc:service name="sd340Init" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode5" retmsg="retMsg5" outnum="23">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
 
	</wtc:service>
	<wtc:array id="sVerifyTypeArr1" start="0" length="10" scope="end"/>
	<wtc:array id="sVerifyTypeArr2" start="10" length="8" scope="end"/>
	<wtc:array id="sVerifyTypeArr3" start="18" length="1" scope="end"/>
	<wtc:array id="sVerifyTypeArr4" start="19" length="3" scope="end"/>
	<wtc:array id="s_zqkh" start="22" length="1" scope="end"/>
<%
		result1 = sVerifyTypeArr1;
		result2 = sVerifyTypeArr2;
		result3 = sVerifyTypeArr2;
		result4 = sVerifyTypeArr3;
		result5 = sVerifyTypeArr4;
		if_zgqk = s_zqkh;
		System.out.println("aaaaaaaaaaaaaaaaaaaaa if_zgqk is " +if_zgqk);
		/*
		 System.out.println("---------ly-----------result5[0][0]=["+result5[0][0]+"]");
		System.out.println("---------ly-----------result5[0][1]=["+result5[0][1]+"]");
		System.out.println("---------ly-----------result5[0][2]=["+result5[0][2]+"]");*/
		iretCode = retCode5;
		iretMsg = retMsg5;
	}
 


	String return_code = "999999";
	String ret_msg = "调用服务失败";
	if(result1!=null&&result1.length>0){
		return_code = result1[0][0];
		ret_msg = result1[0][1];
	}

System.out.println("################################iretCode->"+iretCode+"&&&&iretMsg->"+iretMsg);
System.out.println("aaaaaaaaaaaaaaaaabusy_type="+busy_type);
 if(return_code.equals("000000")||return_code.equals("137111"))
{
 	String return_msg = null;
	String countName  = null;
	String userType   = null;
	String runname = null;
	String predelFee  = "0";
	String phoneNum   = "1";
	String prepayFee  = "0";
	String contract   = null;
	String belongcode = null;


  String nobillpay = null;   //未出账话费：

  String credit= null;  //信誉度
	String menu = null;  //套餐类型
	String paytype=null; //付费类型


	String busitype=null; //业务类别
	String curbalanace= null; //当前可用余额
	String mhp = null; //中高端客户属性
	String username=null; //用户名称
	String userprop =null;//用户属性
	String usernode = "";//用户备注
  String showPrePay = "";//显示预存


	double sDeservedFee = 0;      //合计应收
	double snobillpay = 0;
	double sOweFee = 0;             //欠费
 	double sPayMoney =0;          //缴费
	double sPredelFee=0;
	double sCredit=0;           //信用度


	double sum_delayfee=0.00;
	double sum_usefee=0.00;
	int flag=0;

 	if (return_code.equals("000000"))
	{

		return_msg = result1[0][1].trim();           //返回消息
		countName  = result1[0][2].trim();         //帐户名称
		userType   = result1[0][3].trim();           //帐户属性
		prepayFee  =  result1[0][4].trim();		//	   帐户预存款
		runname    = result1[0][5].trim();			  //  未出帐话费
		phoneNum   = result1[0][6].trim();		 //	  手机数量
		predelFee	=	 result1[0][7].trim();
		contract   = result1[0][8].trim();		 	//	 冒高标志
		belongcode = result1[0][9].trim();		//	 所属名称
		//xl add for xuxza
		s_zq = if_zgqk[0][0];
		System.out.println("ddddddddddddddddddddddddddd s_zq is "+s_zq);
       if(busy_type.equals("1"))
	   {
			 credit=  result1[0][10].trim();
			 menu =  result1[0][11].trim();
			 paytype= result1[0][12].trim();
       		 nobillpay =  result1[0][13].trim();
			 busitype= result1[0][14].trim(); //业务类别
			 curbalanace=result1[0][15].trim();//当前可用余额
			 mhp = result1[0][16].trim();//中高端客户属性
			 username=result1[0][17].trim();//用户名称
			 userprop=result1[0][3].trim();//客户属性
			 usernode = result1[0][18].trim();
       		 showPrePay = result4[0][0].trim();
	  		 System.out.println("*************showPrePay="+showPrePay);
	   }

	   if(busy_type.equals("2"))
	   {
	   //System.out.println("cccccccccccccccccccccccccccccc");
        	showPrePay = result5[0][0].trim();
	  		 System.out.println("new add111111111111111*************showPrePay="+showPrePay);
			nobillpay =  result4[0][0].trim();
        	//System.out.println("nobillpaynobillpaynobillpaynobillpay="+nobillpay);
	   }

		for (int i=0; i < result2.length;i++)
		{
			sum_usefee = sum_usefee + Double.parseDouble(result2[i][2]);
			sum_delayfee = sum_delayfee + Double.parseDouble(result2[i][3]);
		}
		  
System.out.println("\ncccccccccccccccccccccccccccccc------------------sum_usefee is "+sum_usefee+" and sum_delayfee is "+ sum_delayfee +"\n");
   		 sPredelFee = Double.parseDouble(predelFee);

		if (nobillpay != null) {
		    snobillpay =   Double.parseDouble(nobillpay);
		}
//System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
		if (credit != null) {
		    sCredit = Double.parseDouble(credit);
		}
//System.out.println("ddddddddddddddddddddddddddddddd");
		sOweFee = sum_delayfee+sum_usefee + sPredelFee + snobillpay - sCredit;

//System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaresult5[0][2]");
		if (busy_type.equals("2") && result5[0][2].trim().equals("1"))
		{
		//System.out.println("ttttttttttttttttttttttttt");
			System.out.println("超过一万七的帐户用户缴费");
			sOweFee = Double.parseDouble(result5[0][1]) + sPredelFee + snobillpay - sCredit;
		}

		if(busy_type.equals("1")) {
		    curbalanace = String.valueOf((double) Math.round((Double.parseDouble(prepayFee) - sOweFee)*100)/100);
		}
		
		if (sOweFee<=Double.parseDouble(prepayFee)){
		    sDeservedFee = 0;
		}else{
        sDeservedFee=sOweFee-Double.parseDouble(prepayFee);
    }

		sDeservedFee = (double) Math.round(sDeservedFee*100)/100;  //四舍五入
		sPayMoney =Math.ceil(sDeservedFee);

	}else{//多账户

		 flag = 1;
		 for(int i = 0; i < result3.length; i++){
	      accountstr.append(result3[i][0].trim());
				accountstr.append(",");

		    namestr.append(result3[i][1].trim());
				namestr.append(" ,");

	      accounttypestr.append(result3[i][2].trim());
				accounttypestr.append(" ,");

				paytypestr.append(result3[i][3].trim());
				paytypestr.append(" ,");

				shoudpaystr.append(result3[i][4].trim());
				shoudpaystr.append(" ,");
	   }
	}


/*王良 2006年12月11日 增加X_HLJMob_CRM_PD3_2006_370关于整合业务办理界面提示信息的需求.xls*/
	if (busy_type.equals("1")){
		String[] inPutArray = new String[2];
		inPutArray[0] = workno;
		inPutArray[1] = phoneNo;
%>
<%
	boolean popupWin_flag = false;
	try{
%>
	<wtc:service name="sPopupWin" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode6" retmsg="retMsg6" outnum="7">
	<wtc:param value="<%=inPutArray[0]%>"/>
	<wtc:param value="<%=inPutArray[1]%>"/>
	</wtc:service>
<%
		popupWin_flag = true;
	}
	catch(Exception ex)
	{
		popupWin_flag = false;
		System.out.println("%%%%%%%查询sPopupWin失败！%%%%%%%%%");
	}
%>

	<wtc:array id="sVerifyTypeArr1" start="0" length="5" scope="end"/>
	<wtc:array id="sVerifyTypeArr2" start="5" length="2" scope="end"/>
<%

	/*System.out.println("=liyan "+sVerifyTypeArr1.length);
	System.out.println("==liyan 2 popupWin_flag="+popupWin_flag);*/

	if(sVerifyTypeArr1!=null&&sVerifyTypeArr1.length>0 && popupWin_flag ){
		String strReturnCode = sVerifyTypeArr1[0][0];
	    System.out.println("sVerifyTypeArr1[0][1]="+sVerifyTypeArr1[0][1]);
		System.out.println("strReturnCode=="+strReturnCode);
	 	if (strReturnCode.equals("000000"))
		{
			hHasCheckCond = "000000";
			hUserCheckCond = sVerifyTypeArr1[0][1].trim();  //返回消息
			dVipType = sVerifyTypeArr1[0][2].trim();  //vip级别
			pay_code_num = sVerifyTypeArr1[0][3].trim();  //参与标志
			num = sVerifyTypeArr1[0][4].trim();  //托收帐户
	 	}else{
	 		hHasCheckCond = "000001";
	 		dVipType = sVerifyTypeArr1[0][2].trim();  //vip级别
			pay_code_num = sVerifyTypeArr1[0][3].trim();  //参与标志
			num = sVerifyTypeArr1[0][4].trim();  //托收帐户
		}
	}
}

/* dujl add at 20090506 for 哈尔滨关于开展中低端预存赠礼的需求* start ********* */
	StringBuffer  insql = new StringBuffer();
	//wuxy alter 20090620 解决20号码不入dcustinnet表中问题
	if(busy_type.equals("1"))
	{
		/*insql.append("select to_char(add_months(open_time,3),'yyyymm'),to_char(sysdate,'yyyymm') ");
		insql.append(" From dcustmsg ");
		insql.append(" where phone_no='?' ");
		System.out.println("insql====="+insql);*/
		inParas[0] = "select to_char(add_months(open_time,3),'yyyymm'),to_char(sysdate,'yyyymm') From dcustmsg where phone_no=:phoneNo ";
		inParas[1]="phoneNo="+phoneNo1;
%>
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:param value="<%=inParas[0]%>"/>
<wtc:param value="<%=inParas[1]%>"/>
</wtc:service>
<wtc:array id="timeResult1" scope="end" />
<%
	
  timeResult=timeResult1;
}else
	{
		insql.append("select to_char(sysdate,'yyyymm'),to_char(sysdate,'yyyymm') ");
		insql.append("  FROM dual ");
		System.out.println("insql====="+insql);

%>
<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="timeResult1" scope="end" />
<%
 timeResult=timeResult1;
	}

/* dujl add at 20090506 for 哈尔滨关于开展中低端预存赠礼的需求* end ********** */

/*孙振兴 20070508 增加
原因：R_HLJMob_cuisr_CRM_PD3_2007_158@关于密码沉默用户提醒的需求
*/

%>

<!--  ******fengry 20090812 add for 鹤岗特殊预存类营销活动 begin******  -->
<wtc:service name="s1300Spec" routerKey="phone" routerValue="<%=phoneNo%>" retcode="SpecCode" retmsg="SpecMsg" outnum="4">
<wtc:param value="<%=workno%>"/>
<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="SpecResult1" start="0" length="2" scope="end" />
<wtc:array id="SpecResult" start="2" length="2" scope="end" />

<%
	if(SpecCode.equals("130099"))
	{%>
		<script language=javascript>
			rdShowMessageDialog("<%=SpecMsg%>");
		</script>
<%}%>
<!--  ******fengry 20090812 add for 鹤岗特殊预存类营销活动 end******  -->
<%
	//xl add for 查询集团信息
	String jtbh="";
	String khid="";
	String jtcpmc="";
	String jtlb="";
	String khjlmc="";
	String khjlgh="";
	String jtkhmc="";
	String inParas3[] = new String[2];
	inParas3[0]="select to_char(a.unit_id),to_char(b.cust_id),a.unit_name,nvl(a.owner_code,' '),nvl(e.name,' '),nvl(e.service_no,' '),f.offer_name from dgrpcustmsg a,dcustdoc b,dgrpusermsg d,dgrpmanagermsg e,product_offer  f where a.cust_id=b.cust_id  and a.cust_id = d.cust_id and a.service_no=e.service_no(+) and f.offer_id=to_number(d.product_code) and d.account_id=:contract_no ";
	inParas3[1]="contract_no= "+contractno;
%> 
<wtc:service name="TlsPubSelCrm" retcode="sretCode" retmsg="sretMsg" outnum="7">
    <wtc:param value="<%=inParas3[0]%>"/> 
    <wtc:param value="<%=inParas3[1]%>"/>  
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
	if(ret_val==null||ret_val.length==0)
	{
		jtbh="";
		khid="";
		jtcpmc="";
		jtlb="";
		khjlmc="";
		khjlgh="";
		jtkhmc="";
	}
	else
	{
		jtbh=ret_val[0][0];
		khid=ret_val[0][1];
		jtkhmc=ret_val[0][2];
		jtlb=ret_val[0][3];
		khjlmc=ret_val[0][4];
		khjlgh=ret_val[0][5];
		jtcpmc=ret_val[0][6];
	}
%>
<HTML>
<HEAD>
<title>集团缴费</title>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
/*HARVEST 王梅 20061031 添加为了开发需求332 判断用户入网时间和中奖情况*/
/*HARVEST 王梅 20071030 添加为了开发需求343 判断用户入网时间和中奖情况*/

onload = function()
{
	init();
	/*xl 20100925 佳木斯上报业务优化*/

	document.all.payMoney.focus();
}
function LimitTextArea(field){ 
    maxlimit=50; 
    if (field.value.length > maxlimit) 
     //field.value = field.value.substring(0, maxlimit); 
      rdShowMessageDialog("长度最多只能录入50个汉字!");
	  return false;
   }


function doProcess(packet){
	var num = packet.data.findValueByName("num");
	var giftflag = 	packet.data.findValueByName("giftflag");
	/*tianyang add for pos缴费 start*/
	var verifyType = packet.data.findValueByName("verifyType");
	var sysDate = packet.data.findValueByName("sysDate");
	/*tianyang add for pos缴费 end*/
	//alert('num is  '+num);

	/*xl add*/
	var return_code = packet.data.findValueByName("return_code"); 
	var return_msg = packet.data.findValueByName("return_msg"); 
	var flag = packet.data.findValueByName("result");
	var ed = packet.data.findValueByName("outPledge");
	var total = packet.data.findValueByName("f_temp_total_pay");
	var money = packet.data.findValueByName("payMoney");
	//alert("test for return_code is "+return_code+" and 额度是 "+ed+" and flag is "+flag); 
	if(return_code=="000000" ){
		//要判断 results 的值 1 可以缴费 0就不可以了 也就是是否 >= 90% 
		//更新：需要对0的时候 判断flag 如果冒了要提示 也就是flag=1 要提示
		//rdShowMessageDialog("判断flag的值是 "+flag+"<br>"+" and 另起一行");
		if(flag == "1"){
			rdShowMessageDialog("本网点代办押金额度为:"+ed+",当前日累积营业额为:"+total+",本次缴纳费用为:"+money+",请及时进行资金上缴,否则将无法正常办理缴费!");
		}
		document.getElementById("show").value="ok";
		//return true	; 
		if(num>0){
		rdShowMessageDialog("用户已经参与次活动，不能重复参与!");
		document.frm.pay_note.value="";
		document.frm.pay_note.focus();
		return false;

		}
		 
		if(giftflag=="1"  ){
			rdShowMessageDialog("用户入网时间和参与活动类型对应时间不符，请重新选择!");
			document.frm.pay_note.value="";
			document.frm.pay_note.focus();
			return false;
		}
		/*tianyang add for pos缴费 start*/
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
		/*tianyang add for pos缴费 end*/
	}
	
	
	else{
		 
		
		if(return_code == "000011"){
		//alert("ed is "+ed);	
		rdShowMessageDialog("本网点代办押金额度为:"+ed+",当前日累积营业额为:"+total+",本次缴纳费用为:"+money+",无法办理!");
		}
		else{
			rdShowMessageDialog("错误代码： "+return_code+",<p>错误信息："+return_msg);
		}
		document.getElementById("show").value="no";
		//return false; 
	}
	/*xl add end*/
	

}


/* 如果多账户, 则弹出窗口,供客户选择账户*/
 function showSelWindow()
 {
		 var h=480;
		 var w=650;
		 var t=screen.availHeight/2-h/2;
		 var l=screen.availWidth/2-w/2;

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var returnValue=window.showModalDialog('getUserCount.jsp?accountstr=<%=accountstr%>&accounttypestr=<%=accounttypestr%>&paytypestr=<%=paytypestr%>&shoudpaystr=<%=shoudpaystr%>',"",prop);

 		  if(returnValue==null)
	     {
             rdShowMessageDialog("您没有选择帐户！");
             window.location.href="s1300_group.jsp";
		  }
		 else
		 {
			  document.frm.contractno.value = returnValue;
				document.frm.action = "s1300Cfm_group.jsp?ispopmarket=<%=ispopmarket%>";
				document.frm.submit();
			}

 }

 function init(){

	<%
		if(showflag ==1 ){
	%>
		rdShowMessageDialog("注册年龄15--25岁神州行客户!");
	<%
		}
  %>

		//以下域的缺省值是规范中的要求
		<%
		if ( flag == 1 ){
		%>
			showSelWindow();
    <%
    	}
 		%>

  	if ("<%=runname%>"=="预拆"){
		   rdShowMessageDialog("该用户为预拆用户！");
		}



		<%if(busy_type.equals("1")) {%>
		<%if (Integer.parseInt(contractCount)> 1) {%>
			    rdShowMessageDialog("该帐户对应多个服务号码，请按帐户缴费！");
		    <%}%>

	/*王良 2006年12月11日 增加*/
	<%
	  System.out.println("----hHasCheckCond-----"+hHasCheckCond);
	   System.out.println("----ispopmarket-----"+ispopmarket);
		if (( hHasCheckCond.compareTo("000000") == 0)&&((ispopmarket.compareTo("0"))==0)){
		System.out.println("----flag-----");
				System.out.println(hUserCheckCond);
		
	%>
 		popup_window("<%=hUserCheckCond%>");
  <%
  	}
 	%>

/*王良 2007年1月15日 封掉*/

		<%}%>

}

function searchUnbillDetail() {
    var h=480;
    var w=650;
   	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

	var returnValue = window.showModalDialog('s1300UnbillDetail.jsp?phone_no=<%=phoneNo%>&contractno=<%=contract%>',"",prop);
}

function searchshowDetail() {
    var h=480;
    var w=650;
   	var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

		var returnValue = window.showModalDialog('s1300_dconmsgpre.jsp?contractNo=<%=contract%>',"",prop);
}

//-->
</SCRIPT>

<BODY>
<FORM action="PayCfm_group.jsp" method="post" name="frm">
<input type="hidden" name="print_flag" value="<%=print_flag%>">
<input type="hidden" name="login_aceept" value="<%=login_aceept%>">
<input type="hidden" name="show">
<input type="hidden" name="op_code"  value="<%=op_code%>">
<input type="hidden" name="hUserCheckCond"  value="<%=hUserCheckCond%>">
<input type="hidden" name="hHasCheckCond"  value="<%=hHasCheckCond%>">
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="unitcode" value="<%=org_code%>">
<input type="hidden" name="sumdelayfee"  value="<%=sum_delayfee%>">
<input type="hidden" name="op_code"  value="<%=op_code%>">
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="unitcode" value="<%=org_code%>">
<input type="hidden" name="sumusefee"  value="<%=sum_usefee%>">
<input type="hidden" name="belongcode"  value="<%=belongcode%>">
<input type="hidden" name="count_num"  value="<%=count_num%>">
<input type="hidden" name="contract_num"  value="<%=contract_num%>">
<input type="hidden" name="paySign"  value="">
<!-- dujl add at 20090506 for 哈尔滨关于开展中低端预存赠礼的需求*****start*****-->
<input type="hidden" name="openTime"  value="<%=timeResult[0][0]%>">
<input type="hidden" name="nowTime"  value="<%=timeResult[0][1]%>">
<!-- dujl add at 20090506 for 哈尔滨关于开展中低端预存赠礼的需求*****end*******-->

<!-- tianyang add at 20090928 for POS缴费需求*****start*****-->
<input type="hidden" name="MerchantNameChs"  value="">
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
<!-- tianyang add at 20090928 for POS缴费需求*****end*******-->


<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi">用户信息</div>
		</div>

              <table cellspacing="0">
              	<tr>
			            <td class="blue">部门</td>
			            <td colspan="3"><%=org_code%>&nbsp;</td>
			          </tr>
                <tr>
                  <td class="blue" width="15%">操作类型</td>
                  <td width="35%">
                    <input type="text" readonly class="InputGrey" name="TbusyName"  value="<%=busy_name%>">
                  </td>
                  <td class="blue" width="15%">号码数量</td>
                  <td width="35%">
                    <input type="text" readonly class="InputGrey" name="PhoneNum" value="<%=phoneNum%>">
                  </td>
                </tr>
                <tr>
                  <td class="blue">帐户号码</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="contractno" onKeyPress="return isKeyNumberdot(0)" value="<%=contract%>">
                  </td>
                  <td class="blue">帐户名称</td>
                  <td>
                    <input type="text" name="countName"  readonly class="InputGrey" value="<%=countName%>">
                  </td>
                </tr>

                <tr id="bat_id">
                  <td class="blue">用户预存</td>
                  <td>
                    <input type="text" readonly class="InputGrey" style="color:red" name="showPrePay" value="<%=showPrePay%>">
					<%
						if(busy_type.equals("1")) {
					%>
										<input type="button" class="b_text" name="showdetail" <%if (showPrePay.equals("0.00")) {%> disabled <%}%> class="b_text" value="明细"  onClick="searchshowDetail()">
          <%
          	}
          %>
									</td>
				  				<td class="blue">可划拨预存</td>
                  <td>
                    <input type="text" readonly class="InputGrey" style="color:red" name="prepayFee" value="<%=prepayFee%>">
                  </td>
                </tr>
                <tr id="phoneId">
                  <td class="blue">服务号码</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="phoneNo" value="<%=phoneNo%>">
                  </td>
                  <td class="blue">补收月租</td>
                  <td>
                    <input type="text" readonly class="InputGrey" name="predelFee" value="<%=sPredelFee%>">
                  </td>
                </tr>


				   <%
			//	   System.out.println("dddddddddddddddddd");
				    	if(busy_type.equals("2")) {
				    	//System.out.println("qqqqqqqqqqqqqqqqqqqqccccccccccc");

				   %>
				        <tr id="phoneId">
				             <td class="blue">未出帐话费</td>
				             <td class="blue" >
				               <input type="text" readonly class="InputGrey" style="color:red" name="area" value="<%=result4[0][0]%>">
				             </td>
				               <!--20090325 liyan 添加总欠费-->
				            <% if (result5[0][2].trim().equals("1")) {%>
				             <td class="blue">大客户总欠费</td>
				             <td class="blue" ><input type="text" readonly class="InputGrey" name="allOweFee" value="<%=result5[0][1].trim()%>">(不包含滞纳金)
 							</td>
				             <% }
				            else{ %>
				            	<td colspan="2">&nbsp;</td>
				            	<%}%>
				        </tr>
					<%
						}
					%>
				<tr id="phoneId">
                  <td class="blue">集团编号</td>
                  <td>
                    <input type="text" readonly class="InputGrey"  value="<%=jtbh%>">
                  </td>
                  <td class="blue">客户ID</td>
                  <td>
                    <input type="text" readonly class="InputGrey"  value="<%=khid%>">
                  </td>
                </tr>
				<tr id="phoneId">
                  <td class="blue">集团产品名称</td>
                  <td>
                    <input type="text" name="jtcpmc" readonly class="InputGrey"  value="<%=jtcpmc%>">
                  </td>
                  <td class="blue">集团类别</td>
                  <td>
                    <input type="text" readonly class="InputGrey"  value="<%=jtlb%>">
                  </td>
                </tr>
				<tr id="phoneId">
                  <td class="blue">客户经理名称</td>
                  <td>
                    <input type="text" readonly class="InputGrey"  value="<%=khjlmc%>">
                  </td>
                  <td class="blue">客户经理工号</td>
                  <td>
                    <input type="text" readonly class="InputGrey"  value="<%=khjlgh%>">
                  </td>
                </tr>
				<tr id="phoneId">
                  <td class="blue">集团客户名称</td>
                  <td colspan=3>
                    <input type="text" readonly class="InputGrey"  value="<%=jtkhmc%>">
                  </td>
                   
                </tr>
				 
					</table>
			 <!--xl add-->
			 <table cellspacing="0">
                <tr nowrap>
                  <td class="blue" width="15%">备注</td>
                  <td>
                    <textarea name="backnote" rows="3"  cols="68" onKeyDown="LimitTextArea(this)" onKeyUp="LimitTextArea(this)" onkeypress="LimitTextArea(this)" ><%=usernode%></textarea>
				  				</td>
                </tr>
              </table>
    			 


			<%
					if(flag==0){
			%>

			</div>
			<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">欠费信息</div>
			</div>
              <table cellspacing="0">
                <tr align="center">
                  <th>服务号码</th>
                  <th>欠费月</th>
                  <th>欠费金额</th>
                  <th>滞纳金</th>
                  <th>应收金额</th>
                  <th>优惠金额</th>
                  <th>预存划拨</th>
                  <th>新交款</th>
                </tr>


     <%
     	String tbClass="";
		  for (int i=0;i<result2.length;i++) {
		  		if(i%2==0){
		  			tbClass="Grey";
		  		}
			    if (!result2[0][0].equals("000000")){
			%>
		   <tr align="center">
	            <td class="<%=tbClass%>"><%=result2[i][0]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][1]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][2]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][3]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][4]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][5]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][6]%></td>
	            <td class="<%=tbClass%>"><%=result2[i][7]%></td>
           </tr>
     <%
     			}
     		}
     %>
        </table>
			</div>
							<div id="Operation_Table">
							<div class="title">
								<div id="title_zi">缴费信息</div>
							</div>
              <table cellspacing="0">
                <tr>
                  <td class="blue" noWrap>合计应收</td>
                  <td noWrap>
                    <input type="text" name="totalFee" readonly class="InputGrey" value="<%=sDeservedFee%>">
                  </td>
                  <td class="blue" noWrap>滞纳金优惠率</td>
                  <td noWrap>
                    <input type="text" name="delayRate" maxlength="10" value="1" onBlur="CheckRate(this, '滞纳金优惠率')"    onKeyPress="return isKeyNumberdot(1)" <%=Predel_Favourable%>>
                  </td>
                  <td class="blue" noWrap>补收月租优惠率</td>
                  <td noWrap>
                    <input type="text" name="remonthRate" maxlength="10" value="0" onBlur="CheckRate(this, '补收月租优惠率')"   onKeyPress="return isKeyNumberdot(1)" <%=Predel_Favourable%>>
                  </td>
                </tr>

                <tr>
                  <td class="blue" noWrap>缴费方式</td>
                  <td noWrap>
                    <select name="moneyType" onClick="selType()" onchange="chkType('<%=s_zq%>')">
	                  <option value="0">现金缴费</option>
	                  <option value="9">支票缴费</option>
		<!--
			  <option value="8">POS机缴费</option>
		 -->
			  <!--liyan add pos机 20090825-->
			  <option value="BX">建设银行POS机缴费</option>
			  <option value="BY">工商银行POS机缴费</option>
                     </select>
                  </td>
                  <td class="blue" noWrap>缴费金额</td>
                  <td noWrap>
                    <input type="text" name="payMoney" maxlength="10"  onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();" value="<%=invoice_money%>" <%=s_read_only%>>
                    <font class="orange"><b>（<span id ="deservedPay"><%=sPayMoney%>0</span>）</b></font>
				  				</td>
                  <td class="blue" noWrap><input type=button class="b_text" style="cursor:hand" onClick="accountShoudFecth()" value="计算">&nbsp;&nbsp;找零</td>
                  <td noWrap><input name="shoudfetchmoney" size="5" maxlength="5" class="InputGrey" readOnly></td>
                </tr>

                <tr id="CheckId" style="display:none">
                  <td class="blue" noWrap>银行代码</td>
                  <td noWrap>
                    <input name="BankCode" size="12" maxlength="12">
                    <input name="BankName" size="13" onKeyDown="if(event.keyCode==13)getBankCode();" >
                    <input name="bank1CodeQuery" type=button class="b_text" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=查询 >
				  				</td>
                  <td class="blue" noWrap>支票号码</td>
                  <td noWrap>
                    <input type="text" name="checkNo" maxlength="20" value="" onKeyDown="if(event.keyCode==13)getcheckfee();" onChange="document.frm.currentMoney.value=''">
                    <input name=checkfeequery type=button class="b_text" style="cursor:hand" onClick="getcheckfee()" value=查询>
                   </td>
                  <td class="blue" noWrap>可用金额</td>
                  <td noWrap>
                    <input type="textarea" readonly name="currentMoney">
                  </td>
                </tr>

								<tr id="POS_Id"  style="display:none" cellpadding="4">
                  <td class="blue" noWrap>银行卡号</td>
                  <td noWrap>
                    <input name="pos_code" size="16" type="text" maxlength="19" value="" onKeyDown="if(event.keyCode==13)getposcode();">
				  				</td>
                  <td class="blue" noWrap>银联流水号</td>
                  <td colspan="3" noWrap>
                    <input type="text" name="pos_accept" maxlength="6" value="" size="6" onKeyDown="if(event.keyCode==13)getposcode();">
                   </td>
                </tr>

                <tr>
                  <td class="blue" noWrap>备注信息</td>
                  <td noWrap colspan="5">
                    <input type="text" name="payNote" size="60" maxlength="50" class="InputGrey" readonly>
                  </td>
                </tr>

                <tr>
                  <td noWrap colspan="6" id="footer">
                    <div align="center">
                      <input type="button" name="print" class="b_foot" value="确认&打印" onClick="return doprint();"  >
                      &nbsp;
                      <input type="button" name="return1" class="b_foot" value="返回" onClick="window.location.href='s1300_group.jsp'">
                      &nbsp;
                      <input type="button" name="close1" class="b_foot" value="关闭" onClick="parent.removeTab('<%=opCode%>')">
                    </th>
                </tr>
              </table>

					<%@ include file="/npage/include/footer.jsp" %>
     <%
     			}
     %>
	</FORM>


<script language="javascript" >

<!--

var popupWindow  = null;

function popup_window(UserCheckCond)
{
	var i = 0;
	var	varString = "";

	popupWindow = window.open("", "12", "height=400, width=250, top=60,left=770, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
 	popupWindow.document.write("<TITLE>黑龙江移动业务宣传页</TITLE>");
 	popupWindow.document.write("<BODY BGCOLOR=#ffffff>");
	popupWindow.document.write("<h3>黑龙江移动业务宣传页!</h1>");
	popupWindow.document.write("<TABLE height=150 cellSpacing=0 cellPadding=0 width=300 border=0>");
	for(;UserCheckCond.indexOf("|") > 0;)
	{
		varString = UserCheckCond.substring(0,UserCheckCond.indexOf("|"));
		popupWindow.document.write("<TR>★ "+varString+"</TR>");
		UserCheckCond= UserCheckCond.substring(UserCheckCond.indexOf("|")+1,UserCheckCond.length);
	}
	popupWindow.document.write("</TABLE>");
	popupWindow.document.write("<CENTER><INPUT TYPE='BUTTON' VALUE='关闭' onClick='window.close()'></CENTER>");
	popupWindow.document.write("</BODY>");
	popupWindow.document.write("</HTML>");
	popupWindow.document.close();

}

function popup_window_close()
{
	if (popupWindow != null)
	{
		popupWindow.close();
	}
}

function countPayMoney()
{
   var paymoney ;
   with(document.frm)
	{

	   paymoney = parseFloat(sumusefee.value) +  parseFloat(sumdelayfee.value)*(1-parseFloat(delayRate.value))  + parseFloat(predelFee.value)*(1-parseFloat(remonthRate.value)) - parseFloat(prepayFee.value);

		if(document.all.Area!=null){
			paymoney += parseFloat(area.value);
		}
		if(paymoney<0)   paymoney = 0;
        totalFee.value=formatAsMoney(paymoney);
	    payMoney.value = formatAsMoney(Math.ceil(paymoney));

	}
	  document.all.deservedPay.innerText = document.frm.payMoney.value;
}



 function CheckRate(obj , msg)
 {
     var i , j=0;
	 	 var derate = 0;


			if(!dataValid( 'b' , obj.value))
		   {
             rdShowMessageDialog("请输入有效的"+msg);
 	         	 obj.value = 0;
             countPayMoney();
	           obj.focus();
 	           return false;
		    }
		    derate= parseFloat(obj.value);

			if (  derate < 0  ||  derate> 1  )
			{
             rdShowMessageDialog(msg + "只能在0和1之间！");
 	           obj.value = 0;
             countPayMoney();
 	           obj.focus();
 	           return false;
			}
        countPayMoney()	;
		return true;

}


 function doCheck()
 {

	 var paymoney;
	 var temp ;

     with(document.frm)
     {

 			 paymoney = payMoney.value;

   			if( paymoney=='')
		   {
               rdShowMessageDialog("缴费金额不能为空，请重新输入 !");
   	           payMoney.focus();
 	           return false;
		    }

			if(!dataValid( 'b' , paymoney))
		   {
               rdShowMessageDialog("您输入的是  "+ paymoney +" , 请输入有效的缴费金额！");
   	           payMoney.focus();
 	           return false;
		    }


			if ( paymoney.indexOf(".")!=-1)
			{
				temp =  paymoney.substring(paymoney.indexOf(".")+1,paymoney.length);
 				if ( temp.length> 2 )
				{
					rdShowMessageDialog("缴费金额小数点后只能输入2位！");
					payMoney.focus();
					return false;
				}
			}

            if(parseFloat(paymoney) < 0)
		  	{
				rdShowMessageDialog(" 缴费金额不能为负数！");
                payMoney.focus();
                return false;
          	}

			if( parseFloat(paymoney) < parseFloat(totalFee.value) ) {
				rdShowMessageDialog("请注意，此笔只是部分缴费，用户仍有欠费！");
			}
			/* xl add 改为300w
			20141230 去掉此限制*/
			if( parseFloat(paymoney)> 10000000 ) {
				rdShowMessageDialog("缴费金额不能大于10,000,000！");
				payMoney.focus();
                return false;
			}
			
			

			if (moneyType.value=="9")
			{

				if(currentMoney.value=="")
				{
					rdShowMessageDialog("请校验支票号码！");
				   document.all.checkNo.focus();
				    return false;

				}
				if (parseFloat(currentMoney.value)<parseFloat(paymoney))
				{
					rdShowMessageDialog("请注意，支票金额不足！");
				   document.all.checkNo.focus();
				   return false;
				}
			}
			if (moneyType.value=="8")
			{
				if(getposcode()==false)
					return false;
			}

              payMoney.value = formatAsMoney(paymoney);
 	}
 }
 function chkType(flag)
 {
	// alert("flag is "+flag);
	 with(document.frm)
	 {
		 if(moneyType.value!="1" && flag=="1")
         {
			rdShowMessageDialog("政企客户只能进行现金缴费!");
			moneyType.options[0].selected = true;
			return false;
		 } 
	 }	
 }

 function selType()
 {
      with(document.frm)
      {
	        if ( moneyType.value=="9" ){
							POS_Id.style.display="none";
							CheckId.style.display="block";
					}else if(moneyType.value=="8"){
				 			CheckId.style.display = "none";
							POS_Id.style.display="block";
					}else{
							POS_Id.style.display="none";
							CheckId.style.display="none";
					}
		 }

 }


  function conShort()
 {
	rdShowMessageDialog("此帐户号码为多个号码付费，请配置缴、退费短信接收号码！");
	window.open("/npage/s1211/f1771.jsp?contractNo="+document.all.contractno.value,"","width=1000,height=600");
 }

  function doClose()
  {

  	<%
		if (ispopmarket.compareTo("0")==0){
	  %>
 		popup_window_close();
    <%
  	  }
 	  %>
  	window.close();
  }

/*tianyang add POS缴费 start*/
function getSysDate()
{
	var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","正在获得系统时间，请稍候......");
	myPacket.data.add("verifyType","getSysDate");
	core.ajax.sendPacket(myPacket);
	myPacket = null;

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
/*tianyang add POS缴费 end*/
/*xl 1217 哈分自动稽核*/
 function getLimit()
{
	var myPacket = new AJAXPacket("../s1300/getLimit.jsp?payMoney="+document.all.payMoney.value,"正在查询验证缴费可用额度，请稍候......");
	
	core.ajax.sendPacket(myPacket);
	myPacket = null;
	 
}
 function doprint()
 {
 		var s_sm_code="<%=s_sm_code%>";
		//alert(s_sm_code);
		if(s_sm_code=="PB")
		{
			rdShowMessageDialog("物联网号码不允许进行缴费!");
			return false;
		}
		else
		{
			getAfterPrompt();
			getLimit();
			var show = document.getElementById("show").value;
		//	alert("the doprint showvalue is "+show);
			

	   <%
			if (ispopmarket.compareTo("0")==0){
		  %>
			popup_window_close();
		<%
		  }
		  %>
		if(document.frm.payNote.value.trim().len()==0){
			document.frm.payNote.value='<%=val_showflag%>';
		}

		if(document.frm.count_num.value ==0 && document.frm.contract_num.value>=2){
			conShort();
	  }
		if(show=="ok")
		{
				if(doCheck()==false)
				 return false;

				 var	prtFlag = rdShowConfirmDialog("本次缴费金额"+document.frm.payMoney.value+"元,是否确定缴费？");
				if (prtFlag==1)
				{

					/*liyan add pos机 20090825 */
					if(document.frm.moneyType.value=="BX")
					{
						/*set 输入参数*/
							var transerial    = "000000000000";  	                     //交易唯一号 ，将会取消
							var trantype      = "00";                                  //交易类型
							var bMoney        = document.all.payMoney.value;
							var tranamount    = padLeft(bMoney.replace(".",""),"0",12);//缴费金额
							var tranoper      = "<%=workno%>";                         //交易操作员
							var orgid         = "<%=groupId%>";                        //营业员归属机构
							var trannum       = "<%=phoneNo%>";                        //电话号码
							getSysDate();       /*取系统时间*/
							var respstamp     = document.all.Request_time.value;       //提交时间
							var transerialold = "";			                               //原交易唯一号,在缴费时传入空
							var org_code      = "<%=org_code%>";                       //营业员归属

							/* 调用 posCCB.jsp 中方法设置 IP，端口，串口端口 */
					  SetSysInfo();
					  /* 调用控件，进行参数传递 */
							BankCtrl.SetTranData(transerial,trantype,tranamount,tranoper,orgid,trannum,respstamp,transerialold,org_code);

							/* 按钮变灰 */
							document.frm.print.disabled=true;
							document.frm.return1.disabled=true;
							document.frm.close1.disabled=true;

							/*调用开始交易*/
							BankCtrl.StratTran();

					}
					else if(document.frm.moneyType.value=="BY")
						{
							var TransType     = padLeft("05"," ",2);                             /*交易类型 */
							var bMoney        = document.all.payMoney.value;
							var Amount        = padLeft(bMoney.replace(".",""),"0",12);          /*交易金额 */
							var OldAuthDate   = padLeft(""," ",8);                               /*原交易日期 */
							var ReferNo       = padLeft(""," ",8);                               /*原交易系统检索号 */
							var InstNum       = padLeft(""," ",2);                               /*分期付款期数 */
							var oldterid      = padLeft(""," ",15);                              /*原交易终端号 */
							getSysDate();       /*取boss系统时间*/
							var requestTime   = padLeft(document.all.Request_time.value," ",14); /*交易提交日期 */
							var login_no      = padLeft("<%=workno%>"," ",6);                    /*交易操作员 */
							var org_code      = padLeft("<%=org_code%>"," ",9);                  /*营业员归属 */
							var org_id        = padLeft("<%=groupId%>"," ",10);                  /*营业员归属机构 */
							var phone_no      = padLeft("<%=phoneNo%>"," ",15);                  /*交易缴费号 */
							var toBeUpdate    = padLeft(""," ",100);                             /*预留字段 */
							var inputStr = TransType+Amount+OldAuthDate+ReferNo+InstNum+oldterid+requestTime+login_no+org_code+org_id+phone_no+toBeUpdate;

							/* 调用 posICBC.jsp 中方法设置 IP，端口，串口端口 以及传入参数*/
							var str = SetICBCCfg(inputStr);

							if(str.split("|").length==21)
							{
								if (str.split("|")[19] !="00")
								{
									rdShowMessageDialog("银行返回错误!<br>错误代码："+str.split("|")[19]+"错误信息："+str.split("|")[0]);
									document.frm.print.disabled=false;
									document.frm.return1.disabled=false;
									document.frm.close1.disabled=false;
								}else{
									document.all.MerchantNameChs.value = str.split("|")[10]+str.split("|")[11]; /*商户名称（中英文)*/
									document.all.MerchantId.value      = str.split("|")[8];	    /*商户编码*/
									document.all.TerminalId.value      = str.split("|")[7];	    /*终端编码*/
									document.all.IssCode.value         = str.split("|")[14];		/*发卡行号*/
									document.all.AcqCode.value         = "ICBC";	              /*收单行号*/
									document.all.CardNo.value          = str.split("|")[3];			/*卡号*/
									document.all.BatchNo.value         = str.split("|")[13];		/*批次号*/
									document.all.Response_time.value   = str.split("|")[1]+str.split("|")[2];   /*回应日期时间*/
									document.all.Rrn.value             = str.split("|")[6];	    /*参考号*/
									document.all.AuthNo.value          = "";		                /*授权号*/
									document.all.TraceNo.value         = str.split("|")[12];		/*流水号*/
									/*提交时间 通过调用  getSysDate() 已经得到*/
									document.all.CardNoPingBi.value    = str.split("|")[4];     /*交易卡号（屏蔽）*/
									document.all.ExpDate.value         = str.split("|")[5];     /*卡片有效期*/
									document.all.Remak.value           = str.split("|")[17];    /*备注信息*/
									document.all.TC.value              = str.split("|")[9];     /*需要打印，用于EMV交易（芯片卡）*/
									frm.submit();
								}
							}else{
								rdShowMessageDialog("返回值数量错误！");
								document.frm.print.disabled=false;
								document.frm.return1.disabled=false;
								document.frm.close1.disabled=false;
							}
						}
						else
						{
						 document.frm.print.disabled=true;
							 document.frm.return1.disabled=true;
							 document.frm.close1.disabled=true;
							 frm.submit();
							 return true;
					}
					}
					else
					{
						return false;
					}
		}
		else{
		//	alert("禁止缴费 the value is "+show+" 这句话后期要去掉");
			return false;
		}
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
	if (trim(checkno)=="")
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
	var str=window.showModalDialog('getcheckfee.jsp?bankcode='+bankcode+'&checkno='+checkno,"",prop);
	if( str==null )
		{
 	   		rdShowMessageDialog("没有找到该支票的余额！");
		    document.frm.currentMoney.value = "";
	   		document.frm.checkNo.focus();
	   		return false;
		}

		document.frm.currentMoney.value = str;
 		document.all.print.focus();
	    return true;
 }


function getposcode()
{
	var posCode = document.all.pos_code.value;
	var posAccept = document.all.pos_accept.value;
	if (trim(posCode)=="")
	{
		rdShowMessageDialog("银行卡号不能为空!");
		document.all.pos_code.value="";
	    document.all.pos_code.focus();
 	    return false;
	}
	if (trim(posAccept)==""||posAccept.length!=6)
	{
		rdShowMessageDialog("请重新输入银联流水号!");
		document.all.pos_accept.value="";
	    document.all.pos_accept.focus();
	     return false;
    }
	return true ;
}


function accountShoudFecth() {
     var temp1 = document.frm.payMoney.value;
	 var temp2 = document.frm.totalFee.value;
     var temp3 = Math.round((temp1 - temp2)*100)/100;

     document.frm.payMoney.value = document.frm.totalFee.value;
	 document.frm.shoudfetchmoney.value = temp3;
}

function getBankCode()
{
 		 var h=480;
		 var w=650;
		 var t=screen.availHeight/2-h/2;
		 var l=screen.availWidth/2-w/2;

	      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
          var returnValue=window.showModalDialog('getBankCode.jsp?region_code=<%=org_code.substring(0,2)%>&district_code=<%=org_code.substring(2,4)%>&bank_name='+frm.BankName.value+'&bank_code='+frm.BankCode.value,"",prop);

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
/***HARVEST  wangmei 20060801 添加*****/
/*HARVEST 王梅 20061031 添加为了开发需求332 判断用户入网时间和中奖情况*/

 

 -->
</script>


<!-- **********加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/s1300/posCCB.jsp" %>
<script language="javascript" FOR="BankCtrl" event="Completed()" >
	str = BankCtrl.GetTranData();
	if(str.split("|").length==21)
	{
		if (str.split("|")[6] !="00")
		{
			rdShowMessageDialog("银行返回错误!<br>错误代码："+str.split("|")[6]+"，错误信息："+str.split("|")[7]+"。");
			document.frm.print.disabled=false;
			document.frm.return1.disabled=false;
			document.frm.close1.disabled=false;
		}else{
			document.all.MerchantNameChs.value = str.split("|")[9];  /*商户名称（中英文)*/
			document.all.MerchantId.value      = str.split("|")[10]; /*商户编码*/
			document.all.TerminalId.value      = str.split("|")[11]; /*终端编码*/
			document.all.IssCode.value         = str.split("|")[15]; /*发卡行号*/
			document.all.AcqCode.value         = str.split("|")[16]; /*收单行号*/
			document.all.CardNo.value          = str.split("|")[8];	 /*卡号*/
			document.all.BatchNo.value         = str.split("|")[13]; /*批次号*/
			document.all.Response_time.value   = str.split("|")[5];	 /*回应日期时间*/
			document.all.Rrn.value             = str.split("|")[14]; /*参考号*/
			document.all.AuthNo.value          = "";                 /*授权号*/
			document.all.TraceNo.value         = str.split("|")[12]; /*流水号*/
			/*提交时间 通过调用  getSysDate() 已经得到*/
			document.all.CardNoPingBi.value    = getCardNoPingBi(str.split("|")[8]);/*交易卡号（屏蔽）*/
			document.all.ExpDate.value         = "";                 /*卡片有效期*/
			document.all.Remak.value           = "";                 /*备注信息*/
			document.all.TC.value              = "";                 /*需要打印，用于EMV交易（芯片卡）*/
			frm.submit();
		}
	}else{
		rdShowMessageDialog("返回值数量错误！");
		document.frm.print.disabled=false;
		document.frm.return1.disabled=false;
		document.frm.close1.disabled=false;
	}

</script>

<!-- **********加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/s1300/posICBC.jsp" %>
</body>
</html>

<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=return_code%>'，错误信息：'<%=SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code))%>'。");
		window.location.href="<%=return_page%>";
	 </script>
<% } %>

