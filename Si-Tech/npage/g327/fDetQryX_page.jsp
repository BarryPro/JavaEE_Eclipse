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
		String outFile = request.getParameter("outFile");		     //生成的文件
	  String toPage = request.getParameter("toPage");	         //跳转页面
	  String pageCount = request.getParameter("pageCount");	   //总页面
	  String qryName =  request.getParameter("qryName");	
	  String lines_one_page = request.getParameter("lines_one_page");	//每页显示多少行
	  String DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
    String order_path = DETAIL_PATH + outFile;
    File file2 = new File(order_path);
    System.out.println("---liujian---60=" + file2.exists());
		String workNo = (String)session.getAttribute("workNo");  //工号
		String ip = request.getRemoteAddr();
	  String imageName = ip+workNo+".jpg";

	  String firstPageBody = parseDocument(order_path,Integer.valueOf(toPage).intValue(),lines_one_page);
	  System.out.println("---liujian---toPage=" + toPage);
	  System.out.println("---liujian---order_path=" + order_path);
	  System.out.println("---liujian---firstPageBody=" + firstPageBody);
%>
<head>
		<title>详单查询-<%=qryName%></title>
		<link href="../query/detail.css" rel="stylesheet" type="text/css"></link>
	  <script type="text/javascript" src="/npage/public/printExcel.js"></script>	
		<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
		<script language="javascript">
    	 /*  liujian  2012-3-14 9:06:36  添加详单js方法 begin */
				var currPage = 1;
				$(function() {
						/****************************注册一系列事件*****************************************/
					  // 首页传递first，下一页传递next，上一页传递prev，尾页传递last
						$('#firstPage').click(function() {
							 var currPage = '<%=toPage%>';
							 if(parseInt(currPage) > 1) {
							 		location ="fDetQryX_page.jsp?toPage=1&pageCount=<%=pageCount%>&lines_one_page=<%=lines_one_page%>&outFile=<%=outFile%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>&qryName=<%=qryName%>";
								}
						});
						$('#prevPage').click(function() {
							 var currPage = '<%=toPage%>';
							 if(parseInt(currPage) > 1) {
								 var toPage = currPage - 1;
								 location ="fDetQryX_page.jsp?toPage=" + toPage+ "&pageCount=<%=pageCount%>&lines_one_page=<%=lines_one_page%>&outFile=<%=outFile%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>&qryName=<%=qryName%>";
							 }
						});
						$('#nextPage').click(function() {
							var currPage = '<%=toPage%>';
							if( parseInt(currPage) < parseInt('<%=pageCount%>') ) {
							  var toPage = parseInt('<%=toPage%>') + 1;
							  location ="fDetQryX_page.jsp?toPage=" + toPage+ "&pageCount=<%=pageCount%>&lines_one_page=<%=lines_one_page%>&outFile=<%=outFile%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>&qryName=<%=qryName%>";
							}
						});
						$('#lastPage').click(function() {
							var currPage = '<%=toPage%>';
							if( parseInt(currPage) < parseInt('<%=pageCount%>') ) {
							 location ="fDetQryX_page.jsp?toPage=<%=pageCount%>&pageCount=<%=pageCount%>&lines_one_page=<%=lines_one_page%>&outFile=<%=outFile%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>&qryName=<%=qryName%>";
							}
						});
						
						$('#pageSel').change(function() {
							 var toPage = $('#pageSel').val();
						  location = "fDetQryX_page.jsp?toPage=" + toPage +"&pageCount=<%=pageCount%>&lines_one_page=<%=lines_one_page%>&outFile=<%=outFile%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>&qryName=<%=qryName%>";
						});
						$('#prtBtn').click(function() {
			        var h = 800;
			        var w = 1000;
			        var t = screen.availHeight / 2 - h / 2;
			        var l = screen.availWidth / 2 - w / 2;
			        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			        var path = "../query/print.jsp?fileName=<%=outFile%>&opCode=<%=opCode%>&opName=<%=opName%>";
			        var ret = window.open(path, "", prop);
						});
						$('#submitBtn').click(function() {
				    	var path = "../query/downData.jsp?fileName=<%=outFile%>";
				      var ret = window.open(path);
						})
						/****************************初始化页面*****************************************/
					showLightBox();
						init();
				});
				//初始化
				function init() {
						$('#currPage').val('<%=toPage%>');
						$('#pageCount').val('<%=pageCount%>');
						$('#pageCountSpan').text('<%=pageCount%>');
						$('#currPageSpan').text('<%=toPage%>');
						$('#detailContainer').append('<%=firstPageBody%>');
						setSelPage('<%=pageCount%>');	
						setToPageAttr();
						hideLightBox();	
				}
				//设置颜色和click事件
				function setToPageAttr() {
						var count = '<%=pageCount%>';
						var currPage = '<%=toPage%>';
						if(parseInt(count) == parseInt(currPage)) {
								$('#nextPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
								$('#lastPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
						}else if(parseInt(currPage) == 1) {
							  $('#firstPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
							  $('#prevPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
					  }
				}	
				function setSelPage(pageCount) {
						if(!pageCount) {
								$('#pageSel').append('<option value = 1>第1页</option>');
						}else {
							var count = parseInt(pageCount);
							var pageArr = new Array();
							for( var i = 1; i <= count; i++) {
									if( i == parseInt('<%=toPage%>')) {
										pageArr.push('<option value = ' + i + ' selected>第' + i + '页</option>');
									}else {
										pageArr.push('<option value = ' + i + '>第' + i + '页</option>');
									}
									
							}
							$('#pageSel').append(pageArr.join(''));
						}
				}
				
				function gohome()
				{
					document.location.replace("fg371.jsp?activePhone=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>");
				}
				/*  liujian  2012-3-14 9:06:36  添加详单js方法 end */
		</script>
		
</head>	
	<!-- liujian 2012-3-14 9:08:55 详单DOM结构 begin-->
	<body onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
			<form action="" method="post" name="form1">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">中国移动通信客户<%=qryName%>详单</div>
				</div>
				<div style="background-image:url(/npage/query/img/<%=imageName%>)" id="detailContainer">
			
				</div>
				
				<table cellspacing="0">
			    <tbody> 
			    	<!--隐藏区间开始-->
			    	<input type="hidden" id="currPage" value="" />
			    	<input type="hidden" id="pageCount" value="" />
			    	<!--隐藏区间结束-->
			      <tr> 
			    			<td> 共有<span id="pageCountSpan"></span>页，当前页为第<span id="currPageSpan"></span>页 </td>
 								<td><span name="firstPage" id="firstPage" class="detail_href">【首页】   </span> </td>
          			<td><span name="prevPage" id="prevPage" class="detail_href" >  【上一页】 </span> </td>
         				<td><span name="nextPage" id="nextPage" class="detail_href" >  【下一页】 </span> </td>
		  		      <td><span name="lastPage" id="lastPage" class="detail_href" > 【尾页】    </span> </td>		    
					  		<td width="10%">
					  				<select id="pageSel" name="pageSel" style="width:80px">
								    </select>
					  		</td>		 
			      </tr>
			    </tbody> 
			  	</table>
			  	<table cellspacing="0">
			      <tr> 
			          <td id="footer"> 
			              <input name="prtBtn" id="prtBtn" class="b_foot"  type="button"  index="2" value="打 印" />
			              &nbsp; 
			              <input name="close"  class="b_foot" onClick="removeCurrentTab();" type=button value="关  闭"/>
			              &nbsp;
			              <input name="submitBtn" id="submitBtn" class="b_foot"  type="button"  index="2" value="导 出" />
			              &nbsp; 
			              <input name="back"  class="b_foot"  onClick="gohome();" type="button"  value="返 回" />
			              &nbsp; 
			         </td>
			      </tr>
			  </table>
			  <%@ include file="/npage/include/footer.jsp" %> 
			</form>
	</body>
	<!-- liujian 2012-3-14 9:08:55 详单DOM结构 end-->

</html>

<%!
	   String retCode = "111111";
 	   String retMsg = "文件不存在！";
 	   String currTitleLine = "";
		 //判断文件是否存在
		 public boolean exsitFile(String path) {
				File file = new File(path);
				if (!file.exists() || file.isDirectory() || !file.canRead()) {
						retCode = "000001";
 	 					retMsg = "文件不存在！";
				    return false;
				}else {
					return true;
				}
			}

			//判断是否末尾是空白行
			public boolean lastLineIsBlank(File file) throws IOException {
			  RandomAccessFile raf = null;
			  try {
			    raf = new RandomAccessFile(file, "r");
			    long len = raf.length();
			    if (len == 0L) {
			    	retCode = "000002";
 	 					retMsg = "文件存在，文件大小为0！";
			      return false;
			    } else {
			      long pos = len - 1;
			      raf.seek(pos);
		    	  if( raf.readByte() == '\n' ) {
				    	return true;
				  	}
			    }
			  } catch (FileNotFoundException e) {
			  		retCode = "000003";
 	 					retMsg = "文件处理异常4！";
			  } finally {
			    if (raf != null) {
			      try {
			        raf.close();
			      } catch (Exception e2) {
			      }
			    }
			  }
			  return false;
		}
	
		// 获得文件的行数,去掉空白行
		public int getLineNumber(String path) {
			int number = 0;
			File file = new File(path);
			long fileLength = file.length();
			LineNumberReader rf = null;
			try {
				rf = new LineNumberReader(new FileReader(file));
				if (rf != null) {
					rf.skip(fileLength);
					number = rf.getLineNumber();
					//行数不为1或者只有一行，并且此行不为空
					if(number != 0 || (number == 0 && fileLength != 0L)) {
						number++;
					}
					rf.close();
				}
				//如果存在空白行，去掉。规定最多只有一个空白行
				if(number >0 && lastLineIsBlank(new File(path))) {
					  number--;
				}
			} catch (IOException e) {
				if (rf != null) {
					try {
						retCode = "000003";
 	 					retMsg = "文件处理异常5！";
						rf.close();
					} catch (IOException ee) {
						retCode = "000003";
 	 					retMsg = "文件处理异常6！";
					}
				}
			}
			return number;
		}
	
	//设置html一行的数据
	public StringBuffer setTr(String[] beforeAndcurrLines) {
		System.out.println("---liujian---337---setTr begin ---");
		char beforeLineFirstChar = '0'; //默认为0
		boolean isFirstLine = true; 
		if(beforeAndcurrLines[1] != null) {
			beforeLineFirstChar = beforeAndcurrLines[1].charAt(0);
			isFirstLine = false;
		}
		StringBuffer sb = new StringBuffer();
		//切割行数据，获得每一个字段,-1是因为出现|||这种的情况，有竖线就切割，最后总数-1
		String[] fields = beforeAndcurrLines[0].split("\\|",-1);
		
		//第一个字段可能是：cust/g/body/head/title/span/foot
		//利用正则去掉数字,或者匹配字符
		switch(fields[0].charAt(0)) {
			case 'c' : {
				if(beforeLineFirstChar == '0') {
					sb.append("<table cellspacing=\"0\" style=\"background:;\">");
				}
				sb.append("<tr>");
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td>").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'g' : {
				if(!isFirstLine) {
					sb.append("</table>");
				}
				sb.append("<table class=\"g\" cellspacing=\"0\" style=\"background:;\">").append("<tr><td>").append(fields[1]).append("</td></tr>");
				break;
			}
			case 'h' : {
				if(beforeLineFirstChar == 'h') {
					sb.append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}else if(beforeLineFirstChar == 'g') {
					sb.append("</table>");
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}else if(beforeLineFirstChar == '0' && isFirstLine) { //第一行
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}
				break;
			}
			case 't' : {
				if(!isFirstLine) {
					sb.append("</table>");
				}
				sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td>").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'b' : {
				if(isFirstLine) {
					//添加标题
					String[] titleFields = currTitleLine.split("\\|",-1);
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<titleFields.length-1;i++) {
						sb.append("<td>").append(titleFields[i]).append("</td>");
					}
					sb.append("</tr>");
				}
				sb.append("<tr>");
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td>").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 's' : {
				if(isFirstLine) {
					sb.append("<table><tr>");
				}else {
					sb.append("<tr>");
				}
				int fieldSize = currTitleLine.split("\\|",-1).length-2;
				if(fieldSize < 0) {
					fieldSize = 1;
				}
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td  colspan=\"" + fieldSize + "\" class=\"detailtitle\">").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'f' : {
				if(isFirstLine) {
					sb.append("<table><tr class=\"detailfoot\">");
				}else {
					sb.append("<tr class=\"detailfoot\">");
				}
				int fieldSize = currTitleLine.split("\\|",-1).length-2;
				if(fieldSize < 0) {
					fieldSize = 1;
				}
				for(int i=1;i<fields.length-1;i++) {
					if(i == 2) {
						sb.append("<td colspan=\"" + fieldSize + "\" align=\"right\">").append(fields[i]).append("</td>");
					}else {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
				}
				sb.append("</tr>");
				break;
		    }
		}
		System.out.println("---liujian---337---setTr end ---" + sb.toString());
		return sb;
	}
	
	
	//解析文档
	public String parseDocument(String path,int pageNum,String lines_one_page){
		File file = new File(path);
		//一个模块一个模块的加入到页面中，先不考虑分页问题
		StringBuffer sb = new StringBuffer("");
		InputStreamReader isr = null;
		BufferedReader br = null;
		try{
		System.out.println("---liujian---file.exists = "+file.exists());
			isr = new InputStreamReader(new FileInputStream(file), "GBK");
			br = new BufferedReader(isr);
			//0:currLine；1：beforeLine
			String[] beforeAndcurrLines = new String[2];
			String s = null;
			int currNum = 0;
			while((s = br.readLine()) != null) {
				currNum++;
				if(s.startsWith("title")) {
					currTitleLine = s;
				}
				if(pageNum == -1 || (currNum > (pageNum-1) * Integer.valueOf(lines_one_page).intValue() && currNum <= pageNum * Integer.valueOf(lines_one_page).intValue())) {
					//填充数组
					if(beforeAndcurrLines[0] == null ) {
						beforeAndcurrLines[0] = s;
					}else {
						beforeAndcurrLines[1] = beforeAndcurrLines[0];
						beforeAndcurrLines[0] = s;
					}
					//设置行的html样式，包括设置table
					sb.append(setTr(beforeAndcurrLines).toString());
				}
			}
			sb.append("</table>");
		}catch(Exception e) {
			retCode = "000003";
 	 		retMsg = "文件处理异常3！";
		}finally {
			try{
				br.close();
				isr.close();
				System.out.println("关闭数据流");
			}catch(Exception e) {
				System.out.println("数据流为空");
			}
		}
		System.out.println("---liujian---retCode--" +   retCode);
		System.out.println("---liujian---retMsg--" +   retMsg);
		return sb.toString();
	}
%>