   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opName = "����һ�";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>

 <%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	
	
	String phoneNo  =request.getParameter("phoneNo");
 	String opCode   =request.getParameter("opCode");
 	String clubType =request.getParameter("clubType");
	

    //==============================��ȡӪҵԱ��Ϣ
    String[][] result = new String[][]{};
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	//=======================��ò�����ˮ
	String printAccept="";
	printAccept = getMaxAccept();
	
    String [] inParas = new String[4];
	
	inParas[0] = phoneNo;
	inParas[1] = opCode;
	inParas[2] = workno;
	inParas[3] = clubType;
	
	//String[] ret = impl.callService("s3530Qry",inParas,"15");
%>

    <wtc:service name="s3530Qry" outnum="17" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[3]%>" />		
		</wtc:service>
		<wtc:array id="result_t1" scope="end"/>
			
<%	

	String retCode= code1;
	String retMsg = msg1;
	
	
	if (result_t1 != null && code1.equals("000000"))
	{ 
		String custName = result_t1[0][2];
		String custAddress = result_t1[0][3];
		String icType = result_t1[0][4];
		String icIccid = result_t1[0][5];
		String smName = result_t1[0][6];
		String belongCode = result_t1[0][7];
		String runCode = result_t1[0][8];
		String vipGrade = result_t1[0][9];
		String currentPoint = result_t1[0][10];
		String inTime = result_t1[0][11];
		String expTime = result_t1[0][12];
		String cardNo = result_t1[0][13];
		String clubStatus = result_t1[0][14];

		
	
		System.out.println("custName="+custName);
		System.out.println("custAddress="+custAddress);
		System.out.println("icType="+icType);
		System.out.println("icIccid="+icIccid);
		//System.out.println("smCode="+smCode);
		System.out.println("belongCode="+belongCode);
		System.out.println("runCode="+runCode);
		System.out.println("vipGrade="+vipGrade);
		System.out.println("currentPoint="+currentPoint);
		System.out.println("inTime="+inTime);
		System.out.println("expTime="+expTime);
		System.out.println("cardNo="+cardNo);

%>

<HTML>
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<title>������BOSS-VIP���ֲ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY >
<FORM action="s3530Cfm.jsp" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">�Ἦ����</div>
	</div>
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="loginAccept" value="<%=printAccept%>">
<input type="hidden" name="markname" value="">

              <table   cellspacing="0">
                <tr> 
                  <td width="14%" class="blue">��������</td>
                  <td width="33%"> 
                   ����һ�
                  </td>
                  <td  width="14%">&nbsp;</td>
                  <td  width="39%">&nbsp; 
				  </td>
                <tr> 
                  <td width="14%" class="blue">�ͻ�����</td>
                  <td width="33%"> 
                    <input type="text"  readonly Class="InputGrey"  name="custName" value="<%=custName%>">
                  </td>
                  <td width="14%" class="blue">�ֻ����� </td>
                  <td width="39%"> 
                    <input type="text" name="phoneNo"  readonly Class="InputGrey" value="<%=phoneNo%>">
                  </td>
                </tr>

				<tr> 
                  <td width="14%" class="blue">�ͻ���ַ</td>
                  <td width="33%"> 
                    <input type="text"  size="38" readonly Class="InputGrey" name="custAddress" value="<%=custAddress%>">
                  </td>
                 <td width="14%" class="blue">ҵ��Ʒ��</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="smName" value="<%=smName%>">
                  </td> 
                </tr>

                <tr id="bat_id"> 
                <td width="14%" class="blue">֤������ </td>
                  <td width="39%"> 
                    <input type="text" name="icType"  readonly  Class="InputGrey"  value="<%=icType%>">
                  </td>  
				  <td width="14%" class="blue">֤������</td>
                   <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="icIccid" value="<%=icIccid%>">
                  </td>
                </tr>
                <tr id="phoneId"> 
                  <td width="14%" class="blue">��������</td>
                  <td width="33%"> 
                    <input type="text" readonly  Class="InputGrey"  name="belongCode" value="<%=belongCode%>" >
                  </td>
                  <td width="14%" class="blue">�˴�״̬</td>
                  <td width="39%"> 
                    <input type="text"   readonly  Class="InputGrey" name="runCode" value="<%=runCode%>">
                  </td>
                </tr>
                 <tr   nowrap> 
                  <td width="14%" class="blue">VIP����</td>
                  <td width="33%"> 
                    <input type="text"   readonly  Class="InputGrey" name="vipGrade" value="<%=vipGrade%>">
                  </td>
                  <td width="14%" class="blue">��ǰ����</td>
                  <td width="39%"> 
                    <input type="text"  readonly  Class="InputGrey" name="currentPoint"  value="<%=currentPoint%>">
                  </td>
				  </tr>
                 <tr   nowrap> 
                  <td width="14%" class="blue">���ʱ��</td>
                  <td width="33%"> 
                    <input type="text"    name="inTime" value="<%=inTime%>" readonly Class="InputGrey" >
                  </td>
                  <td width="14%" class="blue">��Ա��Ч����</td>
                  <td width="39%"> 
                    <input type="text"   name="expTime"  value="<%=expTime%>" readonly Class="InputGrey" >
                  </td>
				  </tr>
				<tr   nowrap> 
                  <td width="14%" class="blue">��Ա����</td>
                  <td width="33%"> 
                    <input type="text"    name="cardNo" value="<%=cardNo%>" readonly Class="InputGrey" >
                  </td>
                  <td width="14%" class="blue">��Ա״̬</td>
                  <td width="39%"> 
                    <input type="text"   name="clubStatus"  value="<%=clubStatus%>" readonly Class="InputGrey" >
                    <input type="hidden"    name="clubType" value="<%=clubType%>">
                  </td>
				  </tr>
                <tr nowrap>
				   <td width="14%" class="blue">��������</td>
				   <td width="33%">
					<select name=favour_type id="favour_type" onchange="favTypeChange()" >
<%                  try
                    {
					  String[][] result1 = new String[][]{};
					  String sqlStr ="";
					  if(clubType.equals("01"))
					  	sqlStr ="select favour_code,favour_name,favour_point from sMarkFavCode where favour_type='1021' and region_code ='"+regionCode+"' and sm_code='gn' and favour_code!='CL01' order by favour_code" ;
					  else if(clubType.equals("02"))
					  	sqlStr ="select favour_code,favour_name,favour_point from sMarkFavCode where favour_type='1022' and region_code ='"+regionCode+"' and sm_code='gn' and favour_code!='YM01' order by favour_code" ;
                      //retArray = callView.view_spubqry32("3",sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%                      
                      result1 = result_t2;
                      int recordNum = result1.length;
					  int j;
					  out.println("<option  value='" +  result1[0][0] + "'>" + "--��ѡ��--"+ "</option>");
                      for(j=1;j<recordNum+1;j++)
                      {
                        out.println("<option  value='" +  result1[j-1][2]+ "'>"+result1[j-1][0]+"-->" +result1[j-1][1]+ "</option>");

					  }
                    }catch(Exception e)
                    {
                      //logger.error("Call sunView is Failed!");
                    }
%>
                    </select>   
				</td>
				<td width="14%" class="blue">�������</td>
                  <td width="39%"> 
                    <input type="text"   name="serviceMark"  value="" readonly Class="InputGrey" >
                  </td>
				</tr>
				<tr   nowrap> 
                  <td width="14%" class="blue">����</td>
                  <td width="33%"> 
                    <input type="text"    name="num" value="" onChange= "consumeFee1()" onkeyup="if(event.keyCode==13)consumeFee1()" >
					 <font class="orange">*</font>
                  </td>
                  <td width="14%" class="blue">�������ѻ���</td>
                  <td width="39%"> 
                    <input type="text"   name="sumMark"  value="" readonly Class="InputGrey" >
                  </td>
				  </tr>
				<tr nowrap> 
                  <td width="14%" class="blue">��ע</td>
                  <td colspan="3" width="86%"> 
                    <input type="text"  name="opNote" value=""  size="80"readonly  Class="InputGrey"  >
				  </td>
                </tr>
				<tr> 
            <td noWrap colspan="6">
				<div align="center"> 
	     		<input type="button" name="print"  value="ȷ��&��ӡ" onClick="doprint()"    class="b_foot_long">
                      &nbsp;
                <input type="button" name="return1"  value="����" onClick="history.go(-1);" class="b_foot">
                      &nbsp; 
                <input type="button" name="close1"  value="�ر�" onClick="removeCurrentTab();" class="b_foot">
              </div>
            </td>
        </tr>
			</table>

 <%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
<!--

function favTypeChange()
{	
	with(document.frm){
		var  markpoint = favour_type.options[favour_type.options.selectedIndex].value;
		markname.value = favour_type.options[favour_type.options.selectedIndex].text;
		
		if(	markpoint>currentPoint){
			rdShowMessageDialog("��ǰ����С�ڸ��������֣����ܶһ��������",0);
			print.disabled="true";
			return false;
		}else{
			serviceMark.value=markpoint;
			return true;
		}

	}
}
function consumeFee1()
{
    var a = parseInt(document.frm.num.value,10) ;
    var b = parseInt(document.frm.serviceMark.value,10) ;
    var c = a*b;
	document.frm.sumMark.value= c;
	if(parseInt(document.frm.currentPoint.value,10) < c)
	{
		rdShowMessageDialog("�û���ǰ����С�ڶһ����֣�",0);
		document.all.print.disabled=true;
		return false;
	}else
	{
		document.all.print.disabled=false;
	}
	return true;

}
function doprint()
{
	 getAfterPrompt();
	 with (document.frm)
    {
        if (serviceMark.value == "")
        {
            rdShowMessageDialog(" ��Ʒ���ֲ���Ϊ�գ�",0);
            return false;
        }

        if (num.value == "")
        {
            rdShowMessageDialog(" ��������Ϊ�գ�",0);
            num.focus();
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
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=printAccept%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = document.frm.phoneNo.value;                           //�ͻ��绰
     
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
		
  }

 function printInfo()
  {
	  if(document.frm.opNote.value==""){ 															document.frm.opNote.value="����Ա"+"<%=workname%>"+"���û�"+document.frm.custName.value+"����VIP���ֲ� ����һ�" ;
	  }
  	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
      var d= document.frm.currentPoint.value-document.frm.sumMark.value;
      cust_info+="�ͻ�������" +document.frm.custName.value+"|";
      cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
      cust_info+="�ͻ���ַ��"+document.frm.custAddress.value+"|";
      cust_info+="֤�����룺"+document.frm.icIccid.value+"|";

      opr_info+="�û�Ʒ�ƣ�"+document.frm.smName.value + "|";
      opr_info+="VIP����"+document.frm.vipGrade.value+"|";
	    opr_info+="����ҵ��VIP���ֲ� " +"����һ���"+"|";
	    opr_info+="�һ�����"+document.frm.markname.value+"|";
      opr_info+="�һ�������"+document.frm.num.value+"|";
      opr_info+="�ۼ����֣�"+document.frm.sumMark.value+"|";
	    opr_info+="������ˮ��"+"<%=printAccept%>" +"|";

		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

	  return retInfo;
  }
  function frmCfm(){
	document.frm.action="f3532Cfm.jsp";
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
		window.location.href="f3532.jsp?ph_no=<%=phoneNo%>";
	 </script>
<% } %>

