<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
/*
* ����: 
* �汾: 1.0
* ����: liangyl 2017/03/01 liangyl ����ʵ��������֤һ���Բ��鼰����΢�Ų��Ǽǹ���ĺ�
* ����: liangyl
* ��Ȩ: si-tech
*/
%>
<%
String hwAccept = request.getParameter("hwAccept")==null ? "1":request.getParameter("hwAccept");
String showBody = request.getParameter("showBody")==null ? "01":request.getParameter("showBody");
String sopcode = request.getParameter("sopcode")==null ? "":request.getParameter("sopcode");
System.out.println("liangyl==== public ==" + hwAccept + "|" + showBody+"| sopcode="+sopcode);
String workNo = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String groupId =(String)session.getAttribute("groupId");
String nowDatePub =new SimpleDateFormat("yyyyMMdd").format(new java.util.Date()).toString();
String regionCode = orgCode.substring(0,2);
String reqIdCard = request.getParameter("reqIdCard")==null ? "1":request.getParameter("reqIdCard");
String reqIdName = request.getParameter("reqIdName")==null ? "1":request.getParameter("reqIdName");
String labelName = request.getParameter("labelName");

String idType = request.getParameter("idType")==null ? "":request.getParameter("idType");
String idIccid = request.getParameter("idIccid")==null ? "":request.getParameter("idIccid");
String custName = request.getParameter("custName")==null ? "1":request.getParameter("custName");

System.out.println("liangyl====labelName====="+labelName);
System.out.println("liangyl====idType====="+idType);
System.out.println("liangyl====idIccid====="+idIccid);
System.out.println("liangyl====custName====="+custName);
/* ��չʾ��Щ��Ϣ
		01��ֻչʾ���֤
		10��ֻչʾ����
		11�����֤�븽����չʾ
*/
	String iccidInfoStyle = "";
	String accInfoStyle = "";
	if("01".equals(showBody)){
		iccidInfoStyle = "block";
		accInfoStyle = "none";
	}else if("10".equals(showBody)){
		iccidInfoStyle = "none";
		accInfoStyle = "block";
	}else{
		iccidInfoStyle = "block";
		accInfoStyle = "block";
	}

%>
<table cellspacing="0">
	<tr>
		
		<input type="button" id="photoCollect3" name="photoCollect3" class="b_text"   value="����ɼ�-������" onClick="photoCollect33(1)" >
		<input type="button"  class="b_text"   value="�ϴ����֤ͼ��" onClick="camsfztpsc3()">
		</td>
	</tr>
	
</table>

<script language="JavaScript">
	
	sfzhaoma = "<%=reqIdCard%>";
	sfznamess = "<%=reqIdName%>";
	
	
	
	var picpath_n2 = "";
	var picpath_bei2 = "";
	function RecogNewIDOnly_two(cardnum)
	{
		//ɨ��������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
		try{
			if(objIDCard.LibIsLoaded()){

				if(cardnum==1){
					picpath_n2="";
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic.jpg";
					picpath_n2 = cre_dir + "\\hw_<%=hwAccept%>_pic.jpg";
				}else if(cardnum==2){
					picpath_n2="";
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic2.jpg";
					picpath_n2 = cre_dir + "\\hw_<%=hwAccept%>_pic2.jpg";
				}else if(cardnum==11) {
					picpath_bei2="";
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic11.jpg";
					picpath_bei2 = cre_dir + "\\hw_<%=hwAccept%>_pic11.jpg";
				}
				else if(cardnum==22){
					picpath_bei2="";
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic22.jpg";
					picpath_bei2 = cre_dir + "\\hw_<%=hwAccept%>_pic22.jpg";
				}
				
				objIDCard.SaveResultFile = true;
				objIDCard.Content = 63;
				if(objIDCard.RecogNewIDCardALL()){
					rdShowMessageDialog("ɨ��ɹ���",2);
					if(cardnum==1){
						$("#firstId").val(picpath_n2+"|"+picpath_bei2+"|");
					}else if(cardnum==2){
						$("#secondId").val(picpath_n2+"|"+picpath_bei2+"|");
					}else if(cardnum==11) {
						$("#firstId").val(picpath_n2+"|"+picpath_bei2+"|");
					}else if(cardnum==22) {
						$("#secondId").val(picpath_n2+"|"+picpath_bei2+"|");
					}					
				}			
			}
			else
			{
				rdShowMessageDialog( objIDCard.GetLastErrorInfo(),0 );
			}
		}catch(e){
			rdShowMessageDialog("δ����ɨ���ǣ�",0);
		}
	}
	
	function RecogNewIDOnly_one(cardnum)
	{
		//ɨ��һ�����֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
		try{	
			if( objIDCard.LibIsLoaded() )
			{
				var picpath_n = "";
				if(cardnum==1){
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic.jpg";
					picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic.jpg";
				}else if(cardnum==2){
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic2.jpg";
					picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic2.jpg";
				}else if(cardnum==3){
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic3.jpg";
					picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic3.jpg";
				}else if(cardnum==4){
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic4.jpg";
					picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic4.jpg";
				}else if(cardnum==5){
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic5.jpg";
					picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic5.jpg";
				}else if(cardnum==6){
					objIDCard.ImageFileName =  cre_dir + "\\hw_<%=hwAccept%>_pic6.jpg";
					picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic6.jpg";
				}
				
				objIDCard.SaveResultFile = true;
				objIDCard.Content = 63;
				if( objIDCard.RecogIDCardExALL() ){
					
					rdShowMessageDialog("ɨ��ɹ���",2);
					/* ningtn ��·����¼���� */
					if(cardnum==1){
						$("#firstId").val(picpath_n);
					}else if(cardnum==2){
						$("#secondId").val(picpath_n);
					}else if(cardnum==3){
						$("#accInfoHid1").val(picpath_n);
					}else if(cardnum==4){
						$("#accInfoHid2").val(picpath_n);
					}else if(cardnum==5){
						$("#accInfoHid3").val(picpath_n);
					}else if(cardnum==6){
						$("#accInfoHid4").val(picpath_n);
					}
				}
			}
			else
			{
				rdShowMessageDialog( objIDCard.GetLastErrorInfo() ,0);
			}
		}catch(e){
			rdShowMessageDialog("δ����ɨ���ǣ�",0);
		}
	}

	

	
	function Idcard(cardnum)
	{		
		//��ȡ�������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {	
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		
		var picpath_n ;
		if(cardnum==1){
			picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic.jpg";
		}else if(cardnum==2){
			picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic2.jpg";
		}
		
		
		var result;
		var result2;
		var result3;
		var username;
		
		sfznamess="";
		sfzcodess="";
		sfzIDaddressss="";
		sfzbir_dayss="";
		sfzsexss="";
		sfzidValidDate_objss="";
		sfzpicturespathss="";
		
		result=IdrControl1.InitComm("1001");
		if (result==1)
		{
			result2=IdrControl1.Authenticate();
			if ( result2>0)
			{              
				result3=IdrControl1.ReadBaseMsgP(picpath_n); 
				if (result3>0)           
				{
				  var name = IdrControl1.GetName();
					var code =  IdrControl1.GetCode();
					var sex = IdrControl1.GetSex();
					var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
					var IDaddress  =  IdrControl1.GetAddress();
					var idValidDate_obj = IdrControl1.GetValid();
					
					try{
						
						var aa= idValidDate_obj+"";
					  if(aa.indexOf("����") !=-1) {
					  	/*ɶҲ����*/
					  	//$("#idValidDate").val("21000101");
					  }else {				  
							  var bb=aa.substring(11,21);
								var cc = bb.replace("\.","");
								var dd = cc.replace("\.","");
								/*dd�������֤��Ч��*/
							  //$("#idValidDate").val(dd+"");
								  if(Number("<%=nowDatePub%>") > Number(dd)){
								  	rdShowMessageDialog("֤����Ч������["+Number(dd)+"],֤���ѹ��ڣ����������!");
								  	return false;
								  }
							}
			
						var iccidFilePath = "";
						var iccidfile ; 
						if(cardnum==1){
							iccidfile = fso.CreateTextFile(cre_dir + "\\hw_<%=hwAccept%>_str.txt",true); 
							iccidFilePath = cre_dir + "\\hw_<%=hwAccept%>_str.txt";
						}else if(cardnum==2){
							iccidfile = fso.CreateTextFile(cre_dir + "\\hw_<%=hwAccept%>_str2.txt",true); 
							iccidFilePath = cre_dir + "\\hw_<%=hwAccept%>_str2.txt";
						}
					  iccidfile.WriteLine(name+"|"+code+"|"+IDaddress+"|"+bir_day+"|"+sex+"|"+idValidDate_obj);		
					  		  
					  	 sfznamess=name;
							 sfzcodess=code;
							 sfzIDaddressss=IDaddress;
							 sfzbir_dayss=bir_day;
							 sfzsexss=sex;
							 sfzidValidDate_objss=idValidDate_obj;
							 sfzpicturespathss=picpath_n;
							 
					  iccidfile.Close();
					}catch(e){
						alert("��ȡ�������֤�쳣��");
						
					}
					rdShowMessageDialog("��ȡ�������֤�ɹ���",2);
					/* ningtn ��·����¼���� */
					if(cardnum==1){
						$("#firstId").val(picpath_n + "||" + iccidFilePath);
					}else if(cardnum==2){
						$("#secondId").val(picpath_n + "||" + iccidFilePath);
					}
			
				}
				else
				{
					rdShowMessageDialog(result3); 
					IdrControl1.CloseComm();
				}
			}
			else
			{
				IdrControl1.CloseComm();
				rdShowMessageDialog("�����½���Ƭ�ŵ���������");
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("�˿ڳ�ʼ�����ɹ�",0);
		}
		IdrControl1.CloseComm();
	}
	
	/*2014/12/01 9:05:53 gaopeng ������ʶ����ť*/
  function highViewBtn(cardnum){
  	
  	/*2014/12/04 9:38:18 gaopeng ������ʶ�� */
  	var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {	
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		
		/*ͼƬ·��*/
		var picpath_n ;
		/*
		if(cardnum==1){
			picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic.jpg";
		}else if(cardnum==2){
			picpath_n = cre_dir + "\\hw_<%=hwAccept%>_pic2.jpg";
		}*/
		
  	
  	var card_type11 = $("select[name = 'card_type11']").find("option:selected").val();
  	var card_type22 = $("select[name = 'card_type22']").find("option:selected").val();
  	
  	
  	
  	
  	//���ô���ʾ����
		var sys_accept="<%=hwAccept%>";
		var phone_no="<%=hwAccept%>";
		var org_info="<%=groupId%>";
		var work_no="<%=workNo%>";
		
		//ģ��form��post����
		var xmlStr= "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
								"<req>"+
									"<sys_accept>"+sys_accept+"</sys_accept>"+
									"<phone_no>"+phone_no+"</phone_no>"+
									"<org_info>"+org_info+"</org_info>"+
									"<work_no>"+work_no+"</work_no>"+
								"</req>";
		//ģ�ⷵ�ر���			
		/*			
		var	retStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
								+"<resp>"
								+"<name>ĪС��</name>"
								+"<e_name>Lora</e_name>"
								+"<sex>Ů</sex>"
								+"<nation>�й�</nation>"
								+"<ethnic>��</ethnic>"
								+"<birthday>19880517</birthday>"
								+"<address>�Ĵ�ʡ�ɶ���</address>"
								+"<card_no>21310019880517XXXX</card_no>"
								+"<issue_org>���򹫰���</issue_org>"
								+"<issue_date>20060501</issue_date>"
								+"<b_valid_date>20060501</b_valid_date>"
								+"<e_valid_date>20160501</e_valid_date>"
								+"<iccid_path>C:/custID/hw_98765432_pic.jpg</iccid_path>"
								+"</resp>";
		
		window.clipboardData.setData("text",retStr);
		*/
		//����
		window.showModalDialog("http://10.110.0.100:59000/bp095.go?method=crmOCR&xmlStr="+xmlStr);
		//��ȡ�������Ľ������Զ������
		var authinfo = window.clipboardData.getData("text");
		//alert("���ر���--------"+authinfo);
		var xmlDoc = loadXML(authinfo);
		//��ȡ��resp�ڵ�
 		var elementsXml = xmlDoc.getElementsByTagName("resp");
 
 		//��ʼѭ���ڵ�
		for (var i = 0; i < elementsXml.length; i++) {
			
      //����
      var namea = elementsXml[i].getElementsByTagName("name")[0].firstChild.nodeValue;
      alert(namea);
      //Ӣ������
      var e_name = elementsXml[i].getElementsByTagName("e_name")[0].firstChild.nodeValue;
      //�Ա�
      var sex = elementsXml[i].getElementsByTagName("sex")[0].firstChild.nodeValue;
      //����
      var nation = elementsXml[i].getElementsByTagName("nation")[0].firstChild.nodeValue;
      //����
      var ethnic = elementsXml[i].getElementsByTagName("ethnic")[0].firstChild.nodeValue;
      //��������
      var birthday = elementsXml[i].getElementsByTagName("birthday")[0].firstChild.nodeValue;
      //��ַ
      var address = elementsXml[i].getElementsByTagName("address")[0].firstChild.nodeValue;
      //֤������
      var card_no = elementsXml[i].getElementsByTagName("card_no")[0].firstChild.nodeValue;
      //�䷢����
      var issue_org = elementsXml[i].getElementsByTagName("issue_org")[0].firstChild.nodeValue;
      //�䷢����
      var issue_date = elementsXml[i].getElementsByTagName("issue_date")[0].firstChild.nodeValue;
      //��ʼ��Ч��
      var b_valid_date = elementsXml[i].getElementsByTagName("b_valid_date")[0].firstChild.nodeValue;
      //������Ч��
      var e_valid_date = elementsXml[i].getElementsByTagName("e_valid_date")[0].firstChild.nodeValue;
      //֤��ͷ��·��
      var iccid_path = elementsXml[i].getElementsByTagName("v_iccid_path")[0].firstChild.nodeValue;
      
      /*ͼƬ·����ֵ*/
      picpath_n = iccid_path;
      
      try{
				var iccidFilePath = "";
				var iccidfile ; 
				if(cardnum==1){
					iccidfile = fso.CreateTextFile(cre_dir + "\\hw_<%=hwAccept%>_str.txt",true); 
					iccidFilePath = cre_dir + "\\hw_<%=hwAccept%>_str.txt";
				}else if(cardnum==2){
					iccidfile = fso.CreateTextFile(cre_dir + "\\hw_<%=hwAccept%>_str2.txt",true); 
					iccidFilePath = cre_dir + "\\hw_<%=hwAccept%>_str2.txt";
				}
			  iccidfile.WriteLine(namea+"|"+card_no+"|"+address+"|"+birthday+"|"+sex+"|"+e_valid_date);		
					 
			  iccidfile.Close();
			}catch(e){
				alert("�����Ƕ�ȡ�������֤�쳣��");
			}
			rdShowMessageDialog("�����Ƕ�ȡ�������֤�ɹ���",2);
			/* gaopeng ��·����¼���� */
			if(cardnum==1){
				$("#firstId").val(picpath_n + "||" + iccidFilePath);
			}else if(cardnum==2){
				$("#secondId").val(picpath_n + "||" + iccidFilePath);
			}
		
		}
  	
  }
  
  /*2014/12/01 9:05:53 gaopeng ֤���ɼ�-�����ǰ�ť*/
  function photoCollect22(cardnum){
  
		/*ͼƬ·��*/
		var picpath_n ;
		
		//����
		window.showModalDialog("http://10.110.0.100:59000/workflow/camera/getCamera.jsp");
		//window.showModalDialog("http://10.110.13.52:8899/debug/crmDemo.html");
		//��ȡ�������Ľ������Զ������
		var authinfo = window.clipboardData.getData("text");
		alert("�����ļ���--------"+authinfo);
		authinfo = $.trim(authinfo);
		/*����ȫ·��*/
		authinfo = "c:/bmp/"+authinfo;
		var accInfoHid4 = $("#accInfoHid4").val();
		var infoArray = new Array();
		infoArray = accInfoHid4.split("|");
		/*û��ƴ��Ӱ��ͼƬ*/
		if(infoArray.length == 1){
				/*��һ��ͼƬ*/
				if(cardnum == 1){
					accInfoHid4  = infoArray[0]+"|"+authinfo+"|";
				}
				/*�ڶ���ͼƬƴ�ӵ�������ֵ��*/
				else if(cardnum == 2){
					accInfoHid4  = infoArray[0]+"||"+authinfo;
				}
		}
		else if(infoArray.length == 3){
				/*��һ��ͼƬ*/
				if(cardnum == 1){
					accInfoHid4 = infoArray[0]+"|"+authinfo+"|"+infoArray[2];
				}
				/*�ڶ���ͼƬƴ�ӵ�������ֵ��*/
				else if(cardnum == 2){
					accInfoHid4 = infoArray[0]+"|"+infoArray[1]+"|"+authinfo;
				}
		}
		
		$("#accInfoHid4").val(accInfoHid4);
		//alert($("#accInfoHid4").val());
  }
  var campicpath_n3="";
  var campicname3="";
  function photoCollect33(cardnum){
  
		/*ͼƬ·��*/
		var picpath_n ;
		
		//����
		window.showModalDialog("http://10.110.0.100:59000/workflow/camera/getCamera.jsp");
		//window.showModalDialog("http://10.110.13.52:8899/debug/crmDemo.html");
		//��ȡ�������Ľ������Զ������
		var authinfo = window.clipboardData.getData("text");
		authinfo = "20170301202249.jpg";
		alert("�����ļ���--------"+authinfo);
		authinfo = $.trim(authinfo);
		campicname3=authinfo;
		/*����ȫ·��*/
		authinfo = "C:/bmp/"+authinfo;
		//$("#accInfoHid3").val(authinfo);
		campicpath_n3=authinfo;
		
  }
		
	 
	 //��ͼƬ�ϴ������ݿ���
		function camsfztpsc3() {
			alert("<%=labelName%>");
			if("1993"=="<%=sopcode%>"&&"submitFlag3"=="<%=labelName%>"&&document.all.upbut_flag3.value=="0"){
				rdShowMessageDialog("�����ϴ����֤ͷ������ϴ����֤ͼ��!");
				return;
			}
		 
			if("1993"=="<%=sopcode%>"&&"submitFlag1"=="<%=labelName%>"){
		 		sfzhaoma = $("#gestoresIccId").val();
				sfznamess = $("#gestoresName").val();
				sfzleixing = $("#gestoresIdType").val().split("|")[0];
		 	}
			if("1993"=="<%=sopcode%>"&&"submitFlag2"=="<%=labelName%>"){
		 		sfzhaoma = $("#responsibleIccId").val();
				sfznamess = $("#responsibleName").val();
				sfzleixing = $("#responsibleType").val().split("|")[0];
		 	}
			if("1993"=="<%=sopcode%>"&&"submitFlag3"=="<%=labelName%>"){
		 		sfzhaoma = $("#realUserIccId").val();
				sfznamess = $("#realUserName").val();
				sfzleixing = $("#realUserIdType").val()+"|ռλ";
		 	}
		 	
			
			
			alert(sfzhaoma+"-"+sfznamess+"-"+sfzleixing);
			var v_custId = "";	
			if("<%=sopcode%>"=="1231" || "<%=sopcode%>"=="1230" || "<%=sopcode%>"=="1210" || "<%=sopcode%>"=="1234" || "<%=sopcode%>"=="1235"){
				v_custId = $("#cus_id").val();
			}else if("<%=sopcode%>"=="m058" || "<%=sopcode%>"=="1238"){
				v_custId = $("#new_cus_id").val();
			}else{ //opcode���ܰ�����ĸ���ִ�����������1211,1220���
				v_custId = "<%=sopcode%>";
			}
			window.open("/npage/public/camCardInfoSave.jsp?labelName=<%=labelName%>&idType="+sfzleixing+"&regionCode=<%=regionCode%>&workno=<%=workNo%>&name="+sfznamess+"&opcodes="+sfzcodess+"&picpath_n="+campicpath_n3+"&idIccid="+sfzhaoma,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-570) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
	 }
	
	function chcek_pic(num)//����
{

var pic_path = $("#SCFfile" + num).val();	
var d_num = pic_path.indexOf("\.");
var d_numname = pic_path.lastIndexOf("\\");
var file_type = pic_path.substring(d_num+1,pic_path.length);
var file_names = pic_path.substring(d_numname+1,pic_path.length);


if(file_type.toUpperCase()=="JPG" || file_type.toUpperCase()=="JPEG" || file_type.toUpperCase()=="BMP")
{ 

		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		var   fsss   =   fso.GetFile(pic_path);
		var fileSize = fsss.size; 
		var fileSizeKb = fileSize/1024;//ת��Ϊkb
		var filelujing="";
		var iccidfile ;
		if(parseFloat(fileSizeKb)>parseFloat(2048)){
		rdShowMessageDialog("������С���ܳ���2M���������ϴ���");
	  return ;		
		}
		
		
		if(!fso.FolderExists(cre_dir)) {	
			var newFolderName = fso.CreateFolder(cre_dir);  			
		}

		filelujing=cre_dir+"\\"+file_names;
		
		fsss.Copy(filelujing);
		//alert(num); 
		if(num != 4){
			$("#accInfoHid" + num).val(filelujing);
		}
		if(num == 4){
			//alert(611);
			var accInfoHid4 =  $("#accInfoHid4").val();
			var infoArray = new Array();
			infoArray = accInfoHid4.split("|");
			//alert(infoArray.length);
			/*��ûƴ��ͼƬ��Ϣ��*/
			if(infoArray.length == 1){
				$("#accInfoHid4").val(filelujing);
			}
			/*ƴ���˾���Ҫ������װ*/
			else if(infoArray.length != 1){
				$("#accInfoHid4").val(filelujing+"|"+infoArray[1]+"|"+infoArray[2]);
			}
		}
		
	}
else {
		rdShowMessageDialog("��ѡ��jpg��jpeg��bmp�����ļ�");
		document.getElementById("SCFfile"+num).outerHTML =document.getElementById("SCFfile"+num).outerHTML;
	  return ;
}

			
	}
	/*wanghyd20130926�����°����ɨ�����*/
	
	var picpath_n2new = "";
	var picpath_bei2new = "";
	
	function readByMultiss(str){
			//ɨ��������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	if(ret_open==0){
		var cardType="";
			if(str==1 || str==11) {
					cardType = document.getElementById("card_type11").value ;	
			}
			if(str==2 || str==22) {
					cardType = document.getElementById("card_type22").value ;	
			}
		
		if(cardType==11){
			//�๦���豸RFID��ȡ
			sfznamess="";
			sfzcodess="";
			sfzIDaddressss="";
			sfzbir_dayss="";
			sfzsexss="";
			sfzidValidDate_objss="";
			sfzpicturespathss="";
			sfzhaoma="";
			sfzleixing="";
			sfzminzu="";
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_<%=hwAccept%>"+str+".jpg");
			if(ret_getImageMsg==0){

				//����֤������ϳ�
				var xm =CardReader_CMCC.MutiIdCardName;;//"����";//
				var xb =CardReader_CMCC.MutiIdCardSex;//"1";//
				var mz =CardReader_CMCC.MutiIdCardPeople;//"��";//
				var cs =CardReader_CMCC.MutiIdCardBirthday;//"1985.01.01";//
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;//"1992.01.01-2020.01.01";//
				var yxks=CardReader_CMCC.MutiIdCardSigndate;//"1992.01.01";//��Ч��ʼʱ��
				var yxqx=CardReader_CMCC.MutiIdCardValidterm;//"2020.01.01";//֤����Ч��
				var zz =CardReader_CMCC.MutiIdCardAddress;//"������ʡ��������";//
				var qfjg =CardReader_CMCC.MutiIdCardOrgans;//"������ʡ�������й����־�";////ǩ������
				var zjhm =CardReader_CMCC.MutiIdCardNumber;//"230102198501010512";////֤������
				var base64 =CardReader_CMCC.MutiIdCardPhoto;
				var mblj=cre_dir+"cert_model.bmp";
				var sclj=cre_dir+"cert_<%=hwAccept%>_pic.jpg";
				
				
				sfznamess=xm;
				sfzcodess="<%=sopcode%>";
				sfzIDaddressss=zz;
				sfzbir_dayss=cs;
				sfzsexss=xb;
				sfzidValidDate_objss=yxqx;
				sfzpicturespathss="";
				sfzhaoma=zjhm;
				sfzminzu=mz;
				//var ret_cardEmerg=CardReader_CMCC.CardEmerg(xm,xb,mz,cs,yx,zz,qfjg,zjhm,base64,mblj,sclj);			
						try{
							var iccidfile ; 
							iccidfile = fso.CreateTextFile(cre_dir + "\\hw_<%=hwAccept%>_str"+str+".txt",true);
							iccidfile.WriteLine(xm+"|"+zjhm+"|"+zz+"|"+cs+"|"+xb+"|"+yx);			  
					    iccidfile.Close();
					    rdShowMessageDialog("ɨ��ɹ���",2);
					  	}catch(e){
						 alert("��ȡ�������֤�쳣��");
					}
					
							var picpath_n ;
							var picpath_n2 ;
							if(str==1 || str==11) {
							picpath_n = cre_dir+"\\cert_head_<%=hwAccept%>"+str+".jpg";
							$("#firstId").val(picpath_n + "||" + cre_dir+"\\hw_<%=hwAccept%>_str"+str+".txt");
							}
							if(str==2 || str==22) {
							picpath_n2 = cre_dir+"\\cert_head_<%=hwAccept%>"+str+".jpg";
							$("#secondId").val(picpath_n2 + "||" + cre_dir+"\\hw_<%=hwAccept%>_str"+str+".txt");
							}
							
			}else{
					rdShowMessageDialog("��ȡ��Ϣʧ��");
					return ;
			}
		}else{
			//�๦���豸OCR��ȡ
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_<%=hwAccept%>"+str+".jpg");
			
				if(str==1){
					picpath_n2new="";
					picpath_n2new = "c:\\custID\\cert_<%=hwAccept%>1.jpg";
				}else if(str==2){
					picpath_n2new="";
					picpath_n2new = "c:\\custID\\cert_<%=hwAccept%>2.jpg";
				}else if(str==11) {
					picpath_bei2new="";
					picpath_bei2new = "c:\\custID\\cert_<%=hwAccept%>11.jpg";
				}
				else if(str==22){
					picpath_bei2new="";
					picpath_bei2new = "c:\\custID\\cert_<%=hwAccept%>22.jpg";
				}
								
					rdShowMessageDialog("ɨ��ɹ���",2);
					if(str==1){
						$("#firstId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==2){
						$("#secondId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==11) {
						$("#firstId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==22) {
						$("#secondId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}	

		}
	}else{
					rdShowMessageDialog("���豸ʧ��");
					return ;
	}
	//�ر��豸
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
							rdShowMessageDialog("�ر��豸ʧ��");
					return ;
	}
	
}



	function returnSubState(labelName,result){
		alert(labelName+"------"+result);
		$("#"+labelName).val(result);
	}
</script>

<script type='text/javascript'>
	/*2014/12/01 14:33:13 gaopeng ����loadXML����*/
    loadXML = function(xmlString){
        var xmlDoc=null;
        //�ж������������
        //֧��IE����� 
        if(!window.DOMParser && window.ActiveXObject){   //window.DOMParser �ж��Ƿ��Ƿ�ie�����
            var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
            for(var i=0;i<xmlDomVersions.length;i++){
                try{
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString); //loadXML��������xml�ַ���
                    break;
                }catch(e){
                }
            }
        }
        //֧��Mozilla�����
        else if(window.DOMParser && document.implementation && document.implementation.createDocument){
            try{
                /* DOMParser ������� XML �ı�������һ�� XML Document ����
                 * Ҫʹ�� DOMParser��ʹ�ò��������Ĺ��캯����ʵ��������Ȼ������� parseFromString() ����
                 * parseFromString(text, contentType) ����text:Ҫ������ XML ��� ����contentType�ı�����������
                 * ������ "text/xml" ��"application/xml" �� "application/xhtml+xml" �е�һ����ע�⣬��֧�� "text/html"��
                 */
                domParser = new  DOMParser();
                xmlDoc = domParser.parseFromString(xmlString, 'text/xml');
            }catch(e){
            }
        }
        else{
            return null;
        }

        return xmlDoc;
    }
</script>


<script language=javascript>
	//�ж��豸����
	var fso = new ActiveXObject("Scripting.FileSystemObject");
	if(!fso.FileExists("C:/WINDOWS/system32/CMCC_IDCard.dll")){
		//document.getElementById('bReadByCardReader').disabled = false;
		//document.getElementById('trCardReader').style.display='none';
		//document.getElementById('PROMPTMSG').innerHTML = "�豸״̬";
	}
	if(!fso.FileExists("C:/WINDOWS/system32/MutiIdCard.dll")){ 
		//document.getElementById('readByMultisss1').disabled = false;
		document.getElementById('readByMultisss1').disabled = true;
		document.getElementById('readByMultisss2').disabled = true;
		document.getElementById('readByMultisss1s').disabled = true;
		document.getElementById('readByMultisss2s').disabled = true;		
		//document.getElementById('readByMultisss1').style.display='none';
		//document.getElementById('PROMPTMSG').innerHTML = "�豸״̬";
	}
</script>