<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%
/*
* ����: 
* �汾: 1.0
* ����: liangyl 2017/03/01 liangyl ����ʵ��������֤һ���Բ��鼰����΢�Ų��Ǽǹ���ĺ�
* ����: liangyl
* ��Ȩ: si-tech
*/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat"%><!--����֤-->
<%@ page import="com.jspsmart.upload.*"%><!--����֤-->
<%@ page import="import java.sql.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.io.File"%><!--����֤-->
<%@ page import="com.uploadftp.*"%><!--����֤-->
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
<%@ include file="../../npage/sq100/getIccidFtpPas.jsp" %> 
<%!
	public static String GetImageStr(String imgFilePath) {// ��ͼƬ�ļ�ת��Ϊ�ֽ������ַ��������������Base64���봦��
		byte[] data = null;

		// ��ȡͼƬ�ֽ�����
		try {
			InputStream in = new FileInputStream(imgFilePath);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// ���ֽ�����Base64����
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);// ����Base64��������ֽ������ַ���
	}
	
	public static void reduceImg(String imgsrc, String imgdist, int widthdist,  
			int heightdist, float rate) {  
		try {  
			File srcfile = new File(imgsrc);  
			// ����ļ��Ƿ����  
			if (!srcfile.exists()) {  
				return;  
			}  
			System.out.println(rate);
			// ���rate��Ϊ��˵���ǰ�����ѹ��  
			if (rate > 0) {  
				// ��ȡ�ļ��߶ȺͿ��  
				int[] results = getImgWidth(srcfile);  
				if (results == null || results[0] == 0 || results[1] == 0) {  
					return;  
				} else {  
					widthdist = (int) (results[0] * rate);  
					heightdist = (int) (results[1] * rate);  
				}  
			}  
			// ��ʼ��ȡ�ļ�������ѹ��  
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
	 * ��ȡͼƬ���
	 * 
	 * @param file
	 *            ͼƬ�ļ�
	 * @return ���
	 */
	public static int[] getImgWidth(File file) {
		InputStream is = null;
		BufferedImage src = null;
		int result[] = { 0, 0 };
		try {
			is = new FileInputStream(file);
			src = javax.imageio.ImageIO.read(is);
			result[0] = src.getWidth(null); // �õ�Դͼ��
			result[1] = src.getHeight(null); // �õ�Դͼ��
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
	<%-------------ng35��Ŀ�����ύ�ȴ���̬ͼƬ-----hejwa----2012��12��6��-----%>
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
						font: bold 12px "����", serif; 
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
	<%-------------ng35��Ŀ�����ύ�ȴ���̬ͼƬ-----hejwa----2012��12��6��-------����--%>


<%
	String workno = request.getParameter("workno");
  String sSaveName_db = "";
	String filePath = request.getParameter("filep_j");//ͼƬ·��
	System.out.println("---liangyl-------filePath---------"+filePath);
	String opCode = request.getParameter("op_code");
	System.out.println("---liangyl-------opCode---------"+opCode);
  String regionCode = request.getParameter("regionCode");
  System.out.println("---liangyl-------regionCode---------"+regionCode);
  
  String custName = request.getParameter("custName");
  System.out.println("---liangyl-------custName---------"+custName);
	String idIccid = request.getParameter("idIccid");
	System.out.println("---liangyl-------idIccid---------"+idIccid);
	String idType = request.getParameter("idType");
	System.out.println("liangyl----idType------"+idType);
	String password = (String)session.getAttribute("password");
	String iServerIpAddr = realip.trim();
	System.out.println("---liangyl-------iServerIpAddr---------"+iServerIpAddr);
	String labelName = request.getParameter("labelName");
	System.out.println("---liangyl-------labelName---------"+labelName);
	String up_fa = "1";
	
	
			/*********************************�ϴ�ͼƬ��������*************************************/
		if((filePath!=null||!filePath.equals(""))){
			System.out.println("---liangyl--------------------------if---------------------");
			SmartUpload mySmartUpload = new SmartUpload();
			String t_fileName = filePath ;
			String filename = filePath.substring(filePath.lastIndexOf("/")+1,filePath.length());
			System.out.println("---liangyl-------filename---------"+filename);
			File file_cre = new File(request.getRealPath("npage/cust_ID"));
			if(!file_cre.exists()){
			file_cre.mkdirs();
			}
			String sSaveName=request.getRealPath("npage/cust_ID/")+"/"+filename;
			String sSaveTxtPath=request.getRealPath("npage/tmp/");
			String filetxtName = filename.split(".jpg")[0]+".txt";
			String sSaveNameTxt = sSaveTxtPath+"/"+filetxtName;
			System.out.println("---liangyl---------------sSaveTxtPath-----------"+sSaveTxtPath);
			System.out.println("---liangyl---------------sSaveNameTxt-----------"+sSaveNameTxt);
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
        System.out.println("---liangyl-----------savapic----------------"+savapic);
        su.save(savapic);
        System.out.println("---liangyl-----------su.save(savapic)----------------");        
		   
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
				
	      String sign_date =new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()).toString();
	     
	  String idCard_path = "";  
 		FtpTools ftpT=new FtpTools();
 		
		String idRegion_S = idIccid.substring(0,2);
		String idRegion = idIccid.substring(2,4);
		String dirName = idIccid.substring(0,6)+"/";
		
		
		System.out.println("liangyl---idRegion_S|"+idRegion_S);//���֤��ǰ2λ��ʡ�ݱ�־ 23
		System.out.println("liangyl---idRegion|"+idRegion);//���֤3-4 λ�����б�־ 01
		
		String serverIP = "10.110.2.241";
		serverIP="10.110.13.52";
		int serverPORT =21;// 6790;
		String idPath = "";
		
	if(idRegion_S.equals("23")){
		if(idRegion.equals("01")){       //������
			idPath = "iwebd1/harb/"+dirName;
			
			/*serverIP = "10.110.0.204";
			idPath = "bossjsp/"+dirName;*/
		}else if(idRegion.equals("02")){			 //�������
			idPath = "iwebd1/qqhr/"+dirName;
		}else if(idRegion.equals("03")){			 //����
			idPath = "iwebd1/jix/"+dirName;
		}else if(idRegion.equals("04")){			 //�׸�
			idPath = "iwebd1/heg/"+dirName;
		}else if(idRegion.equals("05")){			 //˫Ѽɽ
			idPath = "iwebd1/sys/"+dirName;
		}else if(idRegion.equals("06")){			 //����
			idPath = "iwebd1/daq/"+dirName;
		}else if(idRegion.equals("07")){		   //����
			idPath = "iwebd1/yic/"+dirName;
		}else if(idRegion.equals("08")){			 //��ľ˹
			idPath = "iwebd1/jms/"+dirName;
		}else if(idRegion.equals("09")){		   //��̨��
			idPath = "iwebd1/qth/"+dirName;
		}else if(idRegion.equals("10")){       //ĵ����
			idPath = "iwebd1/mdj/"+dirName;
		}else if(idRegion.equals("11")){			 //�ں�
			idPath = "iwebd1/heih/"+dirName;
		}else if(idRegion.equals("23")){			 //�绯
			idPath = "iwebd1/suih/"+dirName;
		}else if(idRegion.equals("27")){			 //���˰���
			idPath = "iwebd1/dxal/"+dirName;
		}else{	   //�������� update for ��ѩ������Ժ�����ʡ����������Ҳ���д���������other�ļ���@2015/2/15 
			idPath = "iwebd1/other/";
		}
	}else{												   //��������
		idPath = "iwebd1/other/";
	}
		
		String yearMon=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());
		idPath = idPath +yearMon+"/";
		String ftpsPassword ="cXdlcjQzMjE="; //getPas();
		System.out.println("liangyl----ftpsPassword|"+ftpsPassword);
		
	       String sql_iccidInfo="";
	       String sql_toiccid = "";
	    
	    	
		if(ftpT.connect(serverIP,serverPORT)){
		System.out.println("---liangyl---------4-------"+ftpT.login_S("LKPCOLOKLCLC","LKPCOLOKLCLC"));
		/*	if(ftpT.login_S("iccid",ftpsPassword)){*/
		if(ftpT.login_S("iwebd1",ftpsPassword)){
				System.out.println("---liangyl------------------------5--------------------------");
			  idCard_path = serverIP+"_"+idPath+filename;
			  System.out.println("liangyl----idCard_path|"+idCard_path);
				boolean upftpfile = ftpT.uploadFile("/"+idPath+filename,sSaveName);
				System.out.println("---liangyl------uploadFile ��һ������----------"+"/"+idPath+filename);
				System.out.println("---liangyl------uploadFile �ڶ�������----------"+sSaveName);
				System.out.println("---liangyl-------sSaveName---------"+sSaveName);
				System.out.println("liangyl---�ϴ�ͼƬ���Ϊ��"+upftpfile);
					if(!upftpfile){
					up_fa = "0";
					}
				ftpT.logout();
				}else{
				  ftpT.logout();
				  System.out.println("---liangyl------------------------1--------------------------");
				  up_fa = "0";
				} 
			}else{
				System.out.println("---liangyl------------------------2--------------------------");
				up_fa = "0";
				}
	if(up_fa.equals("1")){   
	
			  
System.out.println("---liangyl------------------------�������˶��������--------------------------");
		
	String  inputParsm [] = new String[15];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workno;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = "";
	
	inputParsm[8] = "1";
	inputParsm[9] = custName;
	inputParsm[10] = idIccid;
	inputParsm[11] = "1";
	
	inputParsm[12] = filetxtName;
	inputParsm[13] = sSaveTxtPath;
	inputParsm[14] = iServerIpAddr;
	/*
	inputParsm[8] = "231026198110202388";
	inputParsm[9] = "���������ϸ���ѧ��·52��";
	inputParsm[10] = "�ﰮ��";
	inputParsm[11] = "2007.05.24-2017.05.24";
	*/
	System.out.println("liangyl---���֤����----"+idType);
	if(idType.equals("0")){
	%>
		<wtc:service name="sImageCompCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="trueCode" retmsg="trueMsg" outnum="1">
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
		</wtc:service>
		<wtc:array id="trueResult" scope="end"/>
<%
System.out.println("---liangyl-------У�鷵�ؽ��-----------"+trueResult[0][0]);
	if("000000".equals(trueCode)){
		if("1".equals(trueResult[0][0])){
			%>
			<script language="JavaScript">
	    		opener.returnSubState("<%=labelName%>","0");
	    	</script>
	    <%
		}
		else{
			%>
			<script language="JavaScript">
	    		opener.returnSubState("<%=labelName%>","1");
	    	</script>
	    <%
		}
	}else {
				%>
		<script language="javascript">
			rdShowMessageDialog("��¼ʧ�ܣ�������룺<%=trueCode%> ��������Ϣ��<%=trueMsg%>",0);
			opener.returnSubState("<%=labelName%>","1");
		</script>
		<%
		}
	}
				}
			  	}
			catch(Exception e)
			{
				up_fa = "0";
				e.printStackTrace();
			}
		  	 //ɾ��Ӳ���ϵ�ͼƬ�ļ�
		  	  File filePic =new File(sSaveName_db);
		  	  System.out.println("---liangyl-------------------------sSaveName_db-----------------------------"+sSaveName_db);
 				  boolean dpa  =true;// filePic.delete();
 				  System.out.println("---liangyl-------------------------dpa-----------------------------"+dpa);
					System.out.println("---liangyl------------------------up_fa--------------------------"+up_fa);
	   if(up_fa.equals("1")){
	   %>

	   				<script language="JavaScript">
                function delete_pic(){
            		try{
            		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
            		}catch(e){
								rdShowMessageDialog("�����ÿͻ��˰�ȫ��",0);
								}
	            		if(fso!=undefined)
	            		{
									tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
									var strtemp= tmpFolder+"";
									var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
									var cre_dir = filep1+":\\custID";//����Ŀ¼
									//�ж��ļ����Ƿ����
										if(fso.FolderExists(cre_dir)) {
											alert("�ⲿdelete1")
									//	var newFolderName = fso.DeleteFolder(cre_dir);
										}
									}
            		}
            		rdShowMessageDialog("�ϴ��ɹ�",2);
            		delete_pic();
            </script>
	   <%}
	  else{
	  	%>
	  				<script language="JavaScript">
	  					function delete_pic(){
            		try{
            		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
            		}catch(e){
								rdShowMessageDialog("�����ÿͻ��˰�ȫ��",0);
								}
	            		if(fso!=undefined)
	            		{
									tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
									var strtemp= tmpFolder+"";
									var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
									var cre_dir = filep1+":\\custID";//����Ŀ¼
									//�ж��ļ����Ƿ����
										if(fso.FolderExists(cre_dir)) {
											alert("�ⲿdelete2")
										//var newFolderName = fso.DeleteFolder(cre_dir);
										}
									}
            		}
            		rdShowMessageDialog("�ϴ�ʧ��"+"<%=up_fa%>",0);
            		delete_pic();
            </script>
	  	<%}
	/**********************************************************************/

  }
%>
</body>
</html>
