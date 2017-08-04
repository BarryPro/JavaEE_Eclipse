<%
/********************
 version v2.0
������: si-tech
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
    //�õ��������
    Logger logger = Logger.getLogger("f1106_2.jsp");
    ArrayList retArray = new ArrayList();
    String return_code,return_message,total_date,login_accept,delay_time;
    String[][] result = new String[][]{};
 	S1100View callView = new S1100View();

    String workno = request.getParameter("workno");                 //����Ա����
    String ip_Addr = request.getParameter("ip_Addr");               //����Ա����
    String opcode = "1106";                                         //��������
    String belongCode = request.getParameter("belongCode");         //��������
    
    String custId = request.getParameter("custId");                 //�ͻ�ID
    String custPwd = Encrypt.encrypt(Pub_lxd.repStr(request.getParameter("custPwd")," "));            	//�ͻ����룬���ܺ��    

    String idIccid = Pub_lxd.repStr(request.getParameter("idIccid"),"");//֤������
    String idType = request.getParameter("idType");                 //֤������
    idType = idType.substring(0,idType.indexOf("|"));
    String custName = Pub_lxd.repStr(request.getParameter("custName"),"");  //�ͻ�����
    String custAddr = Pub_lxd.repStr(request.getParameter("custAddr"),"");  //�ͻ���ַ
   
    String operType = request.getParameter("operType");             //ҵ��Ʒ��
    String innetCode = request.getParameter("innetCode");           //��������
    innetCode = innetCode.substring(0,innetCode.indexOf("-"));

    String machCode = request.getParameter("machCode");             //��������
    if((machCode.trim()).compareTo("") == 0)
    {     machCode = " ";         }    
    String simType = request.getParameter("simType");               //SIM������
    String simNo = request.getParameter("simNo");                   //SIM����
    String phoneNo = request.getParameter("phoneNo");               //�ֻ�����
    String payWay = request.getParameter("payWay");                 //�ʷѷ�ʽ
    String serviceResult = request.getParameter("serviceResult");   //�ط�����
    
    String userId = request.getParameter("userID");                 //�û�ID
    String userPwd =Pub_lxd.repStr(request.getParameter("prt_password")," ");            	//�û�����,���ܺ��
    
    String accountId = request.getParameter("accountID");           //�ʻ�ID
    //String accountPwd = request.getParameter("accountPwd");       //�ʻ�����
    String accountPwd = userPwd;  //���û�������Ϊ�ʻ���Ĭ������
    String cfmAccPwd = request.getParameter("cfmAccPwd");           //ȷ������
    String billType = request.getParameter("upBillType");           //��������
     //-----------------
    String postFlag = "0";             //�ʼı�־
    String postType = " ";             //�ʼ�����
    String postName = " ";            //�ռ�������
    String postFax = " ";               //�ʼĴ���
    String postMail = " ";             //�ʼ�Email
    String postAdd = " ";            //�ʼĵ�ַ
    String postZip = " ";               //�ʼ��ʱ�
    
    String assuId = " ";                 //������֤������
    String assuName = " ";             //����������
    String assuPhone = " ";           //�����˵绰
    String assuAddr = " ";            //������ͨѶ��ַ
    //-----------------
    //String innetFee = request.getParameter("innetFee");             //������
    String handFee = request.getParameter("handFee");               //������
    String choiceFee = request.getParameter("choiceFee");           //ѡ�ŷ�
    String prepayFee = request.getParameter("prepayFee");           //Ԥ����
    String machFee = request.getParameter("machFee");               //������
    String simFee = request.getParameter("simFee");                 //SIM����
    
    //String hid_innetFee = request.getParameter("hid_innetFee");     //�޸�������
    String hid_HandFee = request.getParameter("hid_HandFee");       //�޸�������
    String hid_ChoiceFee = request.getParameter("hid_ChoiceFee");   //�޸�ѡ�ŷ�
    String hid_MachFee = request.getParameter("hid_MachFee");       //�޸Ļ�����
    String hid_SimFee = request.getParameter("hid_SimFee");         //�޸�SIM����    
    
    String favourableTime = request.getParameter("favourableTime");         //��ǰϵͳʱ��
    String hid_favourableTime = request.getParameter("hid_favourableTime");         //�Ż�ʱ��
    
    String cashPay = request.getParameter("cashPay");               //�ֽ𽻿�
    String bankCode = request.getParameter("bankCode");             //���д���
    if((bankCode.trim()).compareTo("") == 0)
    {   bankCode = "zzz";              }    
    String checkNo = request.getParameter("checkNo");               //֧Ʊ����
    if((checkNo.trim()).length()==0)
    {   checkNo = "zzz";              }
    String checkPay = request.getParameter("checkPay");             //֧Ʊ����
    if((checkPay.trim()).compareTo("") == 0)
    {   checkPay = "0.00";             }
    String sumPay = request.getParameter("sumPay");                 //�ϼƷ���
    
    String sysNote = request.getParameter("sysNote");               //ϵͳ��ע
    String opNote = request.getParameter("opNote");                 //������ע                  

    String payCode = request.getParameter("payCode");               //���ʷѴ���
    String additiveCode = request.getParameter("additiveCode");     //�����ʷѴ���
	String rentpayCode = request.getParameter("rentpayCode");       //���ʱ�Ŀ�ѡ�ʷѴ���
	String bindModeCode=request.getParameter("bindModeCode");       //�󶨸����ʷ�
    
    String serviceNow = request.getParameter("serviceNow");         //������Ч�ط�    
	String serviceAfter = request.getParameter("serviceAfter");     //ԤԼ��Ч�ط� 
	String serviceAddNo = request.getParameter("serviceAddNo");     //���Ӻ����ط� 
	String sysAccept = request.getParameter("sysAccept");     		//�õ�������ˮ

	String machineType=request.getParameter("hidMachineType");      //�õ���������
	String tfFlag=request.getParameter("tfFlag");                   //�ط�ѡ���־
	machineType+=tfFlag;

 //---------------------------------------------
	//��֯��ӡ��Ϣ
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

	    printInfo = printInfo + "15|10|10|0|" + phoneNo + "|";   //�ֻ���
		printInfo = printInfo + "10|11|10|0|" + custName + "|";  //�û���
		printInfo = printInfo + "10|13|10|0|"+ custAddr + "|";    //��ַ 

		if(Double.parseDouble(cashPay)<0.01)
          printInfo = printInfo + "10|15|10|0|"+ "֧Ʊ" + "|";    //���ʽ
		else if(Double.parseDouble(checkPay)<0.01)
          printInfo = printInfo + "10|15|10|0|"+ "�ֽ�" + "|";    //���ʽ
		else 
          printInfo = printInfo + "10|15|10|0|"+ "�ֽ�-֧Ʊ" + "|";    //���ʽ

		printInfo = printInfo + "55|17|10|0|" + Pub_lxd.formatNumber(busi_sumPay,2) + "|";   //Сд		
        try
        {
            retArray = callView.view_sToChinaFee(busi_sumPay);
            result = (String[][])retArray.get(0);
            chinaFee = result[0][2];
        }catch(Exception e){
            logger.error("Call sunView is Error,Can't get chinaFee!");
        }				
		printInfo = printInfo + "20|17|10|0|" + chinaFee + "|";                 //��д

        printInfo = printInfo + "5|19|9|0|" + "��������ͨ������ҵ��Ʊ��" + "|"; //ҵ����Ŀ
 		printInfo = printInfo + "5|20|9|0|�����ѣ�" + Pub_lxd.formatNumber(handFee,2) + "|";          //������
		printInfo = printInfo + "50|20|9|0|ѡ�ŷѣ�" + Pub_lxd.formatNumber(choiceFee,2) + "|";        //ѡ�ŷ�
 		printInfo = printInfo + "5|21|9|0|�����ѣ�" + Pub_lxd.formatNumber(machFee,2) + "|";          //������
		printInfo = printInfo + "50|21|9|0|SIM���ѣ�" + Pub_lxd.formatNumber(simFee,2) + "|";          //SIM����
		printInfo = printInfo + "5|22|9|0|��ˮ�ţ�" + sysAccept + "|";        //��ˮ��
		printInfo = printInfo + "50|22|9|0|�û����룺" + userPwd + "|";        //��ˮ��		
	}

	//====================3======================prepayFee
	String fee_sumPay=String.valueOf(Double.parseDouble(prepayFee));
 	String printInfo1 = "";
	if(Double.parseDouble(fee_sumPay)>0.01)
	{
		printInfo1="30|8|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo1 += "38|8|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
		printInfo1 += "43|8|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";

	    printInfo1 = printInfo1 + "15|10|10|0|" + phoneNo + "|";   //�ֻ���
		printInfo1 = printInfo1 + "10|11|10|0|" + custName + "|";  //�û���
		printInfo1 = printInfo1 + "10|13|10|0|"+ custAddr + "|";    //��ַ
		
		if(Double.parseDouble(cashPay)<0.01)
          printInfo1 = printInfo1 + "10|15|10|0|"+ "֧Ʊ" + "|";    //���ʽ
		else if(Double.parseDouble(checkPay)<0.01)
          printInfo1 = printInfo1 + "10|15|10|0|"+ "�ֽ�" + "|";    //���ʽ
		else 
          printInfo1 = printInfo1 + "10|15|10|0|"+ "�ֽ�-֧Ʊ" + "|";    //���ʽ

		printInfo1 = printInfo1 + "55|17|10|0|" + Pub_lxd.formatNumber(fee_sumPay,2) + "|";   //Сд		
        try
        {
            retArray = callView.view_sToChinaFee(fee_sumPay);
            result = (String[][])retArray.get(0);
            chinaFee = result[0][2];
        }catch(Exception e){
            logger.error("Call sunView is Error,Can't get chinaFee!");
        }				
		printInfo1 = printInfo1 + "20|17|10|0|" + chinaFee + "|";                 //��д

        printInfo1 = printInfo1 + "5|19|9|0|" + "��������ͨ�������ɷѷ�Ʊ��" + "|"; //ҵ����Ŀ
		printInfo1 = printInfo1 + "5|20|9|0|����Ԥ��ѣ�" + Pub_lxd.formatNumber(fee_sumPay,2) + "|";         //������
 		printInfo1 = printInfo1 + "50|20|9|0|��ˮ�ţ�" + sysAccept + "|";        //��ˮ��
		printInfo1 = printInfo1 + "5|21|9|0|�û����룺" + userPwd + "|";        //��ˮ��	
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

        //�ͻ���Ϣ��:ҵ��Ʒ�ƴ���~��������~������~�û�����~
           //�����ȴ���~������ֵ~���Ѵ���~��������~��������~
           //Ȩ��ֵ~��������~��������~��������~֧Ʊ����~���д���       
         String pCust_List = operType + "~" + "01" + "~" + "0" + "~" +"000" + "~" + 
                "E" + "~" + "0" + "~" + "0" + "~" + spayType + "~" + billType + "~" + 
                "1" + "~" + innetCode + "~" + machCode + "~" + "01" + "~" + checkNo + "~" + bankCode + "~"; 
        //������Ϣ��:��������~����������~������֤��~�����˵绰~�����˵�ַ~
        String pAssure_List = "";
 
        //�ʼ��ʵ���Ϣ��:�ʼ��ʵ���־~�ʼ��ʵ�����~�ʼ��ʵ���ַ~�ʼ��ʵ��ʱ�~�ʼ��ʵ�����~�ʼ��ʵ�Mail~                
        String pPost_List = "";
         
        //������Ϣ��:�ֽ𽻿�~֧Ʊ����~Ԥ���~SIM����~������~������~ѡ�ŷ�~������~������~       
        String pFee_List = cashPay + "~" + checkPay + "~" + prepayFee + "~" +
                 simFee + "~" + machFee + "~" + "0.00" + "~" + choiceFee + "~" +
                 "0.00" + "~" + handFee + "~"; 
        //�ط���Ϣ����������Ч�ط���            
        String pFunc_List = serviceNow;   
        //�Ż���Ϣ��
        String  pfavourable_List = "";
 
		if(Float.parseFloat(machFee) - Float.parseFloat(hid_MachFee) != 0)          //�������Ż�
        {   pfavourable_List = pfavourable_List + "a001&" + hid_MachFee  + "&" + machFee + "&~";            }
        if(Float.parseFloat(simFee) - Float.parseFloat(hid_SimFee) != 0)            //Sim���Ż�
        {   pfavourable_List = pfavourable_List + "a003&" + hid_SimFee + "&" + simFee + "&~";           }
        if(Float.parseFloat(choiceFee) - Float.parseFloat(hid_ChoiceFee) != 0)      //ѡ�ŷ��Ż�
        {   pfavourable_List = pfavourable_List + "a004&" + hid_ChoiceFee  + "&" + choiceFee + "&~";        }  
        if(Float.parseFloat(handFee) - Float.parseFloat(hid_HandFee) != 0)          //�������Ż�
        {   pfavourable_List = pfavourable_List + "a007&" + hid_HandFee  + "&" + handFee + "&~";            }
 
		//�ײ���Ϣ��
        String pPackage_List = payCode + "~" + additiveCode + "~"+rentpayCode+"~"+bindModeCode+"~";
        //�ط���Ϣ����ԤԼ�ط���  
        String pUnUsedFunc_List = serviceAfter;
        //�ط���Ϣ�����̺����ط���  
        String pAddAddFunc_List = serviceAddNo;   
        //�ͻ���Ϣ׷�ӵ��ַ���
        pCBXCustInfo = custName + "~" + custAddr + "~" + idType + "~" + idIccid + "~" ;       
		//��e����Ϣ��:ƾ֤ϵ�к�~ Gprs�ײ� ~ WLAN�ײ�
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
				   var path = "spubPrint.jsp?DlgMsg=" + "��������ͨ�����ɹ���";
				   var path = path + "&printInfo=" + "<%=printInfo%>"+ "&printInfo1=" + "<%=printInfo1%>" + "&submitCfm=" + "Single";
				   var ret=window.showModalDialog(path,"",prop); 	
				   location = "f1106_1.jsp";                
            </script>
<%            
        }
%>