<%
  /*
   * ����: ȫ��ͨ��������1121
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="1121";
	String op_code=opCode;
	String opName="��ͨ��������";
	String phoneNo = (String)request.getParameter("activePhone");
%>

<%
	Logger logger = Logger.getLogger("f1121_3.jsp");
	String thework_no = (String)session.getAttribute("workNo");					//��������
	String theip = (String)session.getAttribute("ipAddr");  					//IP��ַ
	String org_id = (String)session.getAttribute("orgId");          			//����ID
	String org_code = (String)session.getAttribute("orgCode");      			//�������� (��������) 
	String regionCode = (String)session.getAttribute("regCode");
	 
%>

<%
	/*------------------------------�õ�����s1121Cfm��Ҫ�Ĳ���----------------------------------------*/
	                                             
	String custid = ReqUtil.get(request,"i2");                                  //�ͻ�ID
	String userid = ReqUtil.get(request,"userid");                              //�û�ID
	String accountid = ReqUtil.get(request,"accountid");                        //�ʻ�ID
	String openrandom = ReqUtil.get(request,"openrandom");                      //������ˮ
	
	String cheque = ReqUtil.get(request,"i14");                                 //֧Ʊ����
	String sysnote = ReqUtil.get(request,"sysnote");                            //ϵͳ��ע
	String donote = ReqUtil.get(request,"i222");                                //������ע
	String mobile = ReqUtil.get(request,"mob_phone");                           //�ֻ�����
	String cash = ReqUtil.get(request,"i13"); 									//�ֽ𽻿�
	String custName = ReqUtil.get(request,"i5"); 								//�û���
	String innetFee = ReqUtil.get(request,"innetFee"); 							//������
	String handFee = ReqUtil.get(request,"i8"); 								//������
	String choiceFee = ReqUtil.get(request,"i9"); 								//ѡ�ŷ�
	String machineFee = ReqUtil.get(request,"i11"); 							//������
	String simFee = ReqUtil.get(request,"i12"); 								//SIM����
	String prepayFee = ReqUtil.get(request,"i10"); 								//Ԥ���
	//String stream = getMaxAccept();												//������ˮ
	String stream = ReqUtil.get(request,"stream"); 	
	String ret_code ="";
	String ret_msg="";
%>

<%
/*----------------------------��ʼ����s1121Cfm-----------------------------------------------*/
		String[] paraStrIn = new String[]{thework_no,custid,userid,accountid,op_code,openrandom,org_code,theip,cheque,sysnote,donote,mobile,org_id,stream};
		String outParaNums= "1";  
%>
	<wtc:service name="s1121Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=thework_no%>"/>
		<wtc:param value="<%=custid%>"/>
		<wtc:param value="<%=userid%>"/>
		<wtc:param value="<%=accountid%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=openrandom%>"/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value="<%=theip%>"/>
		<wtc:param value="<%=cheque%>"/>
		<wtc:param value="<%=sysnote%>"/>
		<wtc:param value="<%=donote%>"/>
		<wtc:param value="<%=mobile%>"/>
		<wtc:param value="<%=org_id%>"/>
		<wtc:param value="<%=stream%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>	
<%		
		ret_code = retCode ;
		ret_msg = retMsg ;
	    String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName
		+"&workNo="+thework_no+"&loginAccept="+stream+"&pageActivePhone="+mobile+"&retMsgForCntt="+retMsg
		+"&opBeginTime="+opBeginTime;
		System.out.println("url=========================="+url);
%>
	<jsp:include page="<%=url%>" flush="true" />	
<%
	if(ret_code.equals("000000"))
	{
%>
<%
		String retInfo="";
		String note = custid + mobile + "��ͨ����" + "�ֽ��:" + WtcUtil.formatNumber(cash,2) + "֧Ʊ��:" + WtcUtil.formatNumber(cheque,2);
		retInfo="64|5|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo += "72|5|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo += "77|5|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";
		retInfo = retInfo + "16|5|9|0|" + thework_no + "|";            //����
		retInfo = retInfo + "24|5|9|0|" + openrandom + "|";            //��ˮ
		retInfo = retInfo + "30|5|9|0|" + "ȫ��ͨ��ͨ��������������ϸ" + "|";         //ȫ��ͨ����������ϸ
		
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
		retInfo = retInfo + "65|14|10|0|" + currentPay  + "|";     									 //Сд		
		String chinaFee= "";

%>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=currentPay%>"/>
	</wtc:service>
	<wtc:array id="retArray" scope="end"/>
<%			
		chinaFee = retArray[0][2];
		
		retInfo = retInfo + "22|14|10|0|" + chinaFee + "|";                     						//��д
		retInfo = retInfo + "21|19|9|0|�����ѣ�  " +  WtcUtil.formatNumber(innetFee,2) + "|";        	//������
		retInfo = retInfo + "50|19|9|0|�����ѣ�    " + WtcUtil.formatNumber(handFee,2) + "|";        	//������
		retInfo = retInfo + "21|20|9|0|ѡ�ŷѣ�  " + WtcUtil.formatNumber(choiceFee,2) + "|";         	//ѡ�ŷ�
		retInfo = retInfo + "50|20|9|0|�����ѣ�    " + WtcUtil.formatNumber(machineFee,2) + "|";       	//������
		retInfo = retInfo + "21|21|9|0|SIM���ѣ� " + WtcUtil.formatNumber(simFee,2)+ "|";          		//SIM����
		retInfo = retInfo + "50|21|9|0|Ԥ��ѣ�    " + WtcUtil.formatNumber(prepayFee,2) + "|";       	//Ԥ���
		retInfo = retInfo + "21|22|9|0|�ֽ�  " + WtcUtil.formatNumber(cash,2) + "|";         		//�ֽ��
		retInfo = retInfo + "50|22|9|0|֧Ʊ�    " + WtcUtil.formatNumber(cheque,2) + "|";       		//֧Ʊ��
		
		retInfo = retInfo + "21|24|9|0|��ע��    " + note + "|";										//��ע

%>
<script language="javascript">
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
	var path = "spubPrint_1104.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&printInfo=<%=retInfo%>&submitCfm=submitCfm";
	var ret=window.showModalDialog(path,"",prop);
}
</script>
<script language="javascript">
	rdShowMessageDialog('ȫ��ͨ��ͨ���������ɹ�!',2);
	showPrtDlg("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
	document.location.replace("<%=request.getContextPath()%>/npage/innet/f1121_1.jsp?activePhone=<%=phoneNo%>");
</script>
<%}else{%>
<script language="javascript">
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
	history.go(-1);
</script>
<%}%>
