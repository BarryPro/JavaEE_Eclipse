<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.04
 ģ��: ���еش����̻�������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	//==============================��ȡӪҵԱ��Ϣ

    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = request.getParameter("phoneNo");
 	String opCode  =request.getParameter("busyType");
	String opName = "";
	String readType ="";
	String sqlInpoint = "";
	String inpointTemp = "";
	
	if(opCode.equals("2285")){
		opName="���еش����̻�������";
	}else{
		opName="���еش����̻����������";
		readType="readonly";
	}

    
	//=======================��ò�����ˮ
	String printAccept="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
	printAccept = seq;
	String exeDate="";
	exeDate = getExeDate("1","3530");
	
    String [] inParas = new String[3];
	
	inParas[0] = phoneNo;
	inParas[1] = opCode;
	inParas[2] = workno;
	
	//String[] ret = impl.callService("s2285Qry",inParas,"14");
%>
	<wtc:service name="s2285Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="17">			
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>	
	</wtc:service>	
	<wtc:array id="ret"  scope="end"/>
<%
	String retCode= retCode1;
	String retMsg = retMsg1;
	
	if (ret.length>0 && retCode.equals("000000"))
	{ 
		String custName = ret[0][2];
		String custAddress = ret[0][3];
		String icType = ret[0][4];
		String icIccid = ret[0][5];
		String smCode = ret[0][6];
		String gradeName = ret[0][7];
		String currentPoint = ret[0][8];
		String inTime = ret[0][9];
		String expTime = ret[0][10];
		String cardNo = ret[0][11];
		String vCuststatus= ret[0][12];
		String phoneNo1= ret[0][13];
		/* ningtn ����������ͨ���� */
		String cityCardNo = ret[0][16];
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

<title>������BOSS-���еش�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<BODY onLoad="init()">
<FORM action="s2285Cfm.jsp" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="loginAccept" value="<%=printAccept%>">

              <table cellspacing="0">
                <tr> 
                  <td class="blue">��������</td>
                  <td colspan="3"> 
                    <input type="text" class="InputGrey" readonly name="opName" value="<%=opName%>" style="color:orange" size="30">
                  </td>
				</tr>
                <tr> 
                  <td class="blue">�ͻ�����</td>
                  <td> 
                    <input type="text" class="InputGrey" readonly name="custName" value="<%=custName%>">
                  </td>
                  <td class="blue">�ֻ�����</td>
                  <td> 
                    <input type="text" name="phoneNo"  readonly class="InputGrey" value="<%=phoneNo%>">
                  </td>
                </tr>

				<tr> 
                  <td class="blue">�ͻ���ַ</td>
                  <td width="39%"> 
                    <input type="text" class="InputGrey" readonly name="custAddress" value="<%=custAddress%>" size='40'>
                  </td>
                 <td class="blue">ҵ��Ʒ��</td>
                  <td> 
                    <input type="text"  class="InputGrey" readonly name="smCode" value="<%=smCode%>">
                  </td> 
                </tr>

                <tr id="bat_id"> 
                <td class="blue">֤������</td>
                  <td> 
                    <input type="text" name="icType"  readonly class="InputGrey" value="<%=icType%>">
                  </td>  
				  <td class="blue">֤������</td>
                   <td> 
                    <input type="text" class="InputGrey" readonly name="icIccid" value="<%=icIccid%>">
                  </td>
                </tr>
                 <tr> 
                  <td class="blue">���еش�����</td>
                  <td> 
                    <input type="text"  class="InputGrey" readonly name="gradeName" value="<%=gradeName%>">
                  </td>
                  <td class="blue">��ǰ����</td>
                 <td> 
                    <input type="text" class="InputGrey" readonly name="currentPoint"  value="<%=currentPoint%>">
                  </td>
				  </tr>
                 <tr> 
					<td class="blue">����״̬</td>
                  <td colspan="3"> 
					<input type="text"  class="InputGrey" readonly name="vCuststatus" value="<%=vCuststatus%>">  
					</td>
				  </tr>
				<tr> 
                  <td class="blue">���տ���</td>
                  <td colspan="3"> 
                    <input type="text" name="cardNo" id="cardNo" value="<%=readType%>" 
                    	maxlength='9' <%=readType%> v_type="0_9" v_minlength="9" onblur="checkElement(this)">
                    <font color="orange">*</font>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">���ʱ��</td>
                  <td> 
                    <input type="text"  name="inTime" value="" <%=readType%>>
                  </td>
                  <td class="blue">��Ա��Ч����</td>
                  <td> 
                    <input type="text" name="expTime"  value="" <%=readType%>>
                  </td>
                </tr>
                <tr id="dnCityRow" style="display:none;">
                	<td class="blue">���г���ͨ��</td>
                	<td colspan="3">
                		<input type="text" name="dnCityCardNo" id="dnCityCardNo"
                		 <%=readType%> maxlength="12" v_type="0_9" v_minlength="12" onblur="checkElement(this)"/>
                		<font color="orange">*</font>
                	</td>
                </tr>
				<tr> 
                  <td class="blue">��ע</td>
                  <td colspan="3"> 
                  <input type="text"  class="InputGrey"  name="opNote" value="" size='60' readOnly>
				  </td>
                </tr>
				<tr> 
            	<td colspan='4'>
				<div align="center" id="footer"> 
	     		<input type="button" name="print" class="b_foot" value="ȷ��&��ӡ" onClick="doprint()"   >
                <input type="button" name="return1" class="b_foot" value="����" onClick="history.go(-1)">
                <input type="button" name="close1" class="b_foot" value="�ر�" onClick="removeCurrentTab()">
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
	
	if("<%=opCode%>"=="2285"){
	
		document.frm.inTime.value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>";
		document.frm.expTime.value='<%=exeDate%>';	
	}else {
		document.frm.inTime.value="<%=inTime%>";
		document.frm.expTime.value="<%=expTime%>";
		document.frm.cardNo.value="<%=cardNo%>";
		/* ningtn �������г���ͨ���� */
		var cityCardNo = "<%=cityCardNo%>";
		$("#dnCityCardNo").val(cityCardNo);
	}
	//�������г���ͨ���� ningtn
	var reg = "<%=regionCode%>";
	if(reg != "01"){
		$("#dnCityRow").hide();
	}else{
		$("#dnCityRow").show();
	}
}

function doprint()
{
	getAfterPrompt();
	if(document.frm.opCode.value=="2285"){
		if(document.frm.cardNo.value==""){
			
			rdShowMessageDialog("�����뿨��!");
	 	    document.frm.cardNo.focus();
	 	    return false;
		}
		if(document.frm.cardNo.value.length !=9){
			rdShowMessageDialog("�����뿨��!");
	 	    document.frm.cardNo.focus();
	 	    return false;
		}
		var cardNoObj = $("#cardNo");
		if(!checkElement(cardNoObj[0])){
			showTip(cardNoObj[0],"����Ϊ9λ����");
			return false;
		}
		if(cardNoObj.val().trim() == "null" || cardNoObj.val().trim().length == 0){
			showTip(cardNoObj[0],"��������");
			return false;
		}
		//�������г���ͨ���� ningtn
		var reg = "<%=regionCode%>";
		if(reg == "01" && "<%=opCode%>"=="2285"){
			var dnCityNoObj = $("#dnCityCardNo");
			if(!checkElement(dnCityNoObj[0])){
				showTip(dnCityNoObj[0],"����Ϊ12λ����");
				return false;
			}
			if(dnCityNoObj.val().trim() == "null" || dnCityNoObj.val().trim().length == 0){
				showTip(dnCityNoObj[0],"��������");
				return false;
			}
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
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept="<%=printAccept%>";                          // ��ˮ��
	var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
	var mode_code=null;                                        //�ʷѴ���
	var fav_code=null;                                         //�ط�����
	var area_code=null;                                        //С������
	var opCode="<%=opCode%>";                                  //��������
	var phoneNo=document.frm.phoneNo.value;                    //�ͻ��绰
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
  }

 function printInfo()
  {
	if(document.frm.opNote.value==""){
		document.frm.opNote.value="����Ա"+"<%=workname%>"+"���û�"+document.frm.custName.value+"���ж��еش�����"+" <%=opName%>"
	}
	var cust_info="";
	var opr_info=""; 
	var note_info1=""; 
	var note_info2=""; 
	var note_info3=""; 
	var note_info4=""; 
	var retInfo = ""; 
	
	cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.frm.custName.value+"|";
	cust_info+="�ͻ���ַ��"+document.frm.custAddress.value+"|";
	cust_info+="֤�����룺"+document.frm.icIccid.value+"|";
	
	opr_info+="�û�Ʒ�ƣ�"+document.frm.smCode.value + "|";
	opr_info+="����ҵ�񣺶��еش�����" +"<%=opName%>"+"|";
	opr_info+="���еش�����"+"<%=gradeName%>";
	if(document.frm.opCode.value=="2285"){
		opr_info+="ע�����ڣ�"+document.frm.inTime.value+"|";
		opr_info+="��Ч������"+document.frm.expTime.value+"|";
	}else{
		opr_info+="����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	}
	opr_info+="���պ��룺"+document.frm.cardNo.value+"|";
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	
	note_info1+="��ע��"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	retInfo+=""+"|";
	  
	return retInfo;
  }
  function frmCfm(){
	document.frm.action="s2285Cfm.jsp";
 	frm.submit();
	return true;
  }
//-->
 </script> 
</body>
</html>
<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("��ѯ����!<br>������룺'<%=retCode%>'��������Ϣ��'<%=retMsg%>'��",0);
		history.go(-1);
	 </script>
<% } %>



