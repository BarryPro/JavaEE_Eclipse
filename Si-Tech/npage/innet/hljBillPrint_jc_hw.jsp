<%
/********************
*version v3.0
*������: si-tech
*
*update:ZZ@2008-10-13 ҳ�����,�޸���ʽ
*1104,1238��ģ��ʹ�ù��ĵ����Ի���
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<!---------- R_HLJMob_liubq_CRM_PD3_2010_0815@�����ڿ��������д�ӡ���֤��Ϣ������ start ------------->
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/innet/getIccidFtpPas.jsp" %><!-- �õ����� -->
<!---------- R_HLJMob_liubq_CRM_PD3_2010_0815@�����ڿ��������д�ӡ���֤��Ϣ������ end   ------------->
<HTML>
<HEAD>
<TITLE>��ӡ</TITLE>
<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>

</HEAD>
<%@ include file="splitStr.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String groupId = (String)session.getAttribute("groupId");
	String regionCode= (String)session.getAttribute("regCode");
	String opCode = request.getParameter("opCode");
	/***************** update by diling @2012/3/14 19:40:41 start***************/
		String favPassDesc = "";
	if ("1234".equals(opCode)||"1230".equals(opCode)) {  
	  favPassDesc = "������֤ͨ��";
	  System.out.println("-------������֤ͨ��-----------opcode="+opCode);
	}

  /***************** update by diling @2012/3/14 19:40:41 end****************/
	String op_name="";
	String DlgMsg = request.getParameter("DlgMsg");
	String printInfo = request.getParameter("printInfo");
	String pType = request.getParameter("pType");
	String billType = request.getParameter("billType");
	String phoneNo = request.getParameter("phoneNo");
	System.out.println("phoneNo+++++++++++++++++++++++++++++++++++++" + phoneNo);
	System.out.println("pType+++++++++++++++++++++++++++++++++++++" + pType);
	System.out.println("pType+++++++++++++++++++++++++++++++++++++" + pType);
	String submitCfm = request.getParameter("submitCfm");

	String mode_code = request.getParameter("mode_code");  //�ʷѴ��� ���û��ֵ ǰ̨�������ľ����ַ��� null
	String fav_code = request.getParameter("fav_code");    //�ط����� ���û��ֵ ǰ̨�������ľ����ַ��� null
	String area_code = request.getParameter("area_code");  //С������ ���û��ֵ ǰ̨�������ľ����ַ��� null
	System.out.println("mode_code+++++++++++++++++++++++++++++++++++++" + mode_code);
	String[] mode_list = null;
	String[] fav_list  = null;
	String[] area_list = new String[1];
	if(mode_code!="null"){
		mode_list = mode_code.split("~");
	}
	if(fav_code!="null"){
		fav_list = fav_code.split("\\|");
	}
	if(area_code!="null"){
		area_list[0] = area_code;
	}
	String login_accept=request.getParameter("sysAccept");
	String iccidInfo=request.getParameter("iccidInfo")==null ? "|||":request.getParameter("iccidInfo");
	String accInfo=request.getParameter("accInfoStr")==null ? "|||":request.getParameter("accInfoStr");
	String[] insRoleArr=accInfo.split("\\|");
	String fujianname="";
System.out.println("iccidInfo============"+iccidInfo);
System.out.println("accInfo============"+accInfo);
	if(!accInfo.equals("")){

		for(int i=0; i<insRoleArr.length; i++){
		System.out.println(insRoleArr[i]);
		int d_numname = insRoleArr[i].lastIndexOf("\\");
		
		String file_names = insRoleArr[i].substring(d_numname+1,insRoleArr[i].length());
		fujianname+=file_names+",";
		} 
	}
	System.out.println("fujianname============"+fujianname);
	/*2014/12/24 15:25:55 gaopeng �����Ż�ƾ�����֤��4G����ҵ��������ӡ���ݵ�����
		�ж��Ƿ��Ѿ�У���������ɹ�
	*/
	String ranPubFlag = "FALSE"; 
	String RandomPubFlag = (String)session.getAttribute("RandomPubFlag");
	System.out.println("gaopengSeeLogSavePrint=====RandomPubFlag====="+RandomPubFlag);
	if(RandomPubFlag!=null && !"".equals(RandomPubFlag)){
		String nowStr = phoneNo+"|true";
		System.out.println("gaopengSeeLogSavePrint=====nowStr====="+nowStr);
		if(nowStr.equals(RandomPubFlag)){
			ranPubFlag = "TRUE";
		}
	}
	/*ȡ�����ҵ���еļ�����ˮ���ҵ�������򴫹���,���û��ȡsession*/
	String loginacceptJT="";
  loginacceptJT=WtcUtil.repNull(request.getParameter("loginacceptJT"));
   if("".equals(loginacceptJT)) {
      //loginacceptJT = (String)session.getAttribute("loginacceptJT");
      if(loginacceptJT==null){
      	//loginacceptJT="";
      }
  }

  
	if(!iccidInfo.equals("|") && !iccidInfo.equals("|||")) {
				loginacceptJT="";
	}


String passwd = ( String )session.getAttribute( "password" );
String workChnFlag = "0" ;
%>
<wtc:service name="s1100Check" outnum="30"
	routerKey="region" routerValue="<%=regionCode%>" retcode="rc" retmsg="rm" >
	<wtc:param value = ""/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=work_no%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%
if ( rc.equals("000000") )
{
	if ( rst.length!=0 )
	{
		workChnFlag = rst[0][0];
	}
	else
	{
	%>
		<script>
			rdShowMessageDialog( "����s1100Checkû�з��ؽ��!" );
			//removeCurrentTab();
		</script>
	<%	
	}
}
else
{
%>
	<script>
		rdShowMessageDialog( "<%=rc%>:<%=rm%>" );
		//removeCurrentTab();
	</script>
<%
} 
  

 
	
	String provinceInfo="������|10014";
	String regionInfo="|";
	String areaInfo="|";
	String hallInfo="|";
	String orgInfos="";
	
	String inParams [] = new String[2]; 
	inParams[0]="select a.group_name,a.group_id  from dchngroupmsg a, dchngroupinfo b  where a.group_id = b.parent_group_id  and root_distance in (2,3,4)  and b.group_id =:groupids order by root_distance";
	inParams[1]="groupids="+groupId;
	 /*10118����*/
	 /*12613Ӫҵ��*/
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/>
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
		if(!retCode1.equals("000000")) {
		%>
			<script language="JavaScript">
	    rdShowMessageDialog("��ѯ���Ź�����Ϣʧ�ܣ�");
	    removeCurrentTab();
			</script>
		<%
		return;
		}
		if("10014".equals(groupId)) {
						
		}
		else {
					if(ret.length==1) {
							regionInfo=ret[0][0]+"|"+ret[0][1];
					}
					if(ret.length==2) {
							regionInfo=ret[0][0]+"|"+ret[0][1];
							areaInfo=ret[1][0]+"|"+ret[1][1];
					}
					if(ret.length==3) {
							regionInfo=ret[0][0]+"|"+ret[0][1];
							areaInfo=ret[1][0]+"|"+ret[1][1];
							hallInfo=ret[2][0]+"|"+ret[2][1];					
					}
		}
				
		orgInfos=provinceInfo+"^"+regionInfo+"^"+areaInfo+"^"+hallInfo;
		System.out.println("��֯������Ϣ=="+orgInfos);	
	
	
	String disabledFlag="";

 	/****************************************yanpx ��ϵ��ӻ������������*****************************************************************/
 	String opTimehw  = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());//ҵ��ʼʱ��
	String cust_info=oneTok(printInfo,'#',1).trim();
	String opr_info=oneTok(printInfo,'#',2).trim();
	String note_info1=oneTok(printInfo,'#',3).trim();
	String note_info2=oneTok(printInfo,'#',4).trim();
	String note_info3=oneTok(printInfo,'#',5).trim();
	String note_info4=oneTok(printInfo,'#',6).trim();
	
	/*************************************yanpx20100830 Ϊ�ͷ�������ӡҳ������***************************************************/
	String accountType = (String)session.getAttribute("accountType"); //1 ΪӪҵ���� 2 Ϊ�ͷ�����
	if("2".equals(accountType)){ 
		%>
		<script language='jscript'>
			window.returnValue="confirm"; //yuanqs add 2010/9/10 17:24:57
		    window.close();
		</script>
		<%
	}
	/*********************************end********************************************************/
		String[] inParamsss1 = new String[2];
	  inParamsss1[0] = "select function_name from sfunccodenew where function_code=:funcodes";
	  inParamsss1[1] = "funcodes="+opCode;

   String classsql="select class_name,class_code from sclass where print_flag=1";
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="2">
			<wtc:sql><%=classsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
			
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="functionnamearry" scope="end" />
  	
<%
		if(functionnamearry.length>0) {
				op_name=functionnamearry[0][0];
		}
		
		
		HashMap hm=new HashMap();
		for(int i=0;i<result.length;i++){
			hm.put(result[i][0],result[i][1]); 
		}
		String [][] retInfo=getParamIn(printInfo,work_no,work_name,hm,favPassDesc);
		
		System.out.println("gaopengSeePrintHw---"+printInfo);
		System.out.println("gaopengSeePrintHw---"+work_no);
		System.out.println("gaopengSeePrintHw---"+work_name);
		System.out.println("gaopengSeePrintHw---"+hm);
		System.out.println("gaopengSeePrintHw---"+favPassDesc);
		

		
        String test[][] = retInfo;
%>
		<wtc:service name="sPrt_Create" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="2" >
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=billType%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=login_accept%>"/>
		  <wtc:param value="<%=phoneNo%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:params value="<%=retInfo[0]%>"/>
			<wtc:params value="<%=retInfo[1]%>"/>
			<wtc:params value="<%=retInfo[2]%>"/>
			<wtc:params value="<%=mode_list%>"/>
			<wtc:params value="<%=fav_list%>"/>
			<wtc:params value="<%=area_list%>"/>
			<wtc:param value="<%=ranPubFlag%>"/>
		</wtc:service>
<%
	System.out.println("!!!!!!!!!!!!!"+retCode);
  if(!retCode.equals("000000")){
  	if(!retCode.equals("696006")){ 
      disabledFlag="disabled";
      DlgMsg="���ɹ�������,�������ɣ������ӡ�洢�ύ�˴�ҵ�����޷���ӡ������" ;
      System.out.println(retCode+"%%%%%");
%>
		<script language='jscript'>
		    var ret_code = "<%=retCode%>";
		    var ret_msg = "<%=retMsg%>";
		    alert("���ɹ������󣡴�����룺<%=retCode%>��������Ϣ��<%=retMsg%>��");
		    //window.close();
		</script>
<%
   }
  }
%>
<%
	
	
	String getLoginInfo = "SELECT   msg.group_name, msg.GROUP_ID, msg.root_distance"
						+" FROM dchngroupmsg msg, dchngroupinfo info"
						+" WHERE msg.GROUP_ID = info.parent_group_id"
						+" AND info.GROUP_ID = '" + groupId + "'"
						+" AND msg.root_distance > 1"
						+" ORDER BY msg.root_distance";
%>
	<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5">
		<wtc:sql><%=getLoginInfo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="ret" scope="end"/>

<!---------- R_HLJMob_liubq_CRM_PD3_2010_0815@�����ڿ��������д�ӡ���֤��Ϣ������ start ------------->
<%@ include file="fIccidInterface.jsp" %>
<!---------- R_HLJMob_liubq_CRM_PD3_2010_0815@�����ڿ��������д�ӡ���֤��Ϣ������ end   ------------->

<SCRIPT type="text/javascript">

var checkhwflags="0";//���ӹ�������ʶ 0�ɹ� 1ʧ��
	
onload=function()
{
	prtButtonShow('<%=opCode%>');
	if("<%=phoneNo%>"!="" && "<%=phoneNo%>"!="null") {
			$("#email").val("<%=phoneNo%>@139.com");
	}
	//core.rpc.onreceive = doProcess;
  //var rdBackColor = "#E3EEF9";
  // If IE version >=5.5, This will be works
  // gradient start color
  //var rdGradientStartColor = "#FFFFFFFF";
  // gradient end color
  //var rdGradientEndColor = "#FFFDEDC1";
  // gradient type, 1 represents from left to right, 0 reresents from top to bottom
  //var rdGradientType = "0";
  //var fillter = "progid:DXImageTransform.Microsoft.Gradient(startColorStr="+rdGradientStartColor+",endColorStr="+rdGradientEndColor+", gradientType="+rdGradientType+")";
  //document.bgColor = rdBackColor;
  //document.body.style.filter = fillter;
//  var obj =window.dialogArguments;
//  alert(obj.name);
}

/**** R_HLJMob_liubq_CRM_PD3_2010_0815@�����ڿ��������д�ӡ���֤��Ϣ������ start ****/
function prtButtonShow(op_code){
	var iccidprintObj = document.all.iccidprint ;
	var hwprintObj = document.all.hwprint ;
	var hwsubprintObj = document.all.hwsubprint ;	
	if(op_code!="1104"){
		iccidprintObj.style.display = "none";
	}
}
/**** R_HLJMob_liubq_CRM_PD3_2010_0815@�����ڿ��������д�ӡ���֤��Ϣ������ end   ****/

function doProcess(packet)
{
  //RPC������findValueByName
  var retType = packet.data.findValueByName("retType");
  var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");

  var fColor = 0*65536+0*256+0;
  self.status="";

 	if((retCode).trim()=="")
	{
    alert("����"+retType+"����ʱʧ�ܣ�");
    return false;
	}

	if(retType == "subprint")
  {
  	if(retCode=="000000")
    {
        var impResultArr = packet.data.findValueByName("impResultArr");
        var num = impResultArr.length;   //������
        var page=Math.ceil((num/45));//ÿҳ45��  ���ڹ���ͷ������������ֽ�ϴ���ͬһ�У���ȥ2�С�
				var x = 0;
        for(var j=0;j<page;j++){
					try{
						//��ӡ��ʼ��
						printctrl.Setup(0);
						printctrl.StartPrint();
						printctrl.PageStart();
						

							for(var i=j*45;i<(j+1)*45;i++){
							 if(i<num){
									if(impResultArr[i][6]=="N"){
										 impResultArr[i][6]=0
									}else{
										 impResultArr[i][6]=5
									}
										printctrl.PrintEx(parseInt(impResultArr[i][3]),parseInt(impResultArr[i][2]-j*45),impResultArr[i][12],parseInt(impResultArr[i][4]),fColor,impResultArr[i][6],impResultArr[i][11],impResultArr[i][10]);
								}
							 //x++;
							}
						//x = 0;
						//��ӡ����

						printctrl.PageEnd();
						printctrl.StopPrint();

				  }catch(e){
				  	//alert(e);
				  }finally{
						//���ش�ӡȷ����Ϣ
						var cfmInfo = "<%=submitCfm%>";
						var retValue = "";
						if(cfmInfo == "Yes")
						{	retValue = "confirm";	}
						window.returnValue= retValue;
						window.close();
					}
			  }
        document.spubPrint.getElementById("message")="δ��ӡ�����ϲ���ӡ�ɹ���";
    }else{
    	   alert("������룺"+retCode+"������Ϣ��"+retMessage);
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
	  }

  }

  if(retType == "print")
  {
  	if(retCode=="000000")
    {
     		var impResultArr = packet.data.findValueByName("impResultArr");
     		
				try{
					//��ӡ��ʼ��
					printctrl.Setup(0);
					printctrl.StartPrint();
					printctrl.PageStart();

						for(var i=0;i<impResultArr.length;i++){
									if(impResultArr[i][6]=="N"){
										 impResultArr[i][6]=0
									}else{
										 impResultArr[i][6]=5
									}
							printctrl.PrintEx(parseInt(impResultArr[i][3]),parseInt(impResultArr[i][2]),impResultArr[i][12],parseInt(impResultArr[i][4]),fColor,impResultArr[i][6],impResultArr[i][11],impResultArr[i][10]);
						}
					//��ӡ����
					printctrl.PageEnd();
					printctrl.StopPrint();
			  }catch(e){
			  	alert(e);
			  }finally{
					//���ش�ӡȷ����Ϣ
					var cfmInfo = "<%=submitCfm%>";
					var retValue = "";
					if(cfmInfo == "Yes")
					{	retValue = "confirm";	}
					window.returnValue= retValue;
					window.close();
				}
    }
    else{
      alert("������룺"+retCode+"������Ϣ��"+retMessage);
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
    }
  }
  if(retType == "noprint"){
  	if(retCode!="000000"){
  		alert("������룺"+retCode+"������Ϣ��"+retMessage);
  	}
	  window.returnValue="continueSub";
	  window.close();
  }
}

//�����ӡ
function doPrint()
{
 
 	//������ͨ��ӡ����
	var print_Packet = new AJAXPacket("../public/fPubSavePrint.jsp","���ڴ�ӡ�����Ժ�......");
	print_Packet.data.add("retType","print");
	print_Packet.data.add("opCode",'<%=opCode%>');
	print_Packet.data.add("phoneNo",'<%=phoneNo%>');
	print_Packet.data.add("billType",'<%=billType%>');
	print_Packet.data.add("login_accept",'<%=login_accept%>');
	core.ajax.sendPacket(print_Packet);
	print_Packet=null;  
}
//�ϲ���ӡ
function doSubPrint()
{ 
	//���úϲ���ӡ����
	var subprint_Packet = new AJAXPacket("../public/fPubSaveSubPrint.jsp","���ڴ�ӡ�����Ժ�......");
	subprint_Packet.data.add("retType","subprint");
	subprint_Packet.data.add("phoneNo",'<%=phoneNo%>');
	subprint_Packet.data.add("billType",'<%=billType%>');
	subprint_Packet.data.add("login_accept",'<%=login_accept%>');
	core.ajax.sendPacket(subprint_Packet);
	subprint_Packet=null;
}
//����ӡ
function doNOPrint()
{
	var noprint_Packet = new AJAXPacket("../public/fPubSaveNoPrint.jsp","���ڴ�ӡ�����Ժ�......");
	noprint_Packet.data.add("retType","noprint");
	noprint_Packet.data.add("phoneNo",'<%=phoneNo%>');
	noprint_Packet.data.add("opCode",'<%=opCode%>');
	noprint_Packet.data.add("billType",'<%=billType%>');
	noprint_Packet.data.add("login_accept",'<%=login_accept%>');
	core.ajax.sendPacket(noprint_Packet);
	noprint_Packet=null;
}
function doSub()
{
  window.returnValue="continueSub";
  window.close();
}
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
function donotesave(packet)
{
  var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");

  if(retCode=="000000"){
   		
	}
	else {
 		alert("������룺"+retCode+"������Ϣ��"+retMessage);
		window.close();
	}
}
function doattachsave(packet)
{
  var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");

  if(retCode=="000000"){
	} else {
			alert("������룺"+retCode+"������Ϣ��"+retMessage);
			window.close();
	}
}
function doreturnSave(packet)
{
  var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");
  
  if(retCode=="000000"){
  
	//document.spubPrint.action="http://10.109.180.71:8089/general/aip_file/seal/main.php";
	//tiantest
	document.spubPrint.action="http://10.110.0.100:59000/bp003.go?method=init";
	//document.spubPrint.action="http://10.110.13.52:8899/bp003.go?method=init";
	document.spubPrint.submit();
	//���ش�ӡȷ����Ϣ
	var cfmInfo = "<%=submitCfm%>";
	var retValue = "";
	if(cfmInfo == "Yes")
	{	retValue = "confirm";	}
	window.returnValue= retValue;
	window.close();
  
  
	} else {
			alert("������룺"+retCode+"������Ϣ��"+retMessage);
			//window.close();
	}
}

function doTest()
{
	  updInfo("d");

}


	  

function ReplaceDot(str)
{
  if(str!=null) { 
  str = str.replace(/"/g,"��")    
  } 
  return str; 
}


function doHWTest(packet){
  //RPC������findValueByName
  var retType = packet.data.findValueByName("retType");
  var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");

  if(retCode=="000000"){
   		var impResultArr = packet.data.findValueByName("impResultArr");
   		var workInfoVal = "";
   		var custInfoVal = "";
   		var oprInfo1Val = "";
   		var noteInfo1Val = "";
   		for(var ai = 0; ai < impResultArr.length; ai++){
   			
   			if(impResultArr[ai][1] == '1'){
					/* workInfo */
					workInfoVal = workInfoVal + impResultArr[ai][10] + "|";
				}else if(impResultArr[ai][1] == '2'){
					/* custInfo */
					custInfoVal = custInfoVal + impResultArr[ai][10] + "|";
				}else if(impResultArr[ai][1] == '3'){
					/* oprInfo1 */
					oprInfo1Val = oprInfo1Val + impResultArr[ai][10] + "|";
				}else{
					/* noteInfo1 */
					noteInfo1Val = noteInfo1Val + impResultArr[ai][10] + "|";
				}
			}

			$("#workInfo").val(workInfoVal);
			$("#custInfo").val(custInfoVal);
			$("#oprInfo1").val(oprInfo1Val);
			$("#noteInfo1").val(noteInfo1Val);
			if("<%=phoneNo%>"!="" && "<%=phoneNo%>"!="null") {
			  if("<%=opCode%>"=="1104") {
				var isGoddNo_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1104/isGoodPhoneres.jsp","���ڲ�ѯ�����Ƿ���������룬���Ժ�......");
	 			isGoddNo_Packet.data.add("selNumValue","<%=phoneNo%>");
	 			core.ajax.sendPacket(isGoddNo_Packet,doIsGoodPhoneF);
	 			isGoddNo_Packet=null; 
	 			}
	 			
	 			if("<%=opCode%>"=="1104" || "<%=opCode%>"=="g784" || "<%=opCode%>"=="g785" || "<%=opCode%>"=="m028" || "<%=opCode%>"=="m275") {
	 				var jtaccept_Packet = new AJAXPacket("queryJTaccept.jsp","���ڲ�ѯ����appУ����ˮ�����Ժ�......");
					jtaccept_Packet.data.add("selNumValue","<%=phoneNo%>");
					core.ajax.sendPacket(jtaccept_Packet,doreturnaccept);
					jtaccept_Packet=null;
				}
		
		
			}
			
						var parmxmlstr="<req>";
						 parmxmlstr+="<workNo>"+document.all.workNo.value+"</workNo>";
						 parmxmlstr+="<workName>"+document.all.workName.value+"</workName>";
						 parmxmlstr+="<orgInfo>"+document.all.orgInfos.value+"</orgInfo>";
						 parmxmlstr+="<channelType><%=workChnFlag%></channelType>";
						 parmxmlstr+="<groupTrans>"+document.all.groupTrans.value+"</groupTrans>";
						 parmxmlstr+="<phoneNo>"+document.all.phoneNo.value+"</phoneNo>";
						 parmxmlstr+="<opTime>"+document.all.opTime.value+"</opTime>";
						 parmxmlstr+="<workInfo>"+document.all.workInfo.value+"</workInfo>";
						 parmxmlstr+="<custInfo>"+document.all.custInfo.value+"</custInfo>";
						 parmxmlstr+="<email>"+document.all.email.value.trim()+"</email>";
						 parmxmlstr+="<addprtTime></addprtTime>";
						 parmxmlstr+="<accInfo>"+document.all.accInfo.value+"</accInfo>";
						 parmxmlstr+="<iccidInfo>"+document.all.iccidInfo.value+"</iccidInfo>";
						 parmxmlstr+="<iscrmUploadfile>"+document.all.iscrmUploadfile.value+"</iscrmUploadfile>";
						 parmxmlstr+="<userIdCard>"+document.all.custiccid1.value+"</userIdCard>";
						 parmxmlstr+="<comments>"+document.all.comments.value+"</comments>";
						 parmxmlstr+="<busiList><busiInfo>";
					   parmxmlstr+="<sysAccept>"+document.all.sysAccept.value+"</sysAccept>";
					   parmxmlstr+="<opCode>"+document.all.opCode.value+"</opCode>";
					   parmxmlstr+="<opName>"+document.all.opName.value+"</opName>";
					   parmxmlstr+="<oprInfo><![CDATA["+ReplaceDot(document.all.oprInfo1.value)+"]]></oprInfo>";
					   parmxmlstr+="<noteInfo><![CDATA["+ReplaceDot(document.all.noteInfo1.value)+"]]></noteInfo>";
						 parmxmlstr+="</busiInfo></busiList></req>";
						 
						 $("#params").val(parmxmlstr);
						    
      	var note_Packet111 = new AJAXPacket("hljBillPrint_jc_upstatus.jsp","���ڱ��渽���������Ժ�......");
				note_Packet111.data.add("login_accept",'<%=login_accept%>');
				note_Packet111.data.add("opCode",'<%=opCode%>');
				note_Packet111.data.add("phoneNo",'<%=phoneNo%>');
				note_Packet111.data.add("billType",'<%=billType%>');	
				note_Packet111.data.add("opflag",'1');
				core.ajax.sendPacket(note_Packet111,doreturnSave);
				note_Packet111=null;
        
      
		}else{
			alert("������룺"+retCode+"������Ϣ��"+retMessage);
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
}
	function doIsGoodPhoneF(packet){
			var countGoodNo = packet.data.findValueByName("countGoodNo");
			if(countGoodNo!=0){  //����
			  $("#iscrmUploadfile").val("Y");    
				}else{
				$("#iscrmUploadfile").val("N"); 
		}
}


   var result = '', timeoutss = null, bhpsStatus = false;

	 
		//У����ӹ���״̬
function updInfo(str){

     result = '';
	 timeoutss = null;
	 bhpsStatus = false
     
	    timeoutss = window.setTimeout(function(){
	        if (result != 'running'){
	        	rdShowMessageDialog("��ֽ���豸�쳣�����л�ֽ�ʴ�ӡ3��",0);
	        }
	    }, 5000);//8�볬ʱ


						$.ajax({   
						
            async:false,   
            url:'http://10.110.0.100:59000/TestOKServer',
            type: 'GET',   
            dataType: 'jsonp',   
            jsonp: 'callbackparam', //Ĭ��callback  
            timeout: 5000,   
            success: function(json) { //�ͻ���jqueryԤ�ȶ���õ�callback�������ɹ���ȡ����������ϵ�json���ݺ󣬻ᶯִ̬�����callback����   
								//alert(json.result);
								
							if(timeoutss != null){
							//alert("qinglile");
							  clearTimeout(timeoutss);//ȡ����Ĵ���ʽ����ֽ��������							
							}
			  				  
								var resultstatus=json.result+"";
								result=resultstatus;
		
								//resultstatus="stop";
								//alert(resultstatus);
								if(resultstatus.trim()=="running") {
									checkhwflags="0";
									
														
		   if(str=="d")	{
		   						
				var note_Packet = new AJAXPacket("hljBillPrint_jc_hwnotes.jsp","���ڱ��汸ע�����Ժ�......");
					note_Packet.data.add("opCode",'<%=opCode%>');
					note_Packet.data.add("login_accept",'<%=login_accept%>');
					note_Packet.data.add("notesss",$("#comments").val());
					core.ajax.sendPacket(note_Packet,donotesave);
					note_Packet=null;
					if("<%=phoneNo%>"!="" && "<%=phoneNo%>"!="null") {
						var note_Packet11 = new AJAXPacket("hljBillPrint_jc_hwriteattach.jsp","���ڱ��渽���������Ժ�......");
						note_Packet11.data.add("login_accept",'<%=login_accept%>');
					note_Packet11.data.add("opCode",'<%=opCode%>');
					note_Packet11.data.add("phoneNo",'<%=phoneNo%>');	
					note_Packet11.data.add("fujianname",'<%=fujianname%>');
					core.ajax.sendPacket(note_Packet11,doattachsave);
					note_Packet11=null;
					}
					
					//������ͨ��ӡ����
					var print_Packet = new AJAXPacket("../public/fPubSavePrint_hw.jsp","���ڴ�ӡ�����Ժ�......");
					print_Packet.data.add("retType","print");
					print_Packet.data.add("opCode",'<%=opCode%>');
					print_Packet.data.add("phoneNo",'<%=phoneNo%>');
					print_Packet.data.add("billType",'<%=billType%>');
					print_Packet.data.add("login_accept",'<%=login_accept%>');
					core.ajax.sendPacket(print_Packet,doHWTest);
					print_Packet=null;
					
					//document.spubPrint.action="http://10.109.180.71:8089/general/aip_file/seal/main.php";
					//tiantest
					//document.spubPrint.action="http://10.110.0.100:59000/bp003.go?method=init";
					//document.spubPrint.action="http://10.110.13.52:8899/bp003.go?method=init";
					//document.spubPrint.submit();									
		     }else {
		     
var note_Packet = new AJAXPacket("hljBillPrint_jc_hwnotes.jsp","���ڱ��汸ע�����Ժ�......");
	note_Packet.data.add("opCode",'<%=opCode%>');
	note_Packet.data.add("login_accept",'<%=login_accept%>');
	note_Packet.data.add("notesss",$("#comments").val());
	core.ajax.sendPacket(note_Packet,donotesave);
	note_Packet=null;
	
	if("<%=phoneNo%>"!="" && "<%=phoneNo%>"!="null") {
			var note_Packet11 = new AJAXPacket("hljBillPrint_jc_hwriteattach.jsp","���ڱ��渽���������Ժ�......");
		note_Packet11.data.add("login_accept",'<%=login_accept%>');
	note_Packet11.data.add("opCode",'<%=opCode%>');
	note_Packet11.data.add("phoneNo",'<%=phoneNo%>');	
	note_Packet11.data.add("fujianname",'<%=fujianname%>');
	core.ajax.sendPacket(note_Packet11,doattachsave);
	note_Packet11=null;
	}
	//���úϲ���ӡ����
	var subprint_Packet = new AJAXPacket("../public/fPubSaveSubPrint_hw.jsp","���ڴ�ӡ�����Ժ�......");
	subprint_Packet.data.add("retType","subprint");
	subprint_Packet.data.add("phoneNo",'<%=phoneNo%>');
	subprint_Packet.data.add("billType",'<%=billType%>');
	subprint_Packet.data.add("login_accept",'<%=login_accept%>');
	core.ajax.sendPacket(subprint_Packet,doSubHWTest);
	subprint_Packet=null;

	//document.spubPrint.action="http://10.109.180.71:8089/general/aip_file/seal/main.php";
	//tiantest
	//document.spubPrint.action="http://10.110.0.100:59000/bp003.go?method=init";
	//document.spubPrint.action="http://10.110.13.52:8899/bp003.go?method=init";
	//document.spubPrint.submit();		     
		     
		     
		     }							
									
									
								}else {
									checkhwflags="1";
									//alert("1");
									 rdShowMessageDialog("��ֽ���豸�쳣�����л�ֽ�ʴ�ӡ1��",0);
								}
            },   
  
            error: function(xhr){  
            	if(timeoutss != null){
							  clearTimeout(timeoutss);//ȡ����Ĵ���ʽ����ֽ��������							
							} 
                checkhwflags="1";
                rdShowMessageDialog("��ֽ���豸�쳣�����л�ֽ�ʴ�ӡ2��",0);
            }
               
        });   
 
		
	}
	
	
	

function doSubTest()
{
	  updInfo("a");
      
}
function doSubHWTest(packet){
  //RPC������findValueByName
  var retType = packet.data.findValueByName("retType");
  var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");
  
  if(retCode=="000000"){

      var everyInfoCounts=packet.data.findValueByName("everyInfoCounts");//ÿ��ҵ������������Ϣ9,8
   		var impResultArr = packet.data.findValueByName("impResultArr");
   		
   		
   		
   		var everyInfoCous =everyInfoCounts.split("|");  		
	
   		var parmxmlstr="<req>";
						 parmxmlstr+="<workNo>"+document.all.workNo.value+"</workNo>";
						 parmxmlstr+="<workName>"+document.all.workName.value+"</workName>";
						 parmxmlstr+="<orgInfo>"+document.all.orgInfos.value+"</orgInfo>";
						 parmxmlstr+="<channelType><%=workChnFlag%></channelType>";
						 parmxmlstr+="<groupTrans>groupTransTIHUANWO</groupTrans>";
						 parmxmlstr+="<phoneNo>"+document.all.phoneNo.value+"</phoneNo>";
						 parmxmlstr+="<opTime>"+document.all.opTime.value+"</opTime>";
						 parmxmlstr+="<workInfo>workInfotihuan</workInfo>";
						 parmxmlstr+="<custInfo>custInfotihuan</custInfo>";
						 parmxmlstr+="<email>"+document.all.email.value.trim()+"</email>";
						 parmxmlstr+="<addprtTime></addprtTime>";
						 parmxmlstr+="<accInfo>"+document.all.accInfo.value+"</accInfo>";
						 parmxmlstr+="<iccidInfo>"+document.all.iccidInfo.value+"</iccidInfo>";
						 parmxmlstr+="<iscrmUploadfile>iscrmUploadfiletihuan</iscrmUploadfile>";
						 parmxmlstr+="<userIdCard></userIdCard>";
						 parmxmlstr+="<comments>"+ReplaceDot(document.all.comments.value)+"</comments>";
						 parmxmlstr+="<busiList>";						 
						
						var shuzi=0;
						var shuzi2=0;
						var oprinfostrs="";
						var noteinfostrs="";
						var workInfotihuanstr="";
						var custInfotihuanstr="";
						var loginacceptstrs="";
						//alert(everyInfoCous.length);
							   for(var counts=0;counts<everyInfoCous.length;counts++){//ѭ��ȡoprinfo��Ϣ��ƴ����һ��
							   //alert("xunhuankaishi"+counts);	 
							   	 loginacceptstrs=loginacceptstrs+impResultArr[shuzi][0]+"|";
								   parmxmlstr+="<busiInfo><sysAccept>"+impResultArr[shuzi][0]+"</sysAccept>";
								   parmxmlstr+="<opCode>"+impResultArr[shuzi][1]+"</opCode>";
								   parmxmlstr+="<opName>"+impResultArr[shuzi][2]+"</opName>";
								   
								   if(impResultArr[shuzi][1].indexOf("1104")!=-1) {
										var isGoddNo_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1104/isGoodPhoneres.jsp","���ڲ�ѯ�����Ƿ���������룬���Ժ�......");
							 			isGoddNo_Packet.data.add("selNumValue","<%=phoneNo%>");
							 			core.ajax.sendPacket(isGoddNo_Packet,doIsGoodPhoneF);
							 			isGoddNo_Packet=null; 
							 			}
							 			
							 			if(impResultArr[shuzi][1].indexOf("1104")!=-1 || impResultArr[shuzi][1].indexOf("g784")!=-1 || impResultArr[shuzi][1].indexOf("g785")!=-1 || impResultArr[shuzi][1].indexOf("m028")!=-1 || impResultArr[shuzi][1].indexOf("m275")!=-1 || impResultArr[shuzi][1].indexOf("1238")!=-1 || impResultArr[shuzi][1].indexOf("m058")!=-1) {
	
							 				var jtaccept_Packet = new AJAXPacket("queryJTaccept.jsp","���ڲ�ѯ����appУ����ˮ�����Ժ�......");
										jtaccept_Packet.data.add("selNumValue","<%=phoneNo%>");
										core.ajax.sendPacket(jtaccept_Packet,doreturnaccept);
										jtaccept_Packet=null;					
											 			
							 			}
								   
								   shuzi+=Number(everyInfoCous[counts]); 
								   
//alert(shuzi);
//alert(shuzi2+"qian");
							        
							     for(var ai = shuzi2; ai < shuzi; ai++){
							     		if(typeof(impResultArr[ai])!="undefined"&&impResultArr[ai]!="undefined"){
							     			if(impResultArr[ai][3]=="3") {
							     					oprinfostrs= oprinfostrs  +  impResultArr[ai][5]  +  "|";
							     			} else if(impResultArr[ai][3]=="4") {
							     					noteinfostrs= noteinfostrs  +  impResultArr[ai][5]  +  "|";
							     			}
							     			if(counts==0) {
							     				if(impResultArr[ai][3]=="1") {
							     					workInfotihuanstr= workInfotihuanstr  +  impResultArr[ai][5]  +  "|";
							     			  }	else if(impResultArr[ai][3]=="2") {
							     					custInfotihuanstr= custInfotihuanstr  +  impResultArr[ai][5]  +  "|";
							     			  }
							     			}
							     		}else{
							     			break;
							     		}
							     }  
							   
							     
							     shuzi2+=Number(everyInfoCous[counts]);
	//alert(shuzi2+"hou");						     
							     parmxmlstr+="<oprInfo><![CDATA[";  
							     parmxmlstr+=ReplaceDot(oprinfostrs);   
							     parmxmlstr+="]]></oprInfo>"; 
							     parmxmlstr+="<noteInfo><![CDATA[";
							     parmxmlstr+=ReplaceDot(noteinfostrs); 
							     parmxmlstr+="]]></noteInfo>";
							     parmxmlstr+="</busiInfo>";
							     oprinfostrs="";
							     noteinfostrs="";
			//alert("xunhuanjieshu");				      						   
							   }

						 parmxmlstr+="</busiList></req>";
						 
						 var iscrmUploadfilestr=document.all.iscrmUploadfile.value;
						 parmxmlstr=parmxmlstr.replace("iscrmUploadfiletihuan",iscrmUploadfilestr);  
						 parmxmlstr=parmxmlstr.replace("workInfotihuan",workInfotihuanstr);  

						 parmxmlstr=parmxmlstr.replace("custInfotihuan",custInfotihuanstr);  
						 parmxmlstr=parmxmlstr.replace("groupTransTIHUANWO",document.all.groupTrans.value); 
						 
						 
          $("#params").val(parmxmlstr);
			 
      	
      	loginacceptstrs=loginacceptstrs.substring(0,(loginacceptstrs.length-1));
      
        var note_Packet111 = new AJAXPacket("hljBillPrint_jc_upstatus.jsp","���ڱ��渽���������Ժ�......");
				note_Packet111.data.add("login_accept",loginacceptstrs);
				note_Packet111.data.add("opCode",'<%=opCode%>');
				note_Packet111.data.add("phoneNo",'<%=phoneNo%>');
				note_Packet111.data.add("billType",'<%=billType%>');
				note_Packet111.data.add("opflag",'2');	
				core.ajax.sendPacket(note_Packet111,doreturnSave);
				note_Packet111=null;
      
		}else{
			alert("������룺"+retCode+"������Ϣ��"+retMessage);
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
}

  function doreturnFunctions(packet) {
    var retCode = packet.data.findValueByName("errCode");
    var retMessage = packet.data.findValueByName("errMsg");
    var opName = packet.data.findValueByName("opName");
      if(retCode=="000000"){
      	$("#opName").val(opName);  		
   		}
   		else {  		
   		alert("��ѯ����ҵ�����Ƴ���");
   		}
  }
  
     function doreturnaccept(packet) {
    var retCode = packet.data.findValueByName("errCode");
    var retMessage = packet.data.findValueByName("errMsg");
    var acceptjts = packet.data.findValueByName("acceptjts");
      if(retCode=="000000"){
      	$("#groupTrans").val(acceptjts);  	
      	
      	<%if(!iccidInfo.equals("|") && !iccidInfo.equals("|||")) {%>
				 $("#groupTrans").val(""); 
				<%}%>
   		}
   		else {
   		alert("��ѯ����appУ����ˮ����");
   		}
  }
  

$(document).ready(function(){
	var groupInfoArr = new Array();
	<%
		for(int retIter = 0; retIter < ret.length; retIter++){
	%>
		groupInfoArr["<%=retIter%>"] = "<%=ret[retIter][0]%>" + "|" + "<%=ret[retIter][1]%>";
	<%
		}
	%>
	if(typeof(groupInfoArr[0]) != "undefined" && groupInfoArr[0] != ""){
		$("#regionName").val(groupInfoArr[0]);
	}else{
		$("#regionName").val("|");
	}
	if(typeof(groupInfoArr[1]) != "undefined" && groupInfoArr[1] != ""){
		$("#areaName").val(groupInfoArr[1]);
	}else{
		$("#areaName").val("|");
	}
	if(typeof(groupInfoArr[2]) != "undefined" && groupInfoArr[2] != ""){
		$("#hallName").val(groupInfoArr[2]);
	}else{
		$("#hallName").val("|");
	} 
});
  function addemailend() {
  	var emailphone = $("#email").val();
  	if(emailphone.trim()=="") {
  	
  	}
  	else {
	  	var sphones="";
	  	var splitphoe;
	  	if(emailphone.indexOf("@")==-1) {
	  		sphones =emailphone.trim();
	  	}else {
	  	 splitphoe =emailphone.trim().split("@");
	  	 	sphones=splitphoe[0]; 
	  	}
	  	
	  var checkemail_Packet = new AJAXPacket("checkMail.jsp","������֤�ֻ����䣬���Ժ�......");
		checkemail_Packet.data.add("emailphone",sphones);
		core.ajax.sendPacket(checkemail_Packet,docheckEmail);
		checkemail_Packet=null;
	}
  }
 
  function docheckEmail(packet) {
    var retCode = packet.data.findValueByName("errCode");
  var retMessage = packet.data.findValueByName("errMsg");

  if(retCode=="000000"){
   		var emailphone = $("#email").val();
   			 if(emailphone.indexOf("@")==-1) {
				$("#email").val(emailphone.trim()+"@139.com");
	  	}else {

	  	}
	  	var emailphone1 = $("#email").val();
	  	if(emailphone1.indexOf("@139.com")==-1) {
	  		alert("�����ʽ����ȷ�����������룡");
	  		$("#email").val("");
	  	}
   		
   		}
   		else {  		
   		alert("�ú��벻���ڻ��߸ú��벻�Ǻ������ƶ��ֻ����룡");
   		$("#email").val("");
   		}
  }
   function returncfArray(temp) {
   	 var tempdd = new Array(); 
      temp.sort(); 
      var isd=0;
      for(i = 0; i < temp.length; i++) { 
          if( temp[i] == temp[i+1]) { 
            continue; 
        } 
        
          tempdd[isd]=temp[i]; 
          isd++;
      } 
      return tempdd; 
  }
  
  function doclean() {
    $("#email").val("");
  }
</SCRIPT>
<!--**************************************************************************************-->

<body style="overflow-x:hidden;overflow-y:hidden" onkeydown="if(event.keyCode==13)doTest();">
	<head>
		<title>�������ƶ�BOSS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
	</head>
<FORM method=post name="spubPrint" target="_parent">
  <!------------------------------------------------------>
  <div class="popup" >
	  	<div class="popup_qu" id="rdImage" align=center >
		  	<div class="popup_zi orange" id="message"><%=DlgMsg%></div>

		  	
		  </div>
			
	    <div align="center"  style="line-height:100%">
	    	��ע��Ϣ��<input  name="comments" id="comments"  type=text value="" style="width:250px;" maxlength="499">&nbsp;&nbsp;&nbsp;&nbsp;
	    	<br>
	    	139���䣺<input  name="email" id="email"  type=text value="" style="width:250px;" maxlength="19" onBlur="addemailend()">
	    	<input class="b_text" name=commit onClick="doclean()"   type=hidden value="���"> 
	    	
		<br>&nbsp;<br/>
	      <input class="b_text" name=commit onClick="doTest()"  style="width:80px;" type=button value="���ӹ�����ӡ">&nbsp;&nbsp;
	      <input class="b_text" name=commit onClick="doSubTest()" style="width:100px;"  type=button value="���ӹ����ϲ���ӡ">&nbsp;&nbsp;
	      <input type="button" name="iccidprint" class="b_text"   style="width:100px;" value="���֤ɨ���ӡ" onClick="doIccidPrint()" >&nbsp;&nbsp;
<br>
	      <input class="b_text" name=commit onClick="doPrint()"  <%=disabledFlag%> type=button value="��ӡ">&nbsp;&nbsp;
	      <%if(pType.equals("subprint")){%>
	      <input class="b_text" name=commit onClick="doSubPrint()"  <%=disabledFlag%> type=button value="�ϲ���ӡ">&nbsp;&nbsp;
	      <input class="b_text" name=back onClick="doSub()"  type=button value="��ӡ�洢">&nbsp;&nbsp;
				<%}else if(pType.equals("printstore")){%>
				<input class="b_text" name=back onClick="doSub()"  type=button value="��ӡ�洢">&nbsp;&nbsp;
				<%}%>
				
			  <!--<input class="b_foot" name=commit onClick="doNOPrint()"  type=button value="��һ��">!-->
	    </div>
	    <br>&nbsp;<br />
	 </div>


  <input type="hidden" name="orgInfos" value="<%=orgInfos%>">
  <input type="hidden" name="custiccid1" value="">

  <input type="hidden" name="sysAccept" value="<%=login_accept%>">
  <input type="hidden" name="workNo" value="<%=work_no%>" >
	<input type="hidden" name="workName" value="<%=work_name%>" >
	<input type="hidden" name="phoneNo" value="<%=phoneNo%>" >
  <input type="hidden" name="opTime" value="<%=opTimehw%>" >
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" >
	<input type="hidden" name="opName" id="opName" value="<%=op_name%>" >
	<input type="hidden" name="workInfo" id="workInfo" value="" >
	<input type="hidden" name="custInfo" id="custInfo" value="" >

	<input type="hidden" name="oprInfo1" id="oprInfo1" value="" >
	<input type="hidden" name="noteInfo1" id="noteInfo1" value="" >


	<input type="hidden" name="relnum" value="1" >
	
	<input type="hidden" name="hallName" id="hallName" value="" >
	<input type="hidden" name="areaName" id="areaName" value="" >
	<input type="hidden" name="regionName" id="regionName" value="" >

	<input type="text" name="iccidInfo" value="<%=iccidInfo%>" >
	<input type="hidden" name="accInfo" value="<%=accInfo%>" >
	<input type="hidden" name="iscrmUploadfile" id="iscrmUploadfile" >
  <input type="text" name="params" id="params" value="" >
  <input type="text" id="groupTrans" name="groupTrans" value="<%=loginacceptJT%>">

	<!-- ����·�� -->
	<!-- ���֤·����ͼƬ��ȡ�� /npage/public/hwReadCustCard.jsp -->
	<!--

<input type="hidden" name="iccidInfo" value="|||" >
	<input type="hidden" name="accInfo" value="|||" >

	-->


</FORM>
<!-- ���� handwrite �����ӡ�ؼ� -->
<%@ include file="/npage/innet/pubHWPrint.jsp" %>
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.cab#version=1,1,0,3"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
<object id='AGILEPOST' height='20%' width='20%' style='DISPLAY: none'
		classid='clsid:24018177-CAA4-4E5F-BFD2-577B1B4EA4FB' >
	</object>
</BODY>
</HTML>
