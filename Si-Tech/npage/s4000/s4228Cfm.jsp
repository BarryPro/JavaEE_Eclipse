
<%
/********************
 version v2.0
 ������ si-tech
 update gaopeng@2013/3/18 ����һ 10:15:08
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="java.util.ArrayList"%>
<%
  String opName = "��������";
%>              

<%

	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String errorCode="444444";
	String errCodeMsg = "";
	List al = null;
  int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	
	String verifyType = request.getParameter("verifyType");
  String op_code = request.getParameter("opCode");
	String loginNo  =request.getParameter("loginNo"); 	/* ��������   */ 
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
	String regionCode = (String)session.getAttribute("regCode");
	String loginNoPass=request.getParameter("loginNoPass");
	String servLevelName = "";
	if(servLevel.equals("1")){
		servLevelName ="���ں���һ������";
	}else if(servLevel.equals("2")){
		servLevelName ="���ں����������";
	}else if(servLevel.equals("3")){
		servLevelName ="���ʺ���һ������";
	}/*else if(servLevel.equals("4")){
		servLevelName ="���ʺ����������";
	}*/
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
	
	String tmpBusyAccept=request.getParameter("tmpBusyAccept");//��ˮ
	String tmpSendAccept="";
	String custName=request.getParameter("custName1");
	String opType=request.getParameter("opType1");
	String testFlag=request.getParameter("test_flag");
/**
    ���������
								��ˮ						tmpBusyAccept
								������ʶ				01
								��������				op_code
								��������				loginNo
								��������				loginNoPass
								�ֻ�����				phoneNo
								��������				custPWD
								���Ź���				orgCode
								֤������				cardType
								֤������				cardID
								����ʱ��				inTime
								�뿪ʱ��				outTime
								���񼶱�				servLevel
								ͳ����Ŀ����		tmpR1
								ͳ����Ŀ����		tmpR2
								������Ŀ����		tmpR3
								������Ŀֵ			tmpR4
								���						tmpR5
								�ۺ�Ӧ�ۻ���		tmpR6
								�ܽ��					sumAmount
								�ۺ�Ӧ���ܻ���	sumScore
								��Ա����				attendant
								Ӧ�۵���Ѵ���  sumTimes
								
								
**/
	
	
	String  inputParam[] = new String[23];
	inputParam[0]			=			tmpBusyAccept	;
	inputParam[1]			=			"01"					;           
	inputParam[2]			=			op_code				;      
	inputParam[3]			=			loginNo				;      
	inputParam[4]			=			loginNoPass				;      
	inputParam[5]			=			phoneNo				;      
	inputParam[6]			=			custPWD						;           
	inputParam[7]			=			orgCode				;      
	inputParam[8]			=			cardType			;     
	inputParam[9]			=			cardID				;       
	inputParam[10]		=			inTime				;       
	inputParam[11]		=			outTime				;      
	inputParam[12]		=			servLevel			;    
	inputParam[13]		=			tmpR1					;        
	inputParam[14]		=			tmpR2					;        
	inputParam[15]		=			tmpR3					;        
	inputParam[16]		=			tmpR4 				;       
	inputParam[17]		=			tmpR5 				;       
	inputParam[18]		=			tmpR6   			;     
	inputParam[19]		=			sumAmount 		;   
	inputParam[20]		=			sumScore 			;    
	inputParam[21]		=			attendant 		;    
	inputParam[22]		=			sumTimes 			;  
	System.out.println("gaopeng----4228----"+ tmpBusyAccept	);
	System.out.println("gaopeng----4228----"+ "01"					);
	System.out.println("gaopeng----4228----"+ op_code				);
	System.out.println("gaopeng----4228----"+ loginNo				);
	System.out.println("gaopeng----4228----"+ loginNoPass				);
	System.out.println("gaopeng----4228----"+ phoneNo				);
	System.out.println("gaopeng----4228----"+ custPWD						);
	System.out.println("gaopeng----4228----"+ orgCode				);
	System.out.println("gaopeng----4228----"+ cardType			);
	System.out.println("gaopeng----4228----"+ cardID				);
	System.out.println("gaopeng----4228----"+ inTime				);
	System.out.println("gaopeng----4228----"+ outTime				);
	System.out.println("gaopeng----4228----"+ servLevel			);
	System.out.println("gaopeng----4228----"+ tmpR1					);
	System.out.println("gaopeng----4228----"+ tmpR2					);
	System.out.println("gaopeng----4228----"+ tmpR3					);
	System.out.println("gaopeng----4228----"+ tmpR4 				);
	System.out.println("gaopeng----4228----"+ tmpR5 				);
	System.out.println("gaopeng----4228----"+ tmpR6   			);
	System.out.println("gaopeng----4228----"+ sumAmount 		);
	System.out.println("gaopeng----4228----"+ sumScore 			);
	System.out.println("gaopeng----4228----"+ attendant 		);
	System.out.println("gaopeng----4228----"+ sumTimes 	 		);		
	 //al = f4228Req.doProcess(loginNo, orgCode,opCode,phoneNo,cardType ,cardID,custPWD,inTime,outTime,servLevel,tmpR1,tmpR2,tmpR3,tmpR4,tmpR5,tmpR6,sumAmount,sumScore,sumTimes,opNote,tmpBusyAccept,attendant,testFlag);
	%>
	
	 <wtc:service name="s4228Cfm" outnum="3" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputParam[0]%>" />
			<wtc:param value="<%=inputParam[1]%>" />
			<wtc:param value="<%=inputParam[2]%>" />
			<wtc:param value="<%=inputParam[3]%>" />
			<wtc:param value="<%=inputParam[4]%>" />
			<wtc:param value="<%=inputParam[5]%>" />
			<wtc:param value="<%=inputParam[6]%>" />
			<wtc:param value="<%=inputParam[7]%>" />
			<wtc:param value="<%=inputParam[8]%>" />
			<wtc:param value="<%=inputParam[9]%>" />
			<wtc:param value="<%=inputParam[10]%>" />
			<wtc:param value="<%=inputParam[11]%>" />
			<wtc:param value="<%=inputParam[12]%>" />
			<wtc:param value="<%=inputParam[13]%>" />
			<wtc:param value="<%=inputParam[14]%>" />
			<wtc:param value="<%=inputParam[15]%>" />
			<wtc:param value="<%=inputParam[16]%>" />
			<wtc:param value="<%=inputParam[17]%>" />
			<wtc:param value="<%=inputParam[18]%>" />
			<wtc:param value="<%=inputParam[19]%>" />
			<wtc:param value="<%=inputParam[20]%>" />
			<wtc:param value="<%=inputParam[21]%>" />
			<wtc:param value="<%=inputParam[22]%>" />
		</wtc:service>
	<wtc:array id="result1" scope="end"/>
	
	<%

 if( result1.length == 0 ){
		valid = 1;
	}else{

		errorMsg = msg1;
		errorCode = code1;
		
		if( Integer.parseInt(errorCode) != 0){
			valid = 2;
			
		}else{
			valid = 0;

		}
	}

%>

<%if( valid == 1){%>
<script language="JavaScript">

	rdShowMessageDialog("ϵͳ��������ϵͳ����Ա��ϵ��лл!!");
	window.location="s4228.jsp?opCode=4228&opName=��������";

</script>

<%}else if( valid == 2){%>
<script language="JavaScript">

	rdShowMessageDialog("<br>�������:["+"<%=errorCode %>]</br>"+"������Ϣ:["+"<%=errorMsg %>"+"]");
	window.location="s4228.jsp?opCode=4228&opName=��������";

</script>

<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("�����ɹ�!!");
	window.location="s4228.jsp?opCode=4228&opName=��������";
</script>
<%}%>








