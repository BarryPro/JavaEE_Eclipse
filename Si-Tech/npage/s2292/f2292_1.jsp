<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.1.5
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>
 <%
  response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

	//==============================��ȡӪҵԱ��Ϣ
    String workno =  (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = request.getParameter("phoneNo");
 	String opCode  =request.getParameter("busyType");
	String opName = "";
	String readType ="";

 String loginPwd   = (String)session.getAttribute("password"); //��������
	if(opCode.equals("3530")){
		opName="����";

		/*sqlInpoint = "select favour_point from smarkfavcode where favour_code='CL01' and sm_code='gn' and region_code='"+regionCode+"'";
		System.out.println("  sqlInpoint="+sqlInpoint);
		InpointArrTemp = coTemp.spubqry32("1",sqlInpoint);
		InpointStrTemp = (String[][])InpointArrTemp.get(0);
		inpointTemp = InpointStrTemp[0][0];
		*/
		readType ="";

	}else if(opCode.equals("3538")){
		opName="������";
		readType="readonly";
	}else if(opCode.equals("3531")){
		opName="ע��";
		readType="readonly";
	}else if(opCode.equals("3537")){
		opName="������";
		readType="readonly";
	}else{
		opName="�߼�����ͨ����";
		readType="readonly";
	}


	//=======================��ò�����ˮ
	String printAccept="";
	printAccept = getMaxAccept();
	//String exeDate="";
    //exeDate = getExeDate("1","3530");

    String [] inParas = new String[3];

	inParas[0] = phoneNo;
	inParas[1] = opCode;
	inParas[2] = workno;

	//String[] ret = impl.callService("s2292Qry",inParas,"14");
%>
	<wtc:service name="s2292Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="17">			
	<wtc:param value=" " />
	<wtc:param value="01" />
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=loginPwd%>" />
	<wtc:param value="<%=inParas[0]%>"/>	
    <wtc:param value=" " /> 	
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
		String belongCode = ret[0][7];
		String runCode = ret[0][8];
		String vipGrade = ret[0][9];
		String currentPoint = ret[0][10];
		String inTime = ret[0][11];
		String expTime = ret[0][12];
		String cardNo = ret[0][13];
		String freeFlag = ret[0][16];
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
  //�ֻ�Ʒ��
  String datesql = " select  to_char(add_months(sysdate,1),'yyyymm')||'01',to_char(sysdate,'yyyymmdd') from dual";
  System.out.println("datesql====="+datesql);
  //ArrayList datearr = co.spubqry32("2",datesql);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=datesql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="dateStr" scope="end" />
<%
  String yu_date=dateStr[0][0];
  String s_date=dateStr[0][1];
%>

<HTML>
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<title>������BOSS-�������־��ֲ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<BODY onLoad="init()">
<FORM action="s3530Cfm.jsp" method="post" name="frm">
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
            <input type="text"  class="InputGrey" readonly name="opName" value="<%=opName%>">
          </td>
		<tr id="oldloginAccept1">
		 <td class="blue">������ˮ</td>
          <td>
			<input type="text" name="oldloginAccept" value="">
			<font color="orange">*
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
          <td>
            <input type="text" class="InputGrey" readonly name="custAddress" value="<%=custAddress%>">
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
        <tr id="phoneId">
          <td class="blue">��������</td>
          <td>
            <input type="text" readonly class="InputGrey" name="belongCode" value="<%=belongCode%>" >
          </td>
          <td class="blue">����״̬</td>
          <td>
            <input type="text"  class="InputGrey" readonly name="runCode" value="<%=runCode%>">
          </td>
        </tr>
         <tr nowrap>
          <td class="blue">VIP����</td>
          <td>
            <input type="text"  class="InputGrey" readonly name="vipGrade" value="<%=vipGrade%>">
          </td>
          <td class="blue">��ǰ����</td>
          <td>
            <input type="text" class="InputGrey" readonly name="currentPoint"  value="<%=currentPoint%>">
          </td>
		  </tr>
         <tr nowrap>
          <td class="blue">���ʱ��</td>
          <td>
            <input type="text"   name="inTime" value="" <%=readType%>>
            <input type="hidden" name="yjb" value="<%=cardNo%>">
            <input type="hidden" name="cust_info">
			<input type="hidden" name="opr_info">
			<input type="hidden" name="note_info1">
			<input type="hidden" name="note_info2">
			<input type="hidden" name="note_info3">
			<input type="hidden" name="note_info4">
			<input type="hidden" name="printcount">
            <input type="hidden" name="sxsj">
          </td>
          <td class="blue">��Ա����</td>
          <td>
            <select name="packnumtype" >
            		<%
            	try
            {
            
            String regioncodeh = regionCode;
            String getAccTypsqlStr =	"select account_type from dLoginMsg where login_no = '"+workno+"'";
            %>
						<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
							<wtc:sql><%=getAccTypsqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="result" scope="end" />
					<%
						String accountType="";
						if(result!=null&&result.length>0){
							accountType=result[0][0];
						}
						System.out.println("hjwlog------------accountType--------------"+accountType);
						if(accountType.equals("2")){
							String getReCodeSql = "select substr(belong_code,1,2) from dcustmsg where phone_no = '"+phoneNo+"'";
							
							%>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
								<wtc:sql><%=getReCodeSql%></wtc:sql>
							</wtc:pubselect>
							<wtc:array id="resultReCo" scope="end" />
							
							<%
							if(resultReCo!=null&&resultReCo.length>0){
								regioncodeh=resultReCo[0][0];
							}
							
					  }
					  System.out.println("hjwlog------------regioncodeh--------------"+regioncodeh);
				
				String  inParamsMail [] = new String[2];
    		inParamsMail[0] = "select a.member_level,a.member_level||'-- >'||a.member_name from sMusiclevel a,Region b,dChngroupmsg c where to_number(a.mode_code)=b.offer_id and b.group_id=c.group_id and substr(c.boss_org_code,1,2) =:vregioncodeh order by a.member_level";
    		inParamsMail[1] = "vregioncodeh="+regioncodeh;
					  
			  
              //retArray = coTemp.spubqry32("2",sqlStr);
			  
			  if(opCode.equals("3531")||opCode.equals("3537")||opCode.equals("3539"))
              {
              	
              	inParamsMail[0] = "select a.member_level,a.member_level||'-- >'||a.member_name from sMusiclevel a,dWmusicuser b,Region c,dChngroupmsg d where b.phone_no =:vPhoneNo and b.member_level=a.member_level and to_number(a.mode_code)=c.offer_id and c.group_id=d.group_id and substr(d.boss_org_code,1,2) =:vregioncodeh";
    						inParamsMail[1] = "vPhoneNo="+phoneNo+",vregioncodeh="+regioncodeh;
              
              }
              
              System.out.println("gaopengSeeLog-------inParamsMail[0]----"+inParamsMail[0]);
              System.out.println("gaopengSeeLog-------inParamsMail[1]----"+inParamsMail[1]);
%>
			  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="2">			
				  <wtc:param value="<%=inParamsMail[0]%>"/>
				  <wtc:param value="<%=inParamsMail[1]%>"/>
			  </wtc:service>	
			  <wtc:array id="result1"  scope="end"/>	
<%
              int recordNum = result1.length;

              for(int i=0;i<recordNum;i++)
              {

              	if(cardNo.trim().equals(result1[i][0])){
                	if("Y".equals(freeFlag)){
                	  out.println("<option class='button' value='" + result1[i][0] + "' selected>" + result1[i][1] + "(��Ѱ�)</option>");
                	}else{
                	  out.println("<option class='button' value='" + result1[i][0] + "' selected>" + result1[i][1] + "</option>");
                	}
                }else{//����
                	out.println("<option class='button' value='" + result1[i][0] + "'>" + result1[i][1] + "</option>");
                }
              }
              if(opCode.equals("3530")){
                out.println("<option class='button' value='5'>5-- >�ؼ���Ա(��Ѱ�)</option>");
              }
            }catch(Exception e)
            {

            }
%>
        	</select>
          </td>
		  </tr>
        <tr nowrap>
          <td class="blue">��ע</td>
          <td colspan="3">
            <input type="text" name="opNote" value="" size="60" readOnly class="InputGrey">
		  </td>
        </tr>
		<tr>
    	<td noWrap colspan="6" id="footer">
		<div align="center">
 		<input type="button" name="print" class="b_foot" value="ȷ��&��ӡ" onClick="doprint()"   >
              &nbsp;
        <input type="button" name="return1" class="b_foot" value="����" onClick="history.go(-1)">
              &nbsp;
        <input type="button" name="close1" class="b_foot" value="�ر�" onClick="removeCurrentTab()">
      	</div>
   		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp"%> 
</FORM>
<script language="JavaScript">
	var checke177flag="yes";
<!--
function init()
{
	if("<%=opCode%>"=="3530"){
		document.frm.inTime.value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>";
		document.all.oldloginAccept1.style.display="none";


	}else if("<%=opCode%>"=="3531"){
		document.frm.inTime.value="<%=inTime%>";
		document.all.oldloginAccept1.style.display="none";

	}else if("<%=opCode%>"=="3538"){
		document.frm.inTime.value="<%=inTime%>";
		document.all.oldloginAccept1.style.display="none";

	}else{
		//alert("dddddddddd");
		document.frm.inTime.value="<%=inTime%>";
		document.all.oldloginAccept1.style.display = "" ;

	}

}

function doprint()
{

if(document.frm.opCode.value=="3531"){
		if(document.frm.packnumtype.value==4) {
		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/checkQuitType.jsp","���Ժ�...");
		packet.data.add("phoneno","<%=phoneNo%>");
		packet.data.add("seseq","80006");
		core.ajax.sendPacket(packet,dochecke177);
		packet =null;
		}
	}
	
	getAfterPrompt();
	if(document.frm.opCode.value=="3530"){

	}else if(document.frm.opCode.value=="3531"){
		document.frm.sxsj.value="<%=s_date%>";
	}else if(document.frm.opCode.value=="3537"){
		if(document.frm.oldloginAccept.value == ""){
			rdShowMessageDialog("��������ˮ!");
			document.frm.oldloginAccept.focus();
	 	    return false;			
		}

	}else if(document.frm.opCode.value=="3538"){
		if(document.frm.yjb.value==document.frm.packnumtype.value){
			rdShowMessageDialog("��Ա����δ�ı�!");
			  document.frm.packnumtype.focus();
	 	    return false;
		}
		if(parseInt(document.frm.yjb.value,10)>parseInt(document.frm.packnumtype.value,10)){
			document.frm.sxsj.value="<%=s_date%>";
		}else{
			document.frm.sxsj.value="<%=s_date%>";
		}
		//alert(document.frm.sxsj.value);
	}
	else{

	}
	document.all.print.disabled=true;

	//��ӡ�������ύ��
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {
          document.all.printcount.value="1";
	      frmCfm();
        }
	  }
	  if(ret=="continueSub")
	  {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {
          document.all.printcount.value="0";
	      frmCfm();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
       	 document.all.printcount.value="0";
	     frmCfm();
       }
    }
	document.all.print.disabled=false;
	return true;
  }

function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի���
     var h=200;
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
     var phoneNo=<%=phoneNo%>;                                  //�ͻ��绰

     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
   
     return ret;
  }

 function printInfo()
  {
	  if(document.frm.opNote.value==""){
	  document.frm.opNote.value="����Ա"+"<%=workno%>"+"���û�"+document.frm.phoneNo.value+"�����������ֻ�Ա"+"<%=opName%>"
	  }
	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  
      cust_info+="�ͻ�������" +document.frm.custName.value+"|";
      cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
      cust_info+="�ͻ���ַ��"+document.frm.custAddress.value+"|";
      cust_info+="֤�����룺"+document.frm.icIccid.value+"|";
      
      opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+document.frm.smCode.value+ "|";
      opr_info+="����ҵ���������ֻ�Ա " +"<%=opName%>"+"  ������ˮ: "+"<%=printAccept%>" +"|";
	  opr_info+="������ڣ�"+document.frm.inTime.value+"|";
	  
	  if(document.frm.opCode.value=="3530"){
      
	  }else if(document.frm.opCode.value=="3531"){
	  		opr_info+="�˻���Ч���ڣ�"+document.frm.sxsj.value+"|";
	  }else if(document.frm.opCode.value=="3538"){
      		opr_info+="�����Ч���ڣ�"+document.frm.sxsj.value+"|";
      
	  }else{
	  		opr_info+="���������ڣ�"+'<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  }
	  
	  if(document.frm.opCode.value=="3530"){
	 
	  }
	  note_info1+="��ע��"+document.all.opNote.value+"|";
      document.all.cust_info.value=cust_info+"#";
	  document.all.opr_info.value=opr_info+"#";
	  document.all.note_info1.value=note_info1+"#";
	  document.all.note_info2.value=note_info2+"#";
	  document.all.note_info3.value=note_info3+"#";
	  document.all.note_info4.value=note_info4+"#";
	  //retInfo=document.all.cust_info.value+" "+"|"+"---------------------------------------------"+"|"+" "+"|"+document.all.opr_info.value+" "+"|"+" "+"|"+document.all.note_info1.value+document.all.note_info2.value+document.all.note_info3.value+document.all.note_info4.value+" "+"|"+" "+"|"+" "+"|"+" "+"|"+"<%=loginNote.trim()%>"+"#";
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);	
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 	
	  return retInfo;
  }
  function frmCfm(){
	document.frm.action="f2292Cfm.jsp";
 	frm.submit();
	return true;
  }
  
  
  	function dochecke177(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errormsg = packet.data.findValueByName("errorMsg");
	if(errorCode =="000000"){
	checke177flag="yes";		
	var returncode = packet.data.findValueByName("returncode");
	var returnmsg11 = packet.data.findValueByName("returnmsg");
	if(returncode=="000000") {
	}else {
	rdShowMessageDialog(returnmsg11);
	}
	}else{
		rdShowMessageDialog(errormsg);
		checke177flag="no";
		return false;
	}
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

