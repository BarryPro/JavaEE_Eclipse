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


<%
    String opCode = "1469";
    String opName = "ȫ��spҵ���˷�";
    
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
  
%>
<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=%>"  id="seq"/>
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

<%@ include file="../../npage/s5061/head_1469Del_javascript.htm" %>

<script language="JavaScript">
 function sel_type1() {
            window.location.href='s1469.jsp';
 }

 function sel_type2(){
           window.location.href='s1469Del.jsp';
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
	<input type="hidden" name="op_type" id="op_type" value="d">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sysAccept%>">
	<%@ include file="../../include/remark.htm" %>
        <table cellspacing="0">
          <tr> 
            <td class="blue" nowrap>��������</td>
            <td nowrap colspan="3">
            <input name="spType1" type="radio" onClick="sel_type1()" value="1"  > 
            ¼�� 	
            <input name="spType2" type="radio" onClick="sel_type2()" value="2"  checked> 
            ɾ�� 	
            </td>
          </tr>
          <tr> 
            <td class="blue" nowrap>�û�����</td>
            <td nowrap colspan="3"> 
              <input type="text" name="phoneno" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11  index="6" >
              <font class="orange">*</font>              
                        </td>
          </tr>
    			<tr> 
            <td class="blue" nowrap>Sp��ҵ����</td>
            <td nowrap> 
              <input type="text" name="spEnterCode" value="" >
              <font class="orange">*</font>
            </td>
            <td class="blue" nowrap>ҵ�����</td>
            <td nowrap> 
            <input type="text" name="spTranCode"  value="" >
            <font class="orange">*</font>
            <input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="deleteSimChk()" > 
            </td>
          </tr>
                
          <tr> 
            <td class="blue" nowrap>�û�����</td>
            <td nowrap> 
                <input name="cust_name" type="text" class="InputGrey"  readonly index="6" >
            </td>
      		 <td class="blue" nowrap>�˷�����</td>
            <td nowrap> 
                <input name="UnPayLevel" type="text" class="InputGrey" readonly index="6" >
            </td>
          </tr>
          <tr> 
      		 <td class="blue" nowrap>�˷�ԭ��</td>
            <td nowrap> 
                <input name="UnPayFrom" type="text" class="InputGrey"  readonly index="6" >
	       </td>
            
            <td class="blue" nowrap>���ս��</td>
            <td nowrap> 
            <input class="InputGrey" type="text" name="feeMoney"  readonly index="6">
            </td>
          </tr>
          <tr> 
            <td class="blue" nowrap>�˷Ѳ��ս��</td>
            <td nowrap> 
              <input class="InputGrey" type="text" name="backMoney" readonly index="6" >
            </td>
            <td class="blue" nowrap>�˷��ֽ�</td>
            <td nowrap> 
            <input class="InputGrey" type="text" name="backPreMoney"  readonly index="6">
            </td>
          </tr>
         <tr> 
            <TD class="blue" nowrap> ҵ��ʹ��ʱ��</TD>
			       <td nowrap> 
			      		<input name="useing_time" type="text" class="InputGrey" readonly index="6" >
			      </TD>		
            <td class="blue" nowrap>�⳥���</td>
            <td> 
              <input class="InputGrey" type="text" name="compMoney" readonly index="6" >
            </td>
          </tr>
          

          <tr> 
            <td class="blue" nowrap>ҵ������</td>
            <td nowrap> 
              <input class="InputGrey" type="text" name="spTranName" readonly index="6" >
            </td>
            <td class="blue" nowrap>ҵ������</td>
            <td nowrap> 
            <input class="InputGrey" type="text" name="spTranType"  readonly index="6">
            </td>
          </tr>
          
          <tr> 
            <td class="blue" nowrap>�˷�ԭ������</td>
            <td colspan="3"> 
              <input type="text" class="InputGrey" name="sp_mark" size="100" readonly>
            </td>
          </tr>
          <tr>
            <td class="blue" nowrap>��ע</td>
            <td colspan="4"> 
            <input type="text" class="InputGrey" name="op_mark"  size="100" readonly> 
            </td>
          </tr>
          <tr id="footer"> 
            <td colspan="4"> 
                <input class="b_foot" type="button" name="confirm" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled >
                <input class="b_foot" type=reset name=back value="���" onClick="document.all.confirm.disabled=true;" >
                <input class="b_foot" type="button" name="b_back" value="�ر�"  onClick="removeCurrentTab()" index="28">
            </td>
          </tr>
        </table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>

