<%
/********************
 version v2.0
������: si-tech
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
  /**  //��session��ȡ����
  ArrayList arr = (ArrayList)session.getAttribute("allArr");
  String[][] agentInfo = (String[][])arr.get(2);
  String[][] baseInfo = (String[][])arr.get(0);
  String[][] the_pass = (String[][])arr.get(4);
  String login_pass = the_pass[0][0];
  String orgCode = baseInfo[0][16];                  //���Ź���
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
    String opName = "��ͨ����";
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

  //�õ��������
   // Logger logger = Logger.getLogger("f1104_2.jsp");
   // ArrayList retArray = new ArrayList();
   // String return_code,return_message,total_date,login_accept,delay_time;
    String total_date,login_accept,delay_time;
  //  String[][] result = new String[][]{};
  //  S1100View callView = new S1100View();
    String[] ret = new String[]{};
  //  SPubCallSvrImpl impl = new SPubCallSvrImpl(); 
    
    String workno = request.getParameter("workno");                 //����Ա����
    String ip_Addr = request.getParameter("ip_Addr");               //����Ա����
    String opcode = "1104";                                         //��������
    String custId = request.getParameter("custId");                 //�ͻ�ID
    String custPwd =WtcUtil.repStr(request.getParameter("custPwd")," ");  //�ͻ�����
    String idIccid = request.getParameter("idIccid");               //֤������
    String idType = request.getParameter("idType");                 //֤������
    System.out.println("idType  ��f1104_2.jsp����õ���ֵ "+idType);
    String custName = request.getParameter("custName");             //�ͻ�����
    String custAddr = request.getParameter("custAddr");             //�ͻ���ַ
    //�ͻ���Ϣƴ��
    //custName = custName.replaceAll("~","");
    //custAddr = custAddr.replaceAll("~","");
    //idType = idType.replaceAll("~","");
    //idIccid = idIccid.replaceAll("~","");
    String cust_infoa=custName+"~"+custAddr+"~"+idType+"~"+idIccid+"~";
  String operType = request.getParameter("operType");             //ҵ��Ʒ��
    String innetCode = request.getParameter("innetCode");           //�������� ������-����-����Ԥ��
    innetCode = innetCode.substring(0,innetCode.indexOf("-"));
    String credId = request.getParameter("hid_CredId");       //ƾ֤���к�    
    String machCode = request.getParameter("machCode");             //��������
    if((machCode.trim()).compareTo("") == 0)
    {     machCode = " ";         }    
    String simType = request.getParameter("simType");               //SIM������
    String simNo = request.getParameter("simNo");                   //SIM����
    String phoneNo = request.getParameter("phoneNo");  
    System.out.println("ssssssssssssssssssssssss");             //�ֻ�����
    System.out.println(phoneNo);
    String payWay = request.getParameter("payWay");                 //�ʷѷ�ʽ
  String serviceResult = request.getParameter("serviceResult");   //�ط�����
    String userId = request.getParameter("userID");                 //�û�ID
    String userPwd =WtcUtil.repStr(request.getParameter("userPwd")," "); //�û�����
    String accountId = request.getParameter("accountID");           //�ʻ�ID
    String accountPwd = userPwd;
    String billType = request.getParameter("upBillType");           //��������
    String postFlag = request.getParameter("postFlag");             //�ʼı�־
    String postType = request.getParameter("postType");             //�ʼ�����
    String postName = request.getParameter("postName");             //�ռ�������
    String postFax = request.getParameter("postFax");               //�ʼĴ���

    if(postFax==null)
    { postFax = " ";    
    }
    String postMail = request.getParameter("postMail");             //�ʼ�Email
    if(postMail==null)
    { postMail = " ";   }   
    String postAdd = request.getParameter("postAdd");               //�ʼĵ�ַ
    if(postAdd==null)
    { postAdd = " ";    }    
    String postZip = request.getParameter("postZip");               //�ʼ��ʱ�
    if(postZip==null)
    { postZip = " ";    }    
    String assuIdType = request.getParameter("assuIdType");         //������֤������
    if(assuIdType.indexOf("|") > -1)
    {
      assuIdType = assuIdType.substring(0,assuIdType.indexOf("|"));
    }
    String assuId = request.getParameter("assuId");                 //������֤������
    String assuName = request.getParameter("assuName");             //����������
    String assuPhone = request.getParameter("assuPhone");           //�����˵绰
    String assuZip = request.getParameter("assuZip");             //�������ʱ�
    String assuAddr = request.getParameter("assuAddr");             //������ͨѶ��ַ
    if((assuId.compareTo("") != 0)&&(assuPhone.compareTo("")==0))
    { assuPhone = " ";    }
    if((assuId.compareTo("") != 0)&&(assuName.compareTo("")==0))
    { assuName = " ";   }
    if((assuId.compareTo("") != 0)&&(assuZip.compareTo("")==0))
    { assuZip = " ";    }
    if((assuId.compareTo("") != 0)&&(assuAddr.compareTo("")==0))
    { assuAddr = " ";   }      
    String innetFee = request.getParameter("innetFee");             //������
    String handFee = request.getParameter("handFee");               //������
    String choiceFee = request.getParameter("choiceFee");           //ѡ�ŷ�
    String prepayFee = request.getParameter("prepayFee");           //Ԥ����
    String machFee = request.getParameter("machFee");               //������
    String simFee = request.getParameter("simFee");                 //SIM����
    String choicePreFee= request.getParameter("choicePreFee"); 
    
    String hid_innetFee = request.getParameter("hid_innetFee");     //�޸�������
    String hid_HandFee = request.getParameter("hid_HandFee");       //�޸�������
    String hid_ChoiceFee = request.getParameter("hid_ChoiceFee");   //�޸�ѡ�ŷ�
    String hid_MachFee = request.getParameter("hid_MachFee");       //�޸Ļ�����
    String hid_SimFee = request.getParameter("hid_SimFee");         //�޸�SIM����    
    String favourableTime = request.getParameter("favourableTime");         //��ǰϵͳʱ��
    String hid_favourableTime = request.getParameter("hid_favourableTime"); //�Ż�ʱ��
    String strCardSum = request.getParameter("largess_card_sum");         //���ͳ�ֵ������
    
    String cashPay = request.getParameter("cashPay");               //�ֽ𽻿�
    String bankCode = request.getParameter("bankCode");             //���д���
    if((bankCode.trim()).compareTo("") == 0)    
    {   bankCode = "zzz";              }    
    String checkNo = request.getParameter("checkNo");               //֧Ʊ����
    if((checkNo.trim()).compareTo("") == 0)
    {   checkNo = "zzz";              }
    String checkPay = request.getParameter("checkPay");             //֧Ʊ����
    if((checkPay.trim()).compareTo("") == 0)
    {   checkPay = "0.00";             }
    String sumPay = request.getParameter("sumPay");                 //�ϼƷ���
    
    String sysNote = request.getParameter("sysNote");               //ϵͳ��ע
    String opNote = request.getParameter("opNote");                 //������ע      
    if(opNote.equals("")){opNote="��ͨ����";}            

    String payCode = request.getParameter("payCode");               //���ʷѴ���
    String additiveCode = request.getParameter("additiveCode");     //��ѡ�ʷѴ���
    String rentpayCode = request.getParameter("rentpayCode");       //���ʱ�ĸ����ʷѴ���
  String bindModeCode=request.getParameter("bindModeCode");       //�󶨸����ʷ�
  String bindModeName=request.getParameter("bindModeName");       //�󶨸����ʷ�
  String innetPreFee = request.getParameter("innetPreFee");   //����Ԥ���

String strHasEval = request.getParameter("haseval");//�Ƿ����û���������� 
String strEvalCode = request.getParameter("evalcode");//�û���������۴��� 

System.out.println("test"); 
  //�����ʷѺͿ�ѡ�ʷ�ƴ������һ��������������ǿ�ѡ
  String[] tp_rentpayCode = new String[50];
  tp_rentpayCode[0]=payCode;
  StringTokenizer additiveCodeToken = new StringTokenizer(additiveCode,"~");
  int additiveCodeLength = additiveCodeToken.countTokens();
  for(int i=1;i<=additiveCodeLength;i++)
  {
    tp_rentpayCode[i] = (String)additiveCodeToken.nextElement();
    System.out.println("tp_rentpayCode[i]tp_rentpayCode[i]="+tp_rentpayCode[i]);
  }
  String[] tp_rentpayCode_1 = new String[]{};//��Ʒ�۸����ִ�
  String[] tp_rentpayCode_2 = new String[]{};//��Ʒ���Դ�
  String[] tp_rentpayCode_3 = new String[]{};//��Ʒ����
  String[] tp_rentpayCode_4 = new String[]{};//�������
  String[] tp_rentpayCode_5 = new String[]{};//�������Դ�
  String serviceNow = request.getParameter("serviceNow");         //������Ч�ط�    
  String serviceAfter = request.getParameter("serviceAfter");     //ԤԼ��Ч�ط� 
  String serviceAddNo = request.getParameter("serviceAddNo");     //���Ӻ����ط� 
  String sysAccept = request.getParameter("sysAccept");         //�õ�������ˮ

  String machineType=request.getParameter("hidMachineType");      //�õ���������
  String tfFlag=request.getParameter("tfFlag");                   //�ط�ѡ���־
  machineType+=tfFlag;
  String pack_creditNo=WtcUtil.repStr(request.getParameter("pack_creditNo"),"0");//Ӫ����ƾ֤��

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
        String cardtype_bz=request.getParameter("cardtype_bz");//�տ���־
    String spayType="0";
    if(!(checkRadio.trim().equals(""))) spayType="6";
        //�ͻ���Ϣ��:ҵ��Ʒ�ƴ���~��������~������~�û�����~
        //�����ȴ���~������ֵ~���Ѵ���~��������~��������~
        //Ȩ��ֵ~��������~��������~��������~֧Ʊ����~���д���       
        String custGrade = request.getParameter("custGrade"); //�û�����(�����е�attr_code)
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
        //������Ϣ��:����������~������֤������~������֤��~�����˵绰~�����˵�ַ~�������ʱ�~
        //assuName = assuName.replaceAll("~","");
        //assuIdType = assuIdType.replaceAll("~","");
       // assuId = assuId.replaceAll("~","");
       // assuPhone = assuPhone.replaceAll("~","");
       // assuAddr = assuAddr.replaceAll("~","");
       // assuZip = assuZip.replaceAll("~","");
        
        String pAssure_List = assuName + "~" + assuIdType + "~" + assuId + "~" +
                assuPhone + "~" + assuAddr + "~" + assuZip + "~"; 
        //�ʼ��ʵ���Ϣ��:�ʼ��ʵ���־~�ʼ��ʵ�����~�ʼ��ʵ���ַ~�ʼ��ʵ��ʱ�~�ʼ��ʵ�����~�ʼ��ʵ�Mail~                
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
        //������Ϣ��:�ֽ𽻿�~֧Ʊ����~Ԥ���~SIM����~������~������~ѡ�ŷ�~������~������~    
        
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
        //�Ż���Ϣ��
        String  pfavourable_List = "";
    pfavourable_List = simFee + "~" + machFee  +"~" +innetFee+ "~"+choiceFee+"~"+handFee+"~"; 
         //�ײ���Ϣ��
        //payCode = payCode.replaceAll("~","");
       // additiveCode = additiveCode.replaceAll("~","");
        //rentpayCode = rentpayCode.replaceAll("~","");
       // bindModeCode = bindModeCode.replaceAll("~",""); 
    String pPackage_List = payCode + "~" + additiveCode + "~"+rentpayCode+"~"+bindModeCode+"~";
        //�ط���Ϣ����������Ч�ط���            
        String pFunc_List = serviceNow;        
        //�ط���Ϣ����ԤԼ�ط���  
        String pUnUsedFunc_List = serviceAfter;
        //�ط���Ϣ�����̺����ط���  
        String pAddAddFunc_List = serviceAddNo;
        //��e����Ϣ��:ƾ֤ϵ�к�~ Gprs�ײ� ~ WLAN�ײ�
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
        is_not_adward = request.getParameter("is_not_adward");  //�Ƿ����齱
    //}else{
      //is_not_adward = "L";
    //}
    has_cailing = request.getParameter("has_cailing");  //����������
    has_card = request.getParameter("largess_card");  //���ͳ�ֵ��
    String twoFlag = is_sms_call + is_not_adward + has_cailing+has_card;
    System.out.println("twoFlag="+twoFlag);
    System.out.println("has_cailing="+has_cailing);
    //�ͻ���Ϣ���Ĳ��䴦��
    pCust_List = pCust_List+request.getParameter("innettype")+"~";

    //**************Ϊ����ѹ�����*********************/
   
    
    //String retMessage = "";
    //int ret_code=0;
    String[] retArr=null;
    String serviceName="s1104Cfm";
    String outParaNum="2";
    String vAwardMsg="";
/**   try{             //  ��wtc�滻  2008.09.03  liutong
      
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
System.out.println("��ʼ���÷���s1104Cfm  in f1104_2.jsp ****************************************");
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
System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
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
System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%"); 	
	
	
	
	
System.out.println(ret_code);
          if(ret_code.equals("0")||ret_code.equals("000000")){
          System.out.println("���÷���s1104Cfm in f1104_2.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
            vAwardMsg=result[0][0];
            
        }else{
          System.out.println(ret_code+"     System.out.println(ret_code);");
          System.out.println(retMessage+"     System.out.println(retMessage);");
          System.out.println("���÷���s1104Cfm in f1104_2.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
      }


  //===========================================
  //��֯��ӡ���ݿ�ʼ
  if(cashPay==null || cashPay.trim().equals("")) cashPay="0";
  if(checkPay==null || checkPay.trim().equals("")) checkPay="0";
  String chinaFee = "";
  String busi_sumPay=String.valueOf(Double.parseDouble(innetPreFee)+Double.parseDouble(handFee)+Double.parseDouble(choiceFee)+Double.parseDouble(machFee)+Double.parseDouble(simFee)+Double.parseDouble(choicePreFee));
  String printInfo = "";
    String fee_sumPay=String.valueOf(Double.parseDouble(prepayFee));
  String note = custId + phoneNo + "��ͨ����" + "�ֽ��:" + WtcUtil.formatNumber(cashPay,2) + "֧Ʊ��:" + WtcUtil.formatNumber(checkPay,2);
  if(Double.parseDouble(busi_sumPay)>0.01)
  {
    printInfo="64|5|10|0|"+new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())+"|";
    printInfo += "72|5|10|0|"+new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())+"|";
    printInfo += "77|5|10|0|"+new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())+"|";
    printInfo = printInfo + "16|5|9|0|" + workno + "|";            //����
    printInfo = printInfo + "24|5|9|0|" + sysAccept + "|";         //��ˮ
    if(operType.equals("dn")){
      printInfo = printInfo + "35|5|9|0|" + "���еش���ͨ����������ϸ" + "|";  
    }else if(operType.equals("gn")){
      printInfo = printInfo + "35|5|9|0|" + "ȫ��ͨ��ͨ����������ϸ" + "|";  //ȫ��ͨ����������ϸ
    }else if(operType.equals("zn")){  
      printInfo = printInfo + "35|5|9|0|" + "��������ͨ����������ϸ" + "|";
    }

      printInfo = printInfo + "16|8|10|0|" + custName + "|";         //�û���
    printInfo = printInfo + "16|11|10|0|" + phoneNo + "|";         //�ֻ���
    printInfo = printInfo + "50|11|10|0|" + userId + "|";        //Э�����
    if((checkNo.trim()).compareTo("zzz") == 0)
    {   checkNo = "";              }
    printInfo = printInfo + "73|11|10|0|" + checkNo + "|";       //֧Ʊ����
    printInfo = printInfo + "65|14|10|0|" + WtcUtil.formatNumber(sumPay,2) + "|"; //Сд    
    /**try                   //  ��wtc�滻  2008.09.03  liutong
        {
            retArray = callView.view_sToChinaFee(sumPay);
            result = (String[][])retArray.get(0);
            chinaFee = result[0][2];
        }catch(Exception e){
            logger.error("Call sunView is Error,Can't get chinaFee!");
        }   **/
      System.out.println("��ʼ���÷���sToChinaFee  in f1104_2.jsp ****************************************");
%>
<wtc:service name="sToChinaFee" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="retMessage1"  outnum="3" >
      <wtc:param value="<%=sumPay%>"/>
      </wtc:service>
      <wtc:array id="result1" scope="end" />
<%        
         if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("���÷���sToChinaFee in f1104_2.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
          chinaFee=result1[0][2];
            
        }else{
      System.out.println("���÷���sToChinaFee in f1104_2.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
      }
        
    printInfo = printInfo + "22|14|10|0|" + chinaFee + "|";                       //��д

    printInfo = printInfo + "21|20|9|0|�����ѣ�  " + WtcUtil.formatNumber(machFee,2) + "|";          //������
    printInfo = printInfo + "21|21|9|0|SIM���ѣ� " + WtcUtil.formatNumber(simFee,2) + "|";           //SIM����
    printInfo = printInfo + "50|21|9|0|����Ԥ��ѣ�" + WtcUtil.formatNumber(fee_sumPay,2) + "|";     //����Ԥ��
    printInfo = printInfo + "21|22|9|0|�ֽ�  " + WtcUtil.formatNumber(cashPay,2) + "|";          //�ֽ��
    printInfo = printInfo + "50|22|9|0|֧Ʊ�    " + WtcUtil.formatNumber(checkPay,2) + "|";       //֧Ʊ��
    
    if ((has_card.trim()).compareTo("Y") == 0){//���ͳ�ֵ��������
      printInfo = printInfo + "21|24|9|0|������"+strCardSum + "��10Ԫ��ֵ��ֵ��,����ƾ��Ʊ�����������������ڵ�����ָ��Ӫҵ����ȡ��"+"|";      
      printInfo = printInfo + "21|25|9|0|��ע��    " + note + "|";                       //��ע
    }else{
      printInfo = printInfo + "21|24|9|0|��ע��    " + note + "|";                       //��ע
    }
    
    //printInfo = printInfo + "21|25|9|0|�н���Ϣ��" + vAwardMsg +"|";
    printInfo = printInfo + "21|25|9|0|" + vAwardMsg +"|";

    //20091014 fengry begin for ���˰�����������
    if(result[0][1].equals("��л���������.����2009���黶������Ʒ�һ�����Ԥ�治���˻������ڻ�ڼ��ڶһ���Ʒ���������ϡ�"))
    {
        printInfo = printInfo + "21|26|9|0|" + result[0][1] +"|";
    }
    System.out.println("result[0][1]="+result[0][1]);
    //20091014 end

  }
  String printInfo1 = "";
  //=========================================
  //��֯��ӡ���ݽ���
  
  //���� 2008��1��3�� �޸������û��������������
  if(ret_code.equals("0") && strHasEval.equals("1")){      //�жϷ�ʽ�޸�  ret_codeԭΪint 
    String strParaAray[] = new String[6];
    strParaAray[0] = thework_no;  //0  ��������                iLoginNo  thework_no
    strParaAray[1] = theop_code;  //1  ��������                iOpCode   theop_code
    strParaAray[2] = themob;      //2  �ƶ�����                iPhoneNo  themob                         
    strParaAray[3] = strEvalCode; //3  ���۴���
    strParaAray[4] = stream;      //5  ������ˮ
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
          System.out.println("���÷���sCommEvalCfm in f1104_2.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
            
            
        }else{
      System.out.println("���÷���sCommEvalCfm in f1104_2.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
      }


  }

  
    if(!ret_code.equals("000000"))                          //�жϷ�ʽ�޸�  ԭΪint 
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
         var path = "spubPrint_1104.jsp?DlgMsg=" + "ȫ��ͨ��ͨ�����ɹ���";
         var path = path + "&printInfo=<%=printInfo%>&printInfo1=<%=printInfo1%>&submitCfm=Single";
         var ret=window.showModalDialog(path,"",prop);  
                     location = "f1104_1.jsp";
            </script>
<%            

        }
%>
