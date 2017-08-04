<%
    /*************************************
    * 功  能: 安保部普通详单查询(新) e234
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-8-23
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GB2312");%>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>

<script type="text/javascript" src="/npage/public/printExcel.js"></script>	
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode="e234";
    String opName="安保部普通详单查询(新)";
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
	
	String islowcust = request.getParameter("islowcust");
	
	//yuanqs add 100712 详单增加水印
	String workNo = (String)session.getAttribute("workNo");  //工号
	String ip = request.getRemoteAddr();

	 //yuanqs add 2010/8/31 9:38:50 详单加水印需求
    String str = ip + "    " + workNo;
    String imageName = ip+workNo+".jpg";
%>
<html>
<head>
<title> 安保部普通详单标准查询-<%=qryName%></title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<SCRIPT LANGUAGE="JavaScript">
function gohome()
{
	document.location.replace("fe234_main.jsp?activePhone=<%=phoneNo%>");
}
</SCRIPT>

</head>	
<body onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
   
 <FORM method=post name="frm234q" OnSubmit=" ">
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
<table border="0" align="center" cellspacing="0" style="background-image:url(../query/img/<%=imageName%>)" name="t1" id="t1">
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
		        out.println("<tr  align='center'><td nowrap height='24'><font style='font-size:14px;font-family:宋体'>" + tlinetep + "</font></td></tr>");
		     }
		     
		     lineNum++;
		  } while(tline!=null);
       outBrT1.close();
	   outFrT1.close();
    %>    
</table>
      <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
        <tbody> 
         <tr> 
           <font class="orange">
		    <td> 
		    	<% 	int allPage = 0; 
        			allPage = (Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1);
        			int nowPage = 0;
        			nowPage = beginLine/pageSize + 1;
        	%>
		    	共有 <%=allPage%> 页，当前页为每 <%=nowPage%> 页 </td>
              <%if (beginLine != 0) {%>
                  <td><a href="fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=0&phoneNo=<%=phoneNo%>" >【第一页】 </a> </td>
                  <td><a href="fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine - pageSize%>&phoneNo=<%=phoneNo%>" >【上一页】 </a> </td>
              <%}%>
                            
              <%if (beginLine + pageSize < Integer.parseInt(icount)) {%>
                  <td><a href="fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&phoneNo=<%=phoneNo%>" >【下一页】 </a> </td>
				  
				  <td><a href="fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=(((Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)-1)*pageSize)%>&phoneNo=<%=phoneNo%>" >【最后一页】 </a> </td>
                  
			  <%}%>			  
						  <td>
		          	跳转到
								<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
									<%
									String selectCtrl = "";
									for (int i = 1; i <= allPage; i ++) {
									
										if(nowPage == i){
											selectCtrl = "selected";
										}else{
											selectCtrl = "";
										}
									%>
										<option value="<%=i%>" <%=selectCtrl%> >第<%=i%>页</option>
									<%
									}
									%>
								</select>
								页
		          </td>
            </font>
          </tr>
        </tbody> 
      </table>
      <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
        <tbody> 
          <tr align="center"> 
			<td id="footer">
				&nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  打  印  ">
      			&nbsp; <input class="b_foot" name=close onClick="parent.removeCurrentTab();" type=button value="  关  闭  ">
      			&nbsp; <input class="b_foot" name=close onClick="gohome()" type=button value="  返  回  ">
            	&nbsp; <input class="b_foot_long" name=save onClick="printTable(t1)" type=button value="导出当前页">
    		</td>
          </tr>
        </tbody> 
      </table>
      <%@ include file="/npage/include/footer.jsp" %> 
</Form>
<script language="JavaScript">
function print_detail()
{
    document.frm234q.action="sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    frm234q.submit();
    return true;
}

function setPage(goPage){
	if (goPage == "-1") {
		return;
	} else{
		var pageSizeVal = "<%=pageSize%>";
		var beginLineVal = pageSizeVal * (goPage - 1);
		var dirtPate = "fDetQryPrinte234.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=" + beginLineVal + "&phoneNo=<%=phoneNo%>";
		location = dirtPate;
	}
}

</script>

</body>
</html>
