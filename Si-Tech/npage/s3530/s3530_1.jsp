        

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=GB2312" %>

<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>

 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	//==============================��ȡӪҵԱ��Ϣ
    String[][] result = new String[][]{};
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	  String regionCode = (String)session.getAttribute("regCode");
	

	
	String phoneNo = request.getParameter("phoneNo");
 	String opCode  =request.getParameter("busyType");
 	String clubType  =request.getParameter("clubType");
	String opName = "";
	String readType ="";
	String sqlInpoint = "";
	String[][] InpointStrTemp = new String[][]{};
	String inpointTemp = "";
	
	if(opCode.equals("3530")){
		opName="���";
		if(clubType.equals("01"))
			sqlInpoint = "select favour_point from smarkfavcode where favour_code='CL01' and sm_code='gn' and region_code='"+regionCode+"'";
		else if(clubType.equals("02"))
			sqlInpoint = "select favour_point from smarkfavcode where favour_code='YM01' and sm_code='gn' and region_code='"+regionCode+"'";
			
		System.out.println("  sqlInpoint="+sqlInpoint);
%>
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlInpoint%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>
<%		
		//InpointArrTemp = coTemp.spubqry32("1",sqlInpoint);
		InpointStrTemp = result_t3;
		inpointTemp = InpointStrTemp[0][0];
		readType ="";
	}else if(opCode.equals("3538")){
		opName="����";
		readType="readonly";
	}else if(opCode.equals("3531")){
		opName="�˻�";
		readType="readonly";
	}else{
		opName="������";
		readType="readonly";
	}

    
	//=======================��ò�����ˮ
	String printAccept="";
	printAccept = getMaxAccept();
	String exeDate="";
    exeDate = getExeDate("1","3530");
	
    String [] inParas = new String[4];
	
	inParas[0] = phoneNo;
	inParas[1] = opCode;
	inParas[2] = workno;
	inParas[3] = clubType;
	//String[] ret = impl.callService("s3530Qry",inParas,"14");
%>

    <wtc:service name="s3530Qry" outnum="16" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />		
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />

<%	
	String retCode= code1;
	String retMsg = msg1;
	
	if (result_t1 != null && code1.equals("000000"))
	{ 
		String custName = result_t1[0][2];
		String custAddress = result_t1[0][3];
		String icType = result_t1[0][4];
		String icIccid = result_t1[0][5];
		String smCode = result_t1[0][6];
		String belongCode = result_t1[0][7];
		String runCode = result_t1[0][8];
		String vipGrade = result_t1[0][9];
		String currentPoint = result_t1[0][10];
		String inTime = result_t1[0][11];
		String expTime = result_t1[0][12];
		String cardNo = result_t1[0][13];
	/*	
		System.out.println("custName="+custName);
		System.out.println("custAddress="+custAddress);
		System.out.println("icType="+icType);
		System.out.println("icIccid="+icIccid);
		System.out.println("smCode="+smCode);
		System.out.println("belongCode="+belongCode);
		System.out.println("runCode="+runCode);
		System.out.println("vipGrade="+vipGrade);
		System.out.println("currentPoint="+currentPoint);
		System.out.println("inTime="+inTime);
		System.out.println("expTime="+expTime);
		System.out.println("cardNo="+cardNo);
*/
%>

<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<title>������BOSS-VIP���ֲ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY onLoad="init()">
<FORM action="s3530Cfm.jsp" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">�Ἦ����</div>
	</div>

<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="loginAccept" value="<%=printAccept%>">


              <table  cellspacing="0">
                <tr> 
                  <td class="blue">��������</td>
                  <td> 
                    <input type="text"   readonly   Class="InputGrey" name="opName"  value="<%=opName%>">
                  </td>
                  <td >&nbsp;</td>
                  <td> &nbsp;
				  </td>
				  <tr id="newcardNo" style="display:none">
				  <td  class="blue">�¿���</td>
                  <td> 
					<input type="text"   name="oldcardNo"  value="">
					 <font class="orange">*</font>
                  </td>
				  <td >&nbsp;</td>
                  <td>&nbsp;</td>
				</tr>
				<tr id="oldloginAccept1" style="display:none">
				 <td  class="blue">������ˮ</td>
                  <td> 
					<input type="text"   name="oldloginAccept"  value="">
					 <font class="orange">*</font>
                  </td>
				  <td ></td>
                  <td></td> 
				</tr>
                <tr> 
                  <td class="blue">�ͻ�����</td>
                  <td> 
                    <input type="text"  readonly   Class="InputGrey" name="custName" value="<%=custName%>">
                  </td>
                  <td class="blue">�ֻ����� </td>
                  <td> 
                    <input type="text" name="phoneNo"  readonly  Class="InputGrey" value="<%=phoneNo%>">
                  </td>
                </tr>

				<tr> 
                  <td class="blue">�ͻ���ַ</td>
                  <td> 
                    <input type="text"  readonly  size="38" Class="InputGrey" name="custAddress" value="<%=custAddress%>">
                  </td>
                 <td class="blue">ҵ��Ʒ��</td>
                  <td> 
                    <input type="text"   readonly   Class="InputGrey" name="smCode" value="<%=smCode%>">
                  </td> 
                </tr>

                <tr id="bat_id"> 
                <td class="blue">֤������ </td>
                  <td> 
                    <input type="text" name="icType"  readonly   Class="InputGrey"  value="<%=icType%>">
                  </td>  
				  <td class="blue">֤������</td>
                   <td> 
                    <input type="text"  readonly   Class="InputGrey" name="icIccid" value="<%=icIccid%>">
                  </td>
                </tr>
                <tr id="phoneId"> 
                  <td class="blue">��������</td>
                  <td> 
                    <input type="text" readonly   Class="InputGrey"  name="belongCode" value="<%=belongCode%>" >
                  </td>
                  <td class="blue">����״̬</td>
                  <td> 
                    <input type="text"   readonly   Class="InputGrey" name="runCode" value="<%=runCode%>">
                  </td>
                </tr>
                 <tr   nowrap> 
                  <td class="blue">VIP����</td>
                  <td> 
                    <input type="text"   readonly   Class="InputGrey" name="vipGrade" value="<%=vipGrade%>">
                  </td>
                  <td class="blue">��ǰ����</td>
                  <td> 
                    <input type="text"  readonly   Class="InputGrey" name="currentPoint"  value="<%=currentPoint%>">
                  </td>
				  </tr>
                 <tr   nowrap> 
                  <td class="blue">���ʱ��</td>
                  <td> 
                    <input type="text"    name="inTime" value="" <%=readType%>>
                  </td>
                  <td class="blue">��Ա��Ч����</td>
                  <td> 
                    <input type="text"   name="expTime"  value="" <%=readType%>>
                  </td>
				  </tr>
				<tr   nowrap> 
                  <td class="blue">��Ա����</td>
                   <td colspan="3" width="86%"> 
                    <input type="text"    name="cardNo" value=""  maxlength="8" <%=readType%>>
                    <input type="hidden"    name="clubType" value="<%=clubType%>">
                  </td>     
				  </tr>

                <tr nowrap> 
                  <td class="blue">��ע</td>
                  <td colspan="3" width="86%"> 
                    <input type="text"  name="opNote" value=""  size="80"  readonly   Class="InputGrey">
				  </td>
                </tr>
				<tr> 
            <td noWrap colspan="6" id="footer">
				<div align="center"> 
	     		<input type="button" name="print"  value="ȷ��&��ӡ" onClick="doprint()"  class="b_foot_long" >
                      &nbsp;
                <input type="button" name="return1"  value="����" onClick="history.go(-1);" class="b_foot">
                      &nbsp; 
                <input type="button" name="close1"  value="�ر�" onClick="removeCurrentTab()" class="b_foot">
              </div>
            </td>
        </tr>
			</table>

 <%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
<!--
function init()
{
	if("<%=opCode%>"=="3530"){
		document.frm.inTime.value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>";
		document.frm.expTime.value='<%=exeDate%>';
		document.frm.oldloginAccept.style.display="none";
		document.frm.oldcardNo.style.display="none";
		
	}else if("<%=opCode%>"=="3531"){
		document.frm.inTime.value="<%=inTime%>";
		document.frm.expTime.value="<%=expTime%>";
		document.frm.cardNo.value="<%=cardNo%>";
	}else if("<%=opCode%>"=="3537"){
		document.frm.inTime.value="<%=inTime%>";
		document.frm.expTime.value="<%=expTime%>";
		document.frm.cardNo.value="<%=cardNo%>";
		document.all.oldloginAccept1.style.display="block";
		document.all.newcardNo.style.display="none";
	}else{
		//alert("dddddddddd");
		document.frm.inTime.value="<%=inTime%>";
		document.frm.expTime.value="<%=expTime%>";
		document.frm.cardNo.value="<%=cardNo%>";
		document.all.newcardNo.style.display = "block";
		
		document.all.oldloginAccept1.style.display = "none" ;
	
	}

}

function doprint()
{
	getAfterPrompt();
	if(document.frm.opCode.value=="3530"){
		if(document.frm.cardNo.value==""){
			
			rdShowMessageDialog("�����뿨��!");
	 	    document.frm.cardNo.focus();
	 	    return false;
		}
		if(document.frm.cardNo.value.length !=8){
			rdShowMessageDialog("�����뿨��!");
	 	    document.frm.cardNo.focus();
	 	    return false;
		}
		if("<%=inpointTemp%>" -document.frm.currentPoint.value>0){
			rdShowMessageDialog("�û����ֲ���!");
	 	    return false;
		
		}
	}else if(document.frm.opCode.value=="3531"){
		
	}else if(document.frm.opCode.value=="3537"){
		if(document.frm.oldloginAccept.value==""){
			rdShowMessageDialog("�����������ˮ!");
	 	    document.frm.oldloginAccept.focus();
	 	    return false;
		}
	}else{
		if(document.frm.oldcardNo.value==""){
			rdShowMessageDialog("�������¿���!");
	 	    document.frm.oldcardNo.focus();
	 	    return false;
		}
		if(document.frm.oldcardNo.value.length !=8){
			rdShowMessageDialog("�������¿���!");
	 	    document.frm.oldcardNo.focus();
	 	    return false;
		}
	}
	document.all.print.disabled=true;	

	//��ӡ�������ύ��
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
        {
	      frmCfm();
        }
	  }
	  if(ret=="continueSub")
	  {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {
	      frmCfm();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     frmCfm();
       }
    }
	document.all.print.disabled=false;
	return true;
  }

function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo();
	 //alert(printStr);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=printAccept%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = "<%=phoneNo%>";                            //�ͻ��绰
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
		
  }

 function printInfo()
  {
	  if(document.frm.opNote.value==""){ 	
	  	document.frm.opNote.value="����Ա"+"<%=workname%>"+"���û�"+document.frm.custName.value+"����VIP���ֲ�"+" <%=opName%>"
	  }
	    	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		

	  var retInfo = "";
      cust_info+="�ͻ�������" +document.frm.custName.value+"|";
      cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
      cust_info+="�ͻ���ַ��"+document.frm.custAddress.value+"|";
      cust_info+="֤�����룺"+document.frm.icIccid.value+"|";
      opr_info+="�û�Ʒ�ƣ� "+document.frm.smCode.value + "|";
      opr_info+="VIP����"+document.frm.vipGrade.value+"|";
	  opr_info+="����ҵ��VIP���ֲ��� " +"<%=opName%>"+"|";
	  opr_info+="������ڣ�"+document.frm.inTime.value+"|";
	  if(document.frm.opCode.value=="3530"){
      opr_info+="��Ч������"+document.frm.expTime.value+"|";
	  opr_info+="�ۼ����֣�"+"<%=inpointTemp%>"+"|";
      opr_info+="���ֲ����ţ�"+document.frm.cardNo.value+"|";
	  }else if(document.frm.opCode.value=="3531"){
	  opr_info+="�˻����ڣ�"+'<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  }else if(document.frm.opCode.value=="3538"){
      opr_info+="ԭ���ֲ����ţ�"+document.frm.cardNo.value+"|";
      opr_info+="�¾��ֲ����ţ�"+document.frm.oldcardNo.value+"|";
	  }else{
	  opr_info+="���������ڣ�"+'<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  }
	  opr_info+="������ˮ�� "+"<%=printAccept%>" +"|";
	  if(document.frm.opCode.value=="3530"){
	  note_info1+="��ע��1��VIP���ֲ���Ա�ʸ��ǽ�����ȫ��ͨVIP���ֲ���Ա����ȫ��ͨ��ʯ�����𿨡������ͻ����ʸ����֮�ϵģ�ÿ�������һ���µ��ʸ���鲢������ѣ�����������Ա�ʸ�"+"|";
	  note_info1+="2����Ա������Ϊ�������¿ͻ���ֹͣʹ���й��ƶ����磬������ֲ���Ա�ʸ��Զ�ʧЧ�����ֲ���Ѳ��˻���"+"|";
	  }
	  
		  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;
  }
  function frmCfm(){
	document.frm.action="s3530Cfm.jsp";
 	frm.submit();
	return true;
  }
//-->
 </script> 
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("��ѯ����!<br>�������'<%=retCode%>'��������Ϣ'<%=retMsg%>'��",0);
		window.location.href="s3530.jsp?ph_no=<%=phoneNo%>";
	 </script>
<% } %>

