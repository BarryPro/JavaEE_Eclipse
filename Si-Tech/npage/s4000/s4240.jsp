<%
/*
* ����: 
* �汾: 1.0
* ����: liangyl 2017/05/03 liangyl ����ȫ��ָ�ʡ�ʿ������������֪ͨ
* ����: liangyl
* ��Ȩ: si-tech
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
			String opCode = (String)request.getParameter("opCode");		
			String opName = (String)request.getParameter("opName");
			
	    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	    String[][] baseInfoSession = (String[][])arrSession.get(0);
	    String[][] otherInfoSession = (String[][])arrSession.get(2);
	    String[][] pass = (String[][])arrSession.get(4);
	    
	    String loginNo = baseInfoSession[0][2];
	    String loginName = baseInfoSession[0][3];
	    String powerCode= otherInfoSession[0][4];
	    String orgCode = baseInfoSession[0][16];
	    String ip_Addr = request.getRemoteAddr();
	    
	    String regionCode = orgCode.substring(0,2);
	    String regionName = otherInfoSession[0][5];
	    String loginNoPass = pass[0][0];
	    
	    String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
	    String workNo =(String)session.getAttribute("workNo");
		  String groupId =(String)session.getAttribute("groupId");
		  
		  %>
		  <!-- �ж��Ƿ�������֤У�� -->
		  <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="sfzretCode" retmsg="sfzretMsg">
			<wtc:param value="select trim(login_no)  from shighlogin where op_code = 'g412'"/>
		</wtc:service>
		<wtc:array id="sfzresult" scope="end"/>
		  <%
		  boolean renzhengShow=false;
		  if("Y".equals(sfzresult[0][0])){
			  renzhengShow=true;
		  }
		  else{
			  renzhengShow=false;
		  }
		  renzhengShow=false;
		  
		 
	//���й���Ȩ�޼���

		 String loginAccept = "";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode"  routerValue="<%=regionCode%>"  id="sLoginAccept" />
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode"  routerValue="<%=regionCode%>"  id="v_printAccept" />
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%
		loginAccept = sLoginAccept;

	List al = null;

	String[][] provData = new String[][]{};
	
	String totalDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	String monthDate = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
	String dayDate = new java.text.SimpleDateFormat("dd").format(new java.util.Date());
	
	int		isGetDataFlag = 0;	//0:��ȷ,��������. add by yl.
	String errorMsg ="";	
	StringBuffer  insql = new StringBuffer();
	
dataLabel:
	while(1==1){	
	
	//1.SQL ֤������
	insql.delete(0,insql.length());
	insql.append("select substr(node_code,0,3),node_name  from oneboss.sobexchgnode  where node_code<>'0000' order by node_code");
	String sql = insql.toString();
		%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sql%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
		<%
				System.out.println("�������� ------------------------------>"+result.length);
		if( result == null ){
			isGetDataFlag = 2;
			break dataLabel;
		}		
		provData = result;
		isGetDataFlag = 0;
		break;	

	 }
	 	 errorMsg = "ȡ���ݴ���:"+Integer.toString(isGetDataFlag);	    
	 System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	rdShowMessageDialog("<%=errorMsg%>");
//-->
</script>
<%}%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���д������</title>


<script language="JavaScript">
	//����Ӧ��ȫ�ֵı���
	var SUCC_CODE	= "0";   		  //�Լ�Ӧ�ó�����
	var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
	var YE_SUCC_CODE = "0000";	//����Ӫҵϵͳ������޸�
    var v_printAccept="<%=v_printAccept%>";

	onload=function()
	{		
		//document.frm.tmpBusyAccept.value='123';
				//document.frm.loginAccept.value='123';
				//document.frm.custName.value='����1';
				//document.frm.vipNo.value='vip1';
				//document.frm.confirm.disabled = false;
		init();

	}

		
	function init()
	{	  		  
		$("#test").hide();
<%
	
		String power_right = (String)session.getAttribute("power_code");
		String test_sql="select a.oregtype from oneboss.DOBTRANSREGMSG a,oneboss.sobopercode b where a.bipcode=b.oper_code and b.function_code='4240' and b.oper_code='BIP2B006'";
		
%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=test_sql%>"/>
		</wtc:service>
		<wtc:array id="result11" scope="end"/>
			<%
			System.out.println("gaopenggaopenggaopeng~~~~~~~~~~~~~~~~~~~~~"+result11.length+"----"+result11[0][0]);
		if(result11.length>0){
		   if(result11[0][0].equals("11")) {
		   System.out.println("gaopenggaopenggaopeng~~~~~~~~~~~~~~~~~~~~~"+"--------------zheli");
			if(power_right!=null&&power_right.trim().equals("3")){
%>
				$("#test").hide();
				document.all("test_flag").length=2;
				document.all("test_flag").options[0].text="��ʽ";
				document.all("test_flag").options[0].value="0";
				document.all("test_flag").options[1].text="����";
				document.all("test_flag").options[1].value="1";
<%
			}
			
			else{
%>
				$("#test").hide();
				//$("#test_flag").append("<option value='0'>��ʽ</option>");
				document.frm.test_flag.length=1;
				document.frm.test_flag.options[0].text="��ʽ";
				document.frm.test_flag.options[0].value="0";
<%			
			
			}
			}
		}
%>	  	
	//	document.frm.confirm.disabled = true;		
		//document.frm.confirm.disabled = false;		
	//	document.frm.phoneNo.focus();		
	}
			
	//---------1------RPC������------------------
	function go_call_noCheck(){
 		var sqlBuf="";
		//������ݵĺϷ���
	 	
	 	if(!checkElement(document.getElementById("phoneNo"))){ 
	 		return false;
	 	}
	 	
	 	if( (document.frm.custPWD.value == "" )
	 		&& (document.frm.cardID.value == "" )
	 	  ){
	 	  	rdShowMessageDialog("��������'�ͻ�����'����'֤������'�е�һ����");
	 	  	return false;	 	  
	 	  }
	 	
	 	if( document.frm.custPWD.value != "" ){
	 		if(!checkElement(document.getElementById("custPWD"))) return false;
	 	}  
	 	if( document.frm.cardID.value != "" ){
			if(document.frm.cardType.value=="00"){
			document.frm.cardID.v_type="";
			}
			else{
			document.frm.cardID.v_type="";
			}
	 		if(!checkElement(document.getElementById("cardID"))) return false;
	 	} 
		//alert("׼������ajax����");
			var myPacket = new AJAXPacket("s4240_rpc_id.jsp","����ȷ�ϣ����Ժ�......");
			myPacket.data.add("verifyType","phoneno");
			myPacket.data.add("loginNo",document.all.loginNo.value);
			myPacket.data.add("orgCode",document.all.orgCode.value);
			myPacket.data.add("opCode","4150");
			myPacket.data.add("idType",document.all.IDType.value);
			myPacket.data.add("idValue",document.all.phoneNo.value);
			myPacket.data.add("CCPasswd",document.all.custPWD.value);
			myPacket.data.add("cardType",document.all.cardType.value);
			myPacket.data.add("cardID",document.all.cardID.value);
			myPacket.data.add("typeIDs","0");//��ѯ����
			core.ajax.sendPacket(myPacket,do_call_noCheck);
			//alert("end");
      myPacket = null;
	}
	//�û�״̬����
	var name119s=new Array();
	name119s["00"]="����";
	name119s["01"]="����ͣ��";
	name119s["02"]="ͣ��";
	name119s["03"]="Ԥ����";
	name119s["04"]="����";
	name119s["05"]="����";
	name119s["06"]="�ĺ�";
	name119s["07"]="Я��ת��";
	name119s["90"]="�������û�";
	name119s["99"]="�˺��벻����";
	//�û��Ǽ�����
	var name127s=new Array();
	name127s["00"]="׼��";
	name127s["01"]="һ��";
	name127s["02"]="����";
	name127s["03"]="����";
	name127s["04"]="����";
	name127s["05"]="����";
	name127s["06"]="���ǽ�";
	name127s["07"]="������";
	name127s["09"]="δ����";
	
	function do_call_noCheck(packet){
		//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
		var error_code = packet.data.findValueByName("errorCode");
		//alert(error_code);
		var error_msg =  packet.data.findValueByName("errorMsg");
		//alert(error_msg);
		var verifyType = packet.data.findValueByName("verifyType");
		//alert(verifyType);
		if(verifyType=="phoneno"){
			if( error_code=="000000" ){
				var resultmsg1 = packet.data.findValueByName("resultmsg1");
				var resultmsg2 = packet.data.findValueByName("resultmsg2");
				var resultmsg3 = packet.data.findValueByName("resultmsg3");
				var resultmsg4 = packet.data.findValueByName("resultmsg4");
				if(resultmsg1.length>0){
					$("#retrspCode").val(resultmsg1[0][0]);
					$("#retrspDesc").val(resultmsg1[0][1]);
					$("#retSessionID").val(resultmsg1[0][2]);
					$("#retTransIDO").val(resultmsg1[0][3]);
					$("#retTransIDH").val(resultmsg1[0][4]);
					$("#retIDType").val(resultmsg1[0][5]);
					$("#retIDValue").val(resultmsg1[0][6]);
					$("#retoprResult").val(resultmsg1[0][7]);
					$("#retResultDesc").val(resultmsg1[0][8]);
					
					for(var i=0;i<resultmsg2.length;i++){
						if(resultmsg2[i]=="119"){
							$("#retValue"+resultmsg2[i]).val(name119s[resultmsg3[i]]);
						}
						else if(resultmsg2[i]=="127"){
							$("#retValue"+resultmsg2[i]).val(name127s[resultmsg3[i]]);
						}
						else{
							
							$("#retValue"+resultmsg2[i]).val(resultmsg3[i]);
						}
					//	alert(resultmsg2[i]+"--"+resultmsg3[i]);
					}
					$("#yjFee").val(resultmsg4[0][0]);
					$("#ycFee").val(resultmsg4[0][1]);
					$("tr[id='sanzhangTr']").show();
					rdShowMessageDialog("��Ȩ�ɹ��������Ƭ������",1);
				}
			}else{
				$("tr[id='sanzhangTr']").hide();
				$("#b_write").attr("disabled","disabled");
				rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]");
				return false;
			}	
		}					
	}
	

	function resetJsp()
	{
	 with(document.frm)
	 {

		phoneNo.value	= "";
		custPWD.value	= "";
		cardID.value	= "";
		loginAccept.value= "";

	 }
	 
		init();	
			
	}
			
	function Idcard_realUser(){
		//��ȡ�������֤
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime1();
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		var tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		//�ж��ļ����Ƿ���ڣ��������򴴽�Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		var picpath_n = cre_dir +"\\"+picName +".jpg";
		
		var result;
		var result2;
		var result3;
	
		result=IdrControl1.InitComm("1001");
		if (result==1)
		{
			result2=IdrControl1.Authenticate();
			if ( result2>0)
			{              
				result3=IdrControl1.ReadBaseMsgP(picpath_n); 
				if (result3>0){
					$("#pic_nameT").val(picpath_n);
			  var name = IdrControl1.GetName();
				var code =  IdrControl1.GetCode();
				var sex = IdrControl1.GetSex();
				var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
				var IDaddress  =  IdrControl1.GetAddress();
				var idValidDate_obj = IdrControl1.GetValid();
				
				document.all.userName.value =name;//����
				document.all.cardID.value =code;//���֤��
				document.all.userAddr.value =IDaddress;//���֤��ַ
				document.all.idSexHT.value =sex;//�Ա�
				document.all.birthDayHT.value =bir_day;//����
				$("#zhengjianYXQT").val(idValidDate_obj);
				document.all.but_flagT.value="1";
				document.all.up_flagT.value="0";
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
	
	function getCuTime1(){
		 var curr_time = new Date(); 
		 with(curr_time) 
		 { 
		 var strDate = getYear()+"-"; 
		 strDate +=getMonth()+1+"-"; 
		 strDate +=getDate()+""; //ȡ��ǰ���ڣ�������ġ��ա��ֱ�ʶ 
		 strDate +=getHours()+"-"; //ȡ��ǰСʱ 
		 strDate +=getMinutes()+"-"; //ȡ��ǰ���� 
		 strDate +=getSeconds(); //ȡ��ǰ���� 
		 return strDate; //������ 
		 } 
		}
	
	function Idcard2(){
		var str="22";
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
	var cardType ="11";
	if(ret_open==0){
		//alert(v_printAccept+"--"+str);
			//�๦���豸RFID��ȡ
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");
			try{
				document.all.pic_nameT.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
				document.all.but_flagT.value="1";
				document.all.up_flagT.value="0";
			}catch(e){
					
			}
			//alert(ret_getImageMsg);
			//ret_getImageMsg = "0";
			if(ret_getImageMsg==0){
				//����֤������ϳ�
				var xm =CardReader_CMCC.MutiIdCardName;					
				var xb =CardReader_CMCC.MutiIdCardSex;
				var mz =CardReader_CMCC.MutiIdCardPeople;
				var cs =CardReader_CMCC.MutiIdCardBirthday;
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
				var yxqx = CardReader_CMCC.MutiIdCardValidterm;//֤����Ч��
				var zz =CardReader_CMCC.MutiIdCardAddress; //סַ
				var qfjg =CardReader_CMCC.MutiIdCardOrgans; //ǩ������
				var zjhm =CardReader_CMCC.MutiIdCardNumber; //֤������
				var base64 =CardReader_CMCC.MutiIdCardPhoto;
				var v_validDates = "";
				if(yxqx.indexOf("\.") != -1){
					yxqx = yxqx.split(".");
					if(yxqx.length >= 3){
						v_validDates = yxqx[0]+yxqx[1]+yxqx[2]; 
					}else{
						v_validDates = "21000101";
					}
				}else{
					v_validDates = "21000101";
				}
				document.all.userName.value =xm;//����
				document.all.cardID.value =zjhm;//���֤��
				document.all.userAddr.value =zz;//���֤��ַ
				document.all.idSexHT.value =xb;//�Ա�
				document.all.birthDayHT.value =cs;//����
				$("#zhengjianYXQT").val(yxqx)
			}else{
					rdShowMessageDialog("��ȡ��Ϣʧ��");
					return ;
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
	
	function chcek_picT(){
		var pic_path = document.all.filepT.value;
		var d_num = pic_path.indexOf("\.");
		var file_type = pic_path.substring(d_num+1,pic_path.length);
		//�ж��Ƿ�Ϊjpg���� //�����豸����ͼƬ�̶�Ϊjpg����
		if(file_type.toUpperCase()!="JPG"){ 
			rdShowMessageDialog("��ѡ��jpg����ͼ���ļ�");
			document.all.up_flagT.value=3;
			resetfilpT();
			return ;
		}
		
		var pic_path_flag= document.all.pic_nameT.value; 
		
		if(pic_path_flag==""){
			rdShowMessageDialog("����ɨ����ȡ֤����Ϣ");
			document.all.up_flagT.value=4;
			resetfilpT();
			return;
		}
		else{
			if(pic_path!=pic_path_flag){
				rdShowMessageDialog("��ѡ�����һ��ɨ����ȡ֤�������ɵ�֤��ͼ���ļ�"+pic_path_flag);
				document.all.up_flagT.value=5;
				resetfilpT();
				return;
			}
		}
		document.all.up_flagT.value=1;
	}
	function resetfilpT(){//����֤
		document.getElementById("filepT").outerHTML = document.getElementById("filepT").outerHTML;
	}
	
	var simCardNumber="";
	var simtypess="";
	function readcardss() {
		//document.all.b_write.disabled=false;
  		 simtypess="";
  		 /****���������ƹ���ȡSIM������****/
  		 /* 
        * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
        */
     //   path ="http://10.110.0.100:33000/OPSWriteCard/writecard/ReadCardInfo.jsp";
  		 path ="http://10.110.26.27:33000/OPSWriteCard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("<%=request.getContextPath()%>/npage/sg529/Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
  		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("�������ͳ���!");

    		return false;   
    	 }
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("�������ͳ���!");
    		return false ;	
    	} 
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();   
    	for(i=0;i<4;i++)
    	{   	   
    		var chPos = retInfo1.indexOf("&");
        	valueStr = retInfo1.substring(0,chPos);
        	var chPos1 = valueStr.indexOf("=");
        	valueStr1 = valueStr.substring(chPos1+1);
        	retInfo1 = retInfo1.substring(chPos+1);
        	retVal[i]=valueStr1;
    	}
    	
    	if(retVal[0]=="0")
    	{
    		var rescode_str=retVal[2]+"|";
    		var rescode_strstr="";
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("�������ͳ���!");
    		 		  return false;
        		}
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        		}
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("�������ͳ���!");

    		 	return false;   
    		}
    		
  		}
  		else{
  			 rdShowMessageDialog("�������ͳ���!");

    		 return false;   
    	}
    	simCardNumber = retVal[1];
    	simtypess=rescode_strstr.substr(1,rescode_strstr.length-2);
    	if($("#simFee").val()==""){
			$("#simFee").val("0");
		}
    	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
    	
    	
    }
function writechg(obj){
	<%if(renzhengShow){%>
		if($("#submitFlagC").val()=="0"){
			rdShowMessageDialog("���Ƚ�����֤У����ٽ����ύ��");
	 	  	return false;
		}
	<%}%>
	readcardss();
	
	
	
}

function go_wrtirCardBefort(){
	var myPacket = new AJAXPacket("s4240_writecardbefore.jsp","���ڽ���д��ǰ���������Ժ�......"); 
	myPacket.data.add("loginNo",document.all.loginNo.value);
	myPacket.data.add("orgCode",document.all.orgCode.value);
	myPacket.data.add("idValue",document.all.phoneNo.value);
	myPacket.data.add("seq",document.all.breakSeq.value);
	myPacket.data.add("cardSN",simCardNumber);
	myPacket.data.add("ICCID","");
	myPacket.data.add("name","");
	myPacket.data.add("value","");
	core.ajax.sendPacket(myPacket,do_wrtirCardBefort);
	myPacket = null;
}
var writesimcode = "";
var writesimno = "";
var writecardstatus = "";
var writecardNo = "";
var writecardKi = "";
var writecardOpc = "";

function do_wrtirCardBefort(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	if(retCode=="000000"){
		var resultmsg = packet.data.findValueByName("resultmsg");
		$("#brspCode").val(resultmsg[0][0]);//Ӧ�����
		$("#brspDesc").val(resultmsg[0][1]);//Ӧ������
		$("#bSessionID").val(resultmsg[0][2]);//ҵ����ˮ
		$("#bTransIDO").val(resultmsg[0][3]);//������ˮ
		$("#bTransIDH").val(resultmsg[0][4]);//��ط�������ˮ��
		$("#bseq").val(resultmsg[0][5]);//���β�����ˮ��
		$("#bMobileNum").val(resultmsg[0][6]);//�ֻ�����
		$("#boprResult").val(resultmsg[0][7]);//ҵ������Ľ��
		$("#bIMSI").val(resultmsg[0][8]);//IMSI
		$("#bICCID").val(resultmsg[0][9]);//ICCID
		$("#bSMSP").val(resultmsg[0][10]);//SMSP
		$("#bPIN1").val(resultmsg[0][11]);//PIN1
		$("#bPIN2").val(resultmsg[0][12]);//PIN2
		$("#bPUK1").val(resultmsg[0][13]);//PUK1
		$("#bPUK2").val(resultmsg[0][14]);//PUK2
		$("#bHomeProv").val(resultmsg[0][17]);//�ú���Ĺ���ʡʡ����  ����ʡ����ѡ��K2�Ĺ�Կ����K��OPc���м���
		
		var simtypes=simtypess;
		var simnos=document.all.bICCID.value;
		var phonenos=document.all.bMobileNum.value;
		var simimsi=document.all.bIMSI.value;
		var simsmsp=document.all.bSMSP.value;
		
		var simpin1=document.all.bPIN1.value;
		var simpin2=document.all.bPIN2.value;
		var simpuk1=document.all.bPUK1.value;
		var simpuk2=document.all.bPUK2.value;
		var simhomeprov=document.all.bHomeProv.value;
		
	    var path = "s4240_writecard.jsp";
	    path = path + "?regioncode=" + "<%=regionCode%>";
	    path = path + "&sim_type=" +simtypes;
	    path = path + "&sim_no=" +simnos;
	    path = path + "&op_code=" +"<%=opCode%>";
	    path = path + "&phone="+phonenos+"&pageTitle=" + "д��";
	    path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; 
	    path = path + "&simCardNumber="+simCardNumber;
	    path = path + "&simimsi="+simimsi;
	    path = path + "&simsmsp="+simsmsp;
	    path = path + "&simpin1="+simpin1;
	    path = path + "&simpin2="+simpin2;
	    path = path + "&simpuk1="+simpuk1;
	    path = path + "&simpuk2="+simpuk2;
	    path = path + "&simhomeprov="+simhomeprov;
	    
	    var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
	    if(typeof(retInfo) == "undefined"){	
	    	rdShowMessageDialog("д��ʧ��",0);
	    	return false;
	    } 
	    writesimcode=oneTok(oneTok(retInfo,"|",1));
	    writesimno=oneTok(oneTok(retInfo,"|",2));
	    writecardstatus=oneTok(oneTok(retInfo,"|",3));
	    writecardNo=oneTok(oneTok(retInfo,"|",4));
	    writecardKi=oneTok(oneTok(retInfo,"|",5));
	    writecardOpc=oneTok(oneTok(retInfo,"|",6));
	    if(writesimcode=="0"){
			go_wrtirCardAfter();
	    }else{
	      rdShowMessageDialog("д��ʧ��,0");
	      return false;
	    }
	}
	else{
		rdShowMessageDialog("<br>�������:["+retCode+"]</br>������Ϣ:["+retMsg+"]",0);
		rdShowMessageDialog("д��ʧ��",0);
		return false;
	}
}

function go_wrtirCardAfter(){
	var myPacket = new AJAXPacket("s4240_writecardafter.jsp","���ڽ���д������������Ժ�......"); 
	myPacket.data.add("loginNo",document.all.loginNo.value);
	myPacket.data.add("orgCode",document.all.orgCode.value);
	myPacket.data.add("idValue",document.all.phoneNo.value);
	myPacket.data.add("seq",document.all.breakSeq.value);
	myPacket.data.add("myseq","<%=printAccept%>");
	myPacket.data.add("IMSI",document.all.bIMSI.value);
	myPacket.data.add("writeresult",writesimcode);
	myPacket.data.add("encK",writecardKi);
	myPacket.data.add("encOpc",writecardOpc);
	myPacket.data.add("signature","");
	myPacket.data.add("localProvCode","451");
	myPacket.data.add("bHomeProv",document.all.bHomeProv.value);
	myPacket.data.add("serviceFee","0");
	myPacket.data.add("simFee",$("#simFee").val());
	myPacket.data.add("simCardNumber",simCardNumber);
	myPacket.data.add("bICCID",$("#bICCID").val());
	core.ajax.sendPacket(myPacket,do_wrtirCardAfter);
	myPacket = null;
}
function do_wrtirCardAfter(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	if(retCode=="000000"){
		rdShowMessageDialog("д���ɹ���",1);
		$("#b_write").attr("disabled","disabled");
		g412_show_Bill_Prt();
		return false;
	}
	else{
		rdShowMessageDialog("д��ʧ�ܣ�",0);
		$("#b_write").attr("disabled","");
		rdShowMessageDialog("<br>�������:["+retCode+"]</br>������Ϣ:["+retMsg+"]",0);
		return false;
	}
}

function showPrtDlg(printType,DlgMessage,submitCfm){
	//��ʾ��ӡ�Ի���
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var printStr = printInfo(printType);
	
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var sysAccept = "<%=printAccept%>";
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.all.phoneNo.value+"&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm")&&(submitCfm == "Yes"))
		{
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			{
				go_wrtirCardBefort();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ<%=opName%>��Ϣ��')==1)
			{
				go_wrtirCardBefort();
			}
		}
	}
	else{
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ<%=opName%>��Ϣ��')==1)
		{
			go_wrtirCardBefort();
		}
	}
}

function printInfo(printType){
 var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";

	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.retValue101.value+"|";

	opr_info+="����ҵ��:��ص���д��"+"|";
	opr_info+="���������:"+document.all.retValue126.value+"|";
	opr_info+="������ˮ��<%=printAccept%>|";
//	opr_info+="ԭSIM���ţ�"+""+"  ԭSIM�����ͣ�"+""+"|";
	opr_info+="��SIM���ţ�"+simCardNumber+"  ��SIM�����ͣ�"+simtypess+"|";

	note_info1="��ע��"+"|";
	var retValue127 = $("#retValue127").val();
	if(retValue127="׼��"||retValue127=="һ��"||retValue127=="����"||retValue127=="δ����"){
		note_info1+="�𾴵�����/Ůʿ����ӭ����������������������ֻ�SIM������<%=monthDate%>��<%=dayDate%>�����й��ƶ���������˾���¼���벦�����ֻ�����ʡ��10086����ȷ�� ��|";
	}
	else if(retValue127="����"||retValue127=="����"||retValue127=="����"||retValue127=="���ǽ�"||retValue127=="������"){
		note_info1+="�𾴵�����/Ůʿ����ӭ����������������������ֻ�SIM������<%=monthDate%>��<%=dayDate%>�����й��ƶ���������˾���¼�������ڵ��Ǽ���"+retValue127+"�����벦�����ֻ�����ʡ��10086����ȷ�� ��|";
	}
	
	
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
   return retInfo;
}

//��ӡ��Ʊ
function g412_show_Bill_Prt(){
		var  billArgsObj = new Object();
		var public_opCode = "<%=opCode%>";
		$(billArgsObj).attr("10001","<%=loginNo%>");     //����
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",document.all.retValue101.value);   //�ͻ�����
		$(billArgsObj).attr("10006","��ص���д������");    //ҵ�����
		
		$(billArgsObj).attr("10008",document.all.phoneNo.value);    //�û�����
		$(billArgsObj).attr("10015", $("#simFee").val());   //���η�Ʊ���
		$(billArgsObj).attr("10016", $("#simFee").val());   //��д���ϼ�
		$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
		/*10028 10029 ����ӡ*/
		$(billArgsObj).attr("10028","");//�����Ӫ������ƣ�
		$(billArgsObj).attr("10029","");//Ӫ������	
		$(billArgsObj).attr("10030","<%=printAccept%>");   //��ˮ�ţ�--ҵ����ˮ
		$(billArgsObj).attr("10036","g412");   //��������
			/**/
			/*�ͺŲ���*/
		$(billArgsObj).attr("10061","");	       //�ͺ�
		$(billArgsObj).attr("10062","");	//˰��
		$(billArgsObj).attr("10063","");	//˰��	   
	    $(billArgsObj).attr("10071","6");	//
 		$(billArgsObj).attr("10076", $("#simFee").val());
			
		$(billArgsObj).attr("10083", "���֤"); //֤������
		$(billArgsObj).attr("10084", document.all.cardID.value); //֤������
		$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
		$(billArgsObj).attr("10065", ""); //����˺�
		$(billArgsObj).attr("10087", ""); //imei����
 			 

		$(billArgsObj).attr("10041", "");           //Ʒ�����
		$(billArgsObj).attr("10042","��");                   //��λ
		$(billArgsObj).attr("10043","1");	                   //����
		$(billArgsObj).attr("10044",$("#simFee").val());	                //����
			
			 			
		$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
		$(billArgsObj).attr("10072","1"); //1--������Ʊ  2--�����෢Ʊ  2--�˷��෢Ʊ

		$(billArgsObj).attr("10088",public_opCode); //�վ�ģ��
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
					//��Ʊ��Ŀ�޸�Ϊ��·��
		//$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
		var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
		var loginAccept = "<%=loginAccept%>";
		var path = path +"&loginAccept="+loginAccept+"&opCode="+public_opCode+"&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
		parent.removeTab("g412");
}
</script>

</head>
		<form method="post" name="frm" id="frm">
		<input type="hidden" id="retrspCode" name="retrspCode" value=""/><!-- Ӧ����� -->
		<input type="hidden" id="retrspDesc" name="retrspDesc" value=""/><!-- Ӧ������ -->
		<input type="hidden" id="retSessionID" name="retSessionID" value=""/><!-- ҵ����ˮ -->
		<input type="hidden" id="retTransIDO" name="retTransIDO" value=""/><!-- ������ˮ -->
		<input type="hidden" id="retTransIDH" name="retTransIDH" value=""/><!-- ��ط�������ˮ�� -->
		<input type="hidden" id="retIDType" name="retIDType" value=""/><!-- ��ʶ���� -->
		<input type="hidden" id="retIDValue" name="retIDValue" value=""/><!-- ��ʶ���� -->
		<input type="hidden" id="retoprResult" name="retoprResult" value=""/><!-- ҵ������Ľ�� -->
		<input type="hidden" id="retResultDesc" name="retResultDesc" value=""/><!-- �������� -->
		<input type="hidden" id="retValue100" name="retValue100" value=""/><!-- �ͻ���־ -->
		<input type="hidden" id="retValue103" name="retValue103" value=""/><!-- ֤������ -->
		<input type="hidden" id="retValue104" name="retValue104" value=""/><!-- ֤������ -->
		<br/>
		<input type="hidden" id="brspCode" name="brspCode" value=""/><!-- Ӧ����� -->
		<input type="hidden" id="brspDesc" name="brspDesc" value=""/><!-- Ӧ������ -->
		<input type="hidden" id="bSessionID" name="bSessionID" value=""/><!-- ҵ����ˮ -->
		<input type="hidden" id="bTransIDO" name="bTransIDO" value=""/><!-- ������ˮ -->
		<input type="hidden" id="bTransIDH" name="bTransIDH" value=""/><!-- ��ط�������ˮ�� -->
		<input type="hidden" id="bseq" name="bseq" value=""/><!-- ���β�����ˮ�� -->
		<input type="hidden" id="bMobileNum" name="bMobileNum" value=""/><!-- �ֻ����� -->
		<input type="hidden" id="boprResult" name="boprResult" value=""/><!-- ҵ������Ľ�� -->
		<input type="hidden" id="bIMSI" name="bIMSI" value=""/><!-- IMSI -->
		<input type="hidden" id="bICCID" name="bICCID" value=""/><!-- ICCID -->
		<input type="hidden" id="bSMSP" name="bSMSP" value=""/><!-- SMSP -->
		<input type="hidden" id="bPIN1" name="bPIN1" value=""/><!-- PIN1 -->
		<input type="hidden" id="bPIN2" name="bPIN2" value=""/><!-- PIN2 -->
		<input type="hidden" id="bPUK1" name="bPUK1" value=""/><!-- bPUK1 -->
		<input type="hidden" id="bPUK2" name="bPUK2" value=""/><!-- bPUK2 -->
		<input type="hidden" id="bHomeProv" name="bHomeProv" value=""/><!-- �ú���Ĺ���ʡʡ����  ����ʡ����ѡ��K2�Ĺ�Կ����K��OPc���м��� -->
		
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">���д������
					</div>
			</div>

	<table cellspacing="0">

		<tr id="test">
			<td class="blue">��ͨ��ʽ</td>
			<td colspan="3"><select name="test_flag" id="test_flag">
			</select></td>
		</tr>
		<tr>
			<td class="blue">�ͻ���ʶ����</td>
			<td><select name="IDType" id="IDType">
					<option value="01">01--&gt;�ֻ�����</option>
			</select></td>
			<td class="blue">�ͻ���ʶ</td>
			<td>
				<input id="phoneNo" name="phoneNo" type="text" class="button" index="1" maxlength="11" v_must=1 v_type="mobphone" v_minlength=11 v_name="�ֻ�����" value=""/>
				<font class='orange'>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">�ͻ�����</td>
			<td colspan='3'>
				<input name="custPWD" type="password" class="button" index="2" id="custPWD" maxlength="8" v_must=1 v_type=0_9 v_minlength=1 v_name="�ͻ�����"/>
				<font class='orange'>*(�ͻ������֤�������ѡһ)</font>
			</td>
		</tr>
		<tr>
			<td class="blue">֤������</td>
			<td>
				<select name="cardType" id="cardType">
					<option value="00">00--&gt;���֤</option>
					<!--  <option value="01">01--&gt;VIP��</option>
                <option value="02">02--&gt;����</option>
                <option value="04">04--&gt;����֤</option>
                <option value="05">05--&gt;��װ�������֤</option>
                <option value="99">99--&gt;����</option> -->
				</select>
			</td>
			<td class="blue">֤������</td>
			<td>
				<input name="cardID" type="text" class="button" id="cardID" maxlength="20" v_must=1 v_type=0_9 v_minlength=1 v_name="֤������" value=""/>
				<font class="orange">*</font>
				<input type="button" id="dukaBut1" class="b_text" value="����" onclick="Idcard_realUser()" /> <input type="button" id="dukaBut2" class="b_text" value="����(2��)" onclick="Idcard2()" />
				<input name="noCheck" type="button" class="b_text" id="noCheck" value="��֤" onclick="go_call_noCheck()" />
			</td>
		</tr>
		<tr>
			<td class="blue">�ͻ�����</td>
			<td>
				<input type="text" id="retValue101" name="retValue101" readonly="readonly" />
			</td>
			<td class="blue">�ͻ�����</td>
			<td>
				<input type="text" id="retValue114" name="retValue114" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">����ʱ��</td>
			<td>
				<input type="text" id="retValue118" name="retValue118" readonly="readonly" />
			</td>
			<td class="blue">�û�״̬</td>
			<td>
				<input type="text" id="retValue119" name="retValue119" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">PUK��</td>
			<td>
				<input type="text" id="retValue122" name="retValue122" readonly="readonly" />
			</td>
			<td class="blue">���ö�</td>
			<td>
				<input type="text" id="retValue123" name="retValue123" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">����������</td>
			<td>
				<input type="text" id="retValue126" name="retValue126" readonly="readonly" />
			</td>
			<td class="blue">�û��Ǽ�</td>
			<td>
				<input type="text" id="retValue127" name="retValue127" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">�ͻ����ֲ�</td>
			<td>
				<input type="text" id="retValue128" name="retValue128" readonly="readonly" />
			</td>
			<td class="blue">�ͻ�Ʒ��</td>
			<td>
				<input type="text" id="retValue129" name="retValue129" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">��ֵҵ�񿪷����</td>
			<td>
				<input type="text" id="retValue124" name="retValue124" readonly="readonly" />
			</td>
			<td class="blue"></td>
			<td>
			</td>
		</tr>
		<tr>
			<td class="blue">�ʻ�Ӧ�ɽ��(Ԫ)</td>
			<td>
				<input type="text" id="yjFee" name="yjFee" value="" readonly="readonly"/>
			</td>
			<td class="blue">�ʻ�Ԥ�����(Ԫ)</td>
			<td>
				<input type="text" id="ycFee" name="ycFee" value="" readonly="readonly"/>
			</td>
		</tr>
		<jsp:include page="s4240_sanzhang.jsp">
			<jsp:param name="hwAccept" value="<%=sLoginAccept%>" />
			<jsp:param name="showBody" value="01" />
			<jsp:param name="sopcode" value="<%=opCode%>" />
			<jsp:param name="renzhengShow" value="<%=renzhengShow%>" />
			<jsp:param name="labelName" value="submitFlagC" />
		</jsp:include>
		<tr>
			<td class="blue" width="15%">sim����</td>
			<td colspan="3">
				sim������(��λ/Ԫ):<input type="text" id="simFee" name="simFee" value="" maxlength="5" />
			</td>
		</tr>
		<tr>
			<td colspan="4" id="footer" class="blue" align='center'>
				<input class="b_text" type="button" id="b_write" name="b_write" value="ȷ��" onmouseup="writechg(this)" onkeyup="if(event.keyCode==13)writechg()" disabled="disabled" /> &nbsp;
				<!-- <input class="b_foot" name="reset" type="button" value="���" onclick="reset()"/> -->
			</td>
		</tr>
	</table>
<script language="JavaScript">
$("tr[id='sanzhangTr']").hide();
</script>
	<input type="hidden" name="guid" id="guid" value="<%=loginNo%>"/>
	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>"/>
	<input type="hidden" name="loginNoPass" id="loginNoPass" value="<%=loginNoPass%>"/>
	<input type="hidden" name="loginName" id="loginName" value=""/>
	<input type="hidden" name="opCode" id="opCode" value=""/>
	<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>"/>
	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>"/>
	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>"/>
	<input type="hidden" name="totalDate" id="totalDate" value="<%=totalDate%>"/>                                                     
	<input type="hidden" name="tmpBusyAccept" id="tmpBusyAccept" value=""/>
	<input type="hidden" name="tmpSendAccept" id="tmpSendAccept" value=""/> 	
	<input type="hidden" name="tmpBackAccept" id="tmpBackAccept" value=""/>	
	<input type="hidden" name="opType" class="button" id="opType" value="���д������"/>
	<%@ include file="/npage/include/footer.jsp" %>		
</form>
</body>
<object id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"/> 
<%@ include file="/npage/sq100/interface_provider.jsp" %>
</html>
