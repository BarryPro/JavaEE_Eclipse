<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-21
********************/
%>
<%
  String opCode = "5255";
  String opName = "空中充值帐户缴费";
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.util.*"%>
<%@ include file="/npage/common/popup_window.jsp" %>

 <%
 
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String nopass = (String)session.getAttribute("password");
		String regionCode = (String)session.getAttribute("regCode");

		System.out.println("regionCode="+regionCode);
    String phoneNo = request.getParameter("phoneNo");
	String contractno = request.getParameter("contractno");
	String busy_type= request.getParameter("busy_type");
 	String op_code  =request.getParameter("op_code");

	System.out.println("000---contractno=["+contractno+"]");
	System.out.println("000---phoneNo=["+phoneNo+"]");

    String[] inParas = new String[2];
	String[] inParas1 =new String[2];//芦学琛20060301add,用于查询开户时间
	String showopentime = "";
	String[][] result  = null ;

	String count_num="0";
	String contract_num="0";
	String busy_name="";
	String return_page="";
	String contractCount = "-1";
	System.out.println("3232---contractno=["+contractno+"]");
	
	if(busy_type.equals("1")) {
		busy_name="按服务号码缴费";
		return_page="s1300.jsp?activePhone="+phoneNo+"&opCode=5255&opName=空中充值帐户缴费";       
 /*******芦学琛20060301add,查询开户时间 *****  begin******/
		/*String inParas_sql1="select to_char(a.open_time,'YYYY-MM-DD HH24:MI:SS') from dcustinnet a,dCustMsg b where a.id_no=b.id_no and substr(b.run_code,2,1)<'a' and b.phone_no='?'";*/
		inParas1[0]="22";
		inParas1[1]="phone_no="+phoneNo;
		
%>

		<wtc:service name="sCrmDefSqlSel" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  			<wtc:param value="<%=inParas1[0]%>"/>
 			<wtc:param value="<%=inParas1[1]%>"/>
 	  </wtc:service>
	 <wtc:array id="result_t1" scope="end"/>

<%		
		
		result = result_t1;
		if(result==null||result.length==0)
			showopentime ="未查到";
		else if(result.length==1)
			showopentime = result[0][0];
		else
			showopentime ="查出多个开户时间";
 /*****芦学琛20060301add,查询开户时间 ***** end******/		
		if (contractno != null && !contractno.equals("")) {
			System.out.println("4444---contractno=["+contractno+"]");
		     inParas1[0] = "18";
			 inParas1[1]="contract_no="+contractno;
%>

		<wtc:service name="sBossDefSqlSel" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  			<wtc:param value="<%=inParas1[0]%>"/>
 		    <wtc:param value="<%=inParas1[1]%>"/>
 	  </wtc:service>
	 <wtc:array id="result_t2" scope="end"/>

<%            
             result = result_t2;
			 if (result.length == 1) {
		        contractCount = result[0][0];
			 }
		}
	}

	/*王良加入幸运52领奖提示*/
	String luck52 = "";
inParas1[0] = "27";
inParas1[1] ="phone_no="+phoneNo;
%>

		<wtc:service name="sCrmDefSqlSel" outnum="1" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
		   <wtc:param value="<%=inParas1[0]%>"/>
		   <wtc:param value="<%=inParas1[1]%>"/>
 	  </wtc:service>
	 <wtc:array id="result_t3" scope="end"/>

<%  
 
  result = result_t3;
  if (result.length == 1) {
		luck52 = result[0][0]; 
		System.out.println("-----------------strHasRec=["+luck52+"]");
	}
		
	if(busy_type.equals("1") || busy_type.equals("2")) {
		System.out.println("222---contractno=["+contractno+"]");
		 inParas1[0]= "19";
		 inParas1[1]="contract_no="+contractno;
%>

		<wtc:service name="sBossDefSqlSel" outnum="1" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas1[0]%>"/>
			<wtc:param value="<%=inParas1[1]%>"/>
 	  </wtc:service>
	 <wtc:array id="result_t4" scope="end"/>

<%		
	   
		result = result_t4;
		if (result.length == 1) {
		   count_num = result[0][0];
		}
		System.out.println("count_num=["+count_num+"]");
		if(count_num.equals("0")) {
			 inParas1[0] = "27 ";
			 inParas1[1]="contract_no="+contractno;
%>

		<wtc:service name="sBossDefSqlSel" outnum="1" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
  			<wtc:param value="<%=inParas1[0]%>"/>
 			<wtc:param value="<%=inParas1[1]%>"/>
 	  </wtc:service>
	 <wtc:array id="result_t5" scope="end"/>


<%			
	
			result = result_t5;
			if (result.length == 1) {
			  contract_num = result[0][0];
			}
		}
		System.out.println("contract_num=["+contract_num+"]");
	}
	if(busy_type.equals("2")) {
		busy_name="按帐户号码缴费";
		return_page="s1300_2.jsp?activePhone="+phoneNo+"&opCode=5255&opName=空中充值帐户缴费";
	}

	if(busy_type.equals("4")) {
		busy_name="按付费号码缴费";
		return_page="s1300_4.jsp?activePhone="+phoneNo+"&opCode=5255&opName=空中充值帐户缴费";
        
		//付费号码,付费类型 
	    String serviceno = request.getParameter("serviceno");
	    String servicetype = request.getParameter("servicetype");
		inParas1[0]= "26";
		inParas1[1]="service_no="+serviceno+",servicetype="+servicetype;
        
%>

		<wtc:service name="sCrmDefSqlSel" outnum="1" retmsg="msg6" retcode="code6" routerKey="region" routerValue="<%=regionCode%>">
  			 <wtc:param value="<%=inParas1[0]%>"/>
 	    	 <wtc:param value="<%=inParas1[1]%>"/>
 	  </wtc:service>
	 <wtc:array id="result_t6" scope="end"/>

<%        
		
		result = result_t6;
		if (result.length == 1) {
		   phoneNo = result[0][0];
		} else {
		   phoneNo = "11111111111";
		}
	}
	
    //==============================获取营业员信息
	//空中充值帐户判断
	String agtFlag = "";
	System.out.println("-------zhangss------"+phoneNo);
    inParas1[0] = "38";
	inParas1[1]="agt_phone="+phoneNo;
%>

		<wtc:service name="sBossDefSqlSel" outnum="1" retmsg="msg7" retcode="code7" routerKey="region" routerValue="<%=regionCode%>">
  	     <wtc:param value="<%=inParas1[0]%>"/>
 	     <wtc:param value="<%=inParas1[1]%>"/>
 	  </wtc:service>
	 <wtc:array id="result_t7" scope="end"/>


<%
 
  result = result_t7;
  if (result.length == 1) {
		agtFlag = result[0][0]; 
		System.out.println("该号码空中充值帐户数量"+agtFlag);
	}%>
	<SCRIPT LANGUAGE="JavaScript">
	
		if ("<%=agtFlag%>"<=0){
		 
	    rdShowMessageDialog("此空中充值代理商已关闭或无效，请咨询当地渠道管理人员",0);
	    history.go(-1);
    }	

  </SCRIPT>

<%

	//优惠信息    //解析营业员优惠权限
    String[][] favInfo = (String[][])session.getAttribute("favInfo");  //数据格式为String[0][0]---String[n][0]
    String Delay_Favourable = "readonly";        //a040  滞纳金费优惠
    String Predel_Favourable = "readonly";       //a041  补收月租费优惠
    int infoLen = favInfo.length;
    String tempStr = null;
    for(int i=0;i<infoLen;i++)
    {
        tempStr = (favInfo[i][0]).trim();
		
        if(tempStr.equals("a040") )    Delay_Favourable = "";
        if(tempStr.equals("a041"))     Predel_Favourable = "";
 	}

	String TGroupFlag="" ;
	String TBigFlag  ="";
	String BigFlag = "0";

	StringBuffer accountstr  = new StringBuffer(80);   //多账户字符串
	StringBuffer namestr=new StringBuffer(80);        //多账户名称字符串
	StringBuffer accounttypestr=new StringBuffer(80);        //帐户类型
    StringBuffer paytypestr=new StringBuffer(80);        //付费方式
    StringBuffer shoudpaystr=new StringBuffer(80);        //欠费


	String[][] result1  = null ;
	String[][] result2  =null;
	String[][] result3  = null;
	String[][] result4  = null;
	String iretCode="";
	String iretMsg="";
	
	
	inParas = new String[6];
	inParas[0] = phoneNo;
	inParas[1] = contractno;
	inParas[2] = busy_type;
	inParas[3] = org_code;
	inParas[4] = nopass;
	inParas[5] = workno;
	System.out.println(phoneNo+","+contractno+","+busy_type+","+org_code+","+nopass+","+workno);

	
  if(busy_type.equals("1") || busy_type.equals("4")){
     //value  = viewBean.callService("2", phoneNo ,  "s5255_Valid", "28"  ,  lens , inParas,map) ;
     
try{     
%>
	<wtc:service name="s5255_Valid" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode5" retmsg="retMsg5" outnum="28">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr1" start="0" length="20" scope="end"/>
	<wtc:array id="sVerifyTypeArr2" start="20" length="8" scope="end"/>
<%

		result1 = sVerifyTypeArr1;
		result2 = sVerifyTypeArr2;
		result3 = sVerifyTypeArr2;
		iretCode = retCode5;
		iretMsg = retMsg5;
}catch(Exception e){

}		
		
  }
  if(busy_type.equals("2")){
	   //value  = viewBean.callService("1", org_code.substring(0,2),  "s1300_Valid1", "19"  ,  lens_1 , inParas,map) ;
%>
	<wtc:service name="s1300_Valid1" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode5" retmsg="retMsg5" outnum="20">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr1" start="0" length="10" scope="end"/>
	<wtc:array id="sVerifyTypeArr2" start="10" length="8" scope="end"/>
	<wtc:array id="sVerifyTypeArr3" start="18" length="1" scope="end"/>
<%
		result1 = sVerifyTypeArr1;
		result2 = sVerifyTypeArr2;
		result3 = sVerifyTypeArr2;
		result4 = sVerifyTypeArr3;
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

    String nobillpay = null;   //未出账话费
	
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

System.out.println("---------------------busy_type--------------------"+busy_type);
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
             showPrePay = result1[0][19].trim();
	   }

	   if(busy_type.equals("2"))
	   {
          nobillpay =  result4[0][0].trim();
	   } 
												 
System.out.println("---------------------nobillpay--------------------"+nobillpay);        
				for (int i=0; i < result2.length;i++)
				{
					sum_usefee = sum_usefee + Double.parseDouble(result2[i][2]);   
					sum_delayfee = sum_delayfee + Double.parseDouble(result2[i][3]);
				}
                 
                sPredelFee =   Double.parseDouble(predelFee);
	            
				if (nobillpay != null) {
				    snobillpay =   Double.parseDouble(nobillpay);
				}
        
				if (credit != null) {
				    sCredit = Double.parseDouble(credit);
				}		           		
	            
				sOweFee = sum_delayfee+sum_usefee + sPredelFee + snobillpay - sCredit;
				
				if(busy_type.equals("1")) {
				    curbalanace = String.valueOf((double) Math.round((Double.parseDouble(prepayFee) - sOweFee)*100)/100);
				}

	            if (sCredit > 0.00)
					sOweFee = sPredelFee + snobillpay;
				else
					sOweFee = snobillpay - sCredit;
        
 				if (sOweFee<=Double.parseDouble(prepayFee))
				    sDeservedFee = 0;
				else 
                    sDeservedFee=sOweFee-Double.parseDouble(prepayFee);
                
                sDeservedFee = sDeservedFee + sum_delayfee + sum_usefee + sPredelFee;
                
				sDeservedFee = (double) Math.round(sDeservedFee*100)/100;  //四舍五入
		        
 				sPayMoney =Math.ceil(sDeservedFee);
 				  
	}
	else    //多账户
	{
		 flag = 1;
		 for(int i = 0; i < result3.length; i++)
		{
      accountstr.append(result3[i][0].trim());
			accountstr.append(",");
      namestr.append(result3[i][1].trim());
			namestr.append(" ,");
	    accounttypestr.append(result3[i][2].trim());
			accounttypestr.append(" ,");paytypestr.append(result3[i][3].trim());
			paytypestr.append(" ,");
			shoudpaystr.append(result3[i][4].trim());
			shoudpaystr.append(" ,");
			
	    }
        
       System.out.println("accountstr===" +  accountstr);
       System.out.println("namestr===" +  namestr);

	}
	
	

%>

<HTML>
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>


<title>黑龙江BOSS-空中充值代理商帐户充值</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

</head>
<SCRIPT LANGUAGE="JavaScript">
	
		
    
<!--
	//xl
 function doProcess(packet){
	 
	var return_code = packet.data.findValueByName("return_code"); 
	var return_msg = packet.data.findValueByName("return_msg"); 
	var flag = packet.data.findValueByName("result");
 
    var ed = packet.data.findValueByName("outPledge");
	var total = packet.data.findValueByName("f_temp_total_pay");
	var money = packet.data.findValueByName("payMoney");
	/*tianyang add for pos缴费 end*/
	//alert("test for return_code is "+return_code); 
	if(return_code=="000000" ){
		//要判断 results 的值 1 可以缴费 0就不可以了 也就是是否 >= 90% 
		//更新：需要对0的时候 判断flag 如果冒了要提示 也就是flag=1 要提示
		//rdShowMessageDialog("判断flag的值是 "+flag+"<br>"+" and 另起一行");
		if(flag == "1"){
			rdShowMessageDialog("本网点代办押金额度为:"+ed+",当前日累积营业额为:"+total+",本次缴纳费用为:"+money+",请及时进行资金上缴,否则将无法正常办理缴费!");
		}
		document.getElementById("show").value="ok";
		//return true; 
	}
	/*
	else if (return_code == "001001"){ 
		rdShowMessageDialog("查询信息为空 即出错了！ "+return_code);
		return false;
	}
	else if(return_code == "000011"){
		
		rdShowMessageDialog("冒了!本网店代办押金额度为"+ed);
		return false;
	}
	else if(return_code == "000012"){
		rdShowMessageDialog("<%=return_msg%>");
		return false;
	}*/
	
	else{
		 
		
		if(return_code == "000011"){
			rdShowMessageDialog("本网点代办押金额度为:"+ed+",当前日累积营业额为:"+total+",本次缴纳费用为:"+money+",无法办理!");
		}
		else{
			rdShowMessageDialog("错误代码： "+return_code+",<p>错误信息："+return_msg);
		}
		document.getElementById("show").value="no";
		//return false; 
	}
	 
	 

}//xl
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
             rdShowMessageDialog("您没有选择帐户！",0);
             window.location.href="s1300.jsp?ph_no=<%=phoneNo%>";     
		  }
		 else
		 {
			    document.frm.contractno.value = returnValue;
				document.frm.action = "s1300Cfm.jsp";
				document.frm.submit();
			}
	 
 }

 function init(){
		//以下域的缺省值是规范中的要求		
		
		<%
		if ( flag == 1 ){
		%>
		    showSelWindow();
    	<%}
 		%>
 		
  	if ("<%=runname%>"=="预拆"){
		   rdShowMessageDialog("该用户为预拆用户！",0);
		}
		
 	if ("<%=luck52%>"=="1"){
		   rdShowMessageDialog("用户参加幸运52周短信营销活动，已中奖，但未领奖，请协助用户领奖!",0);
	}
				
		
		

		<%if(busy_type.equals("1")) {%> 
		<%if (Integer.parseInt(contractCount) > 1) {%>
			    rdShowMessageDialog("该帐户对应多个服务号码，请按帐户缴费！",0);
		    <%}%>
		    
			<%if ( flag == 0 ){ %>
		       if ("<%=mhp%>"!="非中高端用户"){
		         rdShowMessageDialog("该用户中高端用户！",0);
		       }
		
		       document.all.payMoney.select();
    	    <%}%>         
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
//-->
</SCRIPT>

<BODY  onLoad="init();">
<FORM action="PayCfm.jsp" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>
<FORM action="PayCfm.jsp" method="post" name="frm" >
<input type="hidden" name="op_code"  value="<%=op_code%>">
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="unitcode" value="<%=org_code%>">
<input type="hidden" name="sumdelayfee"  value="<%=sum_delayfee%>">
<input type="hidden" name="sumusefee"  value="<%=sum_usefee%>">
<input type="hidden" name="belongcode"  value="<%=belongcode%>">
<input type="hidden" name="count_num"  value="<%=count_num%>">
<input type="hidden" name="contract_num"  value="<%=contract_num%>">
<input type="hidden" name="paySign"  value="">

	<div class="title">
		<div id="title_zi"> 空中充值代理商帐户充值 
 </div>
	</div>

              <table cellspacing="0">
                <tr> 
                  <td width="14%" class="blue">操作类型</td>
                  <td width="33%"> 
                    <input type="text"  readonly name="TbusyName"  value="<%=busy_name%>"  Class="InputGrey">
                  </td>
                  <td width="14%" class="blue">号码数量</td>
                  <td width="39%"> 
                    <input type="text"   readonly name="PhoneNum" value="<%=phoneNum%>" Class="InputGrey">
                  </td>
                </tr>
                <tr> 
                  <td width="14%" class="blue">帐户号码</td>
                  <td width="33%"> 
                    <input type="text"  readonly  Class="InputGrey" name="contractno" onKeyPress="return isKeyNumberdot(0)" value="<%=contract%>">
                  </td>
                  <td width="14%" class="blue">帐户名称 </td>
                  <td width="39%"> 
                    <input type="text" name="countName"  readonly   Class="InputGrey"  value="<%=countName%>">
                  </td>
                </tr>

                <tr id="bat_id"> 
                  <td width="14%" class="blue">用户预存</td>
                  <td width="39%"> 
                    <input type="text"  readonly   Class="InputGrey" name="showPrePay" value="<%=showPrePay%>">
                  </td>
				  <td width="14%" class="blue">可划拨预存</td>
                  <td width="33%"> 
                    <input type="text"   readonly   Class="InputGrey" name="prepayFee" value="<%=prepayFee%>">
                  </td>
                </tr>
                <tr id="phoneId"> 
                  <td width="14%" class="blue">服务号码</td>
                  <td width="33%"> 
                    <input type="text" readonly   Class="InputGrey"  name="phoneNo" value="<%=phoneNo%>" >
                  </td>
                  <td width="14%" class="blue">补收月租</td>
                  <td width="39%"> 
                    <input type="text"   readonly   Class="InputGrey" name="predelFee" value="<%=sPredelFee%>">
                  </td>
                </tr>
    			
    <% if(busy_type.equals("2")) {%>
        <tr id="phoneId"> 
             <td width="14%" class="blue">未出帐话费</td>
             <td width="33%"> 
               <input type="text" readonly   Class="InputGrey"  name="area" value="<%=result4[0][0]%>" >
             </td>
             <td width="14%"></td>
             <td width="39%"></td>
        </tr>		
	<%}%>

 
    <%if(busy_type.equals("1"))
		{%>
                  <tr   nowrap> 
                  <td width="14%" class="blue">未出帐话费</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="area" value="<%=nobillpay%>">
                    <%
		                 double nobillpaytemp = 0.0;
	                     if (nobillpay != null) {
	                         nobillpaytemp = Double.parseDouble(nobillpay);
						 }
	                %>
                    
					<input type="button" name="unbilldetail"    <%if (nobillpaytemp == 0.0) {%> disabled <%}%>  value="明细" onClick="searchUnbillDetail()" class="b_text">
                  </td>
                  <td width="14%" class="blue">信誉度</td>
                  <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="credit"  value="<%=credit%>">
                  </td>

                </tr>
                 <tr   nowrap> 
                  <td width="14%" class="blue">套餐类型</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="menu" value="<%=menu%>">
                  </td>
                  <td width="14%" class="blue">付款方式</td>
                  <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="paytype"  value="<%=paytype%>">
                  </td>

                </tr>
 
                 <tr   nowrap> 
                  <td width="14%" class="blue">业务品牌</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="busitype" value="<%=busitype%>">
                  </td>
                  <td width="14%" class="blue">当前可用余额</td>
                  <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="curbalanace"  value="<%=curbalanace%>">
                  </td>
				  </tr>

                 <tr   nowrap> 
                  <td width="14%" class="blue">中高端客户属性</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="mhp" value="<%=mhp%>">
                  </td>
                  <td width="14%" class="blue">用户名称</td>
                  <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="username"  value="<%=username%>">
                  </td>
				  </tr>
				
                 <tr   nowrap> 
                  <td width="14%" class="blue">运行状态</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="runname" value="<%=runname%>">
                  </td>
                  <td width="14%" class="blue">客户性质</td>
                  <td width="39%"><input type="text"   readonly  Class="InputGrey" name="userprop" value="<%=userprop%>">
                   </td>
                </tr>

				<tr id="note1" > 
                  <td width="14%" class="blue">
                      归属地市</td>
                  <td width="39%"> 
                    <input type="text"   readonly  Class="InputGrey" name="belongcode" value="<%=belongcode%>">
                  </td>
                 <td noWrap height=25  class="blue">是否参与抽奖</td>
                  <td noWrap > 
                    <select   name="pay_note"  >
                      <option value="0" selected >是</option>
                      <option value="1"  >否</option>
                    </select>
                    <input type="hidden"   readonly  Class="InputGrey" name="luck52"  value="<%=luck52%>">
                  </td>
				</tr>
				<tr id="note1" ><!-- 芦学琛add20060301 begin -->
                  <td noWrap height=25 class="blue">开户时间</td>
				  <td noWrap colspan="1">
				  <input type="text"  readonly  Class="InputGrey"  name="showopentime" value="<%=showopentime%>" size="20" maxlength="20">
				  </td>
				  <td>&nbsp;</td>
				  <td>
				  	&nbsp;
				  </td>
			    </tr> <!-- 芦学琛add20060301 end -->

                <tr nowrap> 
                  <td width="14%" class="blue">备注</td>
                  <td colspan="3" width="86%"> 
                    <textarea name="" rows="3" readonly  Class="InputGrey" cols="68"><%=usernode%></textarea>
				  </td>
                </tr>

       <%}%>
              </table>
 
			
<%if(flag==0){%>
	  
			  <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue">欠费信息 </td>
                </tr>
                </tbody> 
              </table>
              <table cellspacing="0">
                <tr> 
                  <td height=25> 
                    <div align="center"></div>
                  </td>
                  <td nowrap> 
                    <div align="center" class="blue">服务号码</div>
                  </td>
                  <td nowrap> 
                    <div align="center" class="blue">欠费月</div>
                  </td>
                  <td nowrap> 
                    <div align="center" class="blue">欠费金额</div>
                  </td>
                  <td nowrap> 
                    <div align="center" class="blue">滞纳金</div>
                  </td>
                  <td nowrap> 
                    <div align="center" class="blue">应收金额</div>
                  </td>
                  <td nowrap> 
                    <div align="center" class="blue">优惠金额</div>
                  </td>
                  <td nowrap> 
                    <div align="center" class="blue">预存划拨</div>
                  </td>
                  <td nowrap> 
                    <div align="center" class="blue">新交款</div>
                  </td>
                </tr>


         <%
                
		  for (int i=0;i<result2.length;i++) {
			  if (i%2==1) { %>
			      <tr> 
		      <% } else { %>
			    <tr>
			  <%}%>
			
 			      <td></td>
                   <td  align="center"> <%=result2[i][0]%> </td>
                  <td  align="center"><%=result2[i][1]%>  </td>
                  <td  align="center"><%=result2[i][2]%> </td>
                  <td  align="center"><%=result2[i][3]%> </td>
                  <td  align="center"><%=result2[i][4]%> </td>
                  <td  align="center"><%=result2[i][5]%> </td>
                  <td  align="center"><%=result2[i][6]%> </td>
                  <td  align="center"><%=result2[i][7]%></td>
                 </tr>
      <%}%>
 
              </table>

              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td></td>
                </tr>
                </tbody> 
              </table>
              <table cellspacing="0">
                <tr> 
                  <td noWrap height=25 class="blue">合计应收</td>
                  <td noWrap> 
                    <input type="text"   name="totalFee" readonly  Class="InputGrey" value=<%=sDeservedFee%>>
                  </td>
                  <td noWrap class="blue">滞纳金优惠率</td>
                  <td noWrap> 
                    <input type="text"   name="delayRate" maxlength="10" value="0" onBlur="CheckRate(this, '滞纳金优惠率')"  onKeyPress="return isKeyNumberdot(1)" <%=Delay_Favourable%> >
                  </td>
                  <td noWrap class="blue">补收月租优惠率</td>
                  <td noWrap> 
                    <input type="text"   name="remonthRate" maxlength="10" value="0" onBlur="CheckRate(this, '补收月租优惠率')"  onKeyPress="return isKeyNumberdot(1)" <%=Predel_Favourable%>>
                  </td>
                </tr>
                <tr> 
                  <td noWrap height=25 class="blue">缴费方式</td>
                  <td noWrap> 
                    <select   name="moneyType" onClick="selType()">
                      <option value="0" class="blue">现金缴费</option>
                      <option value="9" class="blue">支票缴费</option>                      
                     </select>
                  </td>
                  <td noWrap class="blue">缴费金额</td>
                  <td noWrap> 
                    <input type="text"   name="payMoney" maxlength="10" value="<%=sPayMoney%>0" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();" >
                            <font color="red"><b>（<span id ="deservedPay"><%=sPayMoney%>0</span>）</b></font>
				  </td>
                  <td noWrap><input type=button  style="cursor:hand" onClick="accountShoudFecth()" value=计算 class="b_text">&nbsp;&nbsp;找零</td>
                  <td noWrap><input name="shoudfetchmoney" size="5"  maxlength="5" readOnly  Class="InputGrey" ></td>
                </tr>
                <tr  id="CheckId"  style="display:none" > 
                  <td noWrap height=25 class="blue">银行代码</td>
                  <td noWrap> 
                    <input name="BankCode" size="5"  maxlength="5">
                    <input name="BankName" size="13"  onKeyDown="if(event.keyCode==13)getBankCode();"  >
                    <input name="bank1CodeQuery" type=button  id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=查询 class="b_text" >
            
				  </td>
                  <td noWrap class="blue">支票号码</td>
                  <td noWrap> 
                    <input type="text"   name="checkNo" maxlength="20" value="" onKeyDown="if(event.keyCode==13)getcheckfee();" onChange="document.frm.currentMoney.value=''">
                    <input name=checkfeequery type=button  style="cursor:hand" onClick="getcheckfee()" value=查询 class="b_text">
                   </td>
                  <td noWrap class="blue">可用金额</td>
                  <td noWrap> 
                    <input type="text" readonly  Class="InputGrey"  name="currentMoney">
                  </td>
                </tr>
                <tr> 
                  <td noWrap height=25 class="blue">用户备注</td>
                  <td noWrap colspan="5"> 
                    <input type="text"   name="payNote" size="60" maxlength="50" readonly class="InputGrey">
                  </td>                  
                </tr>
                <tbody> 

                <tr> 
                  <td noWrap colspan="6"> 
                    <div align="center"> 
                      <input type="button" name="print"  value="确认&打印" onClick="return doprint();"  class="b_foot_long" >
                      &nbsp;
                      <input type="button" name="return1"  value="返回" onClick="window.location.href='s1300.jsp?ph_no=<%=phoneNo%>'" class="b_foot">
                      &nbsp; 
                      <input type="button" name="close1"  value="关闭" onClick="removeCurrentTab()" class="b_foot">
                    </div>
                  </td>
                </tr>
 
                </tbody> 
              </table>

<%}%>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">
<!--

function countPayMoney()
{
   var paymoney ;
   with(document.frm)	
	{
	    paymoney = parseFloat(sumusefee.value) +    parseFloat(sumdelayfee.value)*(1-parseFloat(delayRate.value))  + parseFloat(predelFee.value)*(1-parseFloat(remonthRate.value)) - parseFloat(prepayFee.value)    ;
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
               rdShowMessageDialog("请输入有效的"+msg,0);
 	           obj.value = 0;
               countPayMoney();
  	           obj.focus();
 	           return false;
		    }
		    derate= parseFloat(obj.value);
 
			if (  derate < 0  ||  derate > 1  )
			{
               rdShowMessageDialog(msg + "只能在0和1之间！",0);
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
               rdShowMessageDialog("缴费金额不能为空，请重新输入 !",0);
   	           payMoney.focus();
 	           return false;
		    }
			if(!dataValid( 'b' , paymoney))
		   {
               rdShowMessageDialog("您输入的是  "+ paymoney +" , 请输入有效的缴费金额！",0);
   	           payMoney.focus();
 	           return false;
		    }

			if ( paymoney.indexOf(".")!=-1)
			{
				temp =  paymoney.substring(paymoney.indexOf(".")+1,paymoney.length);
 				if ( temp.length > 2 )
				{
					rdShowMessageDialog("缴费金额小数点后只能输入2位！",0);
					payMoney.focus();
					return false;
				}
			}

            if(parseFloat(paymoney) < 0)
		  	{
				rdShowMessageDialog(" 缴费金额不能为负数！",0);
                payMoney.focus();
                return false;
          	}
   
			if( parseFloat(paymoney) < parseFloat(totalFee.value) ) {
				rdShowMessageDialog("请注意，此笔只是部分缴费，用户仍有欠费！",0);
			}
			
			if( parseFloat(paymoney) > 500000 ) {
				rdShowMessageDialog("缴费金额不能大于500,000！",0);
				payMoney.focus();
                return false;
			}			

			if (moneyType.value=="9")
			{
				
				if(currentMoney.value=="")
				{
					rdShowMessageDialog("请校验支票号码！",0);
				   document.all.checkNo.focus();
				    return false;

				}
				if (parseFloat(currentMoney.value)<parseFloat(paymoney))
				{
					rdShowMessageDialog("请注意，支票金额不足！",0);
				   document.all.checkNo.focus();
				   return false;
				}
			}
 
              payMoney.value = formatAsMoney(paymoney);
 	}
 }
 
  
 function selType()
 {
      with(document.frm)
     {
        if ( moneyType.value=="9" )
			CheckId.style.display="block";
		else
 			CheckId.style.display = "none";
	 }
 
 }
  function conShort()
 {
	rdShowMessageDialog("此帐户号码为多个号码付费，请配置缴、退费短信接收号码！",0);
	window.open("/npage/s1211/f1771.jsp?contractNo="+document.all.contractno.value,"","width=1000,height=600");
 }
 function getLimit()
{
	var myPacket = new AJAXPacket("../s1300/getLimit.jsp?payMoney="+document.all.payMoney.value,"正在查询验证缴费可用额度，请稍候......");
	
	core.ajax.sendPacket(myPacket);
	myPacket = null;
	 
}
 function doprint()
 {
	getAfterPrompt();
	//alert("the bool is "+getLimit());
	/*if(!getLimit()){
		alert('11false');
		return ;
	}*/
	getLimit();
	var show = document.getElementById("show").value;
	//alert("the value is "+show);
	if(show=="ok"){
		if(document.frm.count_num.value ==0 && document.frm.contract_num.value >=2){
		conShort();
		}
	if(doCheck()==false)
			 return false;
			 var	prtFlag = rdShowConfirmDialog("本次缴费金额"+document.frm.payMoney.value+"元,是否确定缴费？");
			 if (prtFlag==1)
		    {
				 document.frm.print.disabled=true;
				document.frm.return1.disabled=true;
				document.frm.close1.disabled=true;
				 frm.submit();
				 return true;
		     }
		     else
			 return false;
	}
	else{
		//alert("禁止缴费 the value is "+show);
		return false;
	}

	
	 
 }

function getcheckfee() 
{
	var bankcode = document.all.BankCode.value;
	var checkno = document.all.checkNo.value;
	if (bankcode=="")
	{
		rdShowMessageDialog("请输入或查询银行!",0);
 	    return false;
	}
	if (trim(checkno)=="")
	{
		rdShowMessageDialog("请输入支票号码!",0);
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
 	   		rdShowMessageDialog("没有找到该支票的余额！",0);
		    document.frm.currentMoney.value = "";
	   		document.frm.checkNo.focus();
	   		return false;
		}
 
		document.frm.currentMoney.value = str;
 		document.all.print.focus();
	    return true;
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
             rdShowMessageDialog("你输入的条件没有查到相应的银行！",0);
			document.frm.BankCode.value="";
			document.frm.BankName.value="";
             return false;
		  }

 		  if(returnValue=="")
	     {
             rdShowMessageDialog("您没有选择银行！",0);
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
 
  
 -->
 </script> 
<input type = "hidden" id ="show"> 
</body>
</html>
<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码'<%=return_code%>'，错误信息：'<%=ret_msg%>'。",0);
		window.location.href="<%=return_page%>";
	 </script>
<% } %>

