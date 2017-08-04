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
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<HTML>
<HEAD>
<TITLE>��ӡ</TITLE>
<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>

</HEAD>

<%@ include file="splitStr_jd.jsp" %>
<% 
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	
	String DlgMsg = request.getParameter("DlgMsg");
	String printInfo = request.getParameter("printInfo");
	System.out.println("==========wanghfa===========" + printInfo);
	String pType = request.getParameter("pType");
	String billType = request.getParameter("billType");
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
	System.out.println("pType+++++++++++++++++++++++++++++++++++++" + pType);
	String submitCfm = request.getParameter("submitCfm");
	
	String mode_code = request.getParameter("mode_code");  //�ʷѴ��� ���û��ֵ ǰ̨�������ľ����ַ��� null
	String fav_code = request.getParameter("fav_code");    //�ط����� ���û��ֵ ǰ̨�������ľ����ַ��� null
	String area_code = request.getParameter("area_code");  //С������ ���û��ֵ ǰ̨�������ľ����ַ��� null
	
	String payType = request.getParameter("payType"); /***�ɷ�����***/
	
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
	String disabledFlag="";
	
	System.out.println("area_list[0]="+area_list[0]);
	System.out.println("mode_code="+mode_code);
	System.out.println("fav_code="+fav_code);

  System.out.println("====out====");
  String classsql="select class_name,class_code from sclass where print_flag in(1,3)";   



String classsql1 = " select b.class_name,b.class_code from sPrintModelDet a, sclass b, sPrintModelFunc c "
								+ " where a.class_code = b.class_code and a.print_model_id = c.print_model_id "
							  + " and c.op_code = '"+opCode+"' and (b.catalog <> 'nohead' or b.catalog is null) ";
							  
String classsql2 = " select b.class_name,b.class_code from sPrintModelDet a, sclass b, sPrintModelFunc c "
								+ " where a.class_code = b.class_code and a.print_model_id = c.print_model_id "
							  + " and c.op_code = '"+opCode+"' and b.catalog = 'nohead' ";
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=classsql1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:sql><%=classsql2%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />
<%
		HashMap hm1=new HashMap();
		for(int i=0;i<result1.length;i++){
			hm1.put(result1[i][0], result1[i][1]);
		}
		HashMap hm2=new HashMap();
		for(int i=0;i<result2.length;i++){
			hm2.put(result2[i][0], result2[i][1]);
		}		
		String [][] retInfo=getBillParamIn(printInfo,work_no,work_name,hm1,hm2,payType);
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
		</wtc:service>
<%
	System.out.println("!!!!!!!!!!!!!"+retCode);
  if(!retCode.equals("000000")){  
  	if(!retCode.equals("696006")){
      disabledFlag="disabled";
      DlgMsg="���ɹ�������,�������ɣ������һ���ύ�˴�ҵ�����޷���ӡ������" ;
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
<SCRIPT type="text/javascript">
onload=function()
{
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
}

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

function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
</SCRIPT>
<!--**************************************************************************************-->

<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>�������ƶ�BOSS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
	</head>
<FORM method=post name="spubPrint">
  <!------------------------------------------------------>
  <div class="popup">
	  	<div class="popup_qu" id="rdImage" align=center>
		  	<div class="popup_zi orange" id="message"><%=DlgMsg%></div>
		  </div>

	    <div align="center">
	      <input class="b_foot" name=commit onClick="doPrint()"  <%=disabledFlag%> type=button value="ȷ��">			  
	    </div>
	    <br>   
	 </div>
</FORM>
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.cab#version=1,1,0,3"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
</BODY>
</HTML>