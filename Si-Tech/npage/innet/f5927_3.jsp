<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%/*
* 黑龙江BOSS-套餐实现－普通开户冲正  2003-10
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>
 
<%
S1100View callView1100 = new S1100View();
String[][] result = new String[][]{};
ArrayList retArray = new ArrayList();
String regionCode = (String)session.getAttribute("regCode");

String thework_no = (String)session.getAttribute("workNo");                       //操作工号
String custid = ReqUtil.get(request,"cust_id");                                  //客户ID
String userid = ReqUtil.get(request,"userid");                              //用户ID
String accountid = ReqUtil.get(request,"accountid");                        //帐户ID
String op_code = "5927";                                                    //操作代码
String openrandom = ReqUtil.get(request,"back_accept");                      //开户流水
String org_code = (String)session.getAttribute("orgCode");                                              //机构编码
String theip = (String)session.getAttribute("ipAddr");                                                  //IP地址
String cheque = "0";                                 //支票交款
String sysnote = ReqUtil.get(request,"sysnote");                            //系统备注
String donote = ReqUtil.get(request,"sysnote");                           //操作备注
String mobile = ReqUtil.get(request,"cust_phone");                           //手机号码
String org_id = (String)session.getAttribute("groupId");											//工号ID
String ret_code = "";
String ret_msg="";
String cash = ReqUtil.get(request,"cust_fee"); //现金交款
String custName = ReqUtil.get(request,"cust_name"); //用户名
String innetFee ="0"; //入网费
String handFee = "0"; //手续费
String choiceFee = "0"; //选号费
String machineFee = "0"; //机器费
String simFee = ReqUtil.get(request,"cust_simfee"); //SIM卡费
String prepayFee = ReqUtil.get(request,"cust_prepayfee"); //预存费
String theop_code=op_code;
String themob=mobile;
String password = (String)session.getAttribute("password");
String loginAcceptc = ReqUtil.get(request,"sysAcceptl"); //流水
String ipAddr = request.getRemoteAddr();
String siteId =   (String)session.getAttribute("groupId");
String objectId = (String)session.getAttribute("groupId");
String result1 = request.getParameter("result");
 

try{
 
  UType sendInfo1  = new UType(); //TOprInfo 公共操作信息
  sendInfo1.setUe("STRING", thework_no);//
  sendInfo1.setUe("STRING", op_code);//
  sendInfo1.setUe("STRING", mobile);//
  sendInfo1.setUe("STRING", "0");//sLoginPwd
  sendInfo1.setUe("STRING", "3018");//
  sendInfo1.setUe("STRING", password);//
  sendInfo1.setUe("STRING", ipAddr);//
  sendInfo1.setUe("STRING", siteId);//
  sendInfo1.setUe("STRING", objectId);//
  sendInfo1.setUe("INT", "1");//
  sendInfo1.setUe("LONG", loginAcceptc);//
  
  String[] array1 = result1.split("\\|");
  System.out.println("mylog -------result===================="+result);
  System.out.println("mylog ------array1.length===================="+array1.length);
  /**
  A0109061500000032@S0109061500000040|A0109061500000031@S0109061500000039|
  */
  UType custOrderInfoList  = new UType(); //客户订单子项列表
  for(int i=0;i<array1.length;i++){
  System.out.println("array1["+i+"]===================="+array1[i]);
  		UType custOrderInfo  = new UType(); //创建客户订单节点
  		String[] array2 = array1[i].split("@");
  		System.out.println("array2.length===================="+array2.length);
  		System.out.println("客户订单[0]===================="+array2[0]);
  		System.out.println("服务订单信息[1]===================="+array2[1]);
  		custOrderInfo.setUe("STRING", array2[0]);//存入客户订单号
  		String[] array3 = array2[1].split("~");//获取服务订单号
  		UType servOrderInfoList  = new UType(); //创建服务列表节点
  		for(int j=array3.length-1;j>=0;j--){
  		System.out.println("服务订单["+j+"]===================="+array3[j]);
  			UType servOrderInfo  = new UType(); //创建服务订单节点
  			servOrderInfo.setUe("STRING", array3[j]);//存入服务订单号
  			servOrderInfoList.setUe(servOrderInfo);//把服务订单节点存入所属客户订单节点中
  		}
  		custOrderInfo.setUe(servOrderInfoList);//把服务订单节点存入服务订单列表中
  		custOrderInfoList.setUe(custOrderInfo);//把服务订单列表节点存入客户订单子项列表中
 	}
 
 System.out.println("------------mylog--------调用服务-----------sOrderBack----------------1");
%>
<%String regionCode_sOrderBack = (String)session.getAttribute("regCode");%>
<wtc:utype name="sOrderBack" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sOrderBack%>">
          <wtc:uparam value="<%= sendInfo1 %>" type="UTYPE"/>      
          <wtc:uparam value="<%= custOrderInfoList %>" type="UTYPE"/>      
 </wtc:utype>
		<%
		System.out.println("------------mylog--------调用服务-----------sOrderBack----------------2");
				ret_code = retVal.getValue(0);
       	ret_msg =retVal.getValue(1);
       	
		System.out.println("mylog----------ret_code="+ret_code);
		System.out.println("mylog----------ret_msg="+ret_msg);

}
catch(Exception e){
      e.printStackTrace() ;
      
System.out.println("mylog----------catch-------------------");
}
 
if(ret_code.equals("0")){
 System.out.println("mylog----------ret_code.equals 0 -------------------");
		String retInfo="";
		String note = custid + mobile + "普通开户" + "现金款:" + Pub_lxd.formatNumber(cash,2) + "支票款:" + Pub_lxd.formatNumber(cheque,2);
		retInfo="64|5|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo += "72|5|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo += "77|5|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo = retInfo + "16|5|9|0|" + thework_no + "|";            //工号
		retInfo = retInfo + "24|5|9|0|" + openrandom + "|";            //流水
		retInfo = retInfo + "35|5|9|0|" + "全球通普通开户冲正费用明细" + "|";         //全球通开户交费明细

	  retInfo = retInfo + "16|8|10|0|" + custName + "|";          	   //用户名
		retInfo = retInfo + "16|11|10|0|" + mobile+ "|";               //手机号
		retInfo = retInfo + "50|11|10|0|" + userid + "|"; 		       //协议号码
		String currentPay="";
		if(!cash.equals("")&&!cheque.equals(""))
		{
			 currentPay = String.valueOf(Double.parseDouble(cash)+Double.parseDouble(cheque));
		}else if(cheque.equals("")&&!cash.equals("")){
			 cheque="0.00";
			 currentPay = String.valueOf(Double.parseDouble(cash));
		}else if(!cheque.equals("")&&cash.equals("")){
			 cash="0.00";
			 currentPay = String.valueOf(Double.parseDouble(cheque));
		}
		retInfo = retInfo + "65|14|10|0|" + currentPay  + "|";      //小写		
		String chinaFee= "";
		try
        {
            retArray = callView1100.view_sToChinaFee(currentPay);
            result = (String[][])retArray.get(0);
            chinaFee = result[0][2];
        }catch(Exception e){
        }				

		retInfo = retInfo + "22|14|10|0|" + chinaFee + "|";                     				//大写
		retInfo = retInfo + "21|19|9|0|入网费：  " +  Pub_lxd.formatNumber(innetFee,2) + "|";        //入网费
		retInfo = retInfo + "50|19|9|0|手续费：    " + Pub_lxd.formatNumber(handFee,2) + "|";        //手续费
		retInfo = retInfo + "21|20|9|0|选号费：  " + Pub_lxd.formatNumber(choiceFee,2) + "|";         //选号费
 		retInfo = retInfo + "50|20|9|0|机器费：    " + Pub_lxd.formatNumber(machineFee,2) + "|";       //机器费
		retInfo = retInfo + "21|21|9|0|SIM卡费： " + Pub_lxd.formatNumber(simFee,2)+ "|";          //SIM卡费
		retInfo = retInfo + "50|21|9|0|预存费：    " + Pub_lxd.formatNumber(prepayFee,2) + "|";       //预存费
		retInfo = retInfo + "21|22|9|0|现金款：  " + Pub_lxd.formatNumber(cash,2) + "|";         //现金款
		retInfo = retInfo + "50|22|9|0|支票款：    " + Pub_lxd.formatNumber(cheque,2) + "|";       //支票款
		
		retInfo = retInfo + "21|24|9|0|备注：    " + note + "|";								//备注

%>
<script language="JavaScript">
	function showPrtDlg(printType,DlgMessage,submitCfm)
	 {
		   var h=195;
		   var w=370;
		   var t=screen.availHeight/2-h/2;
		   var l=screen.availWidth/2-w/2;
		   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
		   var path = "spubPrint_1104.jsp?DlgMsg=" + DlgMessage;
		   var path = path + "&printInfo=<%=retInfo%>&submitCfm=submitCfm";
		   var ret=window.showModalDialog(path,"",prop);
	 }
	 
	rdShowMessageDialog('空中选号开户冲正成功!');
	showPrtDlg("Bill","确实要进行发票打印吗？","Yes");
	removeCurrentTab();
</script>
<%}else{%>
<script language="JavaScript">
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
	history.go(-1);
</script>
<%}%>
