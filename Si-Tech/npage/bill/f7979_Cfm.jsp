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
	String regionCode = WtcUtil.repNull(request.getParameter("regionCode"));
	String work_name = (String)session.getAttribute("workName");
	String thework_no = (String)session.getAttribute("workNo");                                   //��������                    0  �������� iLoginNo                          
	String psw =(String)session.getAttribute("password");                                         //��������					1  �������� iLoginPwd                           
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
String theop_code = WtcUtil.repNull(request.getParameter("op_code"));     //��������					2  iOpCode                                                                                                      										
String returnPage = WtcUtil.repNull(request.getParameter("return_page"));
String kin_mode = WtcUtil.repNull(request.getParameter("kin_mode"));
String NextMode = WtcUtil.repNull(request.getParameter("Next_Mode"));
String kin_nos = WtcUtil.repNull(request.getParameter("kin_nos"));											  
String stream = WtcUtil.repNull(request.getParameter("stream"));       //ϵͳ��ˮ												  
String opNote = WtcUtil.repNull(request.getParameter("opNote"));
String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
String Mode_Code = WtcUtil.repNull(request.getParameter("Mode_Code"));
%>
<%

/*--------------------------------��ʼ����sCfm--------------------------------*/
		String [] KinNos = kin_nos.split(",");
		for(int i=0;i<KinNos.length;i++)
		{
			System.out.println("KinNos["+i+"]="+KinNos[i]);
		}
		String paraAray[] = new String[11];	
		paraAray[0] = regionCode; // ���д���		
		paraAray[1] = kin_mode; //  �����ʷѴ���     
		paraAray[2] = thework_no; //  ��������                
		paraAray[3] = psw; //  ��������                                     		           
		paraAray[4] = theop_code; // ��������    
		paraAray[5] = "(�μ�KinNos����,δ���˲���)"; 
		paraAray[6] = phoneNo;
		paraAray[7] = stream; //  ϵͳ��ˮ 
		paraAray[8] = NextMode; //  �����ʷ� 
		paraAray[9] = Mode_Code;
		paraAray[10] = opNote; //  ��ע     
				   		
	for(int i=0;i<paraAray.length;i++){
		System.out.println("paraAray["+i+"]="+paraAray[i]);
	}		
%>
		<wtc:service name="s7979Cfm" routerKey="regioncode" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:params value="<%=KinNos%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>			
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
			
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+retCode+"&opName="+opName2+"&workNo="+thework_no+"&loginAccept="+stream+"&pageActivePhone="+phoneNo+"&opBeginTime="+opBeginTime+"&contactId="+phoneNo+"&contactType=user";
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
 		location="<%=returnPage%>";
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
