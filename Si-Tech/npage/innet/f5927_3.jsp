<%
/********************
 version v2.0
������: si-tech
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
* ������BOSS-�ײ�ʵ�֣���ͨ��������  2003-10
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
 
<%
S1100View callView1100 = new S1100View();
String[][] result = new String[][]{};
ArrayList retArray = new ArrayList();
String regionCode = (String)session.getAttribute("regCode");

String thework_no = (String)session.getAttribute("workNo");                       //��������
String custid = ReqUtil.get(request,"cust_id");                                  //�ͻ�ID
String userid = ReqUtil.get(request,"userid");                              //�û�ID
String accountid = ReqUtil.get(request,"accountid");                        //�ʻ�ID
String op_code = "5927";                                                    //��������
String openrandom = ReqUtil.get(request,"back_accept");                      //������ˮ
String org_code = (String)session.getAttribute("orgCode");                                              //��������
String theip = (String)session.getAttribute("ipAddr");                                                  //IP��ַ
String cheque = "0";                                 //֧Ʊ����
String sysnote = ReqUtil.get(request,"sysnote");                            //ϵͳ��ע
String donote = ReqUtil.get(request,"sysnote");                           //������ע
String mobile = ReqUtil.get(request,"cust_phone");                           //�ֻ�����
String org_id = (String)session.getAttribute("groupId");											//����ID
String ret_code = "";
String ret_msg="";
String cash = ReqUtil.get(request,"cust_fee"); //�ֽ𽻿�
String custName = ReqUtil.get(request,"cust_name"); //�û���
String innetFee ="0"; //������
String handFee = "0"; //������
String choiceFee = "0"; //ѡ�ŷ�
String machineFee = "0"; //������
String simFee = ReqUtil.get(request,"cust_simfee"); //SIM����
String prepayFee = ReqUtil.get(request,"cust_prepayfee"); //Ԥ���
String theop_code=op_code;
String themob=mobile;
String password = (String)session.getAttribute("password");
String loginAcceptc = ReqUtil.get(request,"sysAcceptl"); //��ˮ
String ipAddr = request.getRemoteAddr();
String siteId =   (String)session.getAttribute("groupId");
String objectId = (String)session.getAttribute("groupId");
String result1 = request.getParameter("result");
 

try{
 
  UType sendInfo1  = new UType(); //TOprInfo ����������Ϣ
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
  UType custOrderInfoList  = new UType(); //�ͻ����������б�
  for(int i=0;i<array1.length;i++){
  System.out.println("array1["+i+"]===================="+array1[i]);
  		UType custOrderInfo  = new UType(); //�����ͻ������ڵ�
  		String[] array2 = array1[i].split("@");
  		System.out.println("array2.length===================="+array2.length);
  		System.out.println("�ͻ�����[0]===================="+array2[0]);
  		System.out.println("���񶩵���Ϣ[1]===================="+array2[1]);
  		custOrderInfo.setUe("STRING", array2[0]);//����ͻ�������
  		String[] array3 = array2[1].split("~");//��ȡ���񶩵���
  		UType servOrderInfoList  = new UType(); //���������б�ڵ�
  		for(int j=array3.length-1;j>=0;j--){
  		System.out.println("���񶩵�["+j+"]===================="+array3[j]);
  			UType servOrderInfo  = new UType(); //�������񶩵��ڵ�
  			servOrderInfo.setUe("STRING", array3[j]);//������񶩵���
  			servOrderInfoList.setUe(servOrderInfo);//�ѷ��񶩵��ڵ���������ͻ������ڵ���
  		}
  		custOrderInfo.setUe(servOrderInfoList);//�ѷ��񶩵��ڵ������񶩵��б���
  		custOrderInfoList.setUe(custOrderInfo);//�ѷ��񶩵��б�ڵ����ͻ����������б���
 	}
 
 System.out.println("------------mylog--------���÷���-----------sOrderBack----------------1");
%>
<%String regionCode_sOrderBack = (String)session.getAttribute("regCode");%>
<wtc:utype name="sOrderBack" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sOrderBack%>">
          <wtc:uparam value="<%= sendInfo1 %>" type="UTYPE"/>      
          <wtc:uparam value="<%= custOrderInfoList %>" type="UTYPE"/>      
 </wtc:utype>
		<%
		System.out.println("------------mylog--------���÷���-----------sOrderBack----------------2");
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
		String note = custid + mobile + "��ͨ����" + "�ֽ��:" + Pub_lxd.formatNumber(cash,2) + "֧Ʊ��:" + Pub_lxd.formatNumber(cheque,2);
		retInfo="64|5|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo += "72|5|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo += "77|5|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo = retInfo + "16|5|9|0|" + thework_no + "|";            //����
		retInfo = retInfo + "24|5|9|0|" + openrandom + "|";            //��ˮ
		retInfo = retInfo + "35|5|9|0|" + "ȫ��ͨ��ͨ��������������ϸ" + "|";         //ȫ��ͨ����������ϸ

	  retInfo = retInfo + "16|8|10|0|" + custName + "|";          	   //�û���
		retInfo = retInfo + "16|11|10|0|" + mobile+ "|";               //�ֻ���
		retInfo = retInfo + "50|11|10|0|" + userid + "|"; 		       //Э�����
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
		retInfo = retInfo + "65|14|10|0|" + currentPay  + "|";      //Сд		
		String chinaFee= "";
		try
        {
            retArray = callView1100.view_sToChinaFee(currentPay);
            result = (String[][])retArray.get(0);
            chinaFee = result[0][2];
        }catch(Exception e){
        }				

		retInfo = retInfo + "22|14|10|0|" + chinaFee + "|";                     				//��д
		retInfo = retInfo + "21|19|9|0|�����ѣ�  " +  Pub_lxd.formatNumber(innetFee,2) + "|";        //������
		retInfo = retInfo + "50|19|9|0|�����ѣ�    " + Pub_lxd.formatNumber(handFee,2) + "|";        //������
		retInfo = retInfo + "21|20|9|0|ѡ�ŷѣ�  " + Pub_lxd.formatNumber(choiceFee,2) + "|";         //ѡ�ŷ�
 		retInfo = retInfo + "50|20|9|0|�����ѣ�    " + Pub_lxd.formatNumber(machineFee,2) + "|";       //������
		retInfo = retInfo + "21|21|9|0|SIM���ѣ� " + Pub_lxd.formatNumber(simFee,2)+ "|";          //SIM����
		retInfo = retInfo + "50|21|9|0|Ԥ��ѣ�    " + Pub_lxd.formatNumber(prepayFee,2) + "|";       //Ԥ���
		retInfo = retInfo + "21|22|9|0|�ֽ�  " + Pub_lxd.formatNumber(cash,2) + "|";         //�ֽ��
		retInfo = retInfo + "50|22|9|0|֧Ʊ�    " + Pub_lxd.formatNumber(cheque,2) + "|";       //֧Ʊ��
		
		retInfo = retInfo + "21|24|9|0|��ע��    " + note + "|";								//��ע

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
	 
	rdShowMessageDialog('����ѡ�ſ��������ɹ�!');
	showPrtDlg("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
	removeCurrentTab();
</script>
<%}else{%>
<script language="JavaScript">
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
	history.go(-1);
</script>
<%}%>
