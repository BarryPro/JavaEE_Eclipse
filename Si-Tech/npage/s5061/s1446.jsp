<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-------------------------------------------->
<!---����:  2005-06-02                    ---->
<!---����:  Doucm                         ---->
<!---����:  s1446_integral                ---->
<!---���ܣ��ĺ�֪ͨ                       ---->
<!---�޸ģ�                               ---->
<!-------------------------------------------->
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.09
 ģ��:�ĺ�֪ͨ
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../include/title_name.jsp" %>
<%
	String phoneNo = (String)request.getParameter("activePhone");
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	
	String loginName = (String)session.getAttribute("workName");
	String accountType = (String)session.getAttribute("accountType");
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<%@ include file="../../npage/s5061/head_1446_javascript.htm" %>
</head>
<script language=javascript>
function showWorldMsg()
{
     if( document.all.r_cus[0].checked){}
}
$(document).ready(function(){
	$("#op_type").bind("change",function(){
		var opTypeValue = $("#op_type").val();
		if(opTypeValue == "����"){
			document.all.vHandFee.value = "10.00";     //huangrong add 2011-5-26 �޸ġ��ĺ�֪ͨ(1446)��ҵ��,���ܷ���Ĭ����10��Ϊ10.00Ԫ		
			document.all.vRealFee.value = "10.00";	//huangrong add 2011-5-23 �޸ġ��ĺ�֪ͨ(1446)��ҵ��,ʵ�ս��Ĭ����10.00Ԫ		
		}else{
			document.all.vHandFee.value = "0";
		}
	});
});
//���Ϊ�ͷ�������ֱ��չ��ҳ��   hejwa add 2013��10��15��15:57:56         
$(document).ready(function(){
	if("<%=accountType%>"=="2"){
		$("#qryId_No").hide();
		simChk();
	}
});
 
</script>
<body onload="doLoad();">
<form action="1446BackCfm.jsp" method="POST" name="s1446"  onKeyUp="chgFocus(s1446)">
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	
	<input type="hidden" name="idNo" value="">
	<input type="hidden" name="smCode" value="">
	<input type="hidden" name="belongCode" value="">
	<input type="hidden" name="userPassword" value="">
	<input type="hidden" name="runCode" value="">
	<input type="hidden" name="idName" value="">
	<input type="hidden" name="idIccid" value="">
	<input type="hidden" name="ownerGrade" value="">
	<input type="hidden" name="card_name" value="">
	<input type="hidden" name="totalOwe" value="">
	<input type="hidden" name="loginAccept" value="">
	<input type="hidden" name="opCode" value="1446">
	<input type="hidden" name="op_code" value="1446">
	<%@ include file="../../include/remark.htm" %>
        <table cellspacing="0">
          <tr> 
            <td class="blue">�û�����</td>
            <td> 
              <input class="InputGrey"  type="text" name="phoneno" value="<%=phoneNo%>" maxlength=11 v_must="1" v_type="mobphone2"  readOnly >  <%--«ѧ�20060310��mobphone��Ϊmobphone2���ڼ�����ͨ����--%>        
              <input class="b_text" type="button" name="qryId_No"  id="qryId_No" value="��ѯ"  onClick="simChk()" >            
			</td>

               <%--«ѧ�20060522 add --%>

			<td class="blue">��������</td>
			<td>
				<select name="op_type" id="op_type" onchange="getBefore();">
				</select>
			</td>
             <%--«ѧ�20060522 end --%>


          </tr>
          <tr> 
            <td class="blue">�û�����</td>
            <td> 
                <input name="custName" type="text" class="InputGrey" index="6" readonly >
            </td>
            <td class="blue">ҵ������</td>
            <td> 
             <input name="smName" type="text" class="InputGrey" index="6" readonly >
            </td>
          </tr>
          <tr> 
            <td class="blue">����״̬</td>
            <td> 
              <input type="text" class="InputGrey" name="runName" value="" tabindex="0" readonly >
            </td>
            <td class="blue">�ͻ�����</td>
            <td> 
             <input type="text" class="InputGrey" name="gradeName" value="" tabindex="0" readonly >
            </td>
          </tr>
          <tr> 
			<td class="blue">Ԥ���</td>
            <td>
              <input class="InputGrey" type="test" name="totalPrepay" value="" readonly >
            </td>
            
            <td class="blue">�������</td>
            <td> 
            <input type="text" name="transPhone" value="" onfocus="selType()" v_must=1  v_type=mobphone v_mixlength=1  tabindex="0" >
            </td>
          </tr>
		  <tr id="ywlb" name="ywlb" style="display:none"><%--«ѧ�20060526 ���䲻�ɼ�--%>
			<td class="blue">ҵ�����</td>
            <td> 
              <input class="InputGrey" type="text" name="opName" value="" tabindex="0" readonly onclick="dochang()">
            </td>
          </tr>
          <tr> 
            <td colspan="4"><font color="red"><b>��ע���������׼ȷ��!</b></font></td>
          </tr>
          <!--
		  <tr id="note1" name="note1" style="display:none"> 
            <td colspan="4"><font color="red"><b>��ע�������ѱ�׼�ʷ�Ϊ30Ԫ������Ͳ���С��10Ԫ; ��ͨ�ͻ����!</b></font></td>
          </tr>
          -->
          <input type="hidden" id="note1" name="note1" />
           <tr id="note2"  name="note2" style="display:none"> 
            <td class="blue"> 
              <div align="left">���ܷ�</div>
            </td>
            <td colspan="3"> 
            <input id=Text2 type=text size=17 index="3" name="vHandFee" value="0.00" v_type=float>
              ʵ�գ� 
                <input name="vRealFee" type="text" value="0.00" index="24">
              ���㣺 
                <input colspan="2" name="vPayChange" type="text" class="InputGrey" value="0" readonly="true">
            </td>
          </tr>
		  <tr id="note3" name="note3" style="display:none"> 
            <td class="blue">�˹��ܷ�</td>
			<td colspan="4">
			  <input class="InputGrey" type="test" name="paymoney" value="" readonly>
			</td>
          </tr>
		  <tr> 
            <td class="blue"> 
              <div align="left">��ע</div>
            </td>
            <td colspan="4"> 
              <input type="text" class="InputGrey" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
            </td>
          </tr>
          <tr style="display:none">
            <td class="blue"> 
              <div align="left">�û���ע</div>
            </td>
            <td colspan="4"> 
            <input type="text" class="InputGrey" name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  readOnly index="28" maxlength=60> 
            </td>
          </tr>
         
          <tr> 
            <td colspan="4" id="footer"> 
              <div align="center"> 
                <input class="b_foot" type="button" name="confirm" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled >
                <input class="b_foot" type=reset name=back value="���" onClick="document.all.confirm.disabled=true;" >
                <input class="b_foot" type="button" name="b_back" value="�ر�"  onClick="removeCurrentTab()" index="28">
              </div>
            </td>
          </tr>
        </table>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>             
</DIV>        
   <%@ include file="/npage/include/footer_simple.jsp" %>   
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 

</html>
