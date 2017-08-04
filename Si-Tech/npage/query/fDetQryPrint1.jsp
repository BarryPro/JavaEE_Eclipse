<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>

<%!
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
	String phoneNo = request.getParameter("phoneNo");		//手机号码
	String billBegin = request.getParameter("billBegin");	//开始时间
	String billEnd = request.getParameter("billEnd");		//结束时间
	String qryType = request.getParameter("qryType");		//查询类型
	String qryName = request.getParameter("qryName");		//二级明细名称
	String dateStr = request.getParameter("dateStr");		//查询时间
	String outFile = request.getParameter("outFile");		//生成的文件
	String beginLineStr = request.getParameter("beginLine");	//读取开始行
	String custName = request.getParameter("custName");			//通讯端口
	String icount = request.getParameter("icount");			//通讯端口
	
	String islowcust = request.getParameter("islowcust");
%>
<html>
<head>
<title> 安保部详单查询-<%=qryName%></title>

<SCRIPT LANGUAGE="JavaScript">
<!--
function gohome()
{
	document.location.replace("f1516_1.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>");
}
//-->
</SCRIPT>

</head>	
<body>

<FORM method=post name="frm1500" OnSubmit=" ">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="phoneNo"  value="<%=phoneNo%>">
	<input type="hidden" name="billBegin"  value="<%=billBegin%>">
	<input type="hidden" name="billEnd"  value="<%=billEnd%>">
	<input type="hidden" name="qryType"  value="<%=qryType%>">
	<input type="hidden" name="qryName"  value="<%=qryName%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">
	<div class="title">
		<div id="title_zi">中国移动通信客户<%=qryName%>详单</div>
	</div>
	<table cellspacing="0">
	    <%
	       //得到输出文件 
	  	   String txtPath = DETAIL_PATH;
	       File temp = new File( txtPath,outFile);
	       
	       int lineNum = 0;
	       String tline = null;
	       int beginLine = Integer.parseInt(beginLineStr);
	       int pageSize = 30;
	       
	       FileReader outFrT1 = new FileReader(temp);
	       BufferedReader outBrT1 = new BufferedReader(outFrT1);	
	       
	       do {
			     tline = outBrT1.readLine();
			     String tlinetep = "";
			     if (tline != null) {
			        tlinetep = tline.replaceAll(" ", "&nbsp;");
			     }
			     
			     if (lineNum >= beginLine && lineNum < beginLine + pageSize) {
			         out.println("<tr><td align='left' nowrap>" + tlinetep + "</td></tr>");
			     }
			     
			     lineNum++;
			  } while(tline!=null);
	       outBrT1.close();
		   outFrT1.close();
	    %>    
	</table>
      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
				<tr> 
					<font class="orange">
						<td width="60%"> 共有 <%=(Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)%> 页，当前页为每 <%=beginLine/pageSize + 1%> 页 </td>
						<%if (beginLine != 0) {%>
						<td width="10%"><a href="fDetQryPrint1.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=0&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >【第一页】 </a> </td>
						<td width="10%"><a href="fDetQryPrint1.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine - pageSize%>&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >【上一页】 </a> </td>
						<%}%>
						
						<%if (beginLine + pageSize < Integer.parseInt(icount)) {%>
						<td width="10%"><a href="fDetQryPrint1.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >【下一页】 </a> </td>
						
						<td width="10%"><a href="fDetQryPrint1.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=(((Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)-1)*pageSize)%>&opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=<%=phoneNo%>" >【最后一页】 </a> </td>
						
						<%}%>			  
					</font>
				</tr>
      </table>
      <table width="98%" cellspacing=0>
          <tr id="footer"> 
						<td>
							&nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  打  印  ">
							&nbsp; <input class="b_foot" name=close onClick="removeCurrentTab();" type=button value="  关  闭  ">
							&nbsp; <input class="b_foot" name=close onClick="gohome()" type=button value="  返  回  ">		 
						</td>
          </tr>
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
</Form>
<script language="JavaScript">
function print_detail()
{
    var h = 800;
    var w = 1000;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
    var path = "sPrint1516.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>&opCode=<%=opCode%>&opName=<%=opName%>";
    var ret = window.open(path, "", prop);
}
</script>

</body>
</html>
