<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.*,javax.servlet.http.HttpServletResponse"%>
<%@ page import="com.enterprisedt.net.ftp.*,import java.net.*"%>
<%
  /*midify by yinzx 20091113 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
 
 String remoteFileSerialNo = request.getParameter("remoteFileSerialNo");
 String chfolder = request.getParameter("chfolder");
 String remoteFile=request.getParameter("remoteFile");
 System.out.println("remotFile"+remoteFile);
 String remotedir=remoteFile.substring(0,remoteFile.indexOf(":")+1);
 System.out.println("remotedir:"+remotedir);
 //remoteFile="F:\\1\\0\\20081018\\106\\1023340.V3";
// System.out.println("remoteFileSerialNo:"+remoteFileSerialNo);
// System.out.println("chfolder:"+chfolder);
 String[][] queryList=new String[][]{};
 String sql="select t.ftp_ip,t.ftp_port,t.ftp_user,t.ftp_passwd from dcallftpservercfg t where t.ftp_dir=:remotedir";
 myParams = "remotedir="+remotedir ;

    String login_no = (String)session.getAttribute("workNo");  //工号		
    String contact_id = WtcUtil.repNull(request.getParameter("contact_id")); //接触ID
   // String kf_login_no = "ss";//window.opener.top.cCcommonTool.getWorkNo();//客服工号
    String kf_login_no = WtcUtil.repNull(request.getParameter("kf_login_no"));
    String localIp = WtcUtil.repNull(request.getParameter("localIp"));
    String fileId = WtcUtil.repNull(request.getParameter("fileId"));    
    System.out.println("========= kf_login_no="+kf_login_no);
%>

  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>

<%

if(rows.length==0){
out.write("文件路径不匹配，请联系管理员！");
return;
}
// System.out.println("queryList[][]=====>"+rows[0][0]);
 String ip=rows[0][0];
 String port=rows[0][1];
 String user=rows[0][2];
 String passwd=rows[0][3];
 String[] a_remote=remoteFile.split("\\\\");
 String remoteFileName=a_remote[a_remote.length-1];//contact_id+"_"+fileId+".V3";
 String localFileName=contact_id+"_"+fileId+".V3";
 try{
   //FTP("10.204.16.47","zwy","123",remoteFile, chfolder,response);
   System.out.println("ip:"+ip);
   System.out.println("remoteFile:"+remoteFile);
   System.out.println("remoteFileName:"+remoteFileName);
   System.out.println("chfolder:"+chfolder);
   FTP(ip,user,passwd,remoteFile,remoteFileName,chfolder,response,localFileName);
   //记录转存日志。
   
  System.out.println("=========  插入日志 操作 2222 ===========");
   
 }catch(Exception e){
 //System.out.println("printStackTrace");
 //System.out.println(e);
   e.printStackTrace();
   retCode="000001";
 }
 remoteFile=remoteFile.replace('\\', '/');
 String filename = remoteFile.substring(remoteFile.lastIndexOf("/")+1);

%>





<%!public void FTP(String IP,String userName,String password,String remoteFilePath,String remoteFileName,String localDir,HttpServletResponse response,String localFileName)throws Exception{
    FTPClient ftp = null;
		   ftp = new FTPClient(IP);
		   System.out.println("remoteFilePath"+remoteFilePath);
		   remoteFilePath=remoteFilePath.replace('\\', '/');
		   System.out.println(remoteFilePath);
		  String remoteFile=remoteFilePath.substring(remoteFilePath.lastIndexOf("/")+1);
		   //String remoteFile=contact_id+".V3";
                  //modified by liujied 2 --> 6
                  //modified by liujied 6 backto 2 (20091015)
		   String remoteDir=remoteFilePath.substring(remoteFilePath.indexOf(":")+2,remoteFilePath.lastIndexOf("/")+1);
		   //String reFileName=remoteFilePath.substring(remoteFilePath.lastIndexOf("/")+1,remoteFilePath.length());
		   response.setContentType("application/x-download");//设置为下载application/x-download        
		   response.setHeader("Content-Disposition", "attachment; filename=" +localFileName+ ";"); 
		   OutputStream outputStream = response.getOutputStream();
		   ftp.login(userName, password);
		   ftp.setConnectMode(FTPConnectMode.PASV);
		   //ftp.setType(FTPTransferType.ASCII);
		   ftp.setType(FTPTransferType.BINARY);
                   System.out.println("remoteDir:"+remoteDir);
		   ftp.chdir(remoteDir);
             System.out.println("remoteFileName"+remoteFileName);
             System.out.println("remoteDir:"+remoteDir);
             ftp.get(outputStream,remoteFileName);
            //ftp.get(remoteFileName,reFileName); 
	   //ftp.get(localDir+remoteFile,remoteFileName);
		   outputStream.close();
		   ftp.quit();
	   
  System.out.println("=======  退出download 1 页面   ftp  方法  =========");
   }

%>


<% 
    String filepath = remoteFileName; //文件名
    String sql_log= "insert into dconveyrecordfile (SERIAL_NO,CONTACT_ID,KF_LOGIN_NO,LOGIN_NO,FILEPATH,LISTENTIME,bak2)"+
		"select lpad(SEQ_CONVEYFILE.nextval,14,'0'),:v1,:v2,:v3,:v4,sysdate,:v5 from dual";
System.out.println( contact_id + "========yuanqs");
System.out.println( kf_login_no + "========yuanqs");
System.out.println( login_no + "========yuanqs");
System.out.println( filepath + "========yuanqs");
System.out.println( localIp + "========yuanqs");

%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql_log%>"/>
		<wtc:param value="dbchange"/>
		<wtc:param value="<%=contact_id%>"/>
		<wtc:param value="<%=kf_login_no%>"/>
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=filepath%>"/>
		<wtc:param value="<%=localIp%>"/>
</wtc:service>
