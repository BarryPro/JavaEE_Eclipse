<%@ page contentType="text/html;charset=GB2312" %>
<%request.setCharacterEncoding("GB2312");%>
<%@ page import = "javax.ejb.*" %>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import = "com.sitech.boss.pub.*" %>
<%@ page import = "com.sitech.boss.pub.config.*" %>
<%@ page import = "com.sitech.boss.pub.conn.*" %>
<%@ page import = "com.sitech.boss.pub.exception.*" %>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%@ page import = "com.sitech.boss.pub.wtc.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.lang.String" %>
<%@ page import = "java.text.*" %>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
    String[][] result = new String[][]{};
    
    boolean billCanView = false;
    int slowcust = 0;
    
    int iErrorNo = 0;
    String sErrorMessage = "";
%>

<%!
private static HashMap cfgMap = new HashMap(200);//���滰����ʽ
private static String CGI_PATH = "";
private static String DETAIL_PATH = "";

static{    
    //�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
    CGI_PATH = SystemUtils.getConfig("CGI_PATH");
    DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
    
    System.out.println("$$$$$$$$$$$$$$$ - "+CGI_PATH);
    System.out.println("$$$$$$$$$$$$$$$ - "+DETAIL_PATH);
    
    //�������"/"��ʽ����,����"/"
    if(!CGI_PATH.endsWith("/")){
		CGI_PATH=CGI_PATH+"/";
        DETAIL_PATH=DETAIL_PATH+"/"; 
    }
  }
%>
<%
  String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
  String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
                         //����
	String strIccid = request.getParameter("iccid");		//�ֻ�����
	String strMonth = request.getParameter("month");		//��ѯ����
    String strCustId = request.getParameter("cust_id");		//�굥����
    
    String selectType = request.getParameter("selectType");  //��ѯ����
	String meetingId = request.getParameter("meetingId");  //����ID
	String meetingInitiator = request.getParameter("meetingInitiator");  //���鷢����
	String searchType = request.getParameter("searchType");  //ʱ������
	/* add by wanglma �������Ļ� ����Ĭ��ֵ */
	if("".equals(meetingId)){
	   meetingId = "0";
	}
	if("".equals(meetingInitiator)){
	   meetingInitiator = "0";
	}
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	String custName = "";       //�ͻ�����	
    String outFile = "";

	try {
  	//����·��,�������ļ���
	  String paramterString = workno + " "+ nopass+ " " + strMonth + " " + strCustId + " " +selectType + " " + meetingId + " " + meetingInitiator + " " + " " + searchType + " ";
	  outFile = strCustId + dateStr1 + ".txt";
	  
	  System.out.println("# ##################################################paramterString = "+paramterString);
	  System.out.println("# DETAIL_PATH = "+DETAIL_PATH+" "+searchType);
	  System.out.println("# outFile = "+outFile);
	  
	  String exePath = "/usr/bin/ksh "+ CGI_PATH +"adccp.sh " + paramterString + DETAIL_PATH + outFile;
    System.out.println("exePath="+exePath); 
    Runtime.getRuntime().exec(exePath);
	} catch(IOException ioe) {
		ioe.printStackTrace();
  }    	

	//�õ�����ļ� 
  String txtPath = DETAIL_PATH;
  String totalLine = "";
	int icount = 0;
  String tline = null;  
	File temp = null;  	 
	temp = new File( txtPath,outFile);
	int readCount=0;
	while(!temp.exists() && readCount<720) {
		Thread.sleep(1000);
		readCount++;
	};
	
	FileReader outFrT = new FileReader(temp);
  BufferedReader outBrT = new BufferedReader(outFrT);	
    
  do {
		tline = outBrT.readLine();
		icount++;
  } while(tline!=null);
	
	outBrT.close();
	outFrT.close();  
%>

<html>
<head>
<title>�����굥��ѯ</title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>	

<table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
	<tbody> 
  	<tr bgcolor="#99ccff" align="center"> 
			<td>�й��ƶ�ͨ�ſͻ������굥
			</td>
    </tr>
	</tbody> 
</table>




<table border="0" align="center" cellspacing="0">
    <%
       int lineNum = 0;
       tline = null;
       int beginLine = 0;
       int pageSize = 30;
       
       System.out.println("temp="+temp);
       FileReader outFrT1 = new FileReader(temp);
       BufferedReader outBrT1 = new BufferedReader(outFrT1);	
       
       do {
		     tline = outBrT1.readLine();
		     String tlinetep = "";
		     if (tline != null) {
		        tlinetep = tline.replaceAll(" ", "&nbsp;");
		     }
		     
		     if (lineNum < beginLine + pageSize) {
		         out.println("<tr><td align='left' nowrap>" + tlinetep + "</td></tr>");
		     }
		     
		     lineNum++;
		  } while(tline!=null);
       outBrT1.close();
	   outFrT1.close();
    %>    
</table>

<FORM method=post name="frm1500" OnSubmit=" ">
	<input type="hidden" name="dateStr"  value="<%=dateStr1%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">
	<table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
  <tbody> 
  	<tr bgcolor="#99ccff" align="center"> 
		<font color="#0000FF">
		<td width="80%"> �ܹ��� <%=(icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)%> ҳ����ǰҳΪÿ 1 ҳ </td>
    	<%if (beginLine + pageSize < icount-1) {%>    
      	<td width="10%"><a href="f2735DetQry1.jsp?&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>" >����һҳ�� </a> </td>
	   		<td width="10%"><a href="f2735DetQry1.jsp?icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>" >�����һҳ�� </a> </td>
			<%}%>
    </font>
    </tr>
  </tbody> 
  </table>
  <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
  <tbody> 
  	<tr bgcolor="#99ccff" align="center"> 
			<td>
			&nbsp; <input class="button" name=back onClick="print_detail()" type=button value="  ��  ӡ  ">
    	&nbsp; <input class="button" name=close onClick="window.close()" type=button value="  ��  ��  ">
    	&nbsp; <input class="button" name="submitBtn" id="submitBtn" onClick="print_out()"  type=button value="  ��  ��  ">
			</td>
    </tr>
  </tbody> 
  </table>
</Form>

<script language="JavaScript">
function print_detail()
{
    document.frm1500.action="sPrint.jsp?qryName=\"�����굥��ѯ\"&outFile=<%=outFile%>";
    frm1500.submit();
    return true;
}

function print_out()
{
    var path = "downData.jsp?fileName=<%=outFile%>";
    //alert(path);
    window.open(path);
}
</script>
</body>
</html>
