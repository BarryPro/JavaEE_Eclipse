<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
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
%>
<html>
<head>
<title> 详单查询-<%=qryName%></title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">

<SCRIPT LANGUAGE="JavaScript">
<!--
function gohome()
{
document.location.replace("s1511.jsp");
}
//-->
</SCRIPT>

</head>	
<body>
<p align="center"><font color="#0000FF" size="5">中国移动通信客户<%=qryName%>详单</font></p>
<table border="0" align="center" cellspacing="0">
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

<FORM method=post name="frm1500" OnSubmit=" ">
	<input type="hidden" name="phoneNo"  value="<%=phoneNo%>">
	<input type="hidden" name="billBegin"  value="<%=billBegin%>">
	<input type="hidden" name="billEnd"  value="<%=billEnd%>">
	<input type="hidden" name="qryType"  value="<%=qryType%>">
	<input type="hidden" name="qryName"  value="<%=qryName%>">
	<input type="hidden" name="outFile"  value="<%=outFile%>">

      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
        <tbody> 
          <tr bgcolor="#99ccff" align="center"> 
           <font color="#0000FF">
		    <td width="60%"> 共有 <%=(Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)%> 页，当前页为每 <%=beginLine/pageSize + 1%> 页 </td>
              <%if (beginLine != 0) {%>
                  <td width="10%"><a href="fDetQry2.jsp?qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=0" >【第一页】 </a> </td>
                  <td width="10%"><a href="fDetQry2.jsp?qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine - pageSize%>" >【上一页】 </a> </td>
              <%}%>
                            
              <%if (beginLine + pageSize < Integer.parseInt(icount)) {%>
                  <td width="10%"><a href="fDetQry2.jsp?qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>" >【下一页】 </a> </td>
				  
				  <td width="10%"><a href="fDetQry2.jsp?qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=(((Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)-1)*pageSize)%>" >【最后一页】 </a> </td>
                  
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
      			&nbsp; <input class="button" name=close onClick="gohome()" type=button value="  返  回  ">
			</td>
          </tr>
        </tbody> 
      </table>
</Form>
<script language="JavaScript">
function print_detail()
{
    document.frm1500.action="sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    frm1500.submit();
    return true;
}
</script>

</body>
</html>