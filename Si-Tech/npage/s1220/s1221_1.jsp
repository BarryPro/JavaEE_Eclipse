<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-29
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>



<%
    String opName="��������";
    String opCode = "1221";
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String work_Pwd = (String)session.getAttribute("password");
    boolean workNoFlag=false;
        //if(workNoFromSession.substring(0,1).equals("k"))
    workNoFlag=true;
    
    String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
    favStr[i]=temfavStr[i][0].trim();
    boolean hfrf=false;
    for(int j=0;j<favStr.length;j++)
    System.out.println("======= favStr ======="+favStr[j]+"==============");
        //ArrayList initArr = new ArrayList();
        //ArrayList groupArr = new ArrayList();
    
    String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
    
    String dirtPage=request.getParameter("dirtPage"); 
%>
<%
    request.setCharacterEncoding("GBK");
    
    HashMap hm=new HashMap();
    hm.put("1","û�пͻ�ID��");
    hm.put("3","�������");
    hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
    
    hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("13","δȡ������5����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=org_Code.substring(0,2)%>"  id="seq"/>
<script language=javascript>
<!--

  //core.loadUnit("debug");
  //core.loadUnit("rpccore");
 
  onload=function()
  {
   	//core.rpc.onreceive = doProcess;
    	self.status="";

<%
	if(ReqPageName.equals("s1220Main"))
	{
	  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
	  {        
%>   	 
	    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");	 
<%
	  }
	  else if(retMsg.equals("100"))
	  {
%>
    	rdShowMessageDialog('�ʻ�<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>��Ƿ��<%=WtcUtil.repNull(request.getParameter("oweFee"))%>Ԫ�����ܰ���ҵ��');	    
<%
	  }
      else if(retMsg.equals("101"))
	  {
%>
        rdShowMessageDialog('����<%=WtcUtil.repNull(request.getParameter("errCode"))%>��<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
<%
	  }
	}
%>


  }






//--------3---------��֤��ťר�ú���-------------
 
 function chkPass(){

    /*document.s1220.submit.disabled = true;
    if(!for0_9(document.s1220.loginAccept)){
    return false;
    }*/
    if(((document.all.phoneno.value).trim()).length<1)
    {
        rdShowMessageDialog("�������ֻ����룡");
        return;
    }
    if(document.s1220.loginAccept.value.length == 0){
        rdShowMessageDialog("��������ˮ�ţ�");
        return;
    }
    if(document.s1220.billDate.value.length == 0)
    {
        rdShowMessageDialog("���������ڣ�");
        return;
    }
    
    var myPacket = new AJAXPacket("QryCus_Info.jsp","�����ύ�����Ժ�......");
    
    myPacket.data.add("work_No",document.s1220.work_No.value);   
    myPacket.data.add("org_Code",document.s1220.org_Code.value); 
    myPacket.data.add("work_Pwd",document.s1220.work_Pwd.value);
    myPacket.data.add("op_code",document.s1220.op_code.value); 
    myPacket.data.add("phoneNo",document.s1220.phoneno.value);    
    myPacket.data.add("billDate",document.s1220.billDate.value);           
    myPacket.data.add("loginAccept",document.s1220.loginAccept.value);       
    core.ajax.sendPacket(myPacket);
    myPacket = null;
}
 
 
 //--------4---------doProcess����----------------
 
 
  function doProcess(packet)
  {
  	
  	
    var vRetPage=packet.data.findValueByName("rpcpage");
   
    if(vRetPage == "QryCus_Info"){

        var retCode = packet.data.findValueByName("retCode");
        var retMsg = packet.data.findValueByName("retMsg");
        var userId = packet.data.findValueByName("userId");
        var custName = packet.data.findValueByName("custName");
        var passWord = packet.data.findValueByName("passWord");
        var asIdtape = packet.data.findValueByName("asIdtape");
        var asIdname = packet.data.findValueByName("asIdname");
        var asIdiccid = packet.data.findValueByName("asIdiccid");
        var smTape = packet.data.findValueByName("smTape");
        var smName = packet.data.findValueByName("smName");
        var runCode = packet.data.findValueByName("runCode");
        var runName = packet.data.findValueByName("runName");
        var cardName = packet.data.findValueByName("cardName");
        var blocName = packet.data.findValueByName("blocName");
        var base_No = packet.data.findValueByName("base_No");
        var base_Name = packet.data.findValueByName("base_Name");
        var base_Date = packet.data.findValueByName("base_Date");
        var oldFee = packet.data.findValueByName("oldFee");
		var backFlag = packet.data.findValueByName("backFlag");
		var test = packet.data.findValueByName("test");
		var test1 = packet.data.findValueByName("test1");
		var test2 = packet.data.findValueByName("test2");
		var test3 = packet.data.findValueByName("test3");
		var VloginAccept = packet.data.findValueByName("VloginAccept");
		var oldsim = packet.data.findValueByName("oldsim");
		var newsim = packet.data.findValueByName("newsim");
	if(retCode == "000000"){
	    if(backFlag != "0")
		{
			rdShowMessageDialog("ԭʼ�����Ѿ�����!");
			return;
		}
		document.s1220.userId.value = userId;	
		document.s1220.custName.value = custName;
		document.s1220.passWord.value = passWord;
		document.s1220.asIdtape.value = asIdtape;
		document.s1220.asIdname.value = asIdname;	
		document.s1220.asIdiccid.value = asIdiccid;
		document.s1220.smTape.value = smTape;
		document.s1220.smName.value = smName;
		document.s1220.runCode.value = runCode;	
		document.s1220.runName.value = runName;
		document.s1220.cardName.value = cardName;
		document.s1220.blocName.value = blocName;
		document.s1220.base_No.value = base_No;	
		document.s1220.base_Name.value = base_Name;
		document.s1220.base_Date.value = base_Date;
		document.s1220.oldFee.value = oldFee;
		document.s1220.test.value = test;
		document.s1220.test1.value = test1;
		document.s1220.test2.value = test2;
		document.s1220.test3.value = test3;
		document.s1220.VloginAccept.value = VloginAccept;
		document.s1220.oldsim.value = oldsim;
		document.s1220.newsim.value = newsim;
		document.all.confirm.disabled=false;
		
	}else
	{
		rdShowMessageDialog("����:"+ retCode + "->" + retMsg,0);
		return;
	}    
    }
    
    
    
    
    
  }

 

//-------2---------��֤���ύ����-----------------



function go_check_simType10073(){
	    var packet = new AJAXPacket("/npage/s1170/ajax_check_simType10073.jsp","���Ժ�...");
        	packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
        	packet.data.add("opCode","<%=opCode%>");//
    core.ajax.sendPacket(packet,do_check_simType10073);
    packet =null;
}
function do_check_simType10073(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
    }else{//�����ɹ�
	    var result_flag = packet.data.findValueByName("result_flag");	
	    if(result_flag=="1"){
	    	rdShowMessageDialog("��ȥ��m405����ͨ�������շѽ��桱�˹�����");
	    }
    }
}

 function printCommit(){
 	
 	
/*
  	�������롰 �ƶ�����ͨ����Ʒ����ר���Ŀ����մ�������ĺ� hejwa add 2016��9��20��20:17:07
  	
  	���SIM�������ǡ�10073--NFC����ͨ������
		�����û�û�г���ͨ����ѡ�ʷ�(����ԤԼ��Ч��ԤԼʧЧ)�������������ʾ��
		��ʾ��ϢΪ������ȥ��****����ͨ�������շѽ��桯�˹����ѡ���***�ǲ������롣
  	*/
  	go_check_simType10073(); 	
 	
    getAfterPrompt();
	//У��newsim oldsim
    if(!checkElement(document.all.phoneno)) return false;	
   //��ӡ�������ύ��
   document.all.remark.value="������"+ document.all.newsim.value +"��Ϊ"+document.all.oldsim.value;
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
      
    // if(typeof(ret)!="undefined")
    //{
     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
        {
            
	      s1220.submit();
        }
	  if(ret=="remark")
	  {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {
	      s1220.submit();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     s1220.submit();
       }
    }	
    return true;
  }
  
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
    var h=198;
    var w=400;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    
    var pType="subprint";
    var billType="1";
    var sysAccept = "<%=seq%>";
    var mode_code = null;
    var fav_code = null;
    var area_code = null;
    var printStr = printInfo(printType);
    var phoneno = "<%=activePhone%>";
    /* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret=window.showModalDialog(path,printStr,prop);
    return ret;
  
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
    //retInfo+='<%=loginName%>'+"|";
    //retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|"; 
    cust_info+="�ͻ�������"+document.all.custName.value+"|";
    cust_info+="�ֻ����룺"+document.all.phoneno.value+"|";  
    cust_info+="֤�����룺"+document.all.asIdiccid.value+"|";
    
    opr_info+="ҵ�����ͣ�"+'<%=opName%>'+"|";
    opr_info+="�����ˮ"+document.all.VloginAccept.value+"|";
    
    note_info1+="��ע��"+document.all.remark.value+"|";
    note_info2+=document.all.t_op_remark.value+"|";
    
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    
    return retInfo;	
  }
//-->



 
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<title><%=opName%></title>
</head>

<body>

<form action="f1221BackCfm.jsp" method="POST" name="s1220"  onKeyUp="chgFocus(s1220)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">ҵ�����</div>
</div>
    <input type="hidden"  name="work_No" id="work_No" size="16" value="<%=work_no%>" >
    <input type="hidden" name="org_Code" id="org_Code" value="<%=org_Code%>">
    <input type="hidden"  name="work_Pwd" id="work_Pwd" size="16" value="<%=work_Pwd%>" >
    <input type="hidden" name="op_code" id="op_code" size="16" value="<%=opCode%>" >
    <input type="hidden"  name="userId" id="userId" size="16">
    <!--input type="test"  name="custName" id="custName" size="16"-->
    <input type="hidden"  name="passWord" id="passWord" size="16" value="">
    <input type="hidden"  name="asIdtape" id="Asidtape" size="16" value="" >
    <!--input type="hidden"  name="asIdname" id="asIdname" size="16" value="" -->
    <!--input type="hidden"  name="asIdiccid" id="asIdiccid" size="16" value="" -->
    <input type="hidden"  name="smTape" id="smTape" size="16" value="" >
    <!--input type="hidden"  name="smName" id="smName" size="16" value="" -->
    <input type="hidden"  name="runCode" id="runCode" size="16" value="" >
    <!--input type="hidden"  name="runName" id="runName" size="16" value="" -->
    <!--input type="hidden"  name="cardName" id="cardName" size="16" value="" -->
    <input type="hidden"  name="blocName" id="blocName" size="16" value="" >
    <!--input type="hidden"  name="base_No" id="base_No" size="16" value="" -->
    <input type="hidden"  name="base_Name" id="base_Name" size="16" value="" >
    <!--input type="hidden"  name="base_Date" id="base_Date" size="16" value="" -->
    <!--input type="hidden"  name="oldFee" id="oldFee" size="16" value="" -->
    <input type="hidden" name="test" size="16" value="" >
    <input type="hidden" name="test1" size="16" value="" >
    <input type="hidden" name="test2" size="16" value="" >
    <input type="hidden" name="test3" size="16" value="" >
    <input type="hidden"  name="VloginAccept" size="16" value="" >
    <input type="hidden"  name="oldsim" size="16" value="" >
    <input type="hidden"  name="newsim" size="16" value="" >
    <input type="hidden"  name="login_Accept"  value="<%=seq%>" >
    <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">


<table cellspacing="0">

    <tr> 
        <td class=blue nowrap>�û�����</td>
        <td nowrap> 
            <input class=InputGrey readOnly type="text" size="16" name="phoneno" id="phoneno" value="<%=activePhone%>" maxlength=11  index="6"> 
        </td>
        <td class=blue>��ˮ��</td>
        <td>
            <input type="text" size="16" v_type="loginAccept" v_must=1 name="loginAccept" id="loginAccept" index="3">
        </td>
        <td class=blue>����</td>
        <td>
            <input type="text" size="16" v_type="billDate" v_must=1 name="billDate" id="billDate" maxlength=8 index="3">
            <input class="b_text" type="button"  value="��ѯ" onClick="chkPass()">
        </td>
    </tr>
    
    
    <tr> 
        <td nowrap class="blue">�û�����</td>
        <td nowrap colspan="5">
            <input class="InputGrey"  type="text" size="16" name="custName" id="custName"  index="6" readonly >
        </td>
        
    </tr>
    <tr> 
        <td nowrap class=blue>֤������</td>
        <td nowrap> 
            <input class="InputGrey"  type="text" size="16" name="asIdname" id="asIdname"  index="8" readonly>
        </td>
        <td nowrap class=blue>֤������</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="asIdiccid" id="asIdiccid" size="16" readonly >
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>����״̬</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="runName" id="runName" size="16" readonly tabindex="0">
        </td>
        <td nowrap class=blue>��ͻ���־</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text" name="cardName" id="cardName" size="16" readonly >
        </td>
    </tr>
    <tr> 
        <td nowrap class="blue">��������</td>
        <td nowrap>  
            <input class="InputGrey" type="text"  name="base_No" id="base_No" size="16" readonly tabindex="0">
        </td>
        <td nowrap class="blue">����ʱ��</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="base_Date" id="base_Date" size="16" readonly tabindex="0">
        </td>
    </tr>
    <tr> 
        <td nowrap class="blue">���úϼ�</td>
        <td nowrap> 
            <input class="InputGrey" type="text"  name="oldFee" id="oldFee" size="16" readonly tabindex="0">
        </td>
        <td nowrap class="blue">�ͻ�Ʒ��</td>
        <td nowrap colspan=3> 
            <input class="InputGrey" type="text"  name="smName" id="smName" size="16" readonly tabindex="0">
        </td>
    </tr>
    
    <tr> 
        <td class="blue">��ע</td>
        <td colspan="5"> 
            <input type="text" class="InputGrey" name="remark" id="remark" size="60" readonly maxlength=30>
        </td>
    </tr>
    <tr style="display:none"> 
        <td class="blue">�û���ע</td>
        <td colspan="5"> 
            <input type="text" name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  index="28" maxlength=60> 
        </td>
    </tr>
  </table>
  <jsp:include page="/npage/public/hwReadCustCard.jsp">
		<jsp:param name="hwAccept" value="<%=seq%>"  />
		<jsp:param name="showBody" value="01"  />
	</jsp:include>
  <table>
    <tr id="footer"> 
        <td colspan="6"> 
            <input class="b_foot" type="button" name="confirm" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled >
            <input class="b_foot" type=reset name=back value="���" onClick="document.all.confirm.disabled=true;" >
            <input class="b_foot" type="button" name="b_back" value="�ر�"  onClick="removeCurrentTab()" index="28">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 

</html>
