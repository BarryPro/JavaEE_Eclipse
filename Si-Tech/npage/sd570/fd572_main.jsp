<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ���뻶�ּ�ͥ
 create by wanglma 20110429
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
  String opCode = request.getParameter("opCode");
  String opName = "���뻶�ּ�ͥ";
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String passWord = (String)session.getAttribute("password");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String phoneNo = request.getParameter("activePhone"); /* �ҳ�����*/
  String memberNo = request.getParameter("member_no"); /* ��Ա����*/
  String memberNoPass = request.getParameter("cus_pass"); /* ��Ա����*/
  String[][] famArr = new String[][]{}; //Ⱥ����Ϣ
  /* ��ˮ */
  String printAccept="";
  printAccept = getMaxAccept();
  String   jzName="",cyNo="",custName ="",  custAddr="",mainFeeId="",famProdId="", opMainFeeId="",opFuFeeId="", idCardType="",  idCardNo="", custType="",  smName ="",  localName="",  mainFee="",  combo ="", opMainFee="", opFeeType="";
%>
    <wtc:service name="sd572Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>		
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=passWord%>"/>
	<wtc:param value="<%=memberNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	</wtc:service>
    <wtc:array id="resultArr" scope="end" start="0" length="16"/>
    <wtc:array id="resultArr1" scope="end" start="16" length="4"/>
<%
   if(resultArr.length > 0){
      custName = resultArr[0][1];
      custAddr = resultArr[0][2];
      idCardType = resultArr[0][3];
      idCardNo = resultArr[0][4];
      smName = resultArr[0][5];
      custType = resultArr[0][6];
      localName = resultArr[0][7];
      mainFeeId = resultArr[0][8]; //��Ա��ǰ���ʷ�
      mainFee = resultArr[0][9];
      combo = resultArr[0][10];
      
      opMainFeeId = resultArr[0][11];//Ҫ�������ʷ�Id
      opFuFeeId = resultArr[0][12];//Ҫ�������ʷ�Id
      famProdId = resultArr[0][13];//
      cyNo = resultArr[0][14]; //��Ա����
      jzName = resultArr[0][15]; //�ҳ�����
   }
   
   famArr = resultArr1 ; //��ͥ��Ϣ
   
   if(!"000000".equals(retCode)){
      %>
        <script language="javascript">
        	rdShowMessageDialog("����ʧ�ܣ�errCode:<%=retCode%>   errMsg:<%=retMsg%>",0);
        	window.location="fd570.jsp?opCode=d572&activePhone=<%=phoneNo%>&opName=<%=opName%>";
        </script>
      <%
   }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���뻶�ּ�ͥ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���

  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }

 function printCommitOne(subButton){
 	getAfterPrompt();
	//controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	subButton.disabled = true;
 	document.frm.action = "fd572_cfm.jsp";
	//��ӡ�������ύ��
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
	{
		frmCfm();
	}else{
		subButton.disabled = false;
	}
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի���
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept="<%=printAccept%>";                            // ��ˮ��
		var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
		var mode_code=null;                                        //�ʷѴ���
		var fav_code=null;                                         //�ط�����
		var area_code=null;                                        //С������
		var opCode="<%=opCode%>";                                  //��������
		var phoneNo="<%=phoneNo%>";                 //�ͻ��绰

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

  function printInfo(printType)
  {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��
		var count=0;
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����

		cust_info+="�ֻ����룺"+$("#phoneNo").val()+"|";
		cust_info+="�ͻ�������<%=jzName%>|";

		
		opr_info+="ҵ������: ������뻶�ּ�ͥҵ��|";
		opr_info += "<%=phoneNo%>�������<%=memberNo%>��������ͥ���ײ���Ч�󣬽����ܻ��ּ�ͥ�Ż��ײ͡�|";
 		note_info1+="������ļ�������ּ�ͥ�ײ͵��°��������Ч��|";
 		note_info1+="��ͥ�����ֻ�����ͳһ�ɷѲ�ͳһ���ѣ�������Ƿ�ѣ���ͥ�����к��뽫ͣ����|";
 		note_info1+="���ּ�ͥ��Ա�������ͬһ������|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }

//-->
//������ʾ

</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

     <table>
	<tr>
		<td class="blue" width="20%">
			��Ա����
		</td>
		<td width="30%">
			<input type="text" name="memberNo" id="memberNo" value="<%=memberNo%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			��Ա����
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=custName%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			��Ա��ַ
		</td>
		<td colspan="3">
			<input name="custAddr" id="custAddr" type="text" size="60" class="InputGrey" value="<%=custAddr%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			��Ա֤������
		</td>
		<td width="30%">
			<input name="idCardType" id="idCardType" type="text" class="InputGrey" value="<%=idCardType%>" readonly>
		</td>
		<td class="blue" width="20%">
			��Ա֤������
		</td>
		<td width="30%">
			<input type="text" name="idCardNo" id="idCardNo" size="40" value="<%=idCardNo%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			Ʒ������
		</td>
		<td width="30%">
			<input name="smName" id="smName" type="text" class="InputGrey" value="<%=smName%>" readonly>
		</td>
		<td class="blue" width="20%">
			��Ա������
		</td>
		<td width="30%">
			<input type="text" name="localName" id="localName" size="40" value="<%=localName%>" v_must="1" class="InputGrey" readonly>
		</td>	
	</tr>
	<tr>
		<td class="blue" width="20%">
			��ǰ���ʷ�
		</td>
		<td width="30%">
			<input name="mainFee" id="mainFee" type="text" class="InputGrey" size="40" value="<%=mainFeeId%>--<%=mainFee%>" readonly>
		</td>
		<td class="blue">
			�����ײ�����
		</td>
		<td>
			<input name="combo" id="combo" type="text" class="InputGrey" size="40" value="���ּ�ͥ<%=combo%>�ײ�" readonly>
		</td>
	</tr>
	
</table>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ҵ����ϸ</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY>
		  <tr>
			<tr>
		      <th align=center>�ֻ�����</th>
			  <th align=center>��ɫ����</th>
			  <th align=center>��Чʱ��</th>
			  <th align=center>ʧЧʱ��</th>
			</tr>
			<%
			 for(int j=0;j<famArr.length;j++){
			%>
		    <tr>
			  <TD align=center class="Grey"><%=famArr[j][0]%></TD>
			  <TD align=center class="Grey">
			  	<%
			  	  if("11100".equals(famArr[j][1])){
			  	 %>
			  	  �ҳ�
			  	  <%}else{%>
			  	  ��Ա
			  	  <%}%>
			  	 </TD>
			  <TD align=center class="Grey"><%=famArr[j][2]%></TD>
			  <TD align=center class="Grey"><%=famArr[j][3]%></TD>
			</tr>				
			<%
			 }
			%>
		</table>
	<table>
		  <tr>
            <td colspan="4" id="footer"> <div align="center">
                &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��&��ӡ" onClick="printCommitOne(this)" >
                &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="���" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp;
				</div>
			</td>
          </tr>
      </table>
      

    <input type="hidden" name="opCode" value="<%=opCode%>"  />
    <input type="hidden" name="phoneNo" id="phoneNo" value="<%=phoneNo%>"  />
    <input type="hidden" name="opMainFeeId" value="<%=opMainFeeId%>"  />
    <input type="hidden" name="opFuFeeId" value="<%=opFuFeeId%>"  />
    <input type="hidden" name="mainFeeId" value="<%=mainFeeId%>"  />
    <input type="hidden" name="famProdId" value="<%=famProdId%>"  />
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
