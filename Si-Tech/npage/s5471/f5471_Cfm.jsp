<% /******************** version v2.0 ������: si-tech * *update:zhanghonga@2008
          -08-19 ҳ�����,�޸���ʽ * ********************/ %> 
<%@ page contentType="text/html;charset=GBK"%> 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %> 
<% 	
		String opCode2 =(String)request.getParameter("opCode"); 
		if (opCode2 == null){ opCode2 = "1270";} 
%> 
<%! /**���������������ʽ�������Сд����**/ 
public static String formatNumber(String num, int zeroNum) 
{ 
	DecimalFormat form =(DecimalFormat)NumberFormat.getInstance(Locale.getDefault()); 
	StringBuffer patBuf = new StringBuffer("0"); 
	if(zeroNum > 0) 
	{ 
		patBuf.append("."); for(int i= 0; i < zeroNum; i++) { patBuf.append("0"); }
  }
  form.applyPattern(patBuf.toString());
  return form.format(Double.parseDouble(num)).toString();
}
%>
<%
	String regionCode = WtcUtil.repNull(request.getParameter("region_code"));
	String work_name = (String)session.getAttribute("workName");
	String thework_no = (String)session.getAttribute("workNo");                                   //��������                    0  �������� iLoginNo                          
	String psw =(String)session.getAttribute("password");                                         //��������					1  �������� iLoginPwd                           
	String MonthRent = WtcUtil.repNull(request.getParameter("month_rent_fee"));
	String ipAddr = WtcUtil.repNull(request.getParameter("ipAddr"));
	String serviceName="";
%>
<HTML>
<head>
</HEAD>
<BODY>
<FORM action="" method=post name="form1">
</FORM>
<BODY>
</HTML>
<%      
/*--------------------------------��֯sCfm�Ĵ������-------------------------------*/
String theop_code = "5471";                         //��������					2  iOpCode                                                                             //��½IP					    16 ��¼IP  iIpAddr                            										
String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
String vModeCode = WtcUtil.repNull(request.getParameter("mode_code"));
String op_flag = WtcUtil.repNull(request.getParameter("op_flag"));
String opTime = WtcUtil.repNull(request.getParameter("begin_time"));											  
String stream = WtcUtil.repNull(request.getParameter("stream"));       //ϵͳ��ˮ												  
String opNote = WtcUtil.repNull(request.getParameter("opNote"));
%>
<%

/*--------------------------------��ʼ����sCfm--------------------------------*/
		String [] RegionCodes = regionCode.split(",");
		String [] ModeCodes = vModeCode.split(",");
		String paraAray[] = new String[9];	
		paraAray[0] = "(�μ�RegionCodes����,δ���˲���)"; // ���д���		
		paraAray[1] = "(�μ�vModeCode����,δ���˲���)"; //  �ʷѴ��� 
		paraAray[2] = MonthRent; //		�����    
		paraAray[3] = thework_no; //0  ��������                iLoginNo  thework_no
		paraAray[4] = psw; //4  ��������                iLoginPwd psw                      		           
		paraAray[5] = opTime; //5 ��ͨʱ��    
		paraAray[6] = op_flag; //6  ������־  
		paraAray[7] = opNote; //7  ��ע   
		paraAray[8] = theop_code; //8  �������� 
				
	for(int i=0;i<paraAray.length;i++){
		System.out.println("paraAray["+i+"]="+paraAray[i]);
	}		
%>
		<wtc:service name="s5471Cfm" routerKey="regioncode" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:params value="<%=RegionCodes%>"/>
		<wtc:params value="<%=ModeCodes%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		</wtc:service>
		<wtc:array id="result4" scope="end"/>	
<%	
		int ret_code = 999999;	
		if(retCode!=""){
			ret_code = Integer.parseInt(retCode);
		}
        String ret_msg = retMsg;
		System.out.println("ret_code=====222=============="+ret_code);
	
		System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");	
		String cnttLoginAccept = "";
		String opName2 = (String)request.getParameter("opName");
		System.out.println("%%%%%%%������� theop_code%%%%%%%%"+theop_code);	
		System.out.println("%%%%%%%������� retCode%%%%%%%%"+retCode);	
		System.out.println("%%%%%%%������� opName2%%%%%%%%"+opName2);	
		System.out.println("%%%%%%%������� thework_no%%%%%%%%"+thework_no);	
		System.out.println("%%%%%%%������� stream%%%%%%%%"+stream);	
			
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+retCode+"&opName="+opName2+"&workNo="+thework_no+"&loginAccept="+stream+"&opBeginTime="+opBeginTime+"&contactType=user";
		System.out.println("%%%%%%%������� url%%%%%%%%"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
		System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");

/*------------------------------���ݵ��÷��񷵻ؽ������ҳ����ת------------------------------*/
%>
</script>

<%if(ret_code==0){%>
<script language='jscript'>
rdShowMessageDialog('�����ɹ���',2);
if("<%=returnPage%>"!="") 
{
  if("<%=op_flag%>"=="A" || "<%=op_flag%>"=="U") 
  {
 		location="<%=returnPage%>";
  }
  else if("<%=op_flag%>"=="D")
  {
  	parent.location="/npage/s5471/f5471login.jsp?opName=<%=opName2%>&opCode=<%=theop_code%>";
  }	
}

else
{
  parent.removeTab('<%=opCode2%>');
}
</script>
<%}%>



<%if(!(ret_code==0)){%>
<script language='jscript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��");
	history.go(-2);
</script>
<%}%>
