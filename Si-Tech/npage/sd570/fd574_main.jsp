<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ȡ�����ּ�ͥ
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
  String opName = "ȡ�����ּ�ͥ";
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String passWord = (String)session.getAttribute("password");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String phoneNo = request.getParameter("activePhone"); /* �ҳ�����*/
  String[][] famArr = new String[][]{};
  String fuNo = "";
  String tdNo = "";
  /* ��ˮ */
  String printAccept="";
  printAccept = getMaxAccept();
  String   custName ="",  custAddr="",mainFeeId="", opMainFeeId="", idCardType="",  idCardNo="", custType="",  smName ="",  localName="",  mainFee="",  combo ="", opMainFee="", opFeeType="";
  /* ningtn ���ּ�ͥ */
  String isBuyTd = "0";
%>
    <wtc:service name="sd574Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="14">
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>	
			<wtc:param value="<%=opCode%>"/>		
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=passWord%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="ȡ�����ּ�ͥ"/>		
			</wtc:service>
    <wtc:array id="resultArr" scope="end" start="0" length="13" />
    <wtc:array id="resultArr2" scope="end" start="13" length="1" />
<%
   
   if(resultArr.length > 0){
      custName = resultArr[0][7]; //����
      custAddr = resultArr[0][8]; //��ַ
      idCardType = resultArr[0][9];//֤������
      idCardNo = resultArr[0][10]; //֤������
      smName = resultArr[0][5];  //��Ʒ��
      /* ���ã�ɾ��
      custType = resultArr[0][13]; //�ͻ�����
      */
      localName = resultArr[0][11];//������
      mainFeeId = resultArr[0][1]; //��Ա��ǰ���ʷ�ID
      mainFee = resultArr[0][2];//��Ա��ǰ���ʷ�
      combo = resultArr[0][12]; //�ײ�����
   }
   System.out.println("========ningtn======= :" + resultArr2.length);
   if(resultArr2.length > 0){
   		//�Ƿ�����TD�̻���isBuyTd 1����0û����
   		for(int isBuyIter = 0; isBuyIter < resultArr2.length; isBuyIter++){
   		System.out.println("========ningtn======= :" + resultArr2[isBuyIter][0]);
   			if("1".equals(resultArr2[isBuyIter][0])){
   				isBuyTd = "1";
   			}
   		}
   }
   
   for(int i=0;i<resultArr.length;i++){
     if("TD����".equals(resultArr[i][6])){
        tdNo = resultArr[i][0] ;
     }else if("��������".equals(resultArr[i][6])){
       	fuNo = resultArr[i][0] ;
     }
   }
   if(!"000000".equals(retCode)){
      %>
        <script language="javascript">
        	rdShowMessageDialog("����ʧ�ܣ�errCode: <%=retCode%>   errMsg: <%=retMsg%>",0);
        	window.location="fd570.jsp?opCode=d574&activePhone=<%=phoneNo%>&opName=<%=opName%>";
        </script>
      <%
   }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>�˳����ּ�ͥ</title>
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
 	/* ningtn ���ּ�ͥ ����У�� */
 	if("<%=isBuyTd%>" == "1"){
	 	if(!checkElement(document.frm.phonePrice)){
			return false;
		}
	}else{
		$("#phonePrice").val("0");
	}

 	getAfterPrompt();
	//controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	subButton.disabled = true;
 	document.frm.action = "fd574_cfm.jsp";
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
		cust_info+="�ͻ�������"+$("#custName").val()+"|";

		
		opr_info+="ҵ������: �����˶����ּ�ͥҵ��|";
		opr_info+="���ּ�ͥ�����ƶ��绰���룺"+$("#phoneNo").val()+"|";
		opr_info+="���ּ�ͥ�����ͻ����ƣ�"+$("#custName").val()+"|";
		opr_info+="���ּ�ͥ�ֻ��������룺<%=fuNo%>|";
		opr_info+="���ּ�ͥTD�̻����룺<%=tdNo%>|";
		opr_info+="<%=phoneNo%>��������ɢ��ͥ���Դ����𽫲������ܻ��ּ�ͥ�Ż��ײ͡�|";
		opr_info+="�ƶ��ֻ������˶����ּ�ͥҵ��󣬽����������г������ʷѱ�׼��ȡ��|";
		opr_info+="TD�̻������˶����ּ�ͥҵ��󽫰������ʷѱ�׼��ȡ��0���⡢0Ԫ������ʾ��5Ԫ�����|";
		opr_info+="ѡ��10Ԫ���ߣ����л��͹��ڳ�;��Ե���š���С�����л���������0.2Ԫ,������0.1Ԫ/���ӣ�������ڳ�;0.25Ԫ/����(�����۰�̨ )�����ر�����ѡ�С��������0.25Ԫ/���ӣ���������ڳ�;0.6Ԫ/����(�����۰�̨)�����������б�׼�ʷ���ȡ��|";
 		note_info1+="��������˶����ּ�ͥ�ײ͵��°��������Ч���������𣬽�������ͥ��ͳһ�ɷѲ�ͳһ����ҵ��ͬʱ�������ܼ�ͥ��ͨ������ʷѡ����к��뽫�������ʷѱ�׼��ȡ��Ԥ��ר��δ�������ٰ��·�������Ϊ�ͻ�����������|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }

//-->
//������ʾ

$(document).ready(function(){
	var phoneTrObj = $("#phonePriceTr");
	var isBuyTdVal = "<%=isBuyTd%>";
	if(isBuyTdVal == "1"){
		phoneTrObj.show();
	}else{
		phoneTrObj.hide();
	}
});

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
			�ͻ�����
		</td>
		<td width="30%">
			<input type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			�ͻ�����
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=custName%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			�ͻ���ַ
		</td>
		<td colspan="3">
			<input name="custAddr" id="custAddr" type="text" size="60" class="InputGrey" value="<%=custAddr%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			֤������
		</td>
		<td width="30%">
			<input name="idCardType" id="idCardType" type="text" class="InputGrey" value="<%=idCardType%>" readonly>
		</td>
		<td class="blue" width="20%">
			֤������
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
			���������
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
			<input name="mainFee" id="mainFee" type="text" class="InputGrey" size="40" value="<%=mainFee%>" readonly>
		</td>
		<td class="blue">
			�����ײ�����
		</td>
		<td>
			<input name="combo" id="combo" type="text" class="InputGrey" size="40" value="���ּ�ͥ<%=combo%>�ײ�" readonly>
		</td>
	</tr>
	<tr id="phonePriceTr">
		<td class="blue">���ֻ���</td>
		<td colspan="3">
			<input name="phonePrice" id="phonePrice" type="text" size="40" value="" v_type="money" v_must="1" />
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
		      <th align=center>��������</th>
			  <th align=center>�ײ�����</th>
			  <th align=center>��Чʱ��</th>
			  <th align=center>ʧЧʱ��</th>
			</tr>
			<%
			 for(int j=1;j<resultArr.length;j++){
			%>
		    <tr>
			  <TD align=center class="Grey"><%=resultArr[j][0]%></TD>
			  <TD align=center class="Grey"><%=resultArr[j][6]%></TD>
			  <TD align=center class="Grey"><%=resultArr[j][1]%>--<%=resultArr[j][2]%></TD>
			  <TD align=center class="Grey"><%=resultArr[j][3]%></TD>
			  <TD align=center class="Grey"><%=resultArr[j][4]%></TD>
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
    <input type="hidden" name="phoneNo" value="<%=phoneNo%>"  />
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
