<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
</head>
<body>

	<%-------------ng35项目增加提交等待动态图片-----hejwa----2012年12月6日-----%>
		<style type="text/css">
				#addContainer{ 
				    position: absolute;
				    top: 50%;
				    left: 50%;
				    margin: -150px 0 0 -320px;
						text-align: center;
						width: 640px;
						padding: 20px 0 20px 0;
						border: 1px solid #339;
						background: #EEE;
						white-space: nowrap;
				}
				#addContainer img, #addContainer p{
						display: inline; 
						vertical-align: middle; 
						font: bold 12px "宋体", serif; 
				}
		</style>
		<script type="text/javascript">
			<!--
			     function loader(){
							var oDiv = document.createElement("div");
							oDiv.noWrap = true;
							oDiv.innerHTML = "<div id='addContainer'><nobr><img src='/nresources/default/images/progress.gif'><p class='orange'></p></nobr></div>"
							document.body.insertBefore(oDiv,document.body.firstChild);
							if(document.all){
								window.attachEvent("onload",function(){ oDiv.parentNode.removeChild(oDiv);});
							}else{
								window.addEventListener("load",function(){ oDiv.parentNode.removeChild(oDiv);},false);
							}
					 }
			//-->
		</script>
		<script>loader();</script>
	<%-------------ng35项目增加提交等待动态图片-----hejwa----2012年12月6日-------结束--%>


<%
String upflag = request.getParameter("upflag");//上传标志//二代证

if(upflag==null) upflag ="0";//二代证
System.out.println("----------upflag---------"+upflag);

String workno = request.getParameter("workno");

if(upflag.equals("1")){//二代证
  String sSaveName_db = "";
	String filePath = request.getParameter("filep_j");//图片路径
	System.out.println("----------filePath---------"+filePath);
	String filetxtName = request.getParameter("filep_t");//base64码存储位置
	System.out.println("---liangyl-------filePath---------"+filePath);
	
  String card_flag = request.getParameter("card_flag");//身份证几代标志
  System.out.println("----------card_flag---------"+card_flag);
  String but_flag = request.getParameter("but_flag");//按钮标志，正确的扫描或者读取此值为1
  System.out.println("----------but_flag---------"+but_flag);

	String opCode = "m275";
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
	idType = idType.substring(0,idType.indexOf("|"));    //证件类型：0-身份证
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
		serverIP="10.110.13.52";//临时配置测试完删除
		int serverPORT = 6790;
		serverPORT=21;//临时配置测试完删除
		String idPath = "";
		
	if(idRegion_S.equals("23")){
		if(idRegion.equals("01")){       //哈尔滨
			idPath = "iwebd1/harb/"+dirName;//临时配置测试完删除iwebd1/
			/*serverIP = "10.110.0.204";
			idPath = "bossjsp/"+dirName;*/
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
			//if(ftpT.login_S("iccid",ftpsPassword)){//上线改回
			if(ftpT.login_S("iwebd1",ftpsPassword)){//上线删除
			/*if(ftpT.login_S("webapp","YnV6aGlkYW8=")){*/
			/*if(ftpT.login_S("bossjsp","ZGV2anNw")){*/
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
		
	String  inputParsm [] = new String[20];
	inputParsm[0] = "";
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
	System.out.println("diling---上传--sbasestrs="+sbasestrs);
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
			<wtc:param value="<%=inputParsm[16]%>"/>
			<wtc:param value="<%=inputParsm[17]%>"/>
			<wtc:param value="<%=inputParsm[18]%>"/>
			<wtc:param value="<%=inputParsm[19]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	
	if("000000".equals(retCode)){
		%>

		<%
	}else {
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
 				  boolean dpa  = true;//filePic.delete();//上线前改回
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
            		rdShowMessageDialog("上传成功",2);
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
}
else
	{
	  System.out.println("----------------------------else--------------------------");
     String total_date,login_accept=request.getParameter("IccIdAccept");
  //  String[][] result = new String[][]{};
 	//S1100View callView = new S1100View();
 	/*--------------------------*/
	String custId = request.getParameter("custId"); 
	String regionCode = request.getParameter("regionCode"); 
	
	String belongCode = (String)session.getAttribute("orgCode");
	belongCode = belongCode.substring(0,7);
	
	String regionId = request.getParameter("regionCode") + request.getParameter("districtCode") + "999"; 
	
	String custName = request.getParameter("custName"); 
	String custPwd = WtcUtil.repStr(request.getParameter("custPwd"),"");
	String inputFlag = request.getParameter("inputFlag");
	System.out.println("# inputFlag = "+inputFlag);
	custPwd=Encrypt.encrypt(custPwd);
	String pic_name = request.getParameter("pic_name");
	System.out.println("----------pic_name---------"+pic_name);
	String custStatus = request.getParameter("custStatus"); 
	String custGrade = WtcUtil.repStr(request.getParameter("custGrade"),"00"); 
	String ownerType = request.getParameter("ownerType"); 
	String custAddr = WtcUtil.repNull(request.getParameter("custAddr")); 
	String idType = request.getParameter("idType");
	idType = idType.substring(0,idType.indexOf("|"));    //证件类型：0-身份证
	/*20131216 gaopeng 2013/12/16 16:01:31 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息 start*/
	/*经办人姓名*/
	String gestoresName = WtcUtil.repStr(request.getParameter("gestoresName"),"");
	/*经办人联系地址*/
	String gestoresAddr = WtcUtil.repStr(request.getParameter("gestoresAddr"),"");
	/*经办人证件类型*/
	String gestoresIdType = WtcUtil.repStr(request.getParameter("gestoresIdType"),"");
	gestoresIdType = gestoresIdType.substring(0,gestoresIdType.indexOf("|"));
	/*经办人证件号码*/
	String gestoresIccId = request.getParameter("gestoresIccId");
	
	String xsjbrxx=WtcUtil.repStr(request.getParameter("xsjbrxx"),"0");

	
	String jingbanrenStr=gestoresName+"|"+gestoresIdType+"|"+gestoresIccId+"|"+gestoresAddr+"|";
	
	
	/*20131216 gaopeng 2013/12/16 16:01:31 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息 end*/
	
  String isDirectManageCust = request.getParameter("isDirectManageCust");//是否直管客户
  String directManageCustNo = request.getParameter("directManageCustNo");//直管客户编码
  String groupNo = request.getParameter("groupNo");//组织机构代码
	
	String idIccid = request.getParameter("idIccid"); 
	String idAddr = request.getParameter("idAddr"); 
	String idValidDate = WtcUtil.repStr(request.getParameter("idValidDate")," "); 
	if(idValidDate.trim().compareTo("")==0)
	{	  
	/*
	*闰年问题
	int toy=Integer.parseInt(new SimpleDateFormat("yyyy", Locale.getDefault()).format(new Date())); 
	String tomd= new SimpleDateFormat("MMdd", Locale.getDefault()).format(new Date());  
	idValidDate=String.valueOf(toy+10)+tomd;
	*/
		Calendar cc = Calendar.getInstance();
            cc.setTime(new java.util.Date());
            cc.add(Calendar.YEAR, 10);
            java.util.Date _tempDate = cc.getTime();
            idValidDate = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(_tempDate);
	}
	
	String contactPerson = request.getParameter("contactPerson"); 
	String contactPhone = request.getParameter("contactPhone"); 
	String contactAddr = request.getParameter("contactAddr"); 
	String contactPost = request.getParameter("contactPost");
	if(contactPost.compareTo("")==0)
	{	contactPost = " ";	}
	String contactMAddr = request.getParameter("contactMAddr"); 	
	String contactFax = request.getParameter("contactFax"); 
	if(contactFax.compareTo("")==0)
	{	contactFax = " ";	}	
	String contactMail = request.getParameter("contactMail"); 
	if(contactMail.compareTo("")==0)
	{	contactMail = " ";	}
	String unitCode = request.getParameter("unitCode"); //机构代码
	String parentId = request.getParameter("parentId"); 
	if(parentId.compareTo("") == 0)
	{   parentId = custId;          	}
	String custSex = request.getParameter("custSex");  	//客户性别
	String birthDay = WtcUtil.repStr(request.getParameter("birthDay")," "); //出生日期
	if(birthDay.trim().compareTo("") == 0)
	{
 	  if(idIccid.trim().length()==15 && idType.equals("0")) 
		birthDay="19"+idIccid.substring(6,8)+idIccid.substring(8,12);
	  else if(idIccid.trim().length()==18 && idType.equals("0")) 
        birthDay=idIccid.substring(6,10)+idIccid.substring(10,14);
	  else
        birthDay="19491001";
	} 
	String professionId = request.getParameter("professionId"); 
	String vudyXl = request.getParameter("vudyXl"); //学历
	String custAh = request.getParameter("custAh"); //客户爱好 
	if(custAh.length() == 0)
	{	custAh = "无";	}
	String custXg = request.getParameter("custXg"); //客户习惯
	if(custXg.compareTo("") == 0)
	{	custXg = "无";	}
	String unitXz = request.getParameter("unitXz"); //集团规模等级
	String yzlx = request.getParameter("yzlx"); //执照类型//后台未用到,所以利用其传送策反集团标志
	String yzhm = request.getParameter("yzhm"); //执照号码
	String yzrq = request.getParameter("yzrq"); //执照有效期
	String frdm = request.getParameter("frdm"); //法人代码
	String groupCharacter = WtcUtil.repStr(request.getParameter("groupCharacter"),"无");//群组信息
	String opCode = "1100";
	
	workno = request.getParameter("workno");	
	String sysNote = request.getParameter("sysNote"); 
	String opNote = request.getParameter("opNote"); 
	String ip_Addr = request.getParameter("ip_Addr"); 
	String oriGrpNo=WtcUtil.repStr(request.getParameter("oriGrpNo"),"0");
	String sisJSX = WtcUtil.repNull(request.getParameter("isJSX"));
	
	/*luxc 20080326 add*/
	if("02".equals(ownerType)||"03".equals(ownerType)||"04".equals(ownerType))
	{
		String instigate_flag	= request.getParameter("instigate_flag");
		String getcontract_flag	= request.getParameter("getcontract_flag");
		if("null".equals(getcontract_flag))
		{
			getcontract_flag="N";
		}
		yzlx=instigate_flag+getcontract_flag;
		System.out.println("luxc:instigate_flag="+instigate_flag+"|getcontract_flag="+getcontract_flag);
		System.out.println("luxc:yzlx="+yzlx);
	}
	/*luxc 20080326 add end*/
	
    //------------------------

	/**	retArray = callView.view_s1100Cfm(custId, regionId, custName, custPwd,		//4
		            custStatus, custGrade, ownerType, custAddr, idType, idIccid, 	//10
		            idAddr, idValidDate, contactPerson, contactPhone, contactAddr, 	//15
		            contactPost, contactMAddr, contactFax, contactMail, unitCode, 	//20
		            parentId, custSex, birthDay, professionId, vudyXl, custAh, 		//26
		            custXg, unitXz, yzlx, yzhm, yzrq, frdm,groupCharacter,opCode,	//34
		            workno,sysNote,opNote,ip_Addr,oriGrpNo);						//39**/
  //wangzn add 091201 for 潜在集团升签约
  String isPre = "1".equals(request.getParameter("isPre"))? "1":"0";
  String preUnitId = request.getParameter("preUnitId");
  String selSvcLvl = request.getParameter("selSvcLvl");
  String selU0002 = request.getParameter("selU0002");
  String selU0003 = request.getParameter("selU0003");
  
			System.out.println("************************************************************************************************8");
			System.out.println("--------------------login_accept------------------------------"+login_accept);
			System.out.println("--------------------custId------------------------------------"+custId);
			System.out.println("--------------------belongCode----------------------------------"+belongCode);
			System.out.println("--------------------custName----------------------------------"+custName);
			System.out.println("--------------------custPwd-----------------------------------"+custPwd);
			System.out.println("--------------------custStatus--------------------------------"+custStatus);
			System.out.println("--------------------custGrade---------------------------------"+custGrade);
			System.out.println("--------------------ownerType---------------------------------"+ownerType);
			System.out.println("--------------------custAddr----------------------------------"+custAddr);
			System.out.println("--------------------idType------------------------------------"+idType);
			System.out.println("--------------------idIccid-----------------------------------"+idIccid);
			System.out.println("--------------------idAddr------------------------------------"+idAddr);
			System.out.println("--------------------idValidDate-------------------------------"+idValidDate);
			System.out.println("--------------------contactPerson-----------------------------"+contactPerson);
			System.out.println("--------------------contactPhone------------------------------"+contactPhone);
			System.out.println("--------------------contactAddr-------------------------------"+contactAddr);
			System.out.println("--------------------contactPost-------------------------------"+contactPost);
			System.out.println("--------------------contactMAddr------------------------------"+contactMAddr);
			System.out.println("--------------------contactFax--------------------------------"+contactFax);
			System.out.println("--------------------contactMail-------------------------------"+contactMail);
			System.out.println("--------------------unitCode----------------------------------"+unitCode);	
			System.out.println("--------------------parentId----------------------------------"+parentId);
			System.out.println("--------------------custSex-----------------------------------"+custSex);
			System.out.println("--------------------birthDay----------------------------------"+birthDay);
			System.out.println("--------------------professionId------------------------------"+professionId);
			System.out.println("--------------------vudyXl------------------------------------"+vudyXl);
			System.out.println("--------------------custAh------------------------------------"+custAh);	
			System.out.println("--------------------custXg------------------------------------"+custXg);
			System.out.println("--------------------unitXz------------------------------------"+unitXz);
			System.out.println("--------------------yzlx--------------------------------------"+yzlx);
			System.out.println("--------------------yzhm--------------------------------------"+yzhm);
			System.out.println("--------------------yzrq--------------------------------------"+yzrq);
			System.out.println("--------------------frdm--------------------------------------"+frdm);
			System.out.println("--------------------groupCharacter----------------------------"+groupCharacter);
			System.out.println("--------------------opCode------------------------------------"+opCode);
			System.out.println("--------------------workno------------------------------------"+workno);
			System.out.println("--------------------sysNote-----------------------------------"+sysNote);
			System.out.println("--------------------opNote------------------------------------"+opNote);
			System.out.println("--------------------ip_Addr-----------------------------------"+ip_Addr);
			System.out.println("--------------------oriGrpNo----------------------------------"+oriGrpNo);   
			System.out.println("--------------------isPre-------------------------------------"+isPre); //wangzn add 091201 for 潜在集团升签约
      System.out.println("--------------------preUnitId-------------------------------------"+preUnitId); //wangzn add 091201 for 潜在集团升签约			
      System.out.println("--------------------selSvcLvl-------------------------------------"+selSvcLvl); //wangzn add 091201 for 潜在集团升签约			
      System.out.println("q100--------------------selU0002-------------------------------------"+selU0002); //wangzn add 091201 for 潜在集团升签约			
      System.out.println("q100--------------------selU0003-------------------------------------"+selU0003); //wangzn add 091201 for 潜在集团升签约			
			
			System.out.println("************************************************************************************************8");

%>


<wtc:service name="s1100Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="4" >
					    <wtc:param value="<%=login_accept%>"/>
			        <wtc:param value="<%=custId%>"/>
			        <wtc:param value="<%=regionId%>"/>
			        <wtc:param value="<%=custName%>"/>
			        <wtc:param value="<%=custPwd%>"/>
			        <wtc:param value="<%=custStatus%>"/>
			        <wtc:param value="<%=custGrade%>"/>
			        <wtc:param value="<%=ownerType%>"/>         
			        <wtc:param value="<%=custAddr%>"/>
			        <wtc:param value="<%=idType%>"/>
			        <wtc:param value="<%=idIccid%>"/>
			        	
			        <wtc:param value="<%=idAddr%>"/>
			        <wtc:param value="<%=idValidDate%>"/>
			        <wtc:param value="<%=contactPerson%>"/>
			        <wtc:param value="<%=contactPhone%>"/>
			        <wtc:param value="<%=contactAddr%>"/>
			        <wtc:param value="<%=contactPost%>"/>
			        <wtc:param value="<%=contactMAddr%>"/>
			        <wtc:param value="<%=contactFax%>"/>
			        <wtc:param value="<%=contactMail%>"/>
			        <wtc:param value="<%=unitCode%>"/>	
			        	
			        <wtc:param value="<%=parentId%>"/>
			        <wtc:param value="<%=custSex%>"/>
			        <wtc:param value="<%=birthDay%>"/>
			        <wtc:param value="<%=professionId%>"/>
			        <wtc:param value="<%=vudyXl%>"/>
			        <wtc:param value="<%=custAh%>"/>	
			        <wtc:param value="<%=custXg%>"/>
			        <wtc:param value="<%=unitXz%>"/>
			        <wtc:param value="<%=yzlx%>"/>
			        <%if("1993".equals(opCode)){%>
			        		<wtc:param value="<%=isDirectManageCust%>"/>
					        <wtc:param value="<%=directManageCustNo%>"/>
					        <wtc:param value="<%=groupNo%>"/>
			        <%}else{%>
			        		<wtc:param value="<%=yzhm%>"/>
					        <wtc:param value="<%=yzrq%>"/>
					        <wtc:param value="<%=frdm%>"/>
			        <%}%>
			        
			        <wtc:param value="<%=groupCharacter%>"/>
			        <wtc:param value="<%=opCode%>"/>
			        <wtc:param value="<%=workno%>"/>
			        <wtc:param value="<%=sysNote%>"/>
			        <wtc:param value="<%=opNote%>"/>
			        <wtc:param value="<%=ip_Addr%>"/>
			        <wtc:param value="<%=oriGrpNo%>"/>
				      <wtc:param value="<%=isPre%>"/>
				      	
			        <wtc:param value="<%=preUnitId%>"/>
				      <wtc:param value="<%=selSvcLvl%>"/>
				      <wtc:param value="<%=selU0002%>"/>
				      <wtc:param value="<%=selU0003%>"/>
				    	<wtc:param value="<%=sisJSX%>"/>
				   	<%
					    	 /*当选择单位开户时,再传值*/
					    	if(sisJSX.equals("1") || "1993".equals(opCode)){
					    %>
					      <wtc:param value="<%=gestoresName%>"/>
					    	<wtc:param value="<%=gestoresIdType%>"/>
					    	<wtc:param value="<%=gestoresIccId%>"/>
					    	<wtc:param value="<%=gestoresAddr%>"/>
					    <%
					    	}
					    	else if(xsjbrxx.equals("1")){
					    		%>
					    		<wtc:param value="<%=jingbanrenStr%>"/>
						    	<wtc:param value=""/>
						    	<wtc:param value=""/>
						    	<wtc:param value=""/>
					    	<%}
					    	else{
					    %>	
					    	<wtc:param value=""/>
					    	<wtc:param value=""/>
					    	<wtc:param value=""/>
					    	<wtc:param value=""/>
					    <%	
					    	}
					    %>
			</wtc:service>
			<wtc:array id="result" scope="end" />

<%
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	String retCodeForCntt = ret_code ;
    String retMsgForCntt =retMessage;
	String loginAccept =login_accept; 
	String opName = "客户开户";
	String unit_id = "";
	
	if(ret_code.equals("0")||ret_code.equals("000000")){
		if(result.length>0){
			loginAccept=result[0][2];
			unit_id = result[0][3];
		}
	}
	System.out.println("# unit_id = "+unit_id);
	//String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&contactId="+custId+"&contactType=cust";
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&retMsgForCntt="+retMsgForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone=&opBeginTime="+opBeginTime+"&contactId="+custId+"&contactType=cust";
	System.out.println("url="+url);
		
	%>
	<jsp:include page="<%=url%>" flush="true" />
		
	<script src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/redialog/redialog.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/autocomplete.js"  type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/common.js"  type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/framework2.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/framework_extend.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/tabScript_jsa.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/validate_pack.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/extend/mztree/MzTreeView12.js" type="text/javascript"></script>
	
	<%
		if((ret_code.trim()).compareTo("000000") == 0)
		{
		    if("1".equals(inputFlag)){
		        %>
                    <script language='jscript'>
                    	$("#addContainer").hide();
                        rdShowMessageDialog("客户开户操作成功！",2);
        								window.returnValue = "<%=unit_id%>";
		                		window.close();
                    </script>            
                <%	
		    }else{
  %>
            <script language="JavaScript">
            	$("#addContainer").hide();
                rdShowMessageDialog("客户开户操作成功！",2);
                var cusId = "<%=custId%>";
  							var custName = "<%=custName%>";
  							window.parent.setCustInfo(cusId,custName);
  							
  							 
            </script>            
<%		
            }
        }else
        {
%>
            <script language="JavaScript">
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]");
                $("#addContainer").hide();
               	window.parent.location.reload();
            </script>
<%
        }
        }
%>
</body>
</html>
