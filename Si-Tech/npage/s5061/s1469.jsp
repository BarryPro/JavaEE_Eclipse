<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-10
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
    String opCode = "1469";
    String opName = "ȫ��spҵ���˷�";
    
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
  
%>
<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    String sysAccept = seq;
    System.out.println("sysAccept="+sysAccept);
    
    request.setCharacterEncoding("GBK");
    
    HashMap hm=new HashMap();
    hm.put("1","û�пͻ�ID��");
    hm.put("3","�������");
    hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
    
    hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("13","δȡ������5����˲����ݻ���ѯϵͳ����Ա��");
    hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
    String op_name="ȫ��spҵ���˷�";
    String op_code = "1469";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<title><%=op_name%></title>

<%@ include file="../../npage/s5061/head_1469_javascript.htm" %>


<script language="JavaScript">
	
 
 function sel_type1() {
            window.location.href='s1469.jsp';
 }

 function sel_type2(){
           window.location.href='s1469Del.jsp';
 }
 
 function accountbackfee(){
		
		var varFeeMoney = 0; //�˷ѽ��
		var varFeeFlag = 0;  //�˷ѵ���˫��

		if (document.all.feeMoney.value == "")
		{
			rdShowMessageDialog("��������ս��!");
			return;
		}
		if (document.all.useing_time.value == "")
		{
			rdShowMessageDialog("������ʹ������!");
			return;
		}
		if(forDate(document.all.useing_time)==false) 
		{
			 rdShowMessageDialog("ʹ�����ڸ�ʽ����ȷ!");
			 return;
		}
		varFeeMoney = document.all.feeMoney.value;
		
		if (document.all.UnPayLevel.value == 0)
		{
			varFeeFlag = 1;
		}else{
			varFeeFlag = 2;
		}
		
		if (document.all.UnPayFrom.value == 0)
		{
			document.all.backMoney.value = varFeeMoney;
			//document.all.backPreMoney.value = 0;
			document.all.compMoney.value = varFeeMoney*(varFeeFlag-1);
		}else if (document.all.UnPayFrom.value == 1){
			//document.all.backMoney.value = varFeeMoney *15/100
			document.all.backMoney.value = varFeeMoney *100/100;
			//document.all.backPreMoney.value = varFeeMoney *85/100;
			document.all.compMoney.value = varFeeMoney*(varFeeFlag-1);
		}else if (document.all.UnPayFrom.value == 2){
			//document.all.backMoney.value = varFeeMoney *15/100;
			document.all.backMoney.value = varFeeMoney *100/100;
			//document.all.backPreMoney.value = varFeeMoney *85/100;
			document.all.compMoney.value = varFeeMoney*(varFeeFlag-1);
		}
		 document.forms[0].spTranName.value=document.forms[0].res_name.value;
		document.all.confirm.disabled=false;
		
	      document.forms[0].spTranName.value=document.forms[0].res_name.value;
	  
	  
	}
function change_res()
	{
		document.forms[0].res_name.value=document.forms[0].res_code.options[document.forms[0].res_code.selectedIndex].value;
	 
	  if (document.forms[0].res_code.selectedIndex==6) {
	      document.forms[0].res_name.disabled=false;
	     
	   }
	  else
	    {
	      document.forms[0].res_name.disabled=true;
	      
	    }
	} 
  </script> 

</head>

<body>

<form action="1469SpCfm.jsp" method="POST" name="s1469"  onKeyUp="chgFocus(s1469)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
<input type="hidden" name="op_type" id="op_type" value="a">
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<input type="hidden" name="spTranName" id="spTranType" value="">
<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
<%@ include file="../../include/remark.htm" %>
<table cellspacing="0">
    <tr> 
        <td class=blue nowrap>��������</td>
        <td nowrap colspan="3">
            <input name="spType1" type="radio" onClick="sel_type1()" value="1" checked> 
            ¼�� 	
            <input name="spType2" type="radio" onClick="sel_type2()" value="2"> 
            ɾ�� 	
        </td>
    </tr>
    <tr> 
        <td class=blue nowrap>�û�����</td>
        <td nowrap> 
            <input type="text" name="phoneno" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11  index="6" >
            <font class="orange">*</font>              
        </td>
        <td class=blue nowrap>�û�����</td>
        <td nowrap> 
            <input name="cust_name" type="text" index="6" >
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>Sp��ҵ����</td>
        <td nowrap> 
            <input type="text" name="spEnterCode" value="" >
            <font class="orange">*</font>
        </td>
        <td nowrap class=blue>ҵ�����</td>
        <td nowrap> 
            <input type="text" name="spTranCode"  value="" tabindex="0">
            <font class=orange>*</font>
            <input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="simChk()" >
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>�˷�ԭ��</td>
        <td nowrap> 
            <select name="UnPayFrom" class="button" index="15">
                <option value="0" selected >�ƶ���˾���Ѳ��</option>
                <option value="1">�ƶ���˾��Ϣ�Ѳ��</option>
                <option value="2">SP��Ϣ�Ѳ��</option>
            </select>
        </td>
        <td nowrap class=blue>�˷�����</td>
        <td nowrap> 
            <select name="UnPayLevel" class="button" index="15">
                <option value="0">��������</option>
                <option value="1">˫������</option>
            </select>
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>ҵ������</td>
        <td nowrap> 
            <input type="text" width="160"  MaxLength="60" name="res_name" value="" disabled />
            <font class=orange>*</font>
            <select name="res_code" onchange="change_res()">
                <option value="CM">CM:һ�������������ҵ��</option>
                <option value="MMS">MMS:��������ҵ��</option>
                <option value="WAP">WAP:WAPҵ��</option>
                <option value="FLASH">FLASH:�ֻ�����ҵ��</option>
                <option value="GD">GD:ͨ������ҵ��</option>
                <option value="GAME">GAME:�ֻ���Ϸ     </option>
                <option value="other">����:            </option>
            </select>
        </td>
        <td nowrap class=blue>ҵ������</td>
        <td nowrap> 
            <select name="spTranType" index="15">
                <option value="0">����</option>
                <option value="1">����</option>
            </select>
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>�˷�ԭ������</td>
        <td colspan="3"> 
            <input type="text" name="sp_mark" id="sp_mark" size="100"  maxlength=30>
        </td>
    </tr>
    <tr> 
        <TD nowrap class=blue> ҵ��ʹ��ʱ��</TD>
        <TD>
            <input name="useing_time" type="text" size="14" maxlength="14" v_format="yyyyMMddHHmmss">(��ʽ:yyyymmddhh24miss)
            <font class="orange">*</font>    
        </TD>		
        <td nowrap class=blue>���ս��</td>
        <td noWrap> 
            <input type="text"  class="button" name="feeMoney" maxlength="10" value="" onKeyPress="return isKeyNumberdot(1)" >
            <font class="orange">*</font>
            <input type=button class="b_text" name="buttonclick" style="cursor:hand" onClick="accountbackfee()" value=���� disabled></td>
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>�˷Ѳ��ս��</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="backMoney" value="" readonly >
        </td>
        <td nowrap class=blue>�⳥���</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="compMoney" value="" readonly >
        </td>
            <!--
            <td class=Input nowrap bgcolor="#eeeeee" width="16%">�˷��ֽ�:</td>
            <td class=Input nowrap bgcolor="#eeeeee" width="40%"> 
            <input class="button" type="text" name="backPreMoney" value="" tabindex="0" readonly >
            </td>
            -->
    </tr>
    <tr>
        <td nowrap class=blue>��ע</td>
        <td colspan="3"> 
            <input type="text" class="InputGrey" name="op_mark" id="op_mark" size="60" v_maxlength=60  v_type=string  index="28" readonly maxlength=60> 
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4"> 
            <input class="b_foot" type="button" name="confirm" value="��ӡ&ȷ��"  onClick=" printCommit()" index="26" disabled >
            <input class="b_foot" type=reset name=back value="���" onClick="document.all.confirm.disabled=true;" >
            <input class="b_foot" type="button" name="b_back" value="�ر�"  onClick="removeCurrentTab()" index="28">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

