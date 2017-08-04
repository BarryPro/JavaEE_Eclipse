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
private static HashMap cfgMap = new HashMap(200);//缓存话单格式
private static String CGI_PATH = "";
private static String DETAIL_PATH = "";

static{    
    //从公共配置文件中读取配置信息，此信息被多sever共享
    CGI_PATH = SystemUtils.getConfig("CGI_PATH");
    DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
    
    System.out.println("$$$$$$$$$$$$$$$ - "+CGI_PATH);
    System.out.println("$$$$$$$$$$$$$$$ - "+DETAIL_PATH);
    
    //如果不以"/"格式结束,加上"/"
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
                         //工号
	String strIccid = request.getParameter("iccid");		//手机号码
	String strMonth = request.getParameter("month");		//查询密码
    String strCustId = request.getParameter("cust_id");		//详单类型
    
    String selectType = request.getParameter("selectType");  //查询类型
	String meetingId = request.getParameter("meetingId");  //会议ID
	String meetingInitiator = request.getParameter("meetingInitiator");  //会议发起人
	String searchType = request.getParameter("searchType");  //时间类型
	/* add by wanglma 如果不填的话 赋个默认值 */
	if("".equals(meetingId)){
	   meetingId = "0";
	}
	if("".equals(meetingInitiator)){
	   meetingInitiator = "0";
	}
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //当前时间
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	String custName = "";       //客户名词	
    String outFile = "";

	try {
  	//程序路径,参数，文件名
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

	//得到输出文件 
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
<title>集团详单查询</title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>	

<table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
	<tbody> 
  	<tr bgcolor="#99ccff" align="center"> 
			<td>中国移动通信客户集团详单
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
		<td width="80%"> 总共有 <%=(icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)%> 页，当前页为每 1 页 </td>
    	<%if (beginLine + pageSize < icount-1) {%>    
      	<td width="10%"><a href="f2735DetQry1.jsp?&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>" >【下一页】 </a> </td>
	   		<td width="10%"><a href="f2735DetQry1.jsp?icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>" >【最后一页】 </a> </td>
			<%}%>
    </font>
    </tr>
  </tbody> 
  </table>
  <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
  <tbody> 
  	<tr bgcolor="#99ccff" align="center"> 
			<td>
			&nbsp; <input class="button" name=back onClick="print_detail()" type=button value="  打  印  ">
    	&nbsp; <input class="button" name=close onClick="window.close()" type=button value="  关  闭  ">
    	&nbsp; <input class="button" name="submitBtn" id="submitBtn" onClick="print_out()"  type=button value="  导  出  ">
			</td>
    </tr>
  </tbody> 
  </table>
</Form>

<script language="JavaScript">
function print_detail()
{
    document.frm1500.action="sPrint.jsp?qryName=\"集团详单查询\"&outFile=<%=outFile%>";
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
