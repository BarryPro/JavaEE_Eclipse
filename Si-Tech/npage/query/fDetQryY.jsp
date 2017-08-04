<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%
    String opCode = "1511";
    String opName = "移动梦网详单查询";
    
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
  //CallRemoteResultValue callRemoteResultValue = null;
  String[][] result = new String[][]{};
    
	boolean billCanView = true;
	
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
    //如果不以"/"格式结束,加上"/"
    if(!CGI_PATH.endsWith("/")){
		CGI_PATH=CGI_PATH+"/";
        DETAIL_PATH=DETAIL_PATH+"/"; 
    }
  }
%>
<%
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workNo = baseInfo[0][2];                         //工号
	String phoneNo = request.getParameter("phoneNo");		    //手机号码
	String passWord = request.getParameter("passWord");		  //查询密码
    String qryType = "6";		                                //详单类型
	String qryName = "移动梦网";
	String billBegin = request.getParameter("beginTime");	  //开始时间
	String billEnd = request.getParameter("endTime");		    //结束时间
	String in_towPassWord = request.getParameter("towPassWord");//二次密码
    String searchType = request.getParameter("searchType");
	String searchTime = request.getParameter("searchTime");
	String billTime = billBegin + "^" + billEnd + "^";      //时间串

	if (searchType.equals("1")) {
	   billTime = searchTime;
	}

	/*String predictionNO = "65258723"; */                      //流失号
	String predictionNO = "0";                              /*流水号，changed by zhangnc 20081227 原因：流水号写死*/
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //当前时间
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	String custName = "";       //客户名词	
    String outFile = "";
    String loginAccept = "";
  	String chnSource="";
	String[] inParas = new String[]{""};
    inParas[0] = "select b.cust_name, a.cust_id, a.user_passwd from dCustMsg a, dCustDoc b where a.cust_id = b.cust_id and substr(run_code,2,1) < 'a' and a.phone_no = '" + phoneNo + "'";
    
	//callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "3", inParas);
%>
<!--  安全加固改造
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg"  outnum="3">
	<wtc:sql><%=inParas[0]%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArr" scope="end" />
-->
	      <wtc:service name="sCustTypeQryH" routerKey="phone" routerValue="<%=phoneNo%>" outnum="3" >
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="<%=chnSource%>"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=passWord%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=passWord%>"/>
				</wtc:service>
				<wtc:array id="retArr" scope="end"/>


<%
    //result = callRemoteResultValue.getData();
    result = retArr;
	boolean haveCustName = false;
	if (result.length != 1) {
        sErrorMessage = "该用户不存在，请重新输入！";
	    billCanView = false;
	} 

	int icount = 0;
  String tline = null;
	File temp = null;
  if (billCanView) {
       
	   try {
       //程序路径,参数，文件名
	   String kshString = CGI_PATH + "cp.sh" + " ";
	   String paramterString = workNo + " " + phoneNo + " " + qryType + " " + searchType + " " + billTime + " " + predictionNO + " " + dateStr + " " + "26 ";
	   outFile = phoneNo + qryType + dateStr1 + ".txt"; 
	   String exePath = "/usr/bin/ksh "+ CGI_PATH +"cp.sh " + paramterString + DETAIL_PATH + outFile + " 1 " + "YYYYYY";
       
     Runtime.getRuntime().exec(exePath);
     } catch(IOException ioe) {
		   ioe.printStackTrace();		
	   }    	

	   //得到输出文件 
  	 String txtPath = DETAIL_PATH;
  	 String totalLine = "";
	   temp = new File( txtPath,outFile);
	   int readCount=0;
	   while(!temp.exists() && readCount<30) {
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
	}		
%>

<html>
<head>
<title> 详单查询-移动梦网</title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
<!--
function ifprint(){
   <% if (!billCanView) { %>           
		 rdShowMessageDialog("<%=sErrorMessage%>");
         history.go(-1); 
   <% } %>	
}

function gohome() {
   document.location.replace("s1511.jsp?activePhone=<%=phoneNo%>");
}
//-->
</SCRIPT>
</head>	
<body onload="ifprint()">

<%if (billCanView) {%>
<p align="center"><font color="#0000FF" size="5">中国移动通信客户移动梦网详单</font></p>
<table border="0" align="center" cellspacing="0">
    <%
       int lineNum = 0;
       tline = null;
       int beginLine = 0;
       int pageSize = 30;
       
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
	<input type="hidden" name="phoneNo"  value="<%=phoneNo%>">
	<input type="hidden" name="billBegin"  value="<%=billBegin%>">
	<input type="hidden" name="billEnd"  value="<%=billEnd%>">
	<input type="hidden" name="qryType"  value="<%=qryType%>">
	<input type="hidden" name="dateStr"  value="<%=dateStr1%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">
      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
        <tbody> 
          <tr bgcolor="#99ccff" align="center"> 
		   <font color="#0000FF">
		    <td width="80%"> 总共有 <%=(icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)%> 页，当前页为每 1 页 </td>
            <%if (beginLine + pageSize < icount-1) {%>    
               <td width="10%"><a href="fDetQry2.jsp?icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>" >【下一页】 </a> </td>
               
			   <td width="10%"><a href="fDetQry1.jsp?icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>" >【最后一页】 </a> </td>
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
      			&nbsp; <input class="button" name=close onClick="removeCurrentTab()" type=button value="  关  闭  ">
      		    &nbsp; <input class="button" name=close onClick="gohome()" type=button value="  返  回  ">
			</td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
</Form>

<script language="JavaScript">
function print_detail()
{
	getAfterPrompt();
    document.frm1500.action="sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    frm1500.submit();
    return true;
}
</script>
<% } %>
</body>
</html>
