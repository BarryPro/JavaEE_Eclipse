<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-04
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="../../include/title_name.jsp" %>



<%
    request.setCharacterEncoding("GBK");
    Logger logger = Logger.getLogger("s1442Main.jsp");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<%
    String opCode = "1442";
    String opName = "SIM��Ӫ��";
        //SPubCallSvrImpl co=new SPubCallSvrImpl();

    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String region_code=org_code.substring(0,2);
	boolean hfrf=false;
 	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
 	String phone_z=WtcUtil.repNull(request.getParameter("phone_z"));
    String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

	String chgcode=request.getParameter("change_code");
	String password = request.getParameter("pname");
 	ArrayList simStatusArr=new ArrayList();
 	System.out.println("aaaaaaaaaaaaaaaaaaaa");

	String [][]initStr=new String[][]{};
	String [][]errStr=new String[][]{};

	ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};

    	//String [][]simStatusStr=new String[][]{};
    	//String [][]springbz=new String[][]{};
 	//-----------���������-------------
	String oriHandFee="0";
	String oriHandFeeFlag="";
    	/*
    	String sqHf="select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr('"+org_code+"',1,2) and FUNCTION_CODE='"+op_code + "'";
    	ArrayList handFeeArr=co.sPubSelect("2",sqHf,"phone",srv_no);

        if(((String[][])handFeeArr.get(0)).length>0)
    	{
    	   oriHandFee=((String[][])handFeeArr.get(0))[0][0];
    	   oriHandFeeFlag=((String[][])handFeeArr.get(0))[0][1];
           if(Double.parseDouble(oriHandFee) < 0.01)
    		   hfrf=true;
    	   else
    	   {
             if(!WtcUtil.haveStr(favStr,oriHandFeeFlag.trim()))
    			hfrf=true;
    	   }
    	}
        else
    	  hfrf=true;
	    */

	/***********dujl add at 20100408 for ë�������� begin******/
  //String hlrsql = "SELECT a.hlr_code||'--'||b.hlr_name FROM shlrcode a,shlrcodename b where a.phoneno_head=substr('"+srv_no+"',1,7) and a.region_code='"+region_code+"' AND a.hlr_code=b.hlr_code ";
	//lj. �󶨲���
	String sql_select1 = "SELECT a.hlr_code||'--'||b.hlr_name FROM shlrcode a,shlrcodename b where a.phoneno_head=substr(:srv_no,1,7) and a.region_code=:region_code AND a.hlr_code=b.hlr_code";
	String srv_params1 = "srv_no=" + srv_no + ",region_code=" + region_code;
   %>
			<wtc:service name="TlsPubSelCrm"  routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code" retmsg="ret_message" outnum="2">
				<wtc:param value="<%=sql_select1%>"/>
				<wtc:param value="<%=srv_params1%>"/>
			</wtc:service>
		<wtc:array id="hlrcode" scope="end" />

   <%
   /***********dujl add at 20100408 for ë�������� end********/


     //-----------���sim��״̬----------
	//String sq1="select trim(sim_status),trim(status_name) from sSimStatus where sim_status='2' or sim_status='3'";
	//lj. �󶨲���
	String sql_select2 = "select trim(sim_status),trim(status_name) from sSimStatus where sim_status='2' or sim_status='3'";
	
	    //simStatusArr=co.sPubSelect("2",sq1,"phone",srv_no);
%>
    <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value="<%=sql_select2%>"/>
			</wtc:service>
    <wtc:array id="simStatusStr" scope="end" />
<%
        //simStatusStr=(String[][])simStatusArr.get(0);
    if(simStatusStr.length==0)
        response.sendRedirect("s1442.jsp?ReqPageName=s1442Main&op_code="+op_code+"&retMsg=2");

/*    sq1="select to_char(count(*)) from dSpringCard a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phoneno1 and valid_flag='N' and op_code='1442'";
	String [] paraIn = new String[2];
    paraIn[0] = sq1;
    paraIn[1]="phoneno1="+srv_no;
	System.out.println("xxxxxxxxx");
	System.out.println("xxxxxxxxxsrv_no"+srv_no);*/

 	//------------��÷������˳�ʼ����Ϣ����-----------
	    //SPubCallSvrImpl im1210=new SPubCallSvrImpl();
	System.out.println("phone_z="+phone_z);
	int inputNumber =5;
	String outputNumber = "30";
	String inputParsm [] = new String[inputNumber];
	inputParsm[0] = work_no;
	inputParsm[1] = srv_no;
	inputParsm[2] = op_code;
	inputParsm[3] = chgcode;
	inputParsm[4] = phone_z;
	String [] initBack = new String[32];
  	    //String [] initBack = im1210.callService("s1442Init",inputParsm,outputNumber,"phone",srv_no);
%>
    <wtc:service name="s1442Init" routerKey="phone" routerValue="<%=srv_no%>" retcode="s1442InitCode" retmsg="s1442InitMsg" outnum="32">
        <wtc:param value="<%=inputParsm[0]%>"/>
        <wtc:param value="<%=inputParsm[1]%>"/>
        <wtc:param value="<%=inputParsm[2]%>"/>
        <wtc:param value="<%=inputParsm[3]%>"/>
        <wtc:param value="<%=inputParsm[4]%>"/>
    </wtc:service>
    <wtc:array id="s1442InitArr" scope="end" />
<%
    String retCode = s1442InitCode;
	String retMsg = s1442InitMsg;
	System.out.println(retCode);

	//------------��ȡ��ǰ���ʷ����ƣ�������Ϣ----------
	//SPubCallSvrImpl im1220=new SPubCallSvrImpl();
	int inputNo = 4;
	String   outputNo = "32";
	String  inParsm [] = new String[inputNo];
	inParsm[0] = work_no;
	inParsm[1] = srv_no;
	inParsm[2] = op_code;
	inParsm[3] = password;
  	//String [] initBack1 = im1220.callService("s1270GetMsgView",inParsm,outputNo,"phone",srv_no);

  	/********************** add by dujl at 20090724 start ********************************/
		if(s1442InitArr[0][30].equals("99"))
  		{
%>
  			<script language="javascript">
  				rdShowMessageDialog("ƽ̨�ڲ�����,���ƽ̨���ϻָ����ڼ�������!");
  				removeCurrentTab();
  			</script>
<%
  		}
  		else if(s1442InitArr[0][30].equals("00"))
		{
%>
  			<script language="javascript">
  				var	prtFlag = rdShowConfirmDialog("ȡ���ֳ��ѻ�֧�����ܻ��Ǽ�������?");
  				if(prtFlag==1)
  				{

  				}
  				else
  				{
  					removeCurrentTab();
  				}
  			</script>
<%
  		}
/********************** add by dujl at 20090724 end   ********************************/

    String loginPswInput = (String)session.getAttribute("password");
%>
    <wtc:service name="s1270GetMsg" routerKey="phone" routerValue="<%=srv_no%>" retcode="retc" retmsg="retm" outnum="<%=outputNo%>">
			<wtc:param value=""/>
 			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=loginPswInput%>"/>
			<wtc:param value="<%=srv_no%>"/>
			<wtc:param value="<%=password%>"/>
    </wtc:service>
    <wtc:array id="initBack1" scope="end" />
<%
	if( !retCode.equals("000000"))
	{
        System.out.println("OpCode = " + op_code);
        response.sendRedirect("s1442.jsp?activePhone="+srv_no+"&ReqPageName=s1442Main&op_code="+op_code+"&retMsg=101&errCode="+String.valueOf(retCode)+"&errMsg="+retMsg);
	}
/*	if(chgcode.equals("3") && springbz[0][0].equals("0"))
	{
        retMsg="���û������´������û�!";
        response.sendRedirect("s1442.jsp?activePhone="+srv_no+"&ReqPageName=s1442Main&op_code="+op_code+"&retMsg=101&errCode="+String.valueOf(retCode)+"&errMsg="+retMsg);
	}*/
	    //im1210.printRetValue();
	if(s1442InitArr.length>0 && retCode.equals("000000")){
    	for(int i = 0; i < s1442InitArr[0].length; i++)
    	{
    	    initBack[i] = s1442InitArr[0][i];
    		System.out.println("s1442InitArr["+ String.valueOf(i) + "]=" + s1442InitArr[0][i]);
    	}
	}
	String smCode=initBack[26];
	String[] twoFlag= new String[2];
	twoFlag[0] = "0";
	twoFlag[1] = "0";
	System.out.println("sssssssssssssssssssssssssssssssssssss="+smCode);
	String existPhoneNo="";
	String ss="�и߶��û�";
	int pos=initBack[24].trim().indexOf(ss,0);
	System.out.println("sssssssssssssssssssssssssssssssssssssssssssss2222222222222="+initBack[28]);
%>
<%
	/* ningtn �Ų��ܼ����� */
	String loginNo =(String)session.getAttribute("workNo");
	String workNoPsw = (String)session.getAttribute("password");
	String[] paraAray4 = new String[7];
	paraAray4[0] = initBack[28].trim();
	paraAray4[1] = "01";
	paraAray4[2] = opCode;
	paraAray4[3] = loginNo;
	paraAray4[4] = workNoPsw;
	paraAray4[5] = srv_no;
	paraAray4[6] = "";
	String showText = "";
%>
	<wtc:service name="sAdTermQry" routerKey="regionCode" routerValue="<%=region_code%>"
				 retcode="retCode4" retmsg="retMsg4"  outnum="3" >
		<wtc:param value="<%=paraAray4[0]%>"/>
		<wtc:param value="<%=paraAray4[1]%>"/>
		<wtc:param value="<%=paraAray4[2]%>"/>
		<wtc:param value="<%=paraAray4[3]%>"/>
		<wtc:param value="<%=paraAray4[4]%>"/>
		<wtc:param value="<%=paraAray4[5]%>"/>
		<wtc:param value="<%=paraAray4[6]%>"/>
	</wtc:service>
	<wtc:array id="result4" scope="end" />
<%
	if("000000".equals(retCode4)){
		System.out.println("~~~~����sAdTermQry�ɹ�~~~~");
		if(result4 != null && result4.length > 0){
			showText = result4[0][2];
		}
	}else{
		System.out.println("~~~~����sAdTermQryʧ��~~~~");
%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=retCode4%>��������Ϣ��<%=retMsg4%>");
				history.go(-1);
			</script>
<%
	}
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
if(<%=pos%>>=0){rdShowMessageDialog("���û����и߶��û���");}
/*dujl at 20100408 ���*/

      //core.loadUnit("debug");
      //core.loadUnit("rpccore");

  onload=function()
  {
   	    //core.rpc.onreceive = doProcess;
    self.status="";
    document.all.s_oldStatus.focus();
  }

//----------------��֤���ύ����-----------------
function writechg(){
	if(document.all.t_newsimf.value==""){
		rdShowMessageDialog("��sim���Ų����ǿ�!");
		return false;
	}
	if(document.all.cardtype_bz.value=="k"){
		var phone = (document.all.srv_no.value).trim();
  			document.all.b_write.disabled=true;
  			 var path = "<%=request.getContextPath()%>/npage/innet/fwritecard.jsp";
    		 path = path + "?regioncode=" + "<%=region_code%>";
    		 path = path + "&sim_type=" +document.all.cardcard.value;
    		 path = path + "&sim_no=" +document.all.t_newsimf.value;
    		 path = path + "&op_code=" +"1220";
    	         path = path + "&phone=" + phone + "&pageTitle=" + "д��";

    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		  if(typeof(retInfo) == "undefined")
    			{	rdShowMessageDialog("д��ʧ��",0);
    				document.all.writecardbz.value="1";
    				document.all.b_write.disabled=false;
    				return false;   }
    		 //alert("ssssssssssss");
    		 var retsimcode=oneTok(oneTok(retInfo,"|",1));
    		 var retsimno=oneTok(oneTok(retInfo,"|",2))
    		 var cardstatus=oneTok(oneTok(retInfo,"|",3))
    		 document.all.cardNo.value=oneTok(oneTok(retInfo,"|",4))
    		  if(retsimcode=="0"){rdShowMessageDialog("д���ɹ�",2);
    		   document.all.writecardbz.value="0";
    		 document.all.t_newsimf.value=retsimno;
    		 	document.all.cardstatus.value=cardstatus;
    		 	//document.all.cardNo.value=cardNo; /*  card_no  add by sungq  */
				if(cardstatus=="3"){document.all.t_simFeef.value="0";}
    		 }else{rdShowMessageDialog("д��ʧ��",0);
    		 	document.all.writecardbz.value="1";
    		 	document.all.b_write.disabled=false;

    		 }
		// alert(document.all.writecardbz.value);

	}
	else{
		rdShowMessageDialog("ʵ������д��");
		document.all.b_write.disabled=true;
		return false;
	}
}
function chgcardtype()

{
	document.all.t_newsimf.value="";
    document.all.simType.value="";
    document.all.cardcard.value="";
    document.all.t_simFeef.value="";
    document.all.t_simFeef2.value="";
    if(document.all.cardtype[1].checked==true)  //�տ�
    {
        var phone = (document.all.srv_no.value).trim();
        document.all.cardtype_bz.value="k";
          		  		 /****���������ƹ���ȡSIM������****/
     /* 
      * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
      */
 		 path ="http://10.110.0.100:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("Trans.html",path,"","dialogWidth:10;dialogHeight:10;");
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
   		//alert( retInfo1.substring(0,chPos));
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
        	//alert(valueStr);

    	}
    	//alert("retVal[0]"+retVal[0]);
    	if(retVal[0]=="0")
    	{

    		var rescode_str=retVal[2]+"|";

    		//alert("rescode_str"+rescode_str);
    		var rescode_strstr="";
    		//alert("rescode_str="+rescode_str)
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{

    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		//alert("rescode_str="+rescode_str)
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("�������ͳ���!");
    		 		return false;
        		}
        		//alert("valueStr="+valueStr);
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        			//alert("rescode_strstr="+rescode_strstr);
        		}

    		}
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("�������ͳ���!");
    		 	return false;
    		}
  			 //alert("rescode_strstr="+rescode_strstr);
  		}
  		else{
  			 rdShowMessageDialog("�������ͳ���!");
    		 return false;
    	}
  		 /****ȡSIM�����ͽ���******/
		 var path = "<%=request.getContextPath()%>/npage/innet/fgetsimno_1104.jsp";
		 path = path + "?regioncode=" + "<%=region_code%>";
	         path = path + "&phone=" + phone + "&rescode=" + rescode_strstr+ "&pageTitle=" + "����SIM������";

		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");

		 if(typeof(retInfo) == "undefined")
			{	return false;   }

		var simsim=oneTok(oneTok(retInfo,"~",1));
		var typetype=oneTok(oneTok(retInfo,"~",2));
		var cardcard=oneTok(oneTok(retInfo,"~",3));
		document.all.t_newsimf.value=simsim;
		document.all.simType.value=typetype;
		document.all.cardcard.value=cardcard;

  	}else{
  		document.all.b_write.disabled=true;
  		document.all.cardtype_bz.value="s";
  	}

}
function printCommit()
{
    getAfterPrompt();
	// in here form check
	
	
    /*zhangyan add*/
    if (document.all.cardtype[0].checked==true)
    {
		if ( $("#vilidFlag").val() == 0)/*�����ʡ��Я�ŵĺ���*/
		{
			rdShowMessageDialog("�ú�������ʡ��Я��,����ѡ��տ�!",0);
			//document.all.cardtype[1].checked=true
			return false;
		}    	
    }
    /*����ʹ��
	return false;	*/
	if((document.all.writecardbz.value!="0") && (document.all.cardtype_bz.value=="k")){
 		rdShowMessageDialog("д��δ�ɹ�����ȷ��!");
 		return false;

 	}
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
 {
	 if(((document.all.assuId.value).trim()).length>0)
	 {
        if(document.all.assuId.value.length<5)
		{
          rdShowMessageDialog("֤�����볤������(����5λ)��");
	      document.all.assuId.focus();
		}
	 }

     if(check(frm))
     {
		document.all.t_sys_remark.value="�û�"+"<%=initBack[1].trim()%>"+"<%=op_name%>";
		 if(((document.all.t_op_remark.value).trim()).length==0)
      {
		document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û�"+"<%=initBack[1].trim()%>"+"����<%=op_name%>"
	  }
	   if(((document.all.assuNote.value).trim()).length==0)
      {
		document.all.assuNote.value="����Ա<%=work_no%>"+"���û�"+"<%=initBack[1].trim()%>"+"����<%=op_name%>"
	  }

		//��ʾ��ӡ�Ի���
		//var h=150;
		//var w=350;
		//var t=screen.availHeight/2-h/2;
		//var l=screen.availWidth/2-w/2;
        //
		//var printStr = printInfo(printType);
        //
		//var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		//var path = "<%=request.getContextPath()%>/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
		//var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
		//var ret=window.showModalDialog(path,"",prop);

        var h=198;
        var w=400;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;

        var pType="subprint";
        var billType="1";
        var sysAccept = "<%=initBack[28].trim()%>";
        var mode_code = null;
        var fav_code = null;
        var area_code = null;
        var printStr = printInfo(printType);
        var phoneno = "<%=srv_no%>";

        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
        var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
        var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

        var ret=window.showModalDialog(path,printStr,prop);

		if(typeof(ret)!="undefined")
		{
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
				if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
				{
					conf();
				}
			}
			if(ret=="continueSub")
			{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ<%=op_name%>��Ϣ��')==1)
				{
					 conf();
				}
			}
		}
		else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ<%=op_name%>��Ϣ��')==1)
			{
				conf();
			}
		}
	 }
 }

function printInfo(printType)
{
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
    var retInfo = "";

	//retInfo+='<%=work_no%>  <%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	<%if(chgcode.equals("1")&& !phone_z.trim().equals("")){%>
	    cust_info+="�ֻ����룺"+document.all.phone_z.value+"|";
	<%}else{%>
	    cust_info+="�ֻ����룺"+document.all.srv_no.value+"|";
	<%}%>
	cust_info+="�ͻ�������"+document.all.cus_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cus_addr.value+"|";
	cust_info+="֤�����룺"+document.all.icc_no.value+"|";

	opr_info+="�û�Ʒ�ƣ�"+'<%=initBack[29].trim()%>'+"  ����ҵ�� SIM��Ӫ��"+"  ������ˮ��"+document.all.loginAccept.value+"|";
	opr_info+="ԭSIM���ţ� "+'<%=initBack[9].trim()%>'+"  ԭSIM�����ͣ�"+'<%=initBack[10].trim()%>'+"|";
	opr_info+="��SIM���ţ� "+document.all.t_newsimf.value+"  ��SIM�����ͣ�"+document.all.simType.value+"|";

    note_info1+="��ע"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

 //--------3---------��֤��ťר�ú���-------------
 function chkSim(phoneNo,simOldNo,simNewNo,op_code)
 {
	if(((document.all.t_newsimf.value).trim()).length==0)
	{
      rdShowMessageDialog("��SIM���Ų���Ϊ�գ�");
	  document.all.t_newsimf.value="";
	  document.all.t_newsimf.focus();
	  return false;
	}

  	var myPacket = new AJAXPacket("chgSim1442.jsp","������֤��SIM���ţ����Ժ�......");
	myPacket.data.add("phoneNo",phoneNo);
	myPacket.data.add("simOldNo",simOldNo);
	myPacket.data.add("simNewNo",simNewNo);
	myPacket.data.add("orgCode",document.all.orgCode.value);
	myPacket.data.add("op_code",op_code);
	myPacket.data.add("cardsim_type",document.all.cardcard.value);
	var cardtype="";
	if(document.all.cardtype[1].checked==true){
		document.all.cardtype_bz.value="k";
		cardtype="k";}
	else{	document.all.cardtype_bz.value="s";
		cardtype="s";
	}

	myPacket.data.add("cardtype",cardtype);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
 }

 function doProcess(packet)
 {

    var errCode=packet.data.findValueByName("errCode");
	var errMsg=packet.data.findValueByName("errMsg");
	var simFee=packet.data.findValueByName("simFee");
	var simType=packet.data.findValueByName("simType");
	var simTypeName=packet.data.findValueByName("simTypeName");
	self.status="";

	if(parseInt(errCode)!=0)
	{
	  //rdShowMessageDialog("SIM����֤����");
	  rdShowMessageDialog("����"+errCode+"��"+errMsg,0);
	  document.all.t_newsimf.value="";
	  document.all.t_newsimf.focus();
	}
	else
	{
	  //document.all.t_simFeef.value=jtrim(simFee);
	  document.all.simType.value=(simTypeName).trim();
	  //document.all.oriSimFee.value=jtrim(simFee);
	  if(((document.all.t_simFeef.value).trim()).length==0)
	  document.all.t_simFeef.value="0";
	  if(((document.all.simType.value).trim()).length=="")
	  document.all.simType.value="";
	  //if(jtrim(document.all.oriSimFee.value).length==0)
	  //document.all.oriSimFee.value="0";
	  document.all.t_simFeef.focus();
      document.all.t_simFeef.select();
	  document.all.b_print.disabled=false;
	  document.all.vSimType.value=(simType).trim();
	  if("<%=chgcode%>"!="3"){
	  		f1213GetByPhone(document.all.vSimType,document.all.vSmCode,document.all.regionCode);
	  		document.all.t_simFeef.value=document.all.oriSimFee.value;
		}else{
			document.all.t_simFeef.value="0";
			document.all.t_simFeef2.value="0";
		}
	  if(document.all.vSimType.value=="10014" && document.all.oriSimFee.value=="0" && document.all.t_simFeef2.value=="100"){
	 rdShowMessageDialog("�õ��ʷѽ��޹��������ڴ�����Ԥ��"+document.all.t_simFeef2.value+"Ԫ����ͨ���ɷ�ҵ�����е�������");}

	 if(document.all.vSimType.value=="10015" && document.all.oriSimFee.value=="0" && document.all.t_simFeef2.value=="200"){
	 rdShowMessageDialog("�õ��ʷѽ��޹��������ڴ�����Ԥ��"+document.all.t_simFeef2.value+"Ԫ����ͨ���ɷ�ҵ�����е�������");}


		if(document.all.cardtype_bz.value=='k'){
			  document.all.b_write.disabled=false;

		}
	document.all.t_newsimf.disabled=true;
	}

 }

 function conf()
 {
   frm.action="s1442_conf.jsp";
   document.all.t_newsimf.disabled=false;
   //alert(document.all.chgcode.value);
   frm.submit();
 }

 //-------6--------ʵ����ר�ú���----------------
function ChkHandFee()
 {
   if(((document.all.oriHandFee.value).trim()).length>=1 && ((document.all.t_handFee.value).trim()).length>=1)
   {
	 if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
	 {
	   rdShowMessageDialog("ʵ�������Ѳ��ܴ���ԭʼ�����ѣ�");
	   document.all.t_handFee.value=document.all.oriHandFee.value;
	   document.all.t_handFee.select();
	   document.all.t_handFee.focus();
	   return;
	 }
   }

   if(((document.all.oriHandFee.value).trim()).length>=1 && ((document.all.t_handFee.value).trim()).length==0)
   {
	 document.all.t_handFee.value="0";
   }
 }
  function ChkSimFee()
 {
   if(((document.all.t_simFeef.value).trim()).length>=1)
   {
	 if(parseFloat(document.all.oriSimFee.value)<parseFloat(document.all.t_simFeef.value))
	 {
	  rdShowMessageDialog("ʵ��SIM���Ѳ��ܴ���ԭʼSIM���ѣ�");
	  document.all.t_simFeef.value=document.all.oriSimFee.value;
	  document.all.t_simFeef.select();
	  document.all.t_simFeef.focus();
	  return;
	 }
   }

   if(((document.all.oriSimFee.value).trim()).length>=1 && ((document.all.t_simFeef.value).trim()).length==0)
   {
	 document.all.t_simFeef.value="0";
   }
 }
function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.t_handFee
	var simFee = document.all.t_simFeef;
    var fact=document.all.t_factFee;
    var few=document.all.t_fewFee;
    if(((fact.value).trim()).length==0)
    {
	  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
	  fact.value="";
	  fact.focus();
	  return;
    }
    if(parseFloat(fact.value)<parseFloat(fee.value) + parseFloat(simFee.value))
    {
  	  rdShowMessageDialog("ʵ�ս��㣡");
	  fact.value="";
	  fact.focus();
	  return;
    }

	var tem1=((parseFloat(fact.value)-parseFloat(fee.value)-parseFloat(simFee.value))*100+0.5).toString();
	var tem2=tem1;
	if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
    few.value=(tem2/100).toString();
    few.focus();
  }
}

function f1213GetByPhone(frmSimType, frmSmCode, frmRegionCode){

    document.all.oriSimFee.value="";
     document.all.t_simFeef2.value="";

    var pageTitle = "SIM��Ӫ��";
    var fieldName = "SIM������|SIM����|Ӫ��Ԥ��";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|2";
    var retToField = "oriSimFee|t_simFeef2";
  //  alert(frmSmCode.value);
    var sqlStr = "select distinct sim_name,decode(sm_code||sim_type,'gn10013',0,sim_fee) sim_fee,decode(sm_code||sim_type,'gn10013',0,sim_pre) sim_pre from sSimPre where active_flag = '2'  and   region_code = '"+frmRegionCode.value+"' and sm_code ='"+frmSmCode.value+"' and sim_type = '" + frmSimType.value + "' order by sim_fee";
    //var sqlStr = "select sim_name,sim_fee, sim_pre from sSimPre where active_flag = '2'  and   region_code = '"+frmRegionCode.value+"' and sm_code ='"+frmSmCode.value+"' and sim_type = '" + frmSimType.value + "' order by sim_fee";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
    var a =  parseInt(document.all.custType.value,10) ;
	var b =  parseInt(document.all.t_simFeef2.value,10) ;

	if(a == "00" )
	{
		if(b > '<%=initBack[6].trim()%>')
		{
		rdShowMessageDialog("�û���ǰԤ��С����ѡӪ�������趨Ԥ�棬�벹��Ԥ��");
		document.all.t_newsimf.value= "";
		document.all.t_simFeef2.value= "";
		document.all.t_newsimf.focus();
		return;
		}
	}else
	{
		document.all.t_simFeef2.value= "0";
		return;
	}
	if(document.all.oriSimFee.value == "")
	{
		return false;
	}

	//document.all.vConPaswd.focus();
 }

/* ningtn �Ų��ܼ����� */
	$(document).ready(function(){
		var showtext = "<%=showText%>";
		var showMsgObj = $("#showMsg");
		showMsgObj.hide();
		if(showtext.length > 0){
			showMsgObj.children("div").text(showtext);
			showMsgObj.show();
		}
	});
</script>
</head>
<body>

<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">
    <%@ include file="/npage/include/header.jsp" %>
      	   <!-- /* ningtn �Ų��ܼ����� */  -->
<div class="title" id="showMsg">
	<div id="title_zi">

	</div>
</div>
<div class="title">
	<div id="title_zi">�û���Ϣ</div>
</div>
<!--zhangyan ʡ��Я�ű�־ -->
<input type="hidden" name="vilidFlag" id="vilidFlag"  value="<%=initBack[31]%>">
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1442Main">
<input type="hidden" name="cardcard" id="cardcard">
<input name=writecardbz type=hidden value="">
<input type="hidden" name="cardtype_bz" id="cardtype_bz" value="s">
<input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
<input type="hidden" name="cus_id" id="cus_id" value="<%=initBack[1].trim()%>">
<input type="hidden" name="cus_name" id="cus_name" value="<%=initBack[8].trim()%>">
<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=oriHandFee.trim()%>">
<input type="hidden" name="oriSimFee" id="oriSimFee"  value="">
<input type="hidden" name="simOldNo" id="simOldNo" value="<%=initBack[9].trim()%>">
<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
<input type="hidden" name="icc_no" id="icc_no" value="<%=initBack[14].trim()%>">
<input type="hidden" name="cus_addr" id="cus_addr" value="<%=initBack[15].trim()%>">
<input type="hidden" name="regionCode" value="<%=org_code.substring(0,2)%>">
<input type="hidden" name="vSimType" value="">
<input name="cardstatus" type=hidden value="">
<input name="cardNo" type=hidden value="">
<input type="hidden" name="vSmCode" value="<%=smCode%>">
<input type="hidden" name="custType" value="<%=initBack[27].trim()%>">
<input type="hidden" name="loginAccept" value="<%=initBack[28]%>">
<input type="hidden" name="orgCode" value="<%=org_code%>">
<input type="hidden" name="chgcode" value="<%=chgcode%>">
<%@ include file="../../include/remark.htm" %>

<table cellspacing="0">
    <tr>
        <td nowrap class=blue>��ͻ���־</td>
        <td nowrap>
            <b><font class="orange"><%=twoFlag[0]%></font></b>
        </td>
        <td nowrap class=blue>���ű�־</td>
        <td nowrap><%=twoFlag[1]%></td>
        <td nowrap class=blue>�û�����</td>
        <%if(chgcode.equals("1")&& !phone_z.trim().equals("")){%>
            <td nowrap><%=phone_z.trim()%></td>
        <%}else{%>
            <td nowrap><%=srv_no.trim()%></td>
        <%}%>
    </tr>
    <tr>
        <td nowrap class=blue>֤������</td>
        <td nowrap><%=initBack[13].trim()%></td>
        <td nowrap class=blue>֤������</td>
        <td nowrap><%=initBack[14].trim()%></td>
        <td nowrap class=blue>SIM����</td>
        <td nowrap><%=initBack[10].trim()%></td>
    </tr>
    <tr>
        <td nowrap class=blue>�û�ID</td>
        <td nowrap><%=initBack[1].trim()%></td>
        <td nowrap class=blue>�û�����</td>
        <td nowrap><%=initBack[8].trim()%></td>
        <td nowrap class=blue>�û�����</td>
        <td nowrap><%=initBack[24].trim()%></td>
    </tr>
    <tr>
        <td nowrap class=blue>��ǰԤ��</td>
        <td nowrap><%=initBack[6].trim()%></td>
        <td nowrap class=blue>��ǰǷ��</td>
        <td nowrap><%=initBack[7].trim()%></td>
        <td nowrap class=blue>��ǰ״̬</td>
        <td nowrap><%=initBack[3].trim()%></td>
    </tr>
    <tr>
         <td nowrap class=blue>��ǰ���ʷ�</td>
         <td nowrap class=blue><%=initBack1[0][17].trim()%></td>
         <td nowrap class=blue>�������hlr</td>
         <td nowrap class=><%=hlrcode[0][0].trim()%></td>
         <td colspan=2>&nbsp;</td>
    </tr>
</table>

</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>

<table cellspacing="0">
    <tr style="display:none">
        <td nowrap class=blue>����������</td>
        <td nowrap>
            <input name=assuName  value="<%=initBack[16].trim()%>">
        </td>
        <td nowrap class=blue>�����˵绰</td>
        <td nowrap colspan=3>
            <input name=assuPhone  value="<%=initBack[17].trim()%>">
        </td>
    </tr>
    <tr style="display:none">
        <td nowrap class=blue>������֤������</td>
        <td nowrap>
            <select>
                <wtc:qoption name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="3">
                    <wtc:sql>select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type</wtc:sql>
                </wtc:qoption>
            </select>
        </td>
        <td nowrap class=blue>������֤������</td>
        <td nowrap colspan=3>
            <input name=assuId  value="<%=initBack[19].trim()%>">
        </td>
    </tr>
    <tr style="display:none">
        <td nowrap class=blue>������֤����ַ</td>
        <td nowrap colspan="3">
            <input name=assuIdAddr  value="<%=initBack[20].trim()%>">
        </td>
    </tr>
    <tr style="display:none ">
        <td nowrap class=blue>��������ϵ��ַ</td>
        <td nowrap colspan="3">
            <input name=assuAddr  value="<%=initBack[21].trim()%>">
        </td>
    </tr>
    <tr style="display:none">
        <td nowrap class=blue>�����˱�ע��Ϣ</td>
        <td nowrap colspan="5">
            <input name=assuNote0  value="<%=initBack[22].trim()%>">
        </td>
    </tr>
    <tr>
        <td nowrap class=blue width="13%">�ɿ�SIM����</td>
        <td nowrap width="25%"><%=initBack[9].trim()%></td>
        <td nowrap class=blue width="13%">�ɿ�״̬</td>
        <td nowrap colspan=3>
            <select name="s_oldStatus" index="7">
            <%
                for(int i=0;i<simStatusStr.length;i++)
                {
                    if(i==0)
                    {
            %>
                        <option value="<%=simStatusStr[i][0].trim()%>" selected><%=simStatusStr[i][1].trim()%></option>
            <%
                    }
                    else
                    {
            %>
                        <option value="<%=simStatusStr[i][0].trim()%>"><%=simStatusStr[i][1].trim()%></option>
            <%
                    }
                }
            %>
            </select>
            <font class=orange>*</font>
        </td>
    </tr>
    <tr>
    	<td>&nbsp;</td>
    	<td nowrap colspan="5">
            <input type="radio" name="cardtype" value="N" checked onclick="chgcardtype()" index="-4">
            ʵ��  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="cardtype"   value="Y" onclick="chgcardtype()" index="-3">
            �տ�
        </td>
 	</tr>
    <tr>
        <td nowrap class=blue width="13%">�¿�SIM����</td>
        <td nowrap>
            <input type="text" name="t_newsimf" id="t_newsimf" size="20" v_minlength=1 v_maxlength=100  v_type=string maxlength="20" value="<%=existPhoneNo%>" index="8" onkeyup="if(event.keyCode==13)chkSim((document.all.srv_no.value).trim(),(document.all.simOldNo.value).trim(),(document.all.t_newsimf.value).trim(),(document.all.op_code.value).trim())">
            <font class="orange">*</font>
            <%if(chgcode.equals("1")&& !phone_z.trim().equals("")){%>
                <input  class="b_text" type="button" name="b_tr_normal" value="��֤"  onClick="chkSim((document.all.phone_z.value).trim(),(document.all.simOldNo.value).trim(),(document.all.t_newsimf.value).trim(),(document.all.op_code.value).trim())">
            <%}else{%>
                <input  class="b_text" type="button" name="b_tr_normal" value="��֤"  onClick="chkSim((document.all.srv_no.value).trim(),(document.all.simOldNo.value).trim(),(document.all.t_newsimf.value).trim(),(document.all.op_code.value).trim())">
            <%}%>
            <input class="b_text" type="button" name="b_write" value="д��" onmouseup="writechg()" onkeyup="if(event.keyCode==13)writechg()" disabled index="19">
            <input type="hidden" name="flg_normal" id="flg_normal" value="0">
        </td>
        <td nowrap class=blue>��SIM������</td>
        <td nowrap colspan="3">
            <input type="text" readonly class="InputGrey" name="simType" index="9">
        </td>
    </tr>
    <tr>
        <td nowrap class=blue>SIM����</td>
        <td nowrap>
            <input type="test" readonly class="InputGrey" name="t_simFeef" id="t_simFeef" size="10" v_minlength=1 v_maxlength=10  v_type=float  maxlength="10" onblur="ChkSimFee()" index="9">
        </td>
        <td nowrap class=blue>Ӫ��Ԥ��</td>
        <td colspan=3>
            <input type="text" readonly class="InputGrey" name="t_simFeef2" size="10" v_minlength=1 v_maxlength=10  v_type=float index="9">
        </td>
    </tr>
    <tr>
        <td nowrap class=blue width="13%">������</td>
        <td nowrap width="25%">
            <input type="text" name="t_handFee" id="t_handFee" size="16"
            value="<%=(oriHandFee.trim().equals(""))?("0"):(oriHandFee.trim()) %>" v_type=float <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()" index="10">
        </td>
        <td nowrap class=blue width="13%">ʵ��</td>
        <td nowrap width="20%">
            <input type="text" name="t_factFee" id="t_factFee" size="16" onKeyUp="getFew()" index="11" v_type=float
            <%
                if(hfrf)
                {
            %>
                    readonly
            <%
                }
            %>
            >
        </td>
        <td nowrap class=blue width="10%">����</td>
        <td nowrap>
            <input type="text" class="InputGrey" name="t_fewFee" id="t_fewFee" size="16" readonly>
        </td>
    </tr>
    <tr>
        <td nowrap class=blue>��ע</td>
        <td nowrap colspan="5">
            <input type="text" class="InputGrey" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
        </td>
    </tr>
    <tr style="display:none">
        <td nowrap class=blue>�û���ע</td>
        <td nowrap colspan="5">
            <input type="text" name="t_op_remark" id="t_op_remark" size="60"  v_maxlength=60  v_type=string  maxlength=60 >
            <input type="hidden" name="phone_z" value="<%=phone_z%>">
        </td>
    </tr>
    <tr style="display:none">
        <td nowrap class=blue>�û���ע</td>
        <td nowrap colspan="5">
            <input name=assuNote v_must=0 v_maxlength=60 v_type="string" maxlength="60" size=60 index="12" value="">
        </td>
    </tr>
    <tr id="footer">
        <td nowrap colspan="6">
            <input class="b_foot" type="button" name="b_print" value="ȷ��&��ӡ" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" disabled index="13">
            <input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();document.all.t_newsimf.disabled=false;" index="14">
            <input class="b_foot" type="button" name="b_back" value="����" onClick="history.go(-1)" index="15">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
