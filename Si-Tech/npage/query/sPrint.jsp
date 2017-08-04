<%
    /********************
     version v2.0
     开发商: si-tech
     *
     * update:zhanghonga@2008-08-15 页面改造,修改样式
     * 
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
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
  String opCode = "1526";
  String opName = "普通详单查询";
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
	String workNo = (String)session.getAttribute("workNo");
	String ip = request.getRemoteAddr();
	String imageName = ip+workNo+".jpg"; //yuanqs add 2010-9-1 12:43:30

%>
<html>
<head>
<title> 详单查询-<%=qryName%></title>
</head>	
<body topmargin="0" onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
			<p align="center"><font color="#0000FF" size="5">中国移动通信客户<%=qryName%>详单</font></p>
			<table border="0" align="center" cellspacing="0" id="t1">
	
			    <%
			       //得到输出文件 
			  	   String txtPath = DETAIL_PATH;
			       File temp = new File(txtPath,outFile);
			       
			       String tline = null;
			       FileReader outFrT1 = new FileReader(temp);
			       BufferedReader outBrT1 = new BufferedReader(outFrT1);	
			       
			       do {
					     tline = outBrT1.readLine();
					     String tlinetep = "";
					     if (tline != null) {
					        tlinetep = tline.replaceAll(" ", "&nbsp;");
					     }
					     out.println("<tr><td align='left' nowrap>" + tlinetep + "</td></tr>");
					  } while(tline!=null);
			       outBrT1.close();
				   outFrT1.close();
			    %>    
			</table>
</body>
<SCRIPT type=text/javascript>
   onload=function() {
   	$("#t1").css("background-image","url(img/<%=imageName%>)"); 
      window.print();
      window.close();
   }
</SCRIPT>
</html>
