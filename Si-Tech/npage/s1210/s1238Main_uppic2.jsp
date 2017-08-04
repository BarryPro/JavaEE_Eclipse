<%
/********************
 version v2.0
 开发商: si-tech
 update by liutong @ 2008.09.03
 update by qidp @ 2009-08-18 for 兼容端到端流程
********************/
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
String workno = request.getParameter("workno");
String sSaveName_db = "";
	String filePath = request.getParameter("filep_j");//图片路径
	System.out.println("----------filePath---------"+filePath);
	String filetxtName = request.getParameter("filep_t");//base64码存储位置
	System.out.println("---liangyl-------filePath---------"+filePath);
  String card_flag = request.getParameter("card_flag");//身份证几代标志
  System.out.println("----------card_flag---------"+card_flag);
  String but_flag = request.getParameter("but_flag");//按钮标志，正确的扫描或者读取此值为1
  System.out.println("----------but_flag---------"+but_flag);

	String opCode = request.getParameter("opCode");//"1238";
  String custSex = request.getParameter("idSexH");  	//客户性别
  System.out.println("----------custSex---------"+custSex);
  String regionCode = request.getParameter("regionCode");
  System.out.println("----------regionCode---------"+regionCode);
  String custName = request.getParameter("custName");
  System.out.println("----------custName---------"+custName);
  String idAddr = request.getParameter("idAddrH");
  System.out.println("----------idAddr---------"+idAddr);
	String birthDay = WtcUtil.repStr(request.getParameter("birthDayH")," "); //出生日期
	System.out.println("----------birthDay---------"+birthDay);
	String custId = request.getParameter("custId");
	System.out.println("----------custId---------"+custId);
	String idIccid = request.getParameter("idIccid");
	System.out.println("----------idIccid---------"+idIccid);
	String zhengjianyxq = request.getParameter("zhengjianyxq");
	System.out.println("----------zhengjianyxq---------"+zhengjianyxq);
	String password = (String)session.getAttribute("password");	
	String up_fa = "1";
	
	String idType = request.getParameter("idType");
	String isCheckIdCard =WtcUtil.repStr(request.getParameter("isCheckIdCard"),"0");//是否校验身份证
	System.out.println("----------isCheckIdCard---------"+isCheckIdCard);
	
	String checkPage =WtcUtil.repStr(request.getParameter("checkPage"),"0");//判断提示页面是哪个
	System.out.println("----------checkPage---------"+checkPage);
	if("1210".equals(opCode)){
	}
	else{
		idType = idType.substring(0,idType.indexOf("|"));    //证件类型：0-身份证
		if(!idType.equals("0")){
			isCheckIdCard="0";
			System.out.println("----------isCheckIdCard---------"+isCheckIdCard);
		}
	}
	%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	<%
	
	System.out.println("liangyl----idType=="+idType);
	String iServerIpAddr = realip.trim();
	System.out.println("---liangyl-------iServerIpAddr---------"+iServerIpAddr);
	
	System.out.println("----------birthDay---------"+birthDay);
	if(!birthDay.equals("")) {
	 birthDay =	birthDay.replaceAll("-", "");
	}
	
	
	
			/*********************************上传图片到服务器*************************************/
			if((filePath!=null||!filePath.equals(""))&&but_flag.equals("1")) 
			{
			System.out.println("-----------------------------if---------------------");
			SmartUpload mySmartUpload = new SmartUpload();
			String t_fileName = filePath ;
			String filename = filePath.substring(filePath.lastIndexOf("\\")+1,filePath.length());
			System.out.println("----------filename---------"+filename);
			File file_cre = new File(request.getRealPath("npage/cust_ID"));
			if(!file_cre.exists()){
			file_cre.mkdirs();
			}
			String sSaveName=request.getRealPath("npage/cust_ID/")+"/"+filename;
			String sSaveTxtPath=request.getRealPath("npage/tmp/");
			String sSaveNameTxt = sSaveTxtPath+"/"+filetxtName;
			System.out.println("---liangyl-------sSaveName_db---------"+sSaveName_db);
			System.out.println("---liangyl-------sSaveNameTxt---------"+sSaveNameTxt);
			System.out.println("---liangyl-------sSaveTxtPath---------"+sSaveTxtPath);
			System.out.println("---liangyl-------filetxtName---------"+filetxtName);
			
			sSaveName_db = sSaveName;
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
        String savapic =  request.getRealPath("npage/cust_ID/")+"/";
        System.out.println("--------------savapic----------------"+savapic);
        su.save(savapic);
        System.out.println("--------------su.save(savapic)----------------");
        
        File imgfile = new File(sSaveName);
		System.out.println("---liangyl-----------file.length()----------------"+imgfile.length()/100000);
		if(imgfile.length()>100000){
			float abc =(float) ((float)1/(float)(imgfile.length()/100000));
			reduceImg(sSaveName,sSaveName, 0, 0,abc);
		}
		
		String sbasestrs = GetImageStr(sSaveName_db);
		byte[] base64Byte = sbasestrs.getBytes();
		FileOutputStream fos = new FileOutputStream(sSaveNameTxt);
		fos.write(base64Byte);
		fos.close();
 
		    String IDSex_t = "";
		    System.out.println("--------------custSex----------------"+custSex);
		    if(custSex.equals("1"))
		    	IDSex_t = "男";
		    else if(custSex.equals("2"))
		    	IDSex_t = "女";
		    else
		    	IDSex_t = "未知";
	      String sign_date =new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()).toString();
	  String idCard_path = "";  
 		FtpTools ftpT=new FtpTools();
 		
		String idRegion_S = idIccid.substring(0,2);
		String idRegion = idIccid.substring(2,4);
		String dirName = idIccid.substring(0,6)+"/";
		
		System.out.println("idRegion_S|"+idRegion_S);//身份证号前2位，省份标志 23
		System.out.println("idRegion|"+idRegion);//身份证3-4 位，地市标志 01
		
		String serverIP = "10.110.2.241";
		serverIP="10.110.13.52";//临时配置
		int serverPORT = 6790;
		serverPORT=21;//临时配置
		String idPath = "";
		
	if(idRegion_S.equals("23")){
		if(idRegion.equals("01")){       //哈尔滨
			idPath = "iwebd1/harb/"+dirName;
			
			/*serverIP = "10.110.0.206";
			idPath = "iwebd2/"+dirName;*/
		}else if(idRegion.equals("02")){			 //齐齐哈尔
			idPath = "qqhr/"+dirName;
		}else if(idRegion.equals("03")){			 //鸡西
			idPath = "jix/"+dirName;
		}else if(idRegion.equals("04")){			 //鹤岗
			idPath = "heg/"+dirName;
		}else if(idRegion.equals("05")){			 //双鸭山
			idPath = "sys/"+dirName;
		}else if(idRegion.equals("06")){			 //大庆
			idPath = "daq/"+dirName;
		}else if(idRegion.equals("07")){		   //伊春
			idPath = "yic/"+dirName;
		}else if(idRegion.equals("08")){			 //佳木斯
			idPath = "jms/"+dirName;
		}else if(idRegion.equals("09")){		   //七台河
			idPath = "qth/"+dirName;
		}else if(idRegion.equals("10")){       //牡丹江
			idPath = "mdj/"+dirName;
		}else if(idRegion.equals("11")){			 //黑河
			idPath = "heih/"+dirName;
		}else if(idRegion.equals("23")){			 //绥化
			idPath = "suih/"+dirName;
		}else if(idRegion.equals("27")){			 //大兴安岭
			idPath = "dxal/"+dirName;
		}else{												   //其他地市 update for 胡雪莲提出对黑龙江省的其他地市也进行处理，并传到other文件夹@2015/2/15 
			idPath = "other/";
		}
	}else{												   //其他地市
		idPath = "other/";
	}
		
		String yearMon=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());
		idPath = idPath +yearMon+"/";
		String ftpsPassword = getPas();
		ftpsPassword="cXdlcjQzMjE=";//临时配置测试完删除
		System.out.println("ftpsPassword|"+ftpsPassword);
		
	       String sql_iccidInfo="";
	       String sql_toiccid = "";
	    
	    	
		if(ftpT.connect(serverIP,serverPORT)){
			//System.out.println("---------------------------4--------------------------"+ftpT.login_S("LKPCOLOKLCLC","LKPCOLOKLCLC"));
			//if(ftpT.login_S("iccid",ftpsPassword)){
			if(ftpT.login_S("iwebd1",ftpsPassword)){//临时配置
				System.out.println("---------------------------5--------------------------");
			  idCard_path = serverIP+"_"+idPath+filename;
			  System.out.println("idCard_path|"+idCard_path);
				boolean upftpfile = ftpT.uploadFile("/"+idPath+filename,sSaveName);
				System.out.println("---------uploadFile 第一个参数----------"+"/"+idPath+filename);
				System.out.println("---------uploadFile 第二个参数----------"+sSaveName);
				System.out.println("----------sSaveName---------"+sSaveName);
				System.out.println("上传图片结果为："+upftpfile);
					if(!upftpfile){
					up_fa = "0";
					}
				ftpT.logout();
				}else{
					ftpT.logout();
					System.out.println("---------------------------1--------------------------");
					up_fa = "0";
					} 
			}else{
				System.out.println("---------------------------2--------------------------");
				up_fa = "0";
				}
	if(up_fa.equals("1")){
			  
System.out.println("---------------------------不存在了额额额额额额额额--------------------------");
		
	String  inputParsm [] = new String[21];
	inputParsm[0] = sysAcceptl;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workno;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";

	inputParsm[7] = idIccid;
	inputParsm[8] = "2代";
	inputParsm[9] = custName;
	inputParsm[10] = idAddr;
	inputParsm[11] = IDSex_t;
	inputParsm[12] = birthDay;
	inputParsm[13] = zhengjianyxq;

//	inputParsm[14] = "";
//	inputParsm[15] = custId;
//	inputParsm[16] = idCard_path;
	inputParsm[14] = "";
	inputParsm[15] = custId;
	inputParsm[16] = idCard_path;
	inputParsm[17] = filetxtName;
	inputParsm[18] = sSaveTxtPath;
	inputParsm[19] = iServerIpAddr;
	inputParsm[20] = isCheckIdCard;
	System.out.println("diling---上传--sbasestrs="+sbasestrs);
	/*
	inputParsm[8] = "231026198110202388";
	inputParsm[9] = "哈尔滨市南岗区学府路52号";
	inputParsm[10] = "孙爱娟";
	inputParsm[11] = "2007.05.24-2017.05.24";
	*/
	%>
		<wtc:service name="sM032Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="3">
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
			<wtc:param value="<%=inputParsm[16]%>"/>
			<wtc:param value="<%=inputParsm[17]%>"/>
			<wtc:param value="<%=inputParsm[18]%>"/>
			<wtc:param value="<%=inputParsm[19]%>"/>
			<wtc:param value="<%=inputParsm[20]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	
	if("000000".equals(retCode)&&isCheckIdCard.equals("1")){
		%>
		<script language="javascript">
			if("<%=ret[0][2]%>"=="Y"){
				if("1"=="<%=checkPage%>"){
					rdShowMessageDialog("身份证校验成功!",2);
					parent.document.all.up_flag1.value=2;
				}
				if("2"=="<%=checkPage%>"){
					rdShowMessageDialog("身份证校验成功!",2);
					parent.document.all.up_flag2.value=2;
				}
				if("3"=="<%=checkPage%>"){
					rdShowMessageDialog("身份证校验成功!",2);
					parent.document.all.up_flag3.value=2;
				}
			}
			else{
				if("1"=="<%=checkPage%>"){
					rdShowMessageDialog("身份证校验失败!",1);
					parent.document.all.up_flag1.value=0;
				}
				if("2"=="<%=checkPage%>"){
					rdShowMessageDialog("身份证校验失败!",1);
					parent.document.all.up_flag2.value=0;
				}
				if("3"=="<%=checkPage%>"){
					rdShowMessageDialog("身份证校验失败!",1);
					parent.document.all.up_flag3.value=0;
				}
			}
		</script>
		<%
	}
	else if("000000".equals(retCode)){
		%>
		<script language="javascript">
			
			if("1"=="<%=checkPage%>"){
				rdShowMessageDialog("身份证校验成功!",2);
				parent.document.all.up_flag1.value=2;
			}
			else if("2"=="<%=checkPage%>"){
				rdShowMessageDialog("身份证校验成功!",2);
				parent.document.all.up_flag2.value=2;
			}
			else if("3"=="<%=checkPage%>"){
				rdShowMessageDialog("身份证校验成功!",2);
				parent.document.all.up_flag3.value=2;
			}
			else{
				rdShowMessageDialog("文件上传成功!",2);
				parent.document.all.up_flag.value=2;
			}
		</script>
		<%
	}
	else {
		%>
		<script language="javascript">
			rdShowMessageDialog("记录失败，错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
		</script>
		<%
		}
				
				}
		    
		  
			  	}
			catch(Exception e)
			{
			up_fa = "0";
 
			e.printStackTrace();
			}
		  	 //删除硬盘上的图片文件
		  	  File filePic =new File(sSaveName_db);
		  	  System.out.println("----------------------------sSaveName_db-----------------------------"+sSaveName_db);
 				  boolean dpa  = true;//filePic.delete();
 				  System.out.println("----------------------------dpa-----------------------------"+dpa);
					System.out.println("---------------------------up_fa--------------------------"+up_fa);
	   if(up_fa.equals("1")){
	   %>

	   				<script language="JavaScript">
                function delete_pic(){
            		try{
            		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
            		}catch(e){
								rdShowMessageDialog("请设置客户端安全性",0);
								}
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
            		}catch(e){
								rdShowMessageDialog("请设置客户端安全性",0);
								}
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
            		}
            		rdShowMessageDialog("上传失败"+"<%=up_fa%>",0);
            		delete_pic();
            </script>
	  	<%}
	/**********************************************************************/

  }
%>