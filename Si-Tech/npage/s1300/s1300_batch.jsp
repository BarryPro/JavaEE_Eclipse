<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-18 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
  String opCode = "1304";
  String opName = "�ɷ�(����)";
  String batchNo = request.getParameter("batch").trim();
	String contract_no = request.getParameter("TContractNo").trim();
	String bill_date = request.getParameter("sBillDate").trim();
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ret_code = "00";

	String[] inParas = new String[4];
	inParas[0] = batchNo;
	inParas[1] = contract_no;
	inParas[2] = bill_date;
  inParas[3] = ret_code;
	//CallRemoteResultValue  value  = viewBean.callService("1", orgCode.substring(0,2),  "s1420Init", "13"  ,  lens , inParas , map) ;
 %>
	<wtc:service name="s1420Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="13" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="7" scope="end"/>
	<wtc:array id="result2" start="7" length="6" scope="end"/>
<%
	String return_code = "999999";
	if(result!=null&&result.length>0){
		return_code = result[0][0];
	}
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));

 if( return_code.equals("009008"))
  {
 %>
  <script language="JavaScript">
	rdShowMessageDialog("��ѯ����<br>�������:'<%=return_code %>',������Ϣ:�����ڼ䲻��������ҵ��");
	document.location.replace("s1300_3.jsp");
</script>

<%}


 if( !return_code.equals("000000"))
  {
 %>
  <script language="JavaScript">
	rdShowMessageDialog("��ѯ����<br>�������:'<%=return_code %>',������Ϣ:'<%=error_msg%>'��");
	document.location.replace("s1300_3.jsp");
</script>

<%
	}else{
%>

<HTML><HEAD>
<script language="JavaScript">
function doProcess(packet){
	

	/*xl add xl add end*/
	var return_code = packet.data.findValueByName("return_code"); 
	var return_msg = packet.data.findValueByName("return_msg"); 
	var flag = packet.data.findValueByName("result");
	var ed = packet.data.findValueByName("outPledge");
	var total = packet.data.findValueByName("f_temp_total_pay");
	var money = packet.data.findValueByName("payMoney");
	//alert("test for return_code is "+return_code); 
	if(return_code=="000000" ){
		//rdShowMessageDialog("�ж�flag��ֵ�� "+flag+"<br>"+" and ����һ��");
		if(flag == "1"){
			rdShowMessageDialog("���������Ѻ����Ϊ:"+ed+",��ǰ���ۻ�Ӫҵ��Ϊ:"+total+",���ν��ɷ���Ϊ:"+money+",�뼰ʱ�����ʽ��Ͻ�,�����޷���������ɷ�!");
		}
		document.getElementById("show").value="ok";
		
	}
	else{
		 
		
		if(return_code == "000011"){
			rdShowMessageDialog("���������Ѻ����Ϊ:"+ed+",��ǰ���ۻ�Ӫҵ��Ϊ:"+total+",���ν��ɷ���Ϊ:"+money+",�޷�����!");
		}
		else{
			rdShowMessageDialog("������룺 "+return_code+",<p>������Ϣ��"+return_msg);
		}
		document.getElementById("show").value="no";
		 
	}
	
	 

}
 function getLimit()
{
	var myPacket = new AJAXPacket("../s1300/getLimit.jsp?payMoney="+document.frm.TBusyMoney.value,"���ڲ�ѯ��֤�ɷѿ��ö�ȣ����Ժ�......");
	
	core.ajax.sendPacket(myPacket);
	myPacket = null;
	 
}
function doChecks()
 {
 
	 var paymoney;
	 var temp ;
     with(document.frm)
     {

 			 paymoney = TBusyMoney.value;
   			
			

			
            if(parseFloat(paymoney) < 0)
		  	{
				rdShowMessageDialog(" �ɷѽ���Ϊ������",0);
                payMoney.focus();
                return false;
          	}
   
			
 
              TBusyMoney.value = formatAsMoney(paymoney);
 	}
 }
function DoCheck()
{
	//if confirm ���Ҽӵ� ֮ǰ��û�е� Ϊ�˲��Ե�ʱ�򷽱� �żӵ� ��Ҫ���ڰ����ɵ�
	 
	getAfterPrompt();
	getLimit();
//	alert('222');
	var show = document.getElementById("show").value;
//	alert("the value of show  is "+show);
	if(show=="ok"){
		if(doChecks()==false)
		return false;
		var	prtFlag = rdShowConfirmDialog("���νɷѽ��"+document.frm.TBusyMoney.value+"Ԫ,�Ƿ�ȷ���ɷѣ�");
		if (prtFlag==1)
		{
			document.all.sure.disabled=true;
			document.all.back.disabled=true;
			document.frm.submit();
			return true;
		}
		else{
			return false;
		}
	}
	else{
//		alert("��ֹ�ɷ� �˴�alert��ȥ�� ");
		return false;
	}
	
	
}
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<BODY>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<FORM action="s1300_batchCfm.jsp" method="post" name="frm" >
<input type="hidden" name="show" >
<input type="hidden" name="busy_type"  value="3">
<input type="hidden" name="Op_Code"  value="1304">
<%@ include file="/npage/include/header.jsp" %>   
		<div class="title">
			<div id="title_zi">���յ�ȷ��</div>
		</div>
        <table cellspacing="0">
          <tr> 
            <td width="15%" class="blue" nowrap>���ش���</td>
            <td width="35%"> 
              <input type="text" name="returnCode" class="InputGrey" readonly value=<%=ret_code%>>
            </td>
            <td width="15%" class="blue">��������</td>
            <td width="35%"> 
              <input type="text" name="TBatchNo" class="InputGrey" readonly value="<%=batchNo%>">
            </td>
          </tr>
          <tr> 
            <td width="15%" class="blue" nowrap>�� ͬ ��</td>
            <td width="35%"> 
              <input type="text" name="TContractNo" class="InputGrey" readonly value="<%=contract_no%>">
            </td>
            <td width="15%" class="blue">��������</td>
            <td width="35%"> 
              <input type="text" name="TBillDate" maxlength="6" class="InputGrey" readonly value="<%=bill_date%>">
            </td>
          </tr>
          <tr> 
            <td width="15%" class="blue" nowrap>���ս��</td>
            <td width="35%"> 
              <input type="text" name="TBusyMoney" class="InputGrey" readonly value="<%=result[0][3].trim()%>">
            </td>
            <td width="15%" class="blue">��������</td>
            <td width="35%"> 
              <input type="text" name="TPhoneNum" class="InputGrey" readonly value="<%=result[0][4]%>">
            </td>
          </tr>
          <tr> 
            <td width="15%" class="blue" nowrap>��������</td>
            <td width="35%"> 
              <input type="text" name="TBankName"  class="InputGrey" readonly value="<%=result[0][5].trim()%>">
            </td>
            <td width="15%" class="blue">�����ʺ�</td>
            <td width="35%"> 
              <input type="text" name="TBankAccount"  class="InputGrey" readonly value="<%=result[0][6]%>">
            </td>
          </tr>
          <tr> 
            <td width="15%" class="blue" nowrap>�ͻ�����</td>
            <td width="35%"> 
              <input type="text" name="TCustName" class="InputGrey" readonly value="<%=result[0][1].trim()%>">
            </td>
            <td width="15%" class="blue">��������</td>
            <td width="35%"> 
              <input type="text" name="TRegionName" class="InputGrey" readonly value="<%=result[0][2].trim()%>">
            </td>
          </tr>
          <tr> 
            <td width="15%" class="blue" nowrap>��ע</td>
            <td colspan="3"> 
              <input type="text" name="TBackNote" size="40" maxlength="60" value="">
            </td>
          </tr>
        </table>
        </div>
				<div id="Operation_Table"> 
				<div class="title">
					<div id="title_zi">���յ���ϸ</div>
				</div>
        <table cellspacing="0">
          <tr align="center"> 
            <th>�ֻ�����</th>
            <th>Ӧ�ս��</th>
            <th>�Żݽ��</th>
            <th>Ԥ�滮��</th>
            <th>�½���</th>
            <th>�ʵ�״̬</th>
          </tr>
          <%
          	String tbClass="";
				  	for (int i=0;i<result2.length;i++){
				  		if(i%2==0){
					  		tbClass="Grey";
					  	}else{
					  		tbClass="";	
					  	}
				  %>
				  <tr align="center">
            <td class="<%=tbClass%>">&nbsp;<%=result2[i][0]%></td>
            <td class="<%=tbClass%>">&nbsp;<%=result2[i][1]%></td>
            <td class="<%=tbClass%>">&nbsp;<%=result2[i][2]%></td>
            <td class="<%=tbClass%>">&nbsp;<%=result2[i][3]%></td>
            <td class="<%=tbClass%>">&nbsp;<%=result2[i][4]%></td>
            <td class="<%=tbClass%>">&nbsp;<%=result2[i][5]%></td>
          </tr>
          <%}%>
        </table>        
        <TABLE cellSpacing="0">
          <TR > 
            <TD noWrap colspan="6" id="footer"> 
                <input type="submit"  name="sure" class="b_foot" value="ȷ��"  onclick="return DoCheck()">&nbsp;
                <input type="button"  name="back"   class="b_foot" value="����" onclick="window.history.go(-1)" >
              </th>
          </TR>
        </TABLE>
     <%@ include file="/npage/include/footer.jsp" %> 
</FORM>
</body>
</html>
<%}%>