<%
/********************
 version v2.0
 ������: si-tech
 update by liutong @ 2008.09.03
 update by qidp @ 2009-08-18 for ���ݶ˵�������
********************/
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
<%@ include file="/npage/sq100/getIccidFtpPas.jsp" %> 
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

<%
String workno = request.getParameter("workno");
String sSaveName_db = "";
	String filePath = request.getParameter("filep_j");//ͼƬ·��
	System.out.println("----------filePath---------"+filePath);
	String filetxtName = request.getParameter("filep_t");//base64��洢λ��
	System.out.println("---liangyl-------filePath---------"+filePath);
  String card_flag = request.getParameter("card_flag");//���֤������־
  System.out.println("----------card_flag---------"+card_flag);
  String but_flag = request.getParameter("but_flag");//��ť��־����ȷ��ɨ����߶�ȡ��ֵΪ1
  System.out.println("----------but_flag---------"+but_flag);

	String opCode = request.getParameter("opCode");//"1238";
  String custSex = request.getParameter("idSexH");  	//�ͻ��Ա�
  System.out.println("----------custSex---------"+custSex);
  String regionCode = request.getParameter("regionCode");
  System.out.println("----------regionCode---------"+regionCode);
  String custName = request.getParameter("custName");
  System.out.println("----------custName---------"+custName);
  String idAddr = request.getParameter("idAddrH");
  System.out.println("----------idAddr---------"+idAddr);
	String birthDay = WtcUtil.repStr(request.getParameter("birthDayH")," "); //��������
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
	String isCheckIdCard =WtcUtil.repStr(request.getParameter("isCheckIdCard"),"0");//�Ƿ�У�����֤
	System.out.println("----------isCheckIdCard---------"+isCheckIdCard);
	
	String checkPage =WtcUtil.repStr(request.getParameter("checkPage"),"0");//�ж���ʾҳ�����ĸ�
	System.out.println("----------checkPage---------"+checkPage);
	if("1210".equals(opCode)){
	}
	else{
		idType = idType.substring(0,idType.indexOf("|"));    //֤�����ͣ�0-���֤
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
	
	
	
			/*********************************�ϴ�ͼƬ��������*************************************/
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
		    	IDSex_t = "��";
		    else if(custSex.equals("2"))
		    	IDSex_t = "Ů";
		    else
		    	IDSex_t = "δ֪";
	      String sign_date =new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()).toString();
	  String idCard_path = "";  
 		FtpTools ftpT=new FtpTools();
 		
		String idRegion_S = idIccid.substring(0,2);
		String idRegion = idIccid.substring(2,4);
		String dirName = idIccid.substring(0,6)+"/";
		
		System.out.println("idRegion_S|"+idRegion_S);//���֤��ǰ2λ��ʡ�ݱ�־ 23
		System.out.println("idRegion|"+idRegion);//���֤3-4 λ�����б�־ 01
		
		String serverIP = "10.110.2.241";
		serverIP="10.110.13.52";//��ʱ����
		int serverPORT = 6790;
		serverPORT=21;//��ʱ����
		String idPath = "";
		
	if(idRegion_S.equals("23")){
		if(idRegion.equals("01")){       //������
			idPath = "iwebd1/harb/"+dirName;
			
			/*serverIP = "10.110.0.206";
			idPath = "iwebd2/"+dirName;*/
		}else if(idRegion.equals("02")){			 //�������
			idPath = "qqhr/"+dirName;
		}else if(idRegion.equals("03")){			 //����
			idPath = "jix/"+dirName;
		}else if(idRegion.equals("04")){			 //�׸�
			idPath = "heg/"+dirName;
		}else if(idRegion.equals("05")){			 //˫Ѽɽ
			idPath = "sys/"+dirName;
		}else if(idRegion.equals("06")){			 //����
			idPath = "daq/"+dirName;
		}else if(idRegion.equals("07")){		   //����
			idPath = "yic/"+dirName;
		}else if(idRegion.equals("08")){			 //��ľ˹
			idPath = "jms/"+dirName;
		}else if(idRegion.equals("09")){		   //��̨��
			idPath = "qth/"+dirName;
		}else if(idRegion.equals("10")){       //ĵ����
			idPath = "mdj/"+dirName;
		}else if(idRegion.equals("11")){			 //�ں�
			idPath = "heih/"+dirName;
		}else if(idRegion.equals("23")){			 //�绯
			idPath = "suih/"+dirName;
		}else if(idRegion.equals("27")){			 //���˰���
			idPath = "dxal/"+dirName;
		}else{												   //�������� update for ��ѩ������Ժ�����ʡ����������Ҳ���д���������other�ļ���@2015/2/15 
			idPath = "other/";
		}
	}else{												   //��������
		idPath = "other/";
	}
		
		String yearMon=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());
		idPath = idPath +yearMon+"/";
		String ftpsPassword = getPas();
		ftpsPassword="cXdlcjQzMjE=";//��ʱ���ò�����ɾ��
		System.out.println("ftpsPassword|"+ftpsPassword);
		
	       String sql_iccidInfo="";
	       String sql_toiccid = "";
	    
	    	
		if(ftpT.connect(serverIP,serverPORT)){
			//System.out.println("---------------------------4--------------------------"+ftpT.login_S("LKPCOLOKLCLC","LKPCOLOKLCLC"));
			//if(ftpT.login_S("iccid",ftpsPassword)){
			if(ftpT.login_S("iwebd1",ftpsPassword)){//��ʱ����
				System.out.println("---------------------------5--------------------------");
			  idCard_path = serverIP+"_"+idPath+filename;
			  System.out.println("idCard_path|"+idCard_path);
				boolean upftpfile = ftpT.uploadFile("/"+idPath+filename,sSaveName);
				System.out.println("---------uploadFile ��һ������----------"+"/"+idPath+filename);
				System.out.println("---------uploadFile �ڶ�������----------"+sSaveName);
				System.out.println("----------sSaveName---------"+sSaveName);
				System.out.println("�ϴ�ͼƬ���Ϊ��"+upftpfile);
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
			  
System.out.println("---------------------------�������˶��������--------------------------");
		
	String  inputParsm [] = new String[21];
	inputParsm[0] = sysAcceptl;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workno;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";

	inputParsm[7] = idIccid;
	inputParsm[8] = "2��";
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
	System.out.println("diling---�ϴ�--sbasestrs="+sbasestrs);
	/*
	inputParsm[8] = "231026198110202388";
	inputParsm[9] = "���������ϸ���ѧ��·52��";
	inputParsm[10] = "�ﰮ��";
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
					rdShowMessageDialog("���֤У��ɹ�!",2);
					parent.document.all.up_flag1.value=2;
				}
				if("2"=="<%=checkPage%>"){
					rdShowMessageDialog("���֤У��ɹ�!",2);
					parent.document.all.up_flag2.value=2;
				}
				if("3"=="<%=checkPage%>"){
					rdShowMessageDialog("���֤У��ɹ�!",2);
					parent.document.all.up_flag3.value=2;
				}
			}
			else{
				if("1"=="<%=checkPage%>"){
					rdShowMessageDialog("���֤У��ʧ��!",1);
					parent.document.all.up_flag1.value=0;
				}
				if("2"=="<%=checkPage%>"){
					rdShowMessageDialog("���֤У��ʧ��!",1);
					parent.document.all.up_flag2.value=0;
				}
				if("3"=="<%=checkPage%>"){
					rdShowMessageDialog("���֤У��ʧ��!",1);
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
				rdShowMessageDialog("���֤У��ɹ�!",2);
				parent.document.all.up_flag1.value=2;
			}
			else if("2"=="<%=checkPage%>"){
				rdShowMessageDialog("���֤У��ɹ�!",2);
				parent.document.all.up_flag2.value=2;
			}
			else if("3"=="<%=checkPage%>"){
				rdShowMessageDialog("���֤У��ɹ�!",2);
				parent.document.all.up_flag3.value=2;
			}
			else{
				rdShowMessageDialog("�ļ��ϴ��ɹ�!",2);
				parent.document.all.up_flag.value=2;
			}
		</script>
		<%
	}
	else {
		%>
		<script language="javascript">
			rdShowMessageDialog("��¼ʧ�ܣ�������룺<%=retCode%> ��������Ϣ��<%=retMsg%>",0);
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
		  	 //ɾ��Ӳ���ϵ�ͼƬ�ļ�
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
										var newFolderName = fso.DeleteFolder(cre_dir);
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