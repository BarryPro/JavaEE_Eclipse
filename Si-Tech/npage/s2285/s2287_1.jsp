<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-9
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html; charset=GBK" %>
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
	String opName = "";
	String readType ="";
	comImpl coTemp=new comImpl();
	String sqlInpoint = "";
	ArrayList InpointArrTemp = new ArrayList();
	String[][] InpointStrTemp = new String[][]{};
	String inpointTemp = "";
	
	if(opCode.equals("2287")){
		opName="��������";
	}else{
		opName="��������";
		readType="readonly";
	}

    
	//=======================��ò�����ˮ
	String printAccept="";
	printAccept = getMaxAccept();
	String exeDate="";
	exeDate = getExeDate("1","3530");
	
    String [] inParas = new String[3];
	
	inParas[0] = phoneNo;
	inParas[1] = opCode;
	inParas[2] = workno;
	
	//String[] ret = impl.callService("s2285Qry",inParas,"15");
	
%>

    <wtc:service name="s2285Qry" outnum="15" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />		
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />

<%	
	String retCode= code;
	String retMsg = msg;	
	
	if (result_t1 != null && retCode.equals("000000"))
	{ 
		String custName = result_t1[0][2];
		String custAddress = result_t1[0][3];
		String icType = result_t1[0][4];
		String icIccid = result_t1[0][5];
		String smCode = result_t1[0][6];
		String gradeName = result_t1[0][7];
		String currentPoint = result_t1[0][8];
		String inTime = result_t1[0][9];
		String expTime = result_t1[0][10];
		String cardNo = result_t1[0][11];
		String vCuststatus= result_t1[0][12];
		String phoneNo1= result_t1[0][13];
		String oldCardNo= result_t1[0][14];
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
*/
		System.out.println("cardNo="+cardNo);
		System.out.println("oldCardNo="+oldCardNo);

%>

<HTML>
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<title>������BOSS-���еش����ջ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY onLoad="init()">
<FORM action="s2287Cfm.jsp" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">���еش����ջ���</div>
	</div>
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="loginAccept" value="<%=printAccept%>">

              <table  cellspacing="0">
                <tr> 
                  <td width="14%" class="blue">��������</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="opName"  value="<%=opName%>">
                  </td>
				  <td  width="14%"></td>
                  <td  width="39%"> 
                  </td>
				</tr>
                <tr > 
                  <td width="14%" class="blue">�ͻ�����</td>
                  <td width="33%"> 
                    <input type="text"  readonly Class="InputGrey" name="custName" value="<%=custName%>">
                  </td>
                  <td width="14%" class="blue">�ֻ����� </td>
                  <td width="39%"> 
                    <input type="text" name="phoneNo"  readonly  Class="InputGrey"  value="<%=phoneNo%>">
                  </td>
                </tr>

				<tr> 
                  <td width="14%" class="blue">�ͻ���ַ</td>
                  <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="custAddress" value="<%=custAddress%>" size='40'>
                  </td>
                 <td width="14%" class="blue">ҵ��Ʒ��</td>
                  <td width="39%"> 
                    <input type="text"   readonly  Class="InputGrey" name="smCode" value="<%=smCode%>">
                  </td> 
                </tr>

                <tr id="bat_id" > 
                <td width="14%" class="blue">֤������ </td>
                  <td width="33%"> 
                    <input type="text" name="icType"  readonly  Class="InputGrey"  value="<%=icType%>">
                  </td>  
				  <td width="14%" class="blue">֤������</td>
                   <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="icIccid" value="<%=icIccid%>">
                  </td>
                </tr>
                 <tr   b nowrap> 
                  <td width="14%" class="blue">���еش�����</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="gradeName" value="<%=gradeName%>">
                  </td>
                  <td width="14%" class="blue">��ǰ����</td>
                  <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="currentPoint"  value="<%=currentPoint%>">
                  </td>
				  </tr>
                 <tr    nowrap> 
					<td width="14%" class="blue">����״̬</td>
                  <td width="33%"> 
					<input type="text"   readonly  Class="InputGrey" name="vCuststatus" value="<%=vCuststatus%>">  
					</td>
					<td width="14%" class="blue">����ԭ��</td>
					<td width="39%"> 
					 <select   name="cause"  >
                      <option value="����"  >����</option>
                      <option value="��ʧ"  >��ʧ</option>	 
				  </td>  
				  </tr>
				<tr b nowrap> 
                  <td width="14%" class="blue">ԭ���տ���</td>
                  <td width="33%"> 
                    <input type="text"    name="cardNo" value="" <%=readType%> maxlength='8'><font color="#FF0000">*</font>
                  </td>
               <td width="14%" class="blue">�»��տ���</td>
                  <td width="39%"> 
                  <input type="text"    name="newcardNo" value="" <%=readType%> maxlength='8'><font color="#FF0000">*</font>
				  </td>
                </tr>
                <tr  nowrap> 
                  <td width="14%" class="blue">��Ч����</td>
                  <td width="39%"> 
                    <input type="text"   name="expTime"  value="<%=expTime%>" <%=readType%>>
                  </td>
				  <td width="14%">&nbsp;</td>
                  <td width="33%"> &nbsp;
                  </td>
                </tr>
				<tr b nowrap> 
                  <td width="14%" class="blue">��ע</td>
                  <td width="33%"> 
                  <input type="text"  size="55"  name="opNote" value="" size='40'   readonly  Class="InputGrey">
				  </td>
				  <td width="14%">&nbsp;</td>
                  <td width="39%"> &nbsp;
                  </td>
                </tr>
				<tr > 
            <td colspan="4" id="footer">
				<div align="center"> 
	     		<input type="button" name="print"  value="ȷ��&��ӡ" onClick="doprint()" class="b_foot_long">
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
	
	if("<%=opCode%>"=="2287"){
		document.frm.cardNo.value="<%=cardNo%>";
	}else {
		
		document.frm.cardNo.value="<%=oldCardNo%>";
		document.frm.newcardNo.value="<%=cardNo%>";
	}
}

function doprint()
{
	getAfterPrompt();
	if(document.frm.opCode.value=="2287"){
		if(document.frm.newcardNo.value==""){
			
			rdShowMessageDialog("�����뿨��!");
	 	    document.frm.newcardNo.focus();
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
     var phoneNo = <%=phoneNo%>;                            //�ͻ��绰
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		return ret;
  }

 function printInfo()
  {
	  if(document.frm.opNote.value==""){ 								
	  	document.frm.opNote.value="����Ա"+"<%=workname%>"+"���û�"+document.frm.custName.value+"���ж��еش�����"+" <%=opName%>";
	  }
	  
	 	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
      cust_info+="�ͻ�������		" +document.frm.custName.value+"|";
      cust_info+="�ֻ����룺		"+document.frm.phoneNo.value+"|";
      cust_info+="�ͻ���ַ��		"+document.frm.custAddress.value+"|";
      cust_info+="֤�����룺		"+document.frm.icIccid.value+"|";

      opr_info+="�û�Ʒ�ƣ�"+document.frm.smCode.value + "|";
	  opr_info+="����ҵ�񶯸еش����գ�" +"<%=opName%>"+"|";
	  opr_info+="���еش�����"+"<%=gradeName%>   ";
	  if(document.frm.opCode.value=="2287"){
	  opr_info+="ԭ���ţ�"+document.frm.cardNo.value+"|";
	  opr_info+="�¿��ţ�"+document.frm.newcardNo.value+"|";
	  }else{
	  opr_info+="ԭ���ţ�"+document.frm.newcardNo.value+"|";
	  opr_info+="�¿��ţ�"+document.frm.cardNo.value+"|";
	  }
	  note_info1+="��Ч������"+document.frm.expTime.value+"|";
	  note_info2+="������ˮ��"+"<%=printAccept%>"+"|";
		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    return retInfo;
  }
  function frmCfm(){
	document.frm.action="s2287Cfm.jsp";
 	frm.submit();
	return true;
  }
//-->
 </script> 
</body>
</html>
<%} else { %>
	 <script language="JavaScript">
		rdShowMessageDialog("��ѯ����!<br>�������'<%=retCode%>'��������Ϣ'<%=retMsg%>'��",0);
		history.go(-1);
	 </script>
<% } %>



