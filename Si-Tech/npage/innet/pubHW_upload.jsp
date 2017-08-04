<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.uploadftp.*"%>
<%@ page import="java.io.File"%>
<%@ include file="getPrintOrderFtpPas.jsp" %><!-- 得到密码 -->

<%
String workNo = (String)session.getAttribute("workNo");
String regionCode= (String)session.getAttribute("regCode");
String dateStr = new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());	
String upMsg = "";

/************** 工单由本地上传至weblogic服务器 start *************/
SmartUpload su = new SmartUpload();
su.initialize(pageContext);

String loginAccept = request.getParameter("loginAccept");
System.out.println("----------- uppage loginAccept ------------"+loginAccept);

try {
    su.upload();
    String savapic =  request.getRealPath("npage/crm_order/")+"/";
    int upCount = su.save(savapic);
    System.out.println("=============suflag======="+su.save(savapic));
    if(upCount==0){
			upMsg += "httpUpLoadFail";
    }
}catch(Exception e){
		out.clear();
		out.print("httpException");//返回控件HttpPost()方法值。
		out.flush();
}
/************** 工单由本地上传至weblogic服务器 end *************/


/************** 工单由weblogic服务器ftp至文件系统服务器 start *************/
String orderPasPropPath = request.getRealPath("npage/innet/configFtpPrintOrderPas.properties");
System.out.println("------------------orderPasPropPath----------"+orderPasPropPath);
String ftpPwd = getPas(orderPasPropPath);
System.out.println("------------------getPas()----------"+ftpPwd);

FtpTools ftpT=new FtpTools();
/*** ttest ***/
String serverIP = "10.110.2.222";
/**String serverIP = "10.110.0.206";**/
try{
	if(ftpT.connect(serverIP)){
		/*** ttest ***/
		if(ftpT.login_S("prtord",ftpPwd)){
		/**if(ftpT.login_S("webapp",ftpPwd)){**/
			String filePathR = "./order_"+ regionCode +"/"+ dateStr +"/"+ loginAccept +".pdf" ;			
			String filePathL = request.getRealPath("npage/crm_order")+"/"+loginAccept+"_"+workNo+".pdf";
			
			System.out.println("----------filePathR---------"+filePathR);
			System.out.println("----------filePathL---------"+filePathL);
			boolean upftpfile = ftpT.uploadFile(filePathR,filePathL);		
			System.out.println("上传图片结果为："+upftpfile);
			if(!upftpfile){
				upMsg += "ftpUpLoadFail";
			}
		}else{
			upMsg += "ftpUserOrPassWrong"+ftpPwd;
		}
	}else{
		upMsg += "ftpConnectFilesSystemFail";
	}
}catch(Exception e){
	out.clear();
	out.print("ftpException");//返回控件HttpPost()方法值。
	out.flush();
}
/************** 工单由weblogic服务器ftp至文件系统服务器 end *************/

/*删除 npage/cust_order/ 下的临时文件*/
File filePic =new File(request.getRealPath("npage/crm_order")+"/"+loginAccept+"_"+workNo+".pdf");
boolean delflag  = filePic.delete();
System.out.println("删除临时工单结果为："+delflag);
if(!delflag){
	upMsg += "httpDeleteTempFilesFail";
}


if(!upMsg.equals("")){
		out.clear();
		out.print(upMsg);//返回控件HttpPost()方法值。
		out.flush();
}
%>
