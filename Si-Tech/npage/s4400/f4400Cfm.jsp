
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-18
********************/
%>
              
<%
  String opName = "����VIP��������";
%>              

<%@ include file="/npage/include/public_title_name.jsp" %> 

<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%
System.out.println("-----------------------------------f4400Cfm.jsp------------------------------------");
	String	errCode = "";
    String  errMsg = "";
	
	List al = null;
	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����

	StringTokenizer st = null;
	int recNums = 0;
	int tmpRecNums = 0;
	String TOKEN = "|";
	int kk=0;
	
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	
	String verifyType = request.getParameter("verifyType");
	String op_code = request.getParameter("opCode");
	
	String loginNo  =request.getParameter("loginNo"); 	  /* ��������   */ 
	String orgCode  =request.getParameter("orgCode");	    /* ��������   */
	String opCode   =request.getParameter("opCode");		  /* ��������   */		
	String totalDate=request.getParameter("totalDate");	  /* ������ע   */
	String IDType   =request.getParameter("IDType");	 
	String phoneNo  =request.getParameter("phoneNo");
	String cardType =request.getParameter("cardType");	 
	String cardID   =request.getParameter("cardID");
	String custPWD  =request.getParameter("custPWD");
	String inTime   =request.getParameter("inTime");
	String outTime  =request.getParameter("outTime");
	String servLevel=request.getParameter("servLevelVal");
	
	String servLevelName = "";
	if(servLevel.equals("5")){
		servLevelName ="��վVIP�������";
	}else if(servLevel.equals("1")){
		servLevelName ="���ں���һ������";
	}else if(servLevel.equals("2")){
		servLevelName ="���ں����������";
	}else if(servLevel.equals("3")){
		servLevelName ="���ʺ���һ������";
	}else if(servLevel.equals("4")){
		servLevelName ="���ʺ����������";
	}
	String attendant= request.getParameter("attendantVal");

	String tmpR1=request.getParameter("tmpR1");
	String tmpR2=request.getParameter("tmpR2");
	String tmpR3=request.getParameter("tmpR3");
	String tmpR4=request.getParameter("tmpR4");
	String tmpR5=request.getParameter("tmpR5");
	String tmpR6=request.getParameter("tmpR6");

	String sumAmount=request.getParameter("sumAmount");
	String sumScore=request.getParameter("sumScore");
	String opNote=request.getParameter("opNote");
	
	String sumTimes=request.getParameter("sumTimes");
	String airportName=request.getParameter("airportName");
	String airNo=request.getParameter("airNo");
	
	String tmpBusyAccept=request.getParameter("tmpBusyAccept");
	String tmpSendAccept="";
	String custName=request.getParameter("custName1");
	String opType=request.getParameter("opType1");
	String czFlag="";

	//�����ַ������γɶ�ά����. by yl.

  czFlag = "CZ01";
	 
  //add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String)session.getAttribute("password");

String     outList[][] = new String [][]{{"0","1"}};
String  inputParam[] = new String[15];

inputParam[0]=phoneNo;
inputParam[1]=sumScore;
inputParam[2]=czFlag;
inputParam[3]="1";

if(servLevel.equals("5")){
     inputParam[4]="��վ�����������";	
}else {
     inputParam[4]="�ɻ��������������";
	}
inputParam[5]=loginNo;
inputParam[6]=orgCode;
inputParam[7]="4400";
inputParam[8]=opNote;
inputParam[9]="";
inputParam[10]="0";
inputParam[11]="";
inputParam[12]=String.valueOf(Integer.parseInt(sumAmount) / 1000);
inputParam[13]="4400";/*huangrong add op_code 2010-12-1*/ 
inputParam[14]=password;

try
{
	//retArray = callWrapper.callFXService("s1250Cfm",inputParam,"13",outList);        
%>

    <wtc:service name="s1250Cfm" outnum="13" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputParam[10]%>" />
			<wtc:param value="01" />
			<wtc:param value="<%=inputParam[13]%>"/>
			<wtc:param value="<%=inputParam[5]%>" />
			<wtc:param value="<%=inputParam[14]%>" />	
			<wtc:param value="<%=inputParam[0]%>" />
			<wtc:param value=" " />		
			<wtc:param value="<%=inputParam[1]%>" />
			<wtc:param value="<%=inputParam[2]%>" />
			<wtc:param value="<%=inputParam[3]%>" />
			<wtc:param value="<%=inputParam[4]%>" />			
			<wtc:param value="<%=inputParam[6]%>" />						
			<wtc:param value="<%=inputParam[7]%>" />	
			<wtc:param value="<%=inputParam[8]%>" />	
			<wtc:param value="<%=inputParam[9]%>" />			
			<wtc:param value="<%=inputParam[11]%>" />
			<wtc:param value="<%=inputParam[12]%>" />						
		</wtc:service>

<%	             
	errCode = code1;
	errMsg = msg1;
	System.out.println("retCode = " + errCode);
	System.out.println("retMessage = " + errMsg);
}catch(Exception e){
    System.out.println("4400 Call s1250Cfm  is Failed!");
}  
String[][] backInfo = new String[][]{{"0","0"}};

if(errCode.equals("000000"))
{


	String[][] result  = null ;
	
	String inParas[] = new String[11];
	inParas[0] = "4400";
	inParas[1] = loginNo;
	inParas[2] = "";	
	inParas[4] = opType;
	inParas[5] = loginNo;
	inParas[6] = phoneNo;
	inParas[7] = custName;
	inParas[8] = sumTimes;
	inParas[9] = "";
	inParas[10] = tmpBusyAccept;
	
	//	value = viewBean.callService("0", null, serviceName, "2", inParas);
%>

    <wtc:service name="s4400Add" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />			
			<wtc:param value="<%=inParas[4]%>" />
			<wtc:param value="<%=inParas[5]%>" />
			<wtc:param value="<%=inParas[6]%>" />
			<wtc:param value="<%=inParas[7]%>" />
			<wtc:param value="<%=inParas[8]%>" />					
			<wtc:param value="<%=inParas[9]%>" />
			<wtc:param value="<%=inParas[10]%>" />
		</wtc:service>
		<wtc:array id="result_t2" scope="end"   />

<%		
 	result = result_t2;
 	
 	errCode = result[0][0];
 	errMsg = result[0][1];
 	if (errCode.equals("000000"))
 	{
 	  valid =0; 
 	}
}

String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&retMsgForCntt="+errMsg+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+""+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+phoneNo+"&contactType=user";
%>
	<jsp:include page="<%=url%>" flush="true" />
<%if( valid == 0){%>
<script language="JavaScript">
	rdShowMessageDialog("�����ɹ�!!",2);
	showPrtDlg();
	window.location="f4400.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
/*--------------------------��ӡ���̺���---------------------------*/
function showPrtDlg()
{

   var h=105;
   var w=260;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret=rdShowConfirmDialogPrint("�Ƿ��ӡ���������");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //����Ͽ�
        {
            conf();                          
        }
        else if(ret==0)                 //���ȡ��,���Ƿ��ύ
        {    
            window.location="f4400.jsp?opCode=<%=opCode%>&opName=<%=opName%>";                  
        }
    }
}

function conf()
{
   var h=200;
   var w=300;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;

   /***********************��ӡ����Ĳ���**********************************/
   var busi_type = "<%=opType%>";									//ҵ�����
   var work_no = "<%=loginNo%>";                                 //������
   var accept_no = "<%=tmpBusyAccept%>";				//ʹ���ĸ���ˮ
   var send_accept = "<%=tmpSendAccept%>"; //add by jingy
   var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// ϵͳ����
   var phone = "<%=phoneNo%>";					//�ƶ�����
   var cust_name = "<%=custName%>";						//�ͻ�����
   var pay_money = "<%=sumScore%>";					//���ۻ���     ---���ѽ��
   
   var tmpR1="<%=tmpR1%>";
   var tmpR2="<%=tmpR2%>";
   var tmpR3="<%=tmpR3%>";
   var tmpR4="<%=tmpR4%>";
   var tmpR5="<%=tmpR5%>";
   var tmpR6="<%=tmpR6%>";
   
   var servLevel="<%=servLevelName%>";
   var attendant="<%=Integer.parseInt(attendant)==1?"��1��Ա":"������Ա"%>";
   
   var airportName="<%=airportName%>";
   var airNo="<%=airNo%>";
   var sumTimes="<%=sumTimes%>";

   
   /**********************��ӡ����Ĳ�����֯���****************************/

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 

   var ret_value=window.showModalDialog("s4400_print.jsp?busi_type="+busi_type+"&work_no="+work_no+"&accept_no="+accept_no+"&send_accept="+send_accept+"&date="+date+"&phone="+phone+"&cust_name="+cust_name+"&pay_money="+pay_money+"&tmpR1="+tmpR1+"&tmpR2="+tmpR2+"&tmpR3="+tmpR3+"&tmpR4="+tmpR4+"&tmpR5="+tmpR5+"&tmpR6="+tmpR6+"&servLevel="+servLevel+"&attendant="+attendant+"&airportName="+airportName+"&airNo="+airNo+"&sumTimes="+sumTimes,"",prop);//���ȷ�ϣ����ô�ӡҳ��

   window.location = "f4400.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 }
</script>
<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("ϵͳ��������ϵͳ����Ա��ϵ��лл!!",0);
	window.location="f4400.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%}%>








