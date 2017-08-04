<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/05/03 liangyl 关于全面恢复省际跨区补卡服务的通知
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat"%><!--二代证-->
<%@ page import="com.jspsmart.upload.*"%><!--二代证-->
<%@ page import="import java.sql.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.io.File"%><!--二代证-->
<%@ page import="com.uploadftp.*"%><!--二代证-->
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="import sun.misc.BASE64Encoder"%>
<%@ page import="java.awt.Image"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="com.sun.image.codec.jpeg.JPEGCodec"%>
<%@ page import="com.sun.image.codec.jpeg.JPEGImageEncoder"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ include file="/npage/sq100/getIccidFtpPas.jsp" %> 
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
public static void reduceImg(String imgsrc, String imgdist, int widthdist,  
		int heightdist, float rate) {  
	try {  
		File srcfile = new File(imgsrc);  
		// 检查文件是否存在  
		if (!srcfile.exists()) {  
			return;  
		}  
		System.out.println(rate);
		// 如果rate不为空说明是按比例压缩  
		if (rate > 0) {  
			// 获取文件高度和宽度  
			int[] results = getImgWidth(srcfile);  
			if (results == null || results[0] == 0 || results[1] == 0) {  
				return;  
			} else {  
				widthdist = (int) (results[0] * rate);  
				heightdist = (int) (results[1] * rate);  
			}  
		}  
		// 开始读取文件并进行压缩  
		Image src = javax.imageio.ImageIO.read(srcfile);  
		BufferedImage tag = new BufferedImage((int) widthdist,  
				(int) heightdist, BufferedImage.TYPE_INT_RGB);  

		tag.getGraphics().drawImage(  
				src.getScaledInstance(widthdist, heightdist,  
						Image.SCALE_SMOOTH), 0, 0, null);  

		FileOutputStream out = new FileOutputStream(imgdist);  
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);  
		encoder.encode(tag);  
		out.close();  

	} catch (IOException ex) {  
		ex.printStackTrace();  
	}  
}

/**
 * 获取图片宽度
 * 
 * @param file
 *            图片文件
 * @return 宽度
 */
public static int[] getImgWidth(File file) {
	InputStream is = null;
	BufferedImage src = null;
	int result[] = { 0, 0 };
	try {
		is = new FileInputStream(file);
		src = javax.imageio.ImageIO.read(is);
		result[0] = src.getWidth(null); // 得到源图宽
		result[1] = src.getHeight(null); // 得到源图高
		is.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	return result;
}

%>

<%
	String workno = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String sSaveName_db_T = "";
	String sSaveName_db_C = "";
	String sSaveName_db_Z = "";
	String sSaveName_db_F = "";
	
	String phoneNo = request.getParameter("phoneNo");//手机号码
	String labelName = WtcUtil.repStr(request.getParameter("labelName"),"");
	String isCheckIdCard =WtcUtil.repStr(request.getParameter("isCheckIdCard"),"0");//是否校验身份证
	System.out.println("----------isCheckIdCard---------"+isCheckIdCard);
	
	String filePath_Z = request.getParameter("filep_Z");//图片路径
	System.out.println("----------filePath_Z---------"+filePath_Z);
	String filePath_F = request.getParameter("filep_F");//图片路径
	System.out.println("----------filePath_F---------"+filePath_F);
	String filePath_T = request.getParameter("filep_T");//图片路径
	System.out.println("----------filePath_T---------"+filePath_T);
	
	String filePath_C = "";
	if("1".equals(isCheckIdCard)){
		filePath_C = request.getParameter("filep_C");//图片路径
	}
	
	System.out.println("----------filePath_C---------"+filePath_C);

	String opCode = request.getParameter("opCode");//"g412";
	
	String regionCode = request.getParameter("regionCode");
	System.out.println("----------regionCode---------"+regionCode);
	String idIccid = request.getParameter("idIccid");
	System.out.println("----------idIccid---------"+idIccid);
	String up_fa = "1";
	String idType = request.getParameter("idType");
	
	
	String checkPage =WtcUtil.repStr(request.getParameter("checkPage"),"0");//判断提示页面是哪个
	System.out.println("----------checkPage---------"+checkPage);
	
	%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	<%
	
	System.out.println("liangyl----idType=="+idType);
	String iServerIpAddr = realip.trim();
	System.out.println("---liangyl-------iServerIpAddr---------"+iServerIpAddr);
	
	/*********************************上传图片到服务器*************************************/
	if((filePath_Z!=null||!filePath_Z.equals(""))&&(filePath_F!=null||!filePath_F.equals(""))&&(filePath_T!=null||!filePath_T.equals(""))) {
	System.out.println("-----------------------------if---------------------");
	SmartUpload mySmartUpload = new SmartUpload();
	String t_fileName_Z = filePath_Z ;
	String t_fileName_F = filePath_F ;
	String t_fileName_T = filePath_T ;
	String t_fileName_C = "";
	if("1".equals(isCheckIdCard)){
		t_fileName_C = filePath_C ;
	}
	else{
		t_fileName_C="";
	}
	String filename_Z = filePath_Z.substring(filePath_Z.lastIndexOf("\\")+1,filePath_Z.length());
	String filename_F = filePath_F.substring(filePath_F.lastIndexOf("\\")+1,filePath_F.length());
	String filename_T = filePath_T.substring(filePath_T.lastIndexOf("\\")+1,filePath_T.length());
	String filename_C = "";
	if("1".equals(isCheckIdCard)){
		filename_C = filePath_C.substring(filePath_C.lastIndexOf("\\")+1,filePath_C.length());
	}
	else{
		filename_C = "";
	}
	File file_cre = new File(request.getRealPath("npage/tmp"));
	if(!file_cre.exists()){
	file_cre.mkdirs();
	}
	String sSaveName_Z=request.getRealPath("npage/tmp/")+"/"+filename_Z;
	String sSaveName_F=request.getRealPath("npage/tmp/")+"/"+filename_F;
	String sSaveName_T=request.getRealPath("npage/tmp/")+"/"+filename_T;
	String sSaveName_C="";
	
	if("1".equals(isCheckIdCard)){
		sSaveName_C=request.getRealPath("npage/tmp/")+"/"+filename_C;
	}
	else{
		sSaveName_C="";
	}
	
	sSaveName_db_Z = sSaveName_Z;
	sSaveName_db_F = sSaveName_F;
	sSaveName_db_T = sSaveName_T;
	
	if("1".equals(isCheckIdCard)){
		sSaveName_db_C = sSaveName_C;
	}
	else{
		sSaveName_db_C = "";
	}
	
	String srvIP=request.getServerName();
	String iErrorNo ="";
	String sErrorMessage = "";

   	SmartUpload su = new SmartUpload();
    su.initialize(pageContext);
    su.setMaxFileSize(10000000);
    su.setTotalMaxFileSize(20000000);
    su.setAllowedFilesList("doc,txt,jpg,rar,mid,waw,mp3,gif");
    boolean sign = true;
    try {
        su.setDeniedFilesList("exe,bat,jsp,htm,html");
        su.upload();
        String savapic =  request.getRealPath("npage/tmp/")+"/";
        System.out.println("--------------savapic----------------"+savapic);
        su.save(savapic);
        System.out.println("--------------su.save(savapic)----------------");
        
        File imgfile_Z = new File(sSaveName_Z);
		System.out.println("---liangyl-----------file.length()----------------"+imgfile_Z.length()/100000);
		if(imgfile_Z.length()>100000){
			float abc =(float) ((float)1/(float)(imgfile_Z.length()/100000));
			reduceImg(sSaveName_Z,sSaveName_Z, 0, 0,abc);
		}
		
		File imgfile_F = new File(sSaveName_F);
		System.out.println("---liangyl-----------file.length()----------------"+imgfile_F.length()/100000);
		if(imgfile_F.length()>100000){
			float abc =(float) ((float)1/(float)(imgfile_F.length()/100000));
			reduceImg(sSaveName_F,sSaveName_F, 0, 0,abc);
		}
		
		File imgfile_T = new File(sSaveName_T);
		System.out.println("---liangyl-----------file.length()----------------"+imgfile_T.length()/100000);
		if(imgfile_T.length()>100000){
			float abc =(float) ((float)1/(float)(imgfile_T.length()/100000));
			reduceImg(sSaveName_T,sSaveName_T, 0, 0,abc);
		}
		if("1".equals(isCheckIdCard)){
			File imgfile_C = new File(sSaveName_C);
			System.out.println("---liangyl-----------file.length()----------------"+imgfile_C.length()/100000);
			if(imgfile_C.length()>100000){
				float abc =(float) ((float)1/(float)(imgfile_C.length()/100000));
				reduceImg(sSaveName_C,sSaveName_C, 0, 0,abc);
			}
		}
		
		String sbasestrs_Z = GetImageStr(sSaveName_db_Z);
		String sbasestrs_F = GetImageStr(sSaveName_db_F);
		String sbasestrs_T = GetImageStr(sSaveName_db_T);
		String sbasestrs_C = "";
		if("1".equals(isCheckIdCard)){
			sbasestrs_C = GetImageStr(sSaveName_db_C);
		}
		else{
			sbasestrs_C = "";
		}
		
//		byte[] base64Byte = sbasestrs.getBytes();
//		FileOutputStream fos = new FileOutputStream(sSaveNameTxt);
//		fos.write(base64Byte);
//		fos.close();
		String[] iPictureTypes = new String[3];
		iPictureTypes[0]="Z";
		iPictureTypes[1]="F";
		iPictureTypes[2]="T";
		String[] iPicturePics = new String[]{sbasestrs_Z,sbasestrs_F,sbasestrs_T};
		String  inputParsm [] = new String[10];
		inputParsm[0] = sysAcceptl;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workno;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		inputParsm[7] = "0";
		%>
		<wtc:service name="sg412Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
			<wtc:param value="<%=inputParsm[0]%>" />
			<wtc:param value="<%=inputParsm[1]%>" />
			<wtc:param value="<%=inputParsm[2]%>" />
			<wtc:param value="<%=inputParsm[3]%>" />
			<wtc:param value="<%=inputParsm[4]%>" />
			<wtc:param value="<%=inputParsm[5]%>" />
			<wtc:param value="<%=inputParsm[6]%>" />
			<wtc:param value="<%=inputParsm[7]%>" />
			<wtc:params value="<%=iPictureTypes%>"/>
			<wtc:params value="<%=iPicturePics%>" />
		</wtc:service>
		<wtc:array id="result1" scope="end" />
		<%
		if("000000".equals(errCode)){
			%>
			<script type="text/javascript">
				parent.document.all.breakSeq.value="<%=result1[0][0]%>";
			</script>
			<%
		}
		System.out.println("liangyl------------"+result1[0][0]);
		boolean uploadFlag=false;
		if("1".equals(isCheckIdCard)){
			String  inputParsm1 [] = new String[15];
			inputParsm1[0] = "";
			inputParsm1[1] = "01";
			inputParsm1[2] ="";// opCode;
			inputParsm1[3] = "";//workno;
			inputParsm1[4] = "";//password;
			inputParsm1[5] = "";
			inputParsm1[6] = "";
			inputParsm1[7] = "";
			
			inputParsm1[8] = "1";
			inputParsm1[9] = "";//custName;
			inputParsm1[10] = "";//idIccid;
			inputParsm1[11] = "1";
			
			inputParsm1[12] = "";//filetxtName;
			inputParsm1[13] = "";//sSaveTxtPath;
			inputParsm1[14] = "";//iServerIpAddr;
			%>
			<wtc:service name="sImageCompCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="trueCode" retmsg="trueMsg" outnum="1">
				<wtc:param value="<%=inputParsm1[0]%>"/>
				<wtc:param value="<%=inputParsm1[1]%>"/>
				<wtc:param value="<%=inputParsm1[2]%>"/>
				<wtc:param value="<%=inputParsm1[3]%>"/>
				<wtc:param value="<%=inputParsm1[4]%>"/>
				<wtc:param value="<%=inputParsm1[5]%>"/>
				<wtc:param value="<%=inputParsm1[6]%>"/>
				<wtc:param value="<%=inputParsm1[7]%>"/>
					
				<wtc:param value="<%=inputParsm1[8]%>"/>
				<wtc:param value="<%=inputParsm1[9]%>"/>
				<wtc:param value="<%=inputParsm1[10]%>"/>
				<wtc:param value="<%=inputParsm1[11]%>"/>
				<wtc:param value="<%=inputParsm1[12]%>"/>
				<wtc:param value="<%=inputParsm1[13]%>"/>
				<wtc:param value="<%=inputParsm1[14]%>"/>
			</wtc:service>
			<wtc:array id="trueResult" scope="end"/>
			
			<%
			if("000000".equals(trueCode)){
				if("".equals(trueResult[0][0])){
					uploadFlag=true;
				}
				else{
					uploadFlag=false;
				}
			}
			if(uploadFlag){
				%>
				<script type="text/javascript">
				parent.document.all.<%=labelName%>.value="1";
				</script>
				<%
			}
			else{
				%>
				<script type="text/javascript">
				parent.document.all.<%=labelName%>.value="0";
				</script>
				<%
			}
		}
		if("000000".equals(errCode)){
			%>
			<script type="text/javascript">
				parent.document.all.upbut_flagZ.value="1";
				parent.document.all.upbut_flagF.value="1";
				parent.document.all.upbut_flagT.value="1";
				<%if("1".equals(isCheckIdCard)){%>
					parent.document.all.upbut_flagC.value="1";
				<%}%>
				parent.document.all.b_write.disabled=false;
				rdShowMessageDialog("上传图片成功请进行确认写卡操作!",1);
			</script>
			<%
		}
    }catch (IOException e) {
    	%>
		<script type="text/javascript">
			parent.document.all.uploadPicBut.disabled=false;
		</script>
		<%
		e.printStackTrace();
	}
		  	 //删除硬盘上的图片文件
		  	File filePic_Z =new File(sSaveName_db_Z);
		  	File filePic_F =new File(sSaveName_db_F);
		  	File filePic_T =new File(sSaveName_db_T);
		  	boolean dpa_Z  = filePic_Z.delete();
		  	boolean dpa_F  = filePic_F.delete();
		  	boolean dpa_T  = filePic_T.delete();
		  	filePic_Z=null;
		  	filePic_F=null;
		  	filePic_T=null;
		  	boolean dpa_C=false;
		  	if("1".equals(isCheckIdCard)){
		  		File filePic_C =new File(sSaveName_db_C);
		  		dpa_C  = filePic_C.delete();
			  	filePic_C=null;
			}
		  	
		  	System.out.println("----------------------------dpa_Z-----------------------------"+dpa_Z);
		  	System.out.println("----------------------------dpa_F-----------------------------"+dpa_F);
		  	System.out.println("----------------------------dpa_T-----------------------------"+dpa_T);
		  	System.out.println("----------------------------dpa_C-----------------------------"+dpa_C);
			System.out.println("---------------------------up_fa--------------------------"+up_fa);
	   if(up_fa.equals("1")){
	   %>
		<script language="JavaScript">
		function delete_pic(){
	  		try{
	  			var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
	  			if(fso!=undefined){
					var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
					var strtemp= tmpFolder+"";
					var filep1 = strtemp.substring(0,1)//取得系统目录盘符
					var cre_dir = filep1+":\\bmp";//创建目录
				//判断文件夹是否存在
					if(fso.FolderExists(cre_dir)) {
						var newFolderName = fso.DeleteFolder(cre_dir);
					}
				}
	  		}catch(e){
	  			//alert(e.message);
				//rdShowMessageDialog("请设置客户端安全性",0);
			}
	  		try{
	  			var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
	  			if(fso!=undefined){
					var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
					var strtemp= tmpFolder+"";
					var filep1 = strtemp.substring(0,1)//取得系统目录盘符
					var cre_dir = filep1+":\\custID";//创建目录
					//判断文件夹是否存在
					if(fso.FolderExists(cre_dir)) {
						var newFolderName = fso.DeleteFolder(cre_dir);
					}
	  			}
	  		}catch(e){
	  			//alert(e.message);
				//rdShowMessageDialog("请设置客户端安全性",0);
			}
         	
         }
         delete_pic();
		</script>
	   <%}
	  else{
	  	%>
	  				<script language="JavaScript">
	  					function delete_pic(){
            		try{
            		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
            		if(fso!=undefined)
            		{
								tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
								var strtemp= tmpFolder+"";
								var filep1 = strtemp.substring(0,1)//取得系统目录盘符
								var cre_dir = filep1+":\\custID";//创建目录
								//判断文件夹是否存在
									if(fso.FolderExists(cre_dir)) {
									var newFolderName = fso.DeleteFolder(cre_dir);
									}
								}
            		}catch(e){
								rdShowMessageDialog("请设置客户端安全性",0);
								}
	            		
            		}
            		rdShowMessageDialog("上传失败"+"<%=up_fa%>",0);
            		delete_pic();
            </script>
	  	<%}
	/**********************************************************************/

  }
%>