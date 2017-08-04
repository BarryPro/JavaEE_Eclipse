<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "javax.ejb.*" %>
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
<%@ page import = "import com.sitech.common.*" %>
<!-- ningtn 2011-7-18 18:26:15 -->
<script type="text/javascript" src="/npage/public/printExcel.js"></script>	
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
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");        //手机号码
  String broadPhone = request.getParameter("broadPhone");  //宽带账号
  String passWord = request.getParameter("passWord");        //查询密码
	String billBegin = request.getParameter("billBegin");	//开始时间
	String billEnd = request.getParameter("billEnd");		//结束时间
	String qryType = request.getParameter("qryType");		//查询类型
	String qryName = request.getParameter("qryName");		//二级明细名称
	String dateStr = request.getParameter("dateStr");		//查询时间
	String outFile = request.getParameter("outFile");		//生成的文件
	String beginLineStr = request.getParameter("beginLine");	//读取开始行
	String custName = request.getParameter("custName");			//通讯端口
	String icount = request.getParameter("icount");			//通讯端口
	//yuanqs add 100712 详单增加水印
	String workNo = (String)session.getAttribute("workNo");  //工号
	String ip = request.getRemoteAddr();
	
	String islowcust = 
request.getParameter("islowcust");

	    //yuanqs add 2010/8/31 9:38:50 详单加水印需求
    String str = ip + "    " + workNo;
    String imageName = ip+workNo+".jpg";
    /*String imagePath = "/iwebd1/applications/DefaultWebApp/npage/query/img/" + imageName;
    int width = 619;
		int height = 187;
		float alpha = 0.5f;
    CreateImg.drawImage(str, imagePath, width, height, alpha);*/
%>
<head>
<title>  详单查询-<%=qryName%></title>

<SCRIPT LANGUAGE="JavaScript">
<!--
function gohome()
{
document.location.replace("e796_1.jsp?activePhone=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>");
}
//-->
//begin diling add for 增加保存功能 2011-10-24    
function savefile1()
{
    var sFileName = document.frm1500.outFile.value;
    var path = "fDownData1526.jsp?fileName="+sFileName+"&sFilePath=<%=DETAIL_PATH%>";
    var ret = window.open(path);
}
//end diling add for 增加保存功能 2011-10-24      
</SCRIPT>

</head>	
<!-- yuanqs add 2010/9/13 11:02:38 -->
<body onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">中国移动通信客户<%=qryName%>详单</div>
		</div>
<table border="0" align="center" cellspacing="0" name="t1" id="t1"  style="background-image:url(img/<%=imageName%>)">
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
	
      <table cellspacing="0">
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
                  <td><a href="e796_3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=0&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>" >【第一页】 </a> </td>
                  <td><a href="e796_3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine - pageSize%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>" >【上一页】 </a> </td>
              <%}%>
                            
              <%if (beginLine + pageSize < Integer.parseInt(icount)) {%>
                  <td><a href="e796_3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>" >【下一页】 </a> </td>
				  
				  <td><a href="e796_3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=<%=(((Integer.parseInt(icount))/pageSize + ((Integer.parseInt(icount)) % pageSize == 0 ? 0 : 1)-1)*pageSize)%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>" >【最后一页】 </a> </td>
                  
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
          <tr> 
			<td id="footer">
				&nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  打  印  ">
      			&nbsp; <input class="b_foot" name=close onClick="window.close()" type=button value="  关  闭  ">
      			&nbsp; <input class="b_foot" name=close onClick="gohome()" type=button value="  返  回  ">
				<%if (islowcust.equals("242000")) {%>	
				  &nbsp; <input class="b_foot" name=fee onClick="payFee()" type=button value="  交 手 续 费  ">&nbsp;
    		    <% } %>				 
              &nbsp; <input class="b_foot" name=save onClick="savefile1()" type=button value="  保  存  ">
    		  &nbsp; <input class="b_foot_long" name=save onClick="printTable(t1)" type=button value="导出当前页">
    		</td>
          </tr>
        </tbody> 
      </table>
</Form>
<script language="JavaScript">
function print_detail()
{
		var h = 800;
    var w = 1000;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
    var path = "sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    var ret = window.open(path, "", prop);
    //document.frm1500.action="sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
    //frm1500.submit();
    return true;
}
function setPage(goPage){
	if (goPage == "-1") {
		return;
	} else{
		var pageSizeVal = "<%=pageSize%>";
		var beginLineVal = pageSizeVal * (goPage - 1);
		var dirtPate = "e796_3.jsp?islowcust=<%=islowcust%>&qryName=<%=qryName%>&icount=<%=icount%>&outFile=<%=outFile%>&beginLine=" + beginLineVal + "&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
		location = dirtPate;
	}
}
</script>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
