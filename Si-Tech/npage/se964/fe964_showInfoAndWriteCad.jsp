<%
    /*************************************
    * ��  ��: ��ȡ����ѡ��SIM�� e964
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-7-6
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode=request.getParameter("opCode");
		System.out.println("gaopengSeeLog================opCode="+opCode);
    String opName=request.getParameter("opName");
    String loginNo = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String phoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
	  String userCardNo = WtcUtil.repNull((String)request.getParameter("userCardNo"));
	  String custName = WtcUtil.repNull((String)request.getParameter("custName"));
	  String qryPhoneNo = WtcUtil.repNull((String)request.getParameter("qryPhoneNo"));
	  String brandName = WtcUtil.repNull((String)request.getParameter("brandName"));
	  String idName = WtcUtil.repNull((String)request.getParameter("idName"));
	  String custIccid = WtcUtil.repNull((String)request.getParameter("custIccid"));
	  String simCaidName = WtcUtil.repNull((String)request.getParameter("simCaidName"));
	  String custAddr = WtcUtil.repNull((String)request.getParameter("custAddr"));
	  String idNo = WtcUtil.repNull((String)request.getParameter("idNo"));
	  String simType = WtcUtil.repNull((String)request.getParameter("simType"));/*sim������*/
	  String saleFlag = WtcUtil.repNull((String)request.getParameter("saleFlag"));
	  String hlrCodeName = WtcUtil.repNull((String)request.getParameter("hlrCodeName"));
	  String simNo = WtcUtil.repNull((String)request.getParameter("simNo"));
	  String prePayFee = WtcUtil.repNull((String)request.getParameter("prePayFee"));/*Ԥ���*/
	  String simPayFee = WtcUtil.repNull((String)request.getParameter("simPayFee"));/*sim����*/
	  String workNo =(String)session.getAttribute("workNo");
	  String groupId =(String)session.getAttribute("groupId");
    
    /***************
     * begin �ʷѱ���+�ʷ�����   
     ***************/
	  String offerIdStr = WtcUtil.repNull((String)request.getParameter("offerIdStr"));/*�ʷѱ����б����ʷ�+��ѡ�ʷ�*/
	  //offerIdStr = "1200,1201,1202,1203,1204,";
	  String[] offerIds = offerIdStr.split("\\,");
	  String offerIdMain = offerIds[0]; /*���ʷѱ���*/
	  
	  String offerNameStr = WtcUtil.repNull((String)request.getParameter("offerNameStr"));/*�ʷ������б����ʷ�+��ѡ�ʷ�*/
	  //offerNameStr = "���ʷ�����,��ѡ�ʷ�����1,��ѡ�ʷ�����2,��ѡ�ʷ�����3,��ѡ�ʷ�����4,��ѡ�ʷ�����5,";
	  String[] offerNames = offerNameStr.split("\\,");
	  String offerNameMain = offerNames[0]; /*���ʷ�����*/
	  String offerInfoOptional = "";        /*��ѡ�ʷѱ���+���� �ַ���*/
	  for(int i=1;i<offerIds.length;i++){
	    offerInfoOptional = offerInfoOptional +"("+ offerIds[i]+"��"+offerNames[i] +")��";
	  }
    /**********************
     *end �ʷѱ���+�ʷ����� 
     ***********************/
	  
	  /*******************
	   *begin �ʷ����� 
	   ******************/
	  String offerComStr = WtcUtil.repNull((String)request.getParameter("offerComStr"));/*�ʷ������б����ʷ�+��ѡ�ʷ�*/
	  //offerComStr = "���ʷ�����,��ѡ�ʷ�����1,��ѡ�ʷ�����2,��ѡ�ʷ�����3,��ѡ�ʷ�����4,";
	  String[] offerComs = offerComStr.split("\\,");
	  String offerComMain = offerComs[0]; /*���ʷ�����*/
	  String offerComOptional = "";       /*��ѡ�ʷ�����*/
	  for(int j=1;j<offerComs.length;j++){
	    offerComOptional = offerComOptional + offerComs[j] +"��";
	  }
	  /*******************
	   *end �ʷ����� 
	   ******************/
	  /***************
     * begin �ط�����+�ط�����   
     ***************/
	  String spelServIdStr = WtcUtil.repNull((String)request.getParameter("spelServIdStr"));/*�ط������б�*/
	  //spelServIdStr = "�ط�����1,�ط�����2,�ط�����3,�ط�����4,";
	  String[] spelServIds = spelServIdStr.split("\\,");
	  String spelServInfo = "";        /*�ط�����+���� �ַ���*/
	  
	  String spelServNameStr = WtcUtil.repNull((String)request.getParameter("spelServNameStr"));/*�ط������б�*/
	  //spelServNameStr = "�ط�����1,�ط�����2,�ط�����3,�ط�����4,";
	  String[] spelServNames = spelServNameStr.split("\\,");
	  
	  for(int z=0;z<spelServIds.length;z++){
	    spelServInfo = spelServInfo + spelServIds[z]+":"+spelServNames[z] +"��";
	  }
	  if(spelServInfo!=""){
	    spelServInfo = spelServInfo.substring(0,spelServInfo.length()-1);
	  }
	  /***************
     * end �ط�����+�ط�����   
     ***************/
     
    /***************
     *begin ��ȡϵͳʱ��
     ***************/
    Date currentTime = new Date(); 
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
    String currentTimeString = formatter.format(currentTime);
    java.text.SimpleDateFormat formatter1 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentTimeStringFormat = formatter1.format(currentTime);
    /***************
     *end ��ȡϵͳʱ��
     ***************/
     
     String simResBrandCode = "";
%>  
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

<%
	/*2014/05/26 11:10:47 gaopeng ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� ����sql����ѯ����*/
	/*gaopeng 2014/05/26 11:07:39 ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� ��ѯsql �����K06 �ٽ���У��*/
	String simResSql = "select brand_code from srescode where res_code = '"+simType+"'";
%>	
	<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCodeRes" retmsg="retMsgRes">
		<wtc:sql><%=simResSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultRes" scope="end"/>

<%
	if(resultRes.length > 0 && "000000".equals(retCodeRes)){
		simResBrandCode = resultRes[0][0];
		System.out.println("gaopengSeeLog===simResBrandCode="+simResBrandCode);
	}
%>
			 <wtc:service name="sG842Chk" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
	    <wtc:param value=" "/>
	    <wtc:param value="01"/>
	    <wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=password%>"/>
	 		<wtc:param value="<%=qryPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="��ѯ�˺����Ƿ��Ѿ�д���ɹ���"/>		
	</wtc:service>				
		<wtc:array id="dcust2s" scope="end" />	
<%	
String kongkakahao="";
String biaozhiwei="";/*0��д���ɹ�ֱ�ӵ���ȷ�Ϸ��񼴿ɣ�1��δд���ɹ�����Ҫ�������̲���*/
if(retCode2.equals("000000")) {
		if(dcust2s.length>0) {
				biaozhiwei=dcust2s[0][0];
				kongkakahao=dcust2s[0][1];
		}
}
//biaozhiwei="0";
//kongkakahao="0806001650003224";
System.out.println("�Ƿ��Ѿ�д���ɹ�"+biaozhiwei);
System.out.println("�տ�����"+kongkakahao);
		
%>
			
<HTML>
<HEAD>
    <TITLE>��ȡ����ѡ��SIM��</TITLE>
<script language="javascript">
 	function goBack(){
	  window.location.href="fe964_queryInfo.jsp?opCode=<%=opCode%>&opName=<%=opName%>&idIccid=<%=userCardNo%>&phoneNo=<%=phoneNo%>";
	}
</script>
</HEAD>
<body>
<form name="frme964" method="post" >
 	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
	<%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">�û���Ϣ</div>
  </div>
	<table>
		<tr>
		  <td class="blue" width="15%">�������</td>
			<td>
				<%=qryPhoneNo%>
			</td>
			<td class="blue" width="15%">�ͻ�����</td>
			<td width="15%">
				<%=custName%>
			</td>
				<td class="blue" width="15%">֤������</td>
			<td>
				<%=idName%>
			</td>
		</tr>
		<tr>
		  <td class="blue" width="15%">֤������</td>
			<td>
				<%=custIccid%>
			</td>
		  <td class="blue" width="15%">�û�����</td>
			<td>
				<%=idNo%>
			</td>
			<td class="blue" width="15%">sim����</td>
			<td>
				<%=simCaidName%>
			</td>
		</tr>
		<tr>
		   <td class="blue" width="15%">����״̬</td>
			<td>
				<%=saleFlag%>
			</td>
		 <td class="blue" width="15%">�û�Ʒ��</td>
			<td>
				<%=brandName%>
			</td>
		  <td class="blue" width="15%">�������</td>
			<td>
				<%=hlrCodeName%>
			</td>
		</tr>
		<tr>
			<td class="blue" width="15%">�ͻ���ַ</td>
			<td colspan="6">
				<%=custAddr%>
			</td>
		</tr>
		<tr>
			<td class="blue" width="15%">�ͻ�����</td>
			<td>
				<input name="realUserName" id="realUserName" value="" v_type="string"  maxlength="60" size=20 index="19" v_maxlength=60 class="InputGrey" readonly />
			</td>
			<td class="blue" width="15%">֤������</td>
			<td>
				<input name="realUserIccId"  id="realUserIccId"  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18" value="" class="InputGrey" readonly />
				<input type="hidden" name="subFlag"  id="subFlag"  value="0"/>
			</td>
			<td colspan="2">
				<input type="button" id="dukaBut1" name="dukaBut1" class="b_text" value="����" onclick="Idcard_realUser()" <%if(biaozhiwei.equals("0")){%> disabled<%}%>/>
    			<input type="button" id="dukaBut2" name="dukaBut2" class="b_text" value="����(2��)" onclick="Idcard2()" <%if(biaozhiwei.equals("0")){%> disabled<%}%> />
    			<input type="button" id="jiaoyanBut" name="jiaoyanBut" class="b_text" value="У��" onclick="go_checkIdCard()" disabled="disabled" />
			</td>
		</tr>
		<tr>
      <td colspan="6">
        <hr>
      </td>
    </tr>
    <tr>
			<td class="blue" width="15%">sim����</td>
			<td colspan="6">
			  <div align="left">
			    <%=simNo%>
          <font color="red">*</font>
           <input class="b_text" id="ducard" type="button" name="ducard" value="����" onClick="readcardss()"  index="19"  disabled/>&nbsp;
           <input class="b_text" id="b_write" type="button" name="b_write" value="д��" onmouseup="writechg(this)" onkeyup="if(event.keyCode==13)writechg()"  index="19"  disabled/>
          <input type="hidden" name="flg_normal" id="flg_normal" value="0">
        </div>
			</td>
		</tr>
		<tr > 
			  <td colspan="6" align="center" id="footer">
			  				<input class="b_foot" name="gengxins" onClick="gengxinsj()" type="button" value="����SIM��Ϣ" disabled/>
			&nbsp;
			<input class="b_foot" name="subUptBtn" id="subUptBtn" onClick="printCommit()" type="button"  value="ȷ��"  <%if(!biaozhiwei.equals("1")){%> disabled<%}%>/>
			&nbsp; 
			<input class="b_foot" name="back" onClick="goBack()" type="button" value="����" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
			&nbsp;
			</td>
		</tr>
	</table>
</div>
<input type="hidden" name="cardtype_bz"  value="s" />
<input name=simType id="simType" type=hidden value="<%=simType%>" />
<input name=simCode id="simCode" type=hidden value="<%=simNo%>" />
<input name=simCodeBack id="simCodeBack" type=hidden value="" />
<input name=phoneNo id="phoneNo" type=hidden value="" />
<input type="hidden" name="simCodeCfm" id="simCodeCfm"   />
<input type="hidden" name="cardstatus" id="cardstatus"   />
<input name="cardNo" id="cardNo" value=""  />
<input type="hidden" name="idNo" id="idNo" value="<%=idNo%>"  />
<input type="hidden" name="prePayFee" id="prePayFee" value="<%=prePayFee%>"  />
<input type="hidden" name="simPayFee" id="simPayFee" value="<%=simPayFee%>"  />
<input name=writecardbz type=hidden value="" />
<input name="qryPhoneNo" id="qryPhoneNo" type=hidden value="<%=qryPhoneNo%>" />

<%@ include file="/npage/include/public_smz_check.jsp" %>
  <%@ include file="/npage/include/footer.jsp" %>
</form>
<script language="javascript">
	/*2013/08/15 10:26:01 gaopeng �����������*/
	var simtypess="";
	function readcardss() {
		if($("#subFlag").val()=="0"){
	    	rdShowMessageDialog("���֤У��û��ͨ�����������!");
	    	return false;
	    }
		//document.all.b_write.disabled=false;
  		 var phone = '<%=qryPhoneNo%>';
  		 simtypess="";
  		 /****���������ƹ���ȡSIM������****/
  		 /* 
        * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
        */
  		 path ="http://10.110.0.125:33000/writecard/writecard/ReadCardInfo.jsp";
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
    	simtypess=rescode_strstr.substr(1,rescode_strstr.length-2);
    	 document.all.b_write.disabled=false;
    	 
    	 
    }
	var retsimno="";
  function writechg(obj){
  	<%--if("<%=simResBrandCode%>"=="K06" && "<%=simType%>" != simtypess){
			rdShowMessageDialog("��վ�ṩ��sim�����������sim�����Ͳ�ƥ��,������д����",0);
	    return false;   
		}--%>
  
  	
  	
    var path = "<%=request.getContextPath()%>/npage/se964/fe964_fwritecard.jsp";
    path = path + "?regioncode=" + "<%=regionCode%>";
    path = path + "&sim_type=" + simtypess;
    path = path + "&sim_no=" +"<%=simNo%>";
    path = path + "&op_code=" +"<%=opCode%>";
    path = path + "&phone="+"<%=qryPhoneNo%>"+"&pageTitle=" + "д��";
    path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; //add by diling  for ���ڹ��ֹ�˾�����Ż�Զ��д�������������ʾ
    var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    
    if(typeof(retInfo) == "undefined"){	
    	document.all.writecardbz.value="1"; 
    	document.all.subUptBtn.disabled=true;//д��ʧ�ܲ����ύ
    	document.frme964.gengxins.disabled=false;
    	rdShowMessageDialog("д��ʧ��");
    	return false;   
    } 
    var retsimcode=oneTok(oneTok(retInfo,"|",1));
    retsimno=oneTok(oneTok(retInfo,"|",2));
    var cardstatus=oneTok(oneTok(retInfo,"|",3));
    var cardNo=oneTok(oneTok(retInfo,"|",4));
      /*
    var retsimcode="0";
    var retsimno="89860070089810966258";
    var cardstatus="00";
    var cardNo="0806001650003224";
  */
    if(retsimcode=="0"){
      rdShowMessageDialog("д���ɹ�");
      document.all.writecardbz.value="0";
      document.all.simCodeBack.value=retsimno;
      document.all.simCodeCfm.value=retsimno;
      document.all.cardstatus.value=cardstatus;
      document.all.cardNo.value=cardNo;/*�տ�����*/
      document.all.subUptBtn.disabled=false;//д���ɹ����ύ
    }else{
      document.all.writecardbz.value="1";
      document.all.subUptBtn.disabled=true;
      document.frme964.gengxins.disabled=false;
      rdShowMessageDialog("д��ʧ��");
    }
  }
  
  	function gengxinsj() {
		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/sg603/fg603Update.jsp","���ڸ���sim��Ϣ���Ժ�......");
		myPacket.data.add("phonenos",'<%=qryPhoneNo%>');
		myPacket.data.add("opcode",'<%=opCode%>');
		core.ajax.sendPacket(myPacket,doreturnmsgs);
		myPacket = null;
	}
	
	function doreturnmsgs(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
			rdShowMessageDialog("���ݸ��³ɹ��������²�����",2);
			goBack();
		}else {
			rdShowMessageDialog("���ݸ���ʧ�ܣ��������"+retcode+"������ԭ��"+retmsg,0);
		}
	}
	
	
  
  function printCommit()
  {
    getAfterPrompt();

    var ret =showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
    se964_show_Bill_Prt();
    //return false;
    if(typeof(ret)!="undefined"){
      if((ret=="confirm")){
        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1){
          frmCfm();
        }
      }
      if(ret=="continueSub"){
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
          frmCfm();
        }
      }
    }else{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
        frmCfm();
      }
    }
    return true;
  }
  
  
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  
  		var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     		var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
		var sysAccept ="<%=printAccept%>";                       // ��ˮ��
		var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
		var mode_code=null;                        //�ʷѴ���
		var fav_code=null;                         //�ط�����
		var area_code=null;                    //С������
		var opCode =   "<%=opCode%>";                         //��������
		var phoneNo = "<%=qryPhoneNo%>";                         //�ͻ��绰		  
  
	  	//��ʾ��ӡ�Ի���
	    	var h=200;
	    	var w=410;
	     	var t=screen.availHeight/2-h/2;
	     	var l=screen.availWidth/2-w/2;
	     	
	     	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);     	
  }
  
  function printInfo(printType){
    var retInfo = "";
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
    
    cust_info+="�ֻ����룺"+"<%=qryPhoneNo%>"+"|";
    cust_info+="�ͻ�������"+"<%=custName%>"+"|";
    cust_info+="�ͻ���ַ��"+"<%=custAddr%>"+"|";
    cust_info+="֤�����룺"+"<%=custIccid%>"+"|";
    
    opr_info+="����ʱ�䣺"+"<%=currentTimeStringFormat%>"+""+"  �û�Ʒ�ƣ�"+"<%=brandName%>"+"|";
    opr_info+="����ҵ����ȡ����ѡ��SIM��"+""+"  ������ˮ��"+"<%=printAccept%>"+"|";
    opr_info+="SIM���ţ�"+retsimno+""+"  SIM���ѣ�"+"<%=simPayFee%>"+"|";
    opr_info+="Ԥ��"+"<%=prePayFee%>Ԫ"+"|";
    opr_info+="���ʷѣ�"+"<%=offerIdMain%>"+" "+"<%=offerNameMain%>"+""+"  ��Чʱ��:"+"<%=currentTimeString%>"+"|";
    opr_info+="��ѡ�ʷѣ�"+"<%=offerInfoOptional%>"+"|";
    opr_info+="��ͨ�ط���"+"<%=spelServInfo%>"+"|";
    
    note_info1+="���ʷ�������"+"<%=offerComMain%>"+"|";
    note_info1+="��ѡ�ʷ�������"+"<%=offerComOptional%>"+"|";
    note_info1+="��ע������Ա"+"<%=loginNo%>"+""+"�Կͻ�"+"<%=qryPhoneNo%>"+"������ȡ����ѡ��SIM��ҵ�����!"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
  }
  
//��ӡ��Ʊ
  function se964_show_Bill_Prt(){
  			var  billArgsObj = new Object();
  			$(billArgsObj).attr("10001","<%=loginNo%>");     //����
  			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
  			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
  			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
  			$(billArgsObj).attr("10005",$("#prt_cust_name").val());   //�ͻ�����
  			$(billArgsObj).attr("10006","��ȡ����ѡ��sim��");    //ҵ�����
  			
  			$(billArgsObj).attr("10008","<%=qryPhoneNo%>");    //�û�����
  			$(billArgsObj).attr("10015","<%=simPayFee%>");   //���η�Ʊ���
  			$(billArgsObj).attr("10016","<%=simPayFee%>");   //��д���ϼ�
  			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
  			/*10028 10029 ����ӡ*/
  		  	$(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
  			$(billArgsObj).attr("10029","");	 //Ӫ������	
  			$(billArgsObj).attr("10030","<%=printAccept%>");   //��ˮ�ţ�--ҵ����ˮ
  			$(billArgsObj).attr("10036","e964");   //��������
  			/**/

  			
  			/*�ͺŲ���*/
  			$(billArgsObj).attr("10061","");	       //�ͺ�
  			$(billArgsObj).attr("10062","");	//˰��
  			$(billArgsObj).attr("10063","");	//˰��	   
  	    	$(billArgsObj).attr("10071","6");	//
  	 		$(billArgsObj).attr("10076",0);
   			
   			$(billArgsObj).attr("10083", ""); //֤������
   			$(billArgsObj).attr("10084", ""); //֤������
   			$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
   			$(billArgsObj).attr("10065", ""); //����˺�
   			$(billArgsObj).attr("10087", $("#stb_id").val()); //imei����
   			
  			$(billArgsObj).attr("10041", "����ѡ��sim����");           //Ʒ�����
  			$(billArgsObj).attr("10042","̨");                   //��λ
  			$(billArgsObj).attr("10043","1");	                   //����
  			$(billArgsObj).attr("10044",0);	                //����
  			
   			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
   			$(billArgsObj).attr("10072","1"); //1--������Ʊ  2--�����෢Ʊ  2--�˷��෢Ʊ

   			$(billArgsObj).attr("10088","e964"); //�վ�ģ��
   			
   			
  			var h=210;
  			var w=400;
  			var t=screen.availHeight/2-h/2;
  			var l=screen.availWidth/2-w/2;
  			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
  			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
  			
  						//��Ʊ��Ŀ�޸�Ϊ��·��
  			$(billArgsObj).attr("11216","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
  			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";

  			var loginAccept = "<%=printAccept%>";
  			var path = path +"&loginAccept="+loginAccept+"&opCode=m358&submitCfm=submitCfm";
  			var ret = window.showModalDialog(path,billArgsObj,prop);		

  }
  
  function frmCfm(){
  		
			<%
			if(biaozhiwei.equals("0")){
			%> 
				$("#cardNo").val("<%=kongkakahao%>");
			<%
		  }else {
		  %> 

		  <%			
			}
			%>
			
    frme964.action="fe964_subInfo.jsp";
    frme964.submit();
    return true;
  }
  
function Idcard_realUser() {
	//��ȡ�������֤
	var fso = new ActiveXObject("Scripting.FileSystemObject"); //ȡϵͳ�ļ�����
	var tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
	var strtemp = tmpFolder + "";
	var filep1 = strtemp.substring(0, 1)//ȡ��ϵͳĿ¼�̷�
	var cre_dir = filep1 + ":\\custID";//����Ŀ¼
	//�ж��ļ����Ƿ���ڣ��������򴴽�Ŀ¼
	if (!fso.FolderExists(cre_dir)) {
		var newFolderName = fso.CreateFolder(cre_dir);
	}
	
	var picpath_n = cre_dir + "\\aaa_100.jpg";
	var result;
	var result2;
	var result3;
	$("#dukaBut1").attr("disabled","");
	$("#dukaBut2").attr("disabled","");
	$("#jiaoyanBut").attr("disabled","disabled");
	result = IdrControl1.InitComm("1001");
	if (result == 1) {
		result2 = IdrControl1.Authenticate();
		if (result2 > 0) {
			result3 = IdrControl1.ReadBaseMsgP(picpath_n);
			if (result3 > 0) {
				var name = IdrControl1.GetName();
				var code = IdrControl1.GetCode();
				document.all.realUserName.value = name;//����
				document.all.realUserIccId.value = code;//���֤��
				if(document.all.realUserName.value!=""&&document.all.realUserIccId.value!=""){
					$("#dukaBut1").attr("disabled","disabled");
					$("#dukaBut2").attr("disabled","disabled");
					$("#jiaoyanBut").attr("disabled","");
				}
			} else {
				IdrControl1.CloseComm();
				rdShowMessageDialog("�����½���Ƭ�ŵ���������");
			}
		} else {
			IdrControl1.CloseComm();
			rdShowMessageDialog("�˿ڳ�ʼ�����ɹ�", 0);
		}
		IdrControl1.CloseComm();
	}
	fso.DeleteFolder(cre_dir);
}


	function Idcard2() {
		//ɨ��������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject"); //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp = tmpFolder + "";
		var filep1 = strtemp.substring(0, 1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1 + ":\\custID";//����Ŀ¼
		if (!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
		var ret_open = CardReader_CMCC.MutiIdCardOpenDevice(1000);
		if (ret_open != 0) {
			ret_open = CardReader_CMCC.MutiIdCardOpenDevice(1001);
		}
		var cardType = "11";
		$("#dukaBut1").attr("disabled","");
		$("#dukaBut2").attr("disabled","");
		$("#jiaoyanBut").attr("disabled","disabled");
		if (ret_open == 0) {
			//alert(v_printAccept+"--"+str);
			//�๦���豸RFID��ȡ
			var ret_getImageMsg = CardReader_CMCC.MutiIdCardGetImageMsg(cardType, "c:\\aaa.jpg");
			if (ret_getImageMsg == 0) {
				//����֤������ϳ�
				var xm = CardReader_CMCC.MutiIdCardName;
				var zjhm = CardReader_CMCC.MutiIdCardNumber; //֤������		
				document.all.realUserName.value = xm;//����
				document.all.realUserIccId.value = zjhm;//���֤��
				if(document.all.realUserName.value!=""&&document.all.realUserIccId.value!=""){
					$("#dukaBut1").attr("disabled","disabled");
					$("#dukaBut2").attr("disabled","disabled");
					$("#jiaoyanBut").attr("disabled","");
				}
			} else {
				rdShowMessageDialog("��ȡ��Ϣʧ��");
				return;
			}
		} else {
			rdShowMessageDialog("���豸ʧ��");
			return;
		}
		fso.DeleteFolder(cre_dir);
		//�ر��豸
		var ret_close = CardReader_CMCC.MutiIdCardCloseDevice();
		if (ret_close != 0) {
			rdShowMessageDialog("�ر��豸ʧ��");
			return;
		}
	}
	function go_checkIdCard(){
		var myPacket = new AJAXPacket("fe964_checkIdCard.jsp","����У�����֤����......");
		myPacket.data.add("cust_name",$("#realUserName").val());
		myPacket.data.add("id_iccid",$("#realUserIccId").val());
		core.ajax.sendPacket(myPacket,do_checkIdCard);
		myPacket = null;
	}
	function do_checkIdCard(packet){
		var retcode = packet.data.findValueByName("return_code");
		var retmsg = packet.data.findValueByName("return_msg");
		if(retcode=="000000"){
			var s_result = packet.data.findValueByName("s_result");
			if(s_result=="0"){
				$("#dukaBut1").attr("disabled","");
				$("#dukaBut2").attr("disabled","");
				$("#jiaoyanBut").attr("disabled","disabled");
				rdShowMessageDialog("���֤У��ʧ��!");
				$("#subFlag").val("0");
			}
			else{
				$("#dukaBut1").attr("disabled","disabled");
				$("#dukaBut2").attr("disabled","disabled");
				$("#jiaoyanBut").attr("disabled","disabled");
				rdShowMessageDialog("���֤У��ɹ�!");
				$("#subFlag").val("1");
				document.all.ducard.disabled=false;
			}
		}
	}
</script>
</body>


<object id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"/> 
<%@ include file="/npage/sq100/interface_provider.jsp" %>
</HTML>

