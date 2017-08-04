<%
  /* 
   * 功能: 上传文件
   * 版本: 1.0
   * 日期: 2014/1/14 9:45
   * 作者: wanghyd
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="import sun.misc.BASE64Encoder"%>

<%!
	public static String GetImageStr(String imgFilePath) {// 将图片文件转化为字节数组字符串，并对其进行Base64编码处理
		byte[] data = null;

		// 读取图片字节数组
		try {
			InputStream in = new FileInputStream(imgFilePath);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 对字节数组Base64编码
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);// 返回Base64编码过的字节数组字符串

	}

%>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	String opcode = WtcUtil.repNull((String)request.getParameter("op_code"));
	String name = WtcUtil.repNull((String)request.getParameter("name")).trim();
	String code = WtcUtil.repNull((String)request.getParameter("code")).trim();
	String IDaddress = WtcUtil.repNull((String)request.getParameter("IDaddress")).trim();
	String bir_day = WtcUtil.repNull((String)request.getParameter("bir_day")).trim();
	String sex = WtcUtil.repNull((String)request.getParameter("sex")).trim();
	String idValidDate_obj = WtcUtil.repNull((String)request.getParameter("idValidDate_obj")).trim();
	/*String[] insRoleArr=idValidDate_obj.trim().split("-");*/
	String v_custId = WtcUtil.repNull((String)request.getParameter("v_custId"));

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>	
<%
			/* 拼接文件名 */
				String iErrorNo ="";
				String sErrorMessage = " ";
				String sysAccept = "";
				sysAccept = seq;				
				String svnameandpath="";
				String savapic="";
		    
		SmartUpload su = new SmartUpload();
    su.initialize(pageContext);
    su.setMaxFileSize(10000000);
    su.setTotalMaxFileSize(20000000);
    su.setAllowedFilesList("doc,txt,jpg,rar,mid,waw,mp3,gif");
    boolean sign = true;
    try {
        su.setDeniedFilesList("exe,bat,jsp,htm,html");
        su.upload();
        savapic =  request.getRealPath("npage/tmp/")+"/";
        System.out.println("--------------savapic----------------"+savapic);
        su.save(savapic);
        System.out.println("--------------su.save(savapic)----------------");   
				System.out.println("==============文件上传完成==========");
				}
				/* 读取文件，写入tuxedo侧服务器 */
				catch(Exception e)
			{
			e.printStackTrace();
			}
			
			try{ 
					com.jspsmart.upload.File myFile = su.getFiles().getFile(0);
					if (myFile.isMissing()){

					}else{
						svnameandpath = myFile.getFileName();
					}
				}catch (Exception e){
					System.out.println(e.toString()); 
				}
			
		// 测试从图片文件转换为Base64编码
		System.out.println("-----路径名------"+savapic+""+svnameandpath);
		String sbasestrs = GetImageStr(savapic+""+svnameandpath);
		System.out.println(sbasestrs);
		
			   File filess=null;
  		   try{ 		    
  		    filess = new File(savapic+""+svnameandpath);
  		    filess.delete();
  		   System.out.println("==============文件删除完成==========");
				 }catch(Exception e){

				 }
				 
	String  inputParsm [] = new String[16];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = opcode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";

	inputParsm[7] = code;
	inputParsm[8] = "2代";
	inputParsm[9] = name;
	inputParsm[10] = IDaddress;
	inputParsm[11] = sex;
	inputParsm[12] = bir_day;
	inputParsm[13] = idValidDate_obj;
	inputParsm[14] = sbasestrs;
	inputParsm[15] = v_custId;
	/*
	inputParsm[8] = "231026198110202388";
	inputParsm[9] = "哈尔滨市南岗区学府路52号";
	inputParsm[10] = "孙爱娟";
	inputParsm[11] = "2007.05.24-2017.05.24";
	*/
	%>
		<wtc:service name="sM032Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>
			<wtc:param value="<%=inputParsm[10]%>"/>
			<wtc:param value="<%=inputParsm[11]%>"/>	
			<wtc:param value="<%=inputParsm[12]%>"/>	
			<wtc:param value="<%=inputParsm[13]%>"/>
			<wtc:param value="<%=inputParsm[14]%>"/>
			<wtc:param value="<%=inputParsm[15]%>"/>		
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	
	if("000000".equals(retCode)){
		%>
		<script language="javascript">
			rdShowMessageDialog("上传成功！",2);
		</script>
		<%
	}else {
				%>
		<script language="javascript">
			rdShowMessageDialog("上传失败，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
		</script>
		<%
		}
%>
<script type="text/javascript">
	window.close();
</script>	


