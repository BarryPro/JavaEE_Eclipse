<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*1270,1219,2266��ģ����ʹ�õ�ҳ��.
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
						System.out.println("���ع������Ϊ��"+upftpfile);
						if(upftpfile){
							errCode = "000000";
							errMsg = "�����ɹ���";
						}else{
							errCode = "000001";
							errMsg = "ftp����ʧ�ܣ�";
						}
					}else{
						errCode = "000002";
						errMsg = "ftp�û����������";												
					}
				}else{
					errCode = "000003";
					errMsg = "ftp��������ʧ�ܣ�";												
				}
		}else if(retType.equals("delete")){
				File filePic =new File(request.getRealPath("npage/crm_order")+"/"+loginAccept+"_"+workNo+".pdf");
				boolean delflag  = filePic.delete();
				System.out.println("ɾ����ʱ�������Ϊ��"+delflag);
				if(delflag){
					errCode = "000000";
					errMsg = "�����ɹ���";
				}else{
					errCode = "000004";
					errMsg = "httpɾ����ʱ����ʧ�ܣ�";
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
