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

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!-- ningtn 2011-7-18 18:26:15 -->
<script type="text/javascript" src="/npage/public/printExcel.js"></script>	
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
<!-- yuanqs add 2010/8/31 2010/8/31 18:45:38 详单加水印_设置浏览器打印背景 begin -->
<script language="VBScript">
dim hkey_root,hkey_path,hkey_key,doPrint,RegWsh
hkey_root="HKEY_CURRENT_USER"
hkey_path="\Software\Microsoft\Internet Explorer"
doPrint="yes"

Set RegWsh =CreateObject("WScript.Shell")

//设置打印背景图片
//on error resume next
hkey_key=hkey_root+hkey_path+"\Main\Print_Background"
//MsgBox hkey_key
RegWsh.RegWrite hkey_key,doPrint
//关闭RegWsh
set RegWsh=nothing

</script>
<!-- yuanqs add 2010/8/31 2010/8/31 18:45:49 详单加水印_设置浏览器打印背景 end -->
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
	
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    opCode="1526";
    opName="未合并详单查询";
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

    static {
        //从公共配置文件中读取配置信息，此信息被多sever共享
        CGI_PATH = SystemUtils.getConfig("CGI_PATH");
        DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
        System.out.println("---liujian----AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CGI_PATH" + CGI_PATH);
        System.out.println("---liujian----BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DETAIL_PATH" + DETAIL_PATH);
        //如果不以"/"格式结束,加上"/"
        if (!CGI_PATH.endsWith("/")) {
            CGI_PATH = CGI_PATH + "/";
            DETAIL_PATH = DETAIL_PATH + "/";
        }
    }
%>
<%
    String workNo = (String)session.getAttribute("workNo");  //工号
    String workPassword = (String)session.getAttribute("password"); // 工号密码
    String phoneNo = request.getParameter("phoneNo");        //手机号码
    String broadPhone = request.getParameter("broadPhone");  //宽带账号
    String passWord = request.getParameter("passWord");        //查询密码
    String enPass = Encrypt.encrypt(passWord);				//加密后密码 yuanqs add 100820 密码改造需求
   
    String qryType = request.getParameter("qryType");        //详单类型
    String qryName = request.getParameter("qryName");        //详单类型
    String billBegin = request.getParameter("beginTime");    //开始时间
    String billEnd = request.getParameter("endTime");        //结束时间
    String charging_id = request.getParameter("charging_id");
    String resv = request.getParameter("resv");

    String searchType = request.getParameter("searchType");
		searchType="0";
    String ip = request.getRemoteAddr();//获取操作员IP地址 yuanqs add 2010/9/6 15:27:46 详单加水印需求
    String billTime = billBegin + "^" + billEnd + "^";     //时间串

    String predictionNO="0";                     //流失号
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //当前时间
    String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
    String custName = "";       //客户名词	
    String outFile = "";
System.out.println("  zhaorh ==> qryType:" + qryType+"qryName="+qryName+"billBegin="+billBegin+"billEnd="+billEnd+"charging_id="+charging_id);
		
		
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss SSS"); 
		String beginTime = null;
		String getFileTime = null;
    //是否有二次密码
    boolean haveTwoPassWord = false;
    //用户输入的二次密码是否与返回值相同
    boolean isTwoPassWordTrue = false;

    String twoPassWord = "";

		/* liujian 2012-3-28 19:04:43 变量 begin */
		int pageCount = 0;
		String firstPageBody = "";
		int lines_one_page = 2000;
		long fileSize = 0L;
		int secNum = 0;
		int maxSec = 30;
		String fileStatus = "111111";
		String fileMsg = "文件没有生成";
		/* liujian 2012-3-28 19:04:43 变量 end */


		
				
        try {
            /* ningtn 铁通宽带 */
        		String kshString = "";
        		String paramterString = "";
        		String exePath = "";
        		System.out.println("~~~~~~~~~~~~~~~~~~ " + opCode);
        		if("e155".equals(opCode)){
	            /* 宽带详单 */
	            kshString = CGI_PATH + "linkprint.sh" + " ";
	            paramterString = "0" + " " + "01" + " " + opCode + " " +
	            								workNo + " " + workPassword + " " + phoneNo + " " +
	            								passWord + " " + broadPhone + " " + passWord + " " +
	            								qryType  + " " + searchType + " " + billTime + " " +
	            								dateStr  + " " + "26 ";
	            outFile = phoneNo + qryType + dateStr1 + ".txt";
	            exePath = "/usr/bin/ksh " + kshString + paramterString + DETAIL_PATH + outFile + " " + "1" + " "+passWord;
           		System.out.println("--liujian--exePath=" + exePath);
            }else{
            	/* 普通电话详单 */
         
	            //程序路径,参数，文件名
	           // kshString = CGI_PATH + "cp.sh" + " ";
	            paramterString = workNo + " " + phoneNo + " " + qryType + " " + searchType + " " + billTime + " " + predictionNO + " "+ charging_id + " " + resv + " " ;
	            outFile = phoneNo + qryType + dateStr1 + ".txt";
	            exePath = "/usr/bin/ksh " + CGI_PATH + "cp_detail.sh " + paramterString + DETAIL_PATH + outFile ;
            }
            System.out.println("###################fGetQryZ.jsp->kshString->"+kshString+"&paramterString->"+paramterString+"&outFile->"+outFile);
            System.out.println("######################exePath" + exePath);
            
            Runtime.getRuntime().exec(exePath);

        } catch (Exception ioe) {
            ioe.printStackTrace();
%>
			<script language="javascript">
				rdShowMessageDialog("执行shell命令未能成功,原因:<%=ioe.getMessage()%>");
				history.go(-1);
			</script>
<%					
        }
        //得到输出文件 
        String DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
   			String order_path = DETAIL_PATH + outFile;
   //		String order_path = "/iwebd2/detail/file/13703633753020120328155326.txt";
   // 	outFile = "13703633753020120328155326.txt";
   			int icount = 0;
    		String tline = null;
   			File temp = null;
        temp = new File(order_path);
        System.out.println("----liujian---temp=" + temp.getAbsolutePath());
        
        beginTime = s.format(new Date(System.currentTimeMillis()));
				
		    int c = 0;
				while(true) {
					//如果文件不存在，等待10秒钟
					if(!temp.exists()) {
						if(secNum >= 30) {
							System.out.println("--liujian--fileNoCreate--" + temp.exists());
							break;
						}else {
							secNum++;
							Thread.sleep(1000);
						}
					}else {
						if(fileSize == temp.length()) {
							 fileStatus = "000000";
						   fileMsg = "文件生成完成";
						   
						    int lineNum = 0;
				        tline = null;
				        int beginLine = 0;
				        int pageSize = 30;
				
				        FileReader outFrT1 = new FileReader(temp);
				        BufferedReader outBrT1 = new BufferedReader(outFrT1);
				        tline = outBrT1.readLine();
						    String tlinetep = "";
								if((tline.trim().equals(""))&&(lineNum == 0))
								{
									  System.out.println("空的话单");
									  outBrT1.close();
					   				outFrT1.close();
					   				
					   				out.print("<script language=\"javascript\">") ;
					   				out.print("rdShowMessageDialog(\""); 
					   				out.print("用户话单为空！");
					   				out.println("\");");
					   				out.println("history.back(); ");	   				
					   				out.println("</script>");      
					   				return;      
					   				
								}
								else if((tline.indexOf("cust")==-1)&&(lineNum==0))
								{
										System.out.println("不符合正确话单格式，说明服务里面报错了！");	
										outBrT1.close();
					   				outFrT1.close();
					   				
					   				out.print("<script language=\"javascript\">") ;
					   				out.print("rdShowMessageDialog(\""); 
					   				out.print(tline);
					   				out.println("\");");
					   				out.println("history.back(); ");	   				
					   				out.println("</script>");                 	
				            return;
								}	else {
										pageCount = getPageCount(order_path,lines_one_page);
								    firstPageBody = parseDocument(order_path,1,lines_one_page);
								    System.out.println("--liujian--ok--");
								}			
				        outBrT1.close();
				        outFrT1.close();
							break;
						}else if(secNum < maxSec) {
							secNum++;
							fileSize = temp.length();
							Thread.sleep(1000);
						}else {
							fileStatus = "000001";
						  fileMsg = "文件生成时间超过" + maxSec +"秒";
						  System.out.println("--liujian--overTime--");
							break;
						}
					}
					System.out.println("----liujian----" + c++ );
				
    }
      getFileTime = s.format(new Date(System.currentTimeMillis()));
     //yuanqs add 2010/9/6 15:28:25 详单加水印需求
	    String str = ip + "    " + workNo;
	    String imageName = ip+workNo+".jpg";
	    String imagePath = application.getRealPath("/") + "/npage/query/img/" + imageName;
	    System.out.println(imagePath + "===============imagePath");
	    int width = 600;
			int height = 250;
			float alpha = 0.5f;
	    CreateImg.drawImage(str, imagePath, width, height, alpha);
%>

<html>
<head>
    <title> 详单查询-<%=qryName%></title>
    <link href="../query/detail.css" rel="stylesheet" type="text/css"></link>
    <SCRIPT LANGUAGE="JavaScript">

        
			/*调用详单明细*/
			function go_detail(phone_no,charging_id,resv,start_datetime,end_datetime)
			{
				var h=480;
				var w=650;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
		 		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		 		
		 
				alert(phone_no+"|"+charging_id+"|"+resv+"|"+start_datetime+"|"+end_datetime);	
				var returnValue=window.showModalDialog("fDetQryXDetail.jsp?phoneNo="+phone_no+"&qryType=95"+"&qryName=未合并详单"+"&billBegin="+start_datetime+"&billEnd="+end_datetime);
				
				if(returnValue==null)
	     	{
             rdShowMessageDialog("报错了！！！");
             //window.location.href="s1300.jsp";
		  	}
			}



    </SCRIPT>
   
    <script language="javascript">
    	 /*  liujian  2012-3-14 9:06:36  添加详单js方法 begin */
				var currPage = 1;
				$(function() {
					  
						/****************************注册一系列事件*****************************************/
					  // 首页传递first，下一页传递next，上一页传递prev，尾页传递last

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
				//	myInterval = setInterval("judgeFileComp()", 1000);
					if('<%=fileStatus%>' == '000000') {
							init();
					}else {
							hideLightBox();
							rdShowMessageDialog("错误代码：<%=fileStatus%>，错误信息：<%=fileMsg%>",0);
							history.go(-1);
					}
					
				});
				//初始化
				function init() {

						$('#detailContainer').append('<%=firstPageBody%>');
						setToPageAttr();
						hideLightBox();	
				}
				
				//设置颜色和click事件
				function setToPageAttr() {

				}
				
				function setSelPage(pageCount) {

				}
				
				/*  liujian  2012-3-14 9:06:36  添加详单js方法 end */
		</script>
		
</head>

<!-- liujian 2012-3-14 9:08:55 详单DOM结构 begin-->
<body onload="" >
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">中国移动通信客户<%=qryName%>详单</div>
	</div>
	<div style="background-image:url(/npage/query/img/<%=imageName%>)" id="detailContainer">

	</div>
	
	<table cellspacing="0">

  	<table cellspacing="0">
      <tr> 
          <td id="footer"> 
              <input name="prtBtn" id="prtBtn" class="b_foot"  type="button"  index="2" value="打 印" />
              &nbsp;
              <input name="submitBtn" id="submitBtn" class="b_foot"  type="button"  index="2" value="导 出" />
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
	   String detailCode = "111111";
 	   String detailMsg = "文件不存在！";
	 	 int pageCount = 0;
	 	 int secNum = 0;

	 	 
		 //判断文件是否存在
		 public boolean exsitFile(String path) {
				File file = new File(path);
				if (!file.exists() || file.isDirectory() || !file.canRead()) {
	//					System.out.println("---liujian---path=" + path);
						detailCode = "000001";
 	 					detailMsg = "文件不存在！";
				    return false;
				}else {
					return true;
				}
			}

			//判断是否末尾是空白行
			public boolean lastLineIsBlank(File file) throws IOException {
			  RandomAccessFile raf = null;
			 	long len = 0;
	 		 	long pos = 0;
			  try {
			    raf = new RandomAccessFile(file, "r");
			    len = raf.length();
			    if (len == 0) {
			    	detailCode = "000002";
 	 					detailMsg = "文件存在，文件大小为0！";
			      return false;
			    } else {
			      pos = len - 1;
			      raf.seek(pos);
		    	  if( raf.readByte() == '\n' ) {
				    	return true;
				  	}
			    }
			  } catch (FileNotFoundException e) {
			  		detailCode = "000003";
 	 					detailMsg = "文件处理异常4！";
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
//					System.out.println("------------liujian-----------number = " + number);
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
						detailCode = "000003";
 	 					detailMsg = "文件处理异常5！";
						rf.close();
					} catch (IOException ee) {
						detailCode = "000003";
 	 					detailMsg = "文件处理异常6！";
					}
				}
			}
			return number;
		}
	
	//设置html一行的数据
	public StringBuffer setTr(String[] beforeAndcurrLines) {
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
					if( fields[i].length() >0 && fields[i].substring(0,1).equals("@") )
					{
						String[] sArrDetailParas = fields[i].split("\\,",-1);

						String   sTmpHTML="";
						sTmpHTML+="<td><span onClick=go_detail(";
						sTmpHTML+="\""+sArrDetailParas[0].substring(1,sArrDetailParas[0].length())+"\""+"," ;
						sTmpHTML+="\""+sArrDetailParas[1]+"\""+"," ;
						sTmpHTML+="\""+sArrDetailParas[2]+"\""+"," ;
						sTmpHTML+="\""+sArrDetailParas[3]+"\""+"," ;
						sTmpHTML+="\""+sArrDetailParas[4]+"\"" ;
						sTmpHTML+=")> 明细 </span> </td>";
						sb.append(sTmpHTML);
					}
					else
					{
						sb.append("<td>").append(fields[i]).append("</td>");
					}
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
		return sb;
	}
	public static final int LINES_ONE_PAGE = 2000;
	String currTitleLine = "";
	//解析文档
	public String parseDocument(String path,int pageNum,int lines_one_page){
//		System.out.println("-------liujian-------------parseDocument begin");
		File file = new File(path);
		//一个模块一个模块的加入到页面中，先不考虑分页问题
		StringBuffer sb = new StringBuffer("");
		InputStreamReader isr = null;
		BufferedReader br = null;
		try{
			isr = new InputStreamReader(new FileInputStream(file), "GB2312");
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
				if(pageNum == -1 || (currNum > (pageNum-1) * lines_one_page && currNum <= pageNum * lines_one_page)) {
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
			detailCode = "000003";
 	 		detailMsg = "文件处理异常3！";
		}finally {
			try{
				br.close();
				isr.close();
				System.out.println("关闭数据流");
			}catch(Exception e) {
				System.out.println("数据流为空");
			}
		}
//		System.out.println("-------liujian-------------parseDocument end");
		return sb.toString();
	}

	public int getPageCount(String path,int lines_one_page) throws IOException {
		return (getLineNumber(path)-1) / lines_one_page + 1;
	}
%>