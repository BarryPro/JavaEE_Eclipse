<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML>
	<HEAD>
		<TITLE>�ۺ���Ϣ��ѯ</TITLE>
<%
  String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ";
  String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
  String Department=(String)session.getAttribute("orgCode");
  String regionCode = Department.substring(0,2);
  String ip_Addr = "172.16.23.13";
  
  String accountType =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//accountType == "2"ʱΪ�ͷ����Ž���
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
/*
 * ����Ŀ�����ھɰ�ͷ�ϵͳ���������Ҫ���ͷ����Ӫҵ������CRM�ϲ���һ�װ汾�Ľ�������ͺ������󿪷����۹���@2014/7/21
 */
$(document).ready(function(){
	if("<%=accountType%>" == "2"){
		window.location.href="<%=request.getContextPath()%>/npage/public/showMsg_KF.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
});

function doCheck()
{
	
	//if(jtrim(document.frm1500.cus_pass.value).length ==0)
	//	document.frm1500.cus_pass.value="123456";
	if(document.frm1500.cus_pass.value.trim().length>0 && document.frm1500.cus_pass.value.trim().length !=6)
	{
	   rdShowMessageDialog("����λ������ȷ��");
	   document.frm1500.cus_pass.focus();
	   return false;
	}
	 document.frm1500.custPass.value=document.frm1500.cus_pass.value;

	if(document.frm1500.condText.value=="")
	{	rdShowMessageDialog("�������ѯ������");
		document.frm1500.condText.select();
		return false;
	} else {
	
	var queryType = $("select[name='QueryType']").find("option:selected").text();
	/*2015/03/09 15:09:02 gaopeng ����������ר��ר��ҵ�����Ż��ĺ�
		������������ѯ�����������õ���select��textУ��ģ�Ϊʲô�أ�
		ԭ���Ƿ����ж�queryType��value��У�飬����0-7�еľ���Ϊ��Ч��ѯ���롣
	*/
	if(queryType == "����������"){
		var condText = $.trim($("input[name='condText']").val());
		var condPhoneHead1 = condText.substring(0,3);
		var condPhoneHead2 = condText.substring(0,5);
		
			/*
			if(condPhoneHead1 == "147"){
				condText = "206"+condText.substring(3,condText.length);
			}else if(condPhoneHead2 == "10648"){
				condText = "205"+condText.substring(5,condText.length);
			}
			*/
			
			var myPacket = new AJAXPacket("/npage/public/pubGetWLWPhoneNo.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				
			  myPacket.data.add("opCode","1500");
			  myPacket.data.add("phoneNo",condText);
			  
			  
			  core.ajax.sendPacket(myPacket,function(packet){
			  	var retCode=packet.data.findValueByName("retCode");
				  var retMsg=packet.data.findValueByName("retMsg");
				  var phoneNoRet=packet.data.findValueByName("phoneNoRet");
				  if(retCode == "000000"){
				  	condText = phoneNoRet;
				 	}else{
						
				 	}
			  });
			  myPacket = null;
			
		
		$("input[name='condText']").val(condText)
	}
	document.frm1500.action="f1500_2.jsp";
	frm1500.submit();
	}
	return true;
}

</SCRIPT>

<FORM method=post name="frm1500">
<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="opCode"  value="1500">
	<input type="hidden" name="custPass"  value="">
			<div class="title">
				<div id="title_zi">�������ѯ����</div>
			</div>
			<table cellspacing="0">
        <tr>
          <td class="blue" align="center" nowrap>��ѯ����</td>
          <td>
           <select align="left" name=QueryType width=50>
              <option value="0">�������</option>
              <option value="1">�ʻ���</option>
              <option value="2">֤������</option>
              <option value="3">�ͻ�����</option>
              <option value="4">SIM����</option>
              <option value="5">IMSI��</option>
              <option value="7">����˺�</option>
              <option value="0">����������</option>
            </select>
		  		</td>
          <td class="blue" align="center" nowrap> ������Ϣ</td>
          <td>
          	<input type="text" name="condText" size="20" maxlength="60" onKeyDown="if(event.keyCode==13){ doCheck();return false}">
          	<input type="button" name="Button1" class="b_text" value="��ѯ" onclick="doCheck()">
          </td>
          <td class="blue" align="center" nowrap> �û�����</td>
          <td>
           	<jsp:include page="/npage/query/pwd_one.jsp">
		      	<jsp:param name="width1" value="16%"  />
		      	<jsp:param name="width2" value="34%"  />
		      	<jsp:param name="pname" value="cus_pass"  />
		      	<jsp:param name="pwd" value="12345"  />
	    	   	</jsp:include>
          </td>
        </tr>
    	</table>

<script>
	x = screen.availWidth;
	y = screen.availHeight;
	window.innerWidth = x;
	window.innerHeight = y;
</script>
<!------------------------>

	</div>


	<div id="Operation_Table">
		<div class="title">
				<div id="title_zi">��ѯ���</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>�������</th>
        <th>�û�ID��</th>
        <th>��������</th>
        <th>��ǰ״̬</th>
        <th>״̬���ʱ��</th>
        <th>����ʱ��</th>
      </tr>
    </table>



<table cellspacing="0">
  <tr align="center">
    <td id="footer">
      &nbsp; <input name=reset class="b_foot" type=reset onClick="" value=���>
      &nbsp; <input name=back class="b_foot" onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
      &nbsp;
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
</form>
</body>
</html>
<!--***********************************************************************-->
