<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ���ּ�ͥ����
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
  String opName = "���ּ�ͥ����";
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String passWord = (String)session.getAttribute("password");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String phoneNo = request.getParameter("activePhone"); /* �ҳ�����*/
  String backaccept = request.getParameter("backaccept"); /* Ҫ��������ˮ*/
  String[][] famArr = new String[][]{}; //Ⱥ����Ϣ
  String tdMoney = "";
  String tdNo = "";
  String tdImei = "";
  String tdName = "";
  String famType = "";
  String money = "";
  /* ��ˮ */
  String printAccept="";
  printAccept = getMaxAccept();
  String   custName ="",  custAddr="",mainFeeId="",nowPrestore="",custRank="",nowIntegral="", runState="", idCardType="",  idCardNo="",   smName ="",  localName="",  mainFee="";
%>
    <wtc:service name="sd571Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="21">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>		
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=passWord%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=opName%>"/>
	<wtc:param value="<%=backaccept%>"/>		
	</wtc:service>
	<wtc:array id="resultArr" scope="end" start="0" length="12"/>
	<wtc:array id="resultArr1" scope="end" start="12" length="9"/>
	
<%
   if(resultArr.length > 0){
      mainFeeId = resultArr[0][0]; //��Ա��ǰ���ʷ�ID
      mainFee = resultArr[0][1];//��Ա��ǰ���ʷ�����
      custName = resultArr[0][2];//�ͻ�����
      custAddr = resultArr[0][3];//�ͻ���ַ
      idCardType = resultArr[0][4];//֤������
      idCardNo = resultArr[0][5];//֤������
      smName = resultArr[0][6];//Ʒ������
      localName = resultArr[0][7];//��������
	  runState = resultArr[0][8];//����״̬
	  custRank = resultArr[0][9];//�ȼ�
	  nowIntegral = resultArr[0][10];//��ǰ����
	  nowPrestore = resultArr[0][11];//��ǰԤ��
	  
   }
   for(int u=0;u<resultArr1.length;u++){
      for(int y=0;y<resultArr1[u].length;y++){
         System.out.println("---------------------resultArr1["+u+"]["+y+"]-----------------------  "+resultArr1[u][y]);
      }
   }
   //famType = resultArr1[0][8]; //��ͥ����
   
   famArr = resultArr1 ; //��ͥ��Ϣ
   for(int i=0;i<famArr.length;i++){
     if(!"0.00".equals(famArr[i][6])){
        tdMoney = famArr[0][7] ; //��Ǯ��
        tdNo = famArr[i][1] ;
        tdName = famArr[i][4] ;
        tdImei = famArr[i][5] ;
     }
     famType = resultArr1[0][8];//��ͥ����
     for(int j=0;j<famArr[i].length;j++){
       System.out.println("================famArr["+i+"]["+j+"]=====================  "+famArr[i][j]);
     }
   }
   
   if("A".equals(famType)){
      money = "68";
   }else if("B".equals(famType)){
   	  money = "98";
   }else{
   	  money = "28";
   }
   if(!"000000".equals(retCode)){
      %>
        <script language="javascript">
        	rdShowMessageDialog("����ʧ�ܣ�errCode: <%=retCode%>   errMsg: <%=retMsg%>",0);
        	window.location="fd570.jsp?opCode=d571&activePhone=<%=phoneNo%>&opName=<%=opName%>";
        </script>
      <%
   }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���ּ�ͥ����</title>
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
	//setOpNote();//Ϊ��ע��ֵ 
 	document.frm.action = "fd571_cfm.jsp";
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
        
		
		opr_info+="ҵ������: �����ּ�ͥ�ײ�<%=money%>Ԫ�ײͳ���|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }


/******Ϊ��ע��ֵ********/

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
			����״̬
		</td>
		<td>
			<input name="runState" id="runState" type="text" class="InputGrey" size="40" value="<%=runState%>" readonly>
		</td>
	</tr>
	
	<tr>
		<td class="blue" width="20%">
			�ͻ�����
		</td>
		<td width="30%">
			<input name="custRank" id="custRank" type="text" class="InputGrey" size="40" value="<%=custRank%>" readonly>
		</td>
		<td class="blue">
			��ǰ����
		</td>
		<td>
			<input name="nowIntegral" id="nowIntegral" type="text" class="InputGrey" size="40" value="<%=nowIntegral%>" readonly>
		</td>
	</tr>
		<tr>
		<td class="blue" >
			��ǰԤ��
		</td>
		<td colspan="3">
			<input name="nowPrestore" id="nowPrestore" type="text" class="InputGrey" size="40" value="<%=nowPrestore%>" readonly>
		</td>
	</tr>
	
	</table>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ҵ����ϸ</div>
</div>
		<TABLE >
          <TBODY>
		  <tr>
			<tr>
		      <th align=center>��ɫ����</th>
			  <th align=center>�ֻ�����</th>
			  <th align=center>�ײ�����</th>
			  <th align=center>����TD�̻�</th>
			</tr>
			<%
			 for(int j=0;j<famArr.length;j++){
			%>
		    <tr>
			  <TD align=center class="Grey"><%=famArr[j][0]%></TD>
			  <TD align=center class="Grey"><%=famArr[j][1]%></TD>
			  <TD align=center class="Grey"><%=famArr[j][2]%>--<%=famArr[j][3]%></TD>
			  <TD align=center class="Grey">
			   <%
			      if("0".equals(famArr[j][4])){
			   %>
			      ��
			   <%}else{%>
			      <%=famArr[j][4]%>
			   <%}%>	
			  </TD>
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
    <input type="hidden" name="backaccept" value="<%=backaccept%>"  />
    <input type="hidden" name="tdMoney" value="<%=tdMoney%>"  />
    <input type="hidden" name="tdNo" value="<%=tdNo%>"  />
    <input type="hidden" name="tdImei" value="<%=tdImei%>"  />
    <input type="hidden" name="tdName" value="<%=tdName%>"  />
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
