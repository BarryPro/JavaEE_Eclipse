<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.03
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
 
<%
String upflag = request.getParameter("upflag");//�ϴ���־//����֤

if(upflag==null) upflag ="0";//����֤
System.out.println("----------upflag---------"+upflag);

String workno = request.getParameter("workno");

if(upflag.equals("1")){//����֤
String sSaveName_db = "";

	String filePath = request.getParameter("filep_j");//ͼƬ·��
	System.out.println("----------filePath---------"+filePath);
  String card_flag = request.getParameter("card_flag");//���֤������־
  System.out.println("----------card_flag---------"+card_flag);
  String but_flag = request.getParameter("but_flag");//��ť��־����ȷ��ɨ����߶�ȡ��ֵΪ1
  System.out.println("----------but_flag---------"+but_flag);

	String opCode = "1104";
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

	String up_fa = "1";
		
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
        su.save(savapic);
 

		    String IDSex_t = "";
		    System.out.println("--------------custSex----------------"+custSex);
		    custSex = "1";
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
		
		String serverIP = "";
		String idPath = "";
		
if(idRegion_S.equals("23")){
		if(idRegion.equals("01")){       //������
			serverIP = "10.110.2.221";
			idPath = "iccid1/harb/"+dirName;
		}else
		if(idRegion.equals("02")){			 //�������
			serverIP = "10.110.2.222";
			idPath = "iccid2/qqhr/"+dirName;
			}else
		if(idRegion.equals("03")){			 //����
			serverIP = "10.110.2.222";
			idPath = "iccid2/jix/"+dirName;
			}else
		if(idRegion.equals("04")){			 //�׸�
			serverIP = "10.110.2.222";
			idPath = "iccid2/heg/"+dirName;
			}else
		if(idRegion.equals("05")){			 //˫Ѽɽ
			serverIP = "10.110.2.222";
			idPath = "iccid2/sys/"+dirName;
			}else
		if(idRegion.equals("06")){			 //����
			serverIP = "10.110.2.222";
			idPath = "iccid2/daq/"+dirName;
			}else
		if(idRegion.equals("07")){		   //����
			serverIP = "10.110.2.221";
			idPath = "iccid1/yic/"+dirName;
			}else
		if(idRegion.equals("08")){			 //��ľ˹
			serverIP = "10.110.2.222";
			idPath = "iccid2/jms/"+dirName;
			}else
		if(idRegion.equals("09")){		   //��̨��
			serverIP = "10.110.2.221";
			idPath = "iccid1/qth/"+dirName;
			}else
		if(idRegion.equals("10")){       //ĵ����
			serverIP = "10.110.2.221";
			idPath = "iccid1/mdj/"+dirName;
			}else
		if(idRegion.equals("11")){			 //�ں�
			serverIP = "10.110.2.222";
			idPath = "iccid2/heih/"+dirName;
			}else
		if(idRegion.equals("23")){			 //�绯
			serverIP = "10.110.2.222";
			idPath = "iccid2/suih/"+dirName;
			}else
		if(idRegion.equals("27")){			 //���˰���
			serverIP = "10.110.2.222";
			idPath = "iccid2/dxal/"+dirName;
			}else{
			serverIP = "10.110.2.221";
			idPath = "iccid1/other/";
				}
		}else{												   //��������
			serverIP = "10.110.2.221";
			idPath = "iccid1/other/";
			}
			
		String yearMon=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());
		System.out.println("yearMon|"+yearMon); //��ǰ�·� 200908
		System.out.println("serverIP|"+serverIP);
		
		idPath = idPath +yearMon+"/";

		System.out.println("idPath|"+idPath);
				
		ResourceBundle LogfileInfo = ResourceBundle.getBundle("LoginInfo");
		DesEncrypterIsmp t = new DesEncrypterIsmp();  //�����࣬������
		String ftpsPassword = LogfileInfo.getString("ftpPassword");
		System.out.println("ftpsPassword|"+ftpsPassword);
		
		
 		System.out.println("---------------------------3--------------------------");
 	 String sql_ciccid = "select count(*) from DCUSTICCIDIMG where id_iccid='"+idIccid+"'";
	      %>

	      <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
				  <wtc:sql><%=sql_ciccid%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result_ciicid" scope="end"/>

	      <%

	      String re_ciicid = "0";

	      if(result_ciicid.length>0){
	      re_ciicid = result_ciicid[0][0];
	      }


	       String sql_iccidInfo="";
	       String sql_toiccid = "";
	    
	    	if(re_ciicid.equals("0")){	
		if(ftpT.connect(serverIP)){
			System.out.println("---------------------------4--------------------------"+ftpT.login_S("LKPCOLOKLCLC","LKPCOLOKLCLC"));
			if(ftpT.login_S("iccid",ftpsPassword)){
				System.out.println("---------------------------5--------------------------");
			  idCard_path = serverIP+"_"+idPath+filename;
			  System.out.println("idCard_path|"+idCard_path);
				boolean upftpfile = ftpT.uploadFile("/"+idPath+filename,sSaveName);
				System.out.println("----------sSaveName---------"+sSaveName);
				System.out.println("�ϴ�ͼƬ���Ϊ��"+upftpfile);
					if(!upftpfile){
					up_fa = "0";
					}
				}else{
					System.out.println("---------------------------1--------------------------");
					up_fa = "0";
					} 
			}else{
				System.out.println("---------------------------2--------------------------");
				up_fa = "0";
				}
	if(up_fa.equals("1")){   
			  
		     sql_iccidInfo = "insert into DCUSTICCIDIMG (id_iccid,id_type,id_name,id_address,id_sex,id_birthday,id_image) values('"+idIccid+"','"+card_flag+"��','"+custName+"','"+idAddr+"','"+IDSex_t+"',to_date('"+birthDay+"','YYYYMMDD'),'"+idCard_path+"')";
		     sql_toiccid = "insert into DCUSTIDTOICCID (cust_id,ID_ICCID,WORK_NO,OPR_DATE,op_code) values ('"+custId+"','"+idIccid+"','"+workno+"',to_date('"+sign_date+"','yyyy-mm-dd'),'"+opCode+"')"	;
		     
		     System.out.println("sql_iccidInfo|"+sql_iccidInfo);
		     System.out.println("sql_toiccid|"+sql_toiccid);
			%>
			
				<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
				  <wtc:sql><%=sql_iccidInfo%></wtc:sql>
				</wtc:pubselect>


				<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
				  <wtc:sql><%=sql_toiccid%></wtc:sql>
				</wtc:pubselect>
				
							
			<%
				}
		    }
		  else{

		  	sql_toiccid = "insert into DCUSTIDTOICCID (cust_id,ID_ICCID,WORK_NO,OPR_DATE,op_code) values ('"+custId+"','"+idIccid+"','"+workno+"',to_date('"+sign_date+"','yyyy-mm-dd'),'"+opCode+"')"	;
		    System.out.println("sql_toiccid"+sql_toiccid);
		    %>

				<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
				  <wtc:sql><%=sql_toiccid%></wtc:sql>
				</wtc:pubselect>		    
		    
		    <%
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
 				  boolean dpa  = filePic.delete();
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
										var newFolderName = fso.DeleteFolder(cre_dir);
										}
									}
            		}
            		rdShowMessageDialog("�ϴ�ʧ��",0);
            		delete_pic();
            </script>
	  	<%}
	/**********************************************************************/

  }
}
%>