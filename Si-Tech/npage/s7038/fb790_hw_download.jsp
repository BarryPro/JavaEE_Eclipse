<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*1270,1219,2266等模块中使用的页面.
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>

<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.uploadftp.*"%>
<%@ page import="java.io.File"%>

<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode = (String)session.getAttribute("regCode");
		
		String retType = request.getParameter("retType");
		System.out.println("---------- ftp download retType ----------------"+retType);		
		String loginAccept = request.getParameter("loginAccept");
		System.out.println("---------- ftp download loginAccept ----------------"+loginAccept);		
		String printDate = request.getParameter("printDate");
		System.out.println("---------- ftp download printDate ----------------"+printDate);		
		String ftpPwd = request.getParameter("ftpPwd");
		System.out.println("---------- ftp download ftpPwd ----------------"+ftpPwd);		
	    
    String errCode="";
    String errMsg="";	    

		if(retType.equals("download")){
				FtpTools ftpT=new FtpTools();
				/*** ttest ***/
				String serverIP = "10.110.2.222";
				/*String serverIP = "10.110.0.206";*/
				if(ftpT.connect(serverIP)){
					/*** ttest ***/
					if(ftpT.login_S("prtord",ftpPwd)){
					/**if(ftpT.login_S("webapp",ftpPwd)){**/
						String filePathR = "./order_"+regionCode+"/"+printDate+"/"+loginAccept+".pdf" ;
						String filePathL = request.getRealPath("npage/crm_order")+"/"+loginAccept+"_"+workNo+".pdf";
						System.out.println("----------filePathR---------"+filePathR);
						System.out.println("----------filePathL---------"+filePathL);		
						boolean upftpfile = ftpT.downloadFile(filePathR,filePathL);		
						System.out.println("下载工单结果为："+upftpfile);
						if(upftpfile){
							errCode = "000000";
							errMsg = "操作成功！";
						}else{
							errCode = "000001";
							errMsg = "ftp下载失败！";
						}
					}else{
						errCode = "000002";
						errMsg = "ftp用户名密码错误！";												
					}
				}else{
					errCode = "000003";
					errMsg = "ftp连接主机失败！";												
				}
		}else if(retType.equals("delete")){
				File filePic =new File(request.getRealPath("npage/crm_order")+"/"+loginAccept+"_"+workNo+".pdf");
				boolean delflag  = filePic.delete();
				System.out.println("删除临时工单结果为："+delflag);
				if(delflag){
					errCode = "000000";
					errMsg = "操作成功！";
				}else{
					errCode = "000004";
					errMsg = "http删除临时工单失败！";
				}
		}
%>

var response = new AJAXPacket();

var errCode = ""
var errMsg = "";

errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";

response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);

core.ajax.receivePacket(response);
