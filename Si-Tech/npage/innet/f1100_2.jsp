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
 
<%
String upflag = request.getParameter("upflag");//上传标志//二代证

if(upflag==null) upflag ="0";//二代证
System.out.println("----------upflag---------"+upflag);

String workno = request.getParameter("workno");
System.out.println("----------workno---------"+workno);
if(upflag.equals("1")){//二代证
String sSaveName_db = "";


	String filePath = request.getParameter("filep_j");//图片路径
	System.out.println("----------filePath---------"+filePath);
  String card_flag = request.getParameter("card_flag");//身份证几代标志
  System.out.println("----------card_flag---------"+card_flag);
  String but_flag = request.getParameter("but_flag");//按钮标志，正确的扫描或者读取此值为1
  System.out.println("----------but_flag---------"+but_flag);

	String opCode = "1100";
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

	String up_fa = "1";
		
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
		
		String serverIP = "";
		String idPath = "";
		
if(idRegion_S.equals("23")){
		if(idRegion.equals("01")){       //哈尔滨
			serverIP = "10.110.2.221";
			idPath = "iccid1/harb/"+dirName;
			}
		if(idRegion.equals("02")){			 //齐齐哈尔
			serverIP = "10.110.2.222";
			idPath = "iccid2/qqhr/"+dirName;
			}
		if(idRegion.equals("03")){			 //鸡西
			serverIP = "10.110.2.222";
			idPath = "iccid2/jix/"+dirName;
			}
		if(idRegion.equals("04")){			 //鹤岗
			serverIP = "10.110.2.222";
			idPath = "iccid2/heg/"+dirName;
			}
		if(idRegion.equals("05")){			 //双鸭山
			serverIP = "10.110.2.222";
			idPath = "iccid2/sys/"+dirName;
			}
		if(idRegion.equals("06")){			 //大庆
			serverIP = "10.110.2.222";
			idPath = "iccid2/daq/"+dirName;
			}
		if(idRegion.equals("07")){		   //伊春
			serverIP = "10.110.2.221";
			idPath = "iccid1/yic/"+dirName;
			}
		if(idRegion.equals("08")){			 //佳木斯
			serverIP = "10.110.2.222";
			idPath = "iccid2/jms/"+dirName;
			}
		if(idRegion.equals("09")){		   //七台河
			serverIP = "10.110.2.221";
			idPath = "iccid1/qth/"+dirName;
			}
		if(idRegion.equals("10")){       //牡丹江
			serverIP = "10.110.2.221";
			idPath = "iccid1/mdj/"+dirName;
			}
		if(idRegion.equals("11")){			 //黑河
			serverIP = "10.110.2.222";
			idPath = "iccid2/heih/"+dirName;
			}
		if(idRegion.equals("23")){			 //绥化
			serverIP = "10.110.2.222";
			idPath = "iccid2/suih/"+dirName;
			}
		if(idRegion.equals("27")){			 //大兴安岭
			serverIP = "10.110.2.222";
			idPath = "iccid2/dxal/"+dirName;
			}
		}else{												   //其他地市
			serverIP = "10.110.2.221";
			idPath = "iccid1/other/";
			}
		
		String yearMon=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());
		System.out.println("yearMon|"+yearMon); //当前月份 200908
		System.out.println("serverIP|"+serverIP);
		
		idPath = idPath +yearMon+"/";

		System.out.println("idPath|"+idPath);
				
		ResourceBundle LogfileInfo = ResourceBundle.getBundle("LoginInfo");
		DesEncrypterIsmp t = new DesEncrypterIsmp();  //加密类，解密类
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
				System.out.println("上传图片结果为："+upftpfile);
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
			  
		     sql_iccidInfo = "insert into DCUSTICCIDIMG (id_iccid,id_type,id_name,id_address,id_sex,id_birthday,id_image) values('"+idIccid+"','"+card_flag+"代','"+custName+"','"+idAddr+"','"+IDSex_t+"',to_date('"+birthDay+"','YYYYMMDD'),'"+idCard_path+"')";
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
		  	 //删除硬盘上的图片文件
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
            		rdShowMessageDialog("上传失败",0);
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
	String regionId = request.getParameter("regionCode") + request.getParameter("districtCode") + "999"; 
	String custName = request.getParameter("custName"); 
	String custPwd = WtcUtil.repStr(request.getParameter("custPwd")," "); 
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
	System.out.println("contactPost=["+contactPost+"]");
							System.out.println("0000");
	if(contactPost.compareTo("")==0)
	{
									System.out.println("111111111111111");	
		contactPost = " ";	
	}

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
 
  String selSvcLvl=request.getParameter("selSvcLvl");//zhangyan
			System.out.println("************************************************************************************************8");
			System.out.println("--------------------login_accept------------------------------"+login_accept);
			System.out.println("--------------------custId------------------------------------"+custId);
			System.out.println("--------------------regionId----------------------------------"+regionId);
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
      		System.out.println("--------------------selSvcLvl-------------------------------------"+selSvcLvl); //zhangyan add 2011-12-13 15:57:43 for 客户服务等级
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
			        <wtc:param value="<%=yzhm%>"/>
			        <wtc:param value="<%=yzrq%>"/>
			        <wtc:param value="<%=frdm%>"/>
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
	<%
	System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	

 System.out.println("调用服务s1100Cfm in f1100_2.jsp前");
       /** String ret_code = result[0][0];      
        String retMessage = result[0][1];
		String retQuence = result[0][2];
	    **/
		if((ret_code.trim()).compareTo("000000") == 0)
		{
		    if("1".equals(inputFlag)){
		        %>
                    <script language='jscript'>
                        rdShowMessageDialog("客户开户操作成功！",2);
        				window.returnValue = "<%=unit_id%>";
		                window.close();
                    </script>            
                <%	
		    }else{
%>
            <script language="JavaScript">
                rdShowMessageDialog("客户开户操作成功！",2);
				location = "f1100_1.jsp";
            </script>            
<%		
            }
        }else
        {
%>
            <script language="JavaScript">
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]");
                <% if(!("1".equals(inputFlag))){ %>
                history.go(-1);
                <% } %>
            </script>
<%
        }
        }
%>
