<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:
   * �汾: 1.0
   * ����: 
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	0 iLoginAccept ��ˮ
		1 iChnSource  ��������
		2 iOpCode    ��������
		3 iLoginNo    ����
		4 iLoginPwd   ��������
		5 iPhoneNo   �û��ֻ�����
		6 iUserPwd   �û��ֻ�����
		7 sOfferId    �ʷѴ���
		8 sSchool     ѧУ����
		9 sClass      �༶����
*/

	/*===========��ȡ����============*/
	
  String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	String loginAccept=WtcUtil.repNull(request.getParameter("loginAccept"));
	String cust_addr=WtcUtil.repNull(request.getParameter("cust_addr"));
	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String user_id=WtcUtil.repNull(request.getParameter("user_id"));
  String op_type=WtcUtil.repNull(request.getParameter("s_optype"));
	String ic_no=WtcUtil.repNull(request.getParameter("ic_no"));
	
	String opCode = "6236";
	String opName = "���еȴ�����";
  String regionCode = (String)session.getAttribute("regCode");			
  String iopName = 	(String)request.getParameter("iopName");  
  String workNo = (String)session.getAttribute("workNo");
  String noPass = (String)session.getAttribute("password");
  
  String paraStr[]=new String[12];
 	paraStr[0]=loginAccept;		//��ˮ(�������룬������������ڷ�����ȡ��ˮ)                     
	paraStr[1]=opCode;			//���ܴ���                                                       
	paraStr[2]=workNo;			//��������                                                       
	paraStr[3]=noPass;		//�������ܵĹ�������                                                 
  paraStr[4]=regionCode;			//�������Ź���                                               
	paraStr[5]=srv_no;			//�û��ֻ�����                                                   
	paraStr[6]=op_type;		    //��������(1_����, 0_	ȡ��)                                      
	paraStr[7]=WtcUtil.repNull(request.getParameter("ys_fewFee"));			//Ӧ��           
  paraStr[8]=WtcUtil.repNull(request.getParameter("t_factFee"));			//ʵ��                
  paraStr[9]=WtcUtil.repNull(request.getParameter("t_sys_remark"));		//ϵͳ��ע           
	paraStr[10]=WtcUtil.repSpac(request.getParameter("t_op_remark")); 			//�û���ע                                  
  paraStr[11]=request.getRemoteAddr();			//IP��ַ    
           
%>
<wtc:service name="s6236Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=paraStr[0]%>" />
		<wtc:param value="<%=paraStr[1]%>" />
		<wtc:param value="<%=paraStr[2]%>" />
		<wtc:param value="<%=paraStr[3]%>" />
		<wtc:param value="<%=paraStr[4]%>" />
		<wtc:param value="<%=paraStr[5]%>" />
		<wtc:param value="<%=paraStr[6]%>" />
		<wtc:param value="<%=paraStr[7]%>" />
		<wtc:param value="<%=paraStr[8]%>" />
		<wtc:param value="<%=paraStr[9]%>" />
		<wtc:param value="<%=paraStr[10]%>" />
		<wtc:param value="<%=paraStr[11]%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
		
<script language="jscript">
function showPrtDlg(printType,DlgMessage,submitCfm){
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=workNo%>");       //����
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","<%=cust_name%>"); //�ͻ�����
	$(billArgsObj).attr("10006","<%=opName%>"); //ҵ�����
	$(billArgsObj).attr("10008","<%=srv_no%>" ); //�û�����
	$(billArgsObj).attr("10015", "<%=paraStr[8]%>"); //���η�Ʊ���(Сд)��
	$(billArgsObj).attr("10016", "<%=paraStr[8]%>"); //��д���ϼ�
	var sumtypes1="*";
	var sumtypes2="";
	var sumtypes3="";
	
			
	$(billArgsObj).attr("10017",sumtypes1); //���νɷ��ֽ�
	$(billArgsObj).attr("10018",sumtypes2); //֧Ʊ
	$(billArgsObj).attr("10019",sumtypes3); //ˢ��
	$(billArgsObj).attr("10020","0"); //������
	$(billArgsObj).attr("10021","<%=paraStr[8]%>"); //������
	$(billArgsObj).attr("10022",""); //ѡ�ŷ�
	$(billArgsObj).attr("10024",""); //SIM����
	$(billArgsObj).attr("10025",""); //Ԥ�滰��
	$(billArgsObj).attr("10026",""); //������
	$(billArgsObj).attr("10030", "<%=paraStr[0]%>"); //��ˮ��--ҵ����ˮ
	$(billArgsObj).attr("10036","<%=opCode%>"); //��������
	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + DlgMessage;
	
			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + DlgMessage;
	
	
	var path = path + "&loginAccept="+"<%=paraStr[0]%>"+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);
 		 
 }
</script>
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷��� s6236Cfm in s6236_conf.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("�û�<%=cust_name%>(<%=srv_no%>)���еȴ�ҵ�����ɹ���");
		//showPrtDlg("Bill","ȷ��Ҫ����Ʊ��","Yes");
		removeCurrentTab();
	</script>
<%
	}else{
		System.out.println("���÷��� s6236Cfm in s6236_conf.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		removeCurrentTab();
	</script>
<%
	}		
%>	
