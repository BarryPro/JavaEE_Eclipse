<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wanglm
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>����״̬��Ϣ��ѯ</TITLE>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
    String opCode = "d008";
    String opName = "����״̬��Ϣ��ѯ";
%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
%>
</HEAD>

<body>
<script type="text/javascript" src="validate_time.js"></script>
<SCRIPT language="JavaScript">

function yincang(flag){
	if(flag == "1"){
		$("#tr2").hide();
		$("#tr3").hide();
		$("#tr1").show();
		$("#tr4").hide();
	}else if(flag == "2"){
		$("#tr1").hide();
		$("#tr3").hide();
		$("#tr2").show();
		$("#tr4").hide();
	}else if(flag == "0"){
	    $("#tr1").hide();
		$("#tr2").hide();
		$("#tr3").show();
		$("#tr4").hide();	
	}else{
		$("#tr1").hide();
		$("#tr2").hide();
		$("#tr3").hide();
		$("#tr4").show();
	} 
}
function yincanga(fl){
	if(fl == "0"){
		$("#tr5").hide();
	}else {
		$("#tr5").show();
	}
}
function doCheck(){
    	frm.action="fd008_sel.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    	frm.submit();
}
</SCRIPT>

<FORM method=post name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">����״̬��Ϣ��ѯ</div>
</div>

	<TABLE cellSpacing=0>
		<tr>
		 <td class=blue>��ѯ��������</td>	
		 <td><input type="radio" name="dingdanType" value="0" checked  onclick='yincanga("0")' />��;����
		     <input type="radio" name="dingdanType" value="1"  onclick='yincanga("1")' />��ʷ����	
		 </td>
		</tr>
		<tr>
		 <td class=blue>��ѯ������ʽ</td>	
		 <td>
		 	<input type="radio" name="dingdanSel" value="0"  onclick='yincang("0")' />�����Ų�ѯ
		 	<input type="radio" name="dingdanSel" value="1" checked onclick='yincang("1")' />�������Ų�ѯ
		    <input type="radio" name="dingdanSel" value="2"  onclick='yincang("2")' />������˺Ų�ѯ
		    <input type="radio" name="dingdanSel" value="3"  onclick='yincang("3")' />���绰�Ų�ѯ	
		    <input type="radio" name="dingdanSel" value="3"  onclick='yincang("3")' />��������ˮ	
		    <input type="radio" name="dingdanSel" value="5"  onclick='yincang("3")' />���ͻ�������	
		 </td>
		</tr>
		<tr id="tr1"> 
		 <td class=blue>���붩����</td>	
		 <td><input type="text" name="dingdanNum"  />
		 </td>
		</tr>
		
		<tr style="display:none" id="tr2">
		 <td class=blue>�������˺�</td>	
		 <td><input type="text" name="kuandaiNum"  />
		 </td>
		</tr>
		
		<tr style="display:none" id="tr3">
		 <td class=blue>���빤��</td>	
		 <td><input type="text" name="gonghao"  />
		 </td>
		</tr>
		
		<tr style="display:none" id="tr4">
		 <td class=blue>����绰��</td>	
		 <td><input type="text" name="phoneNum"  />
		 </td>
		</tr>
		
		<tr style="display:none" id="tr5">
		 <td class=blue>�����ѯʱ��</td>	
		 <td><input type="text" name="dtime"  v_type="new_date" maxlength="6" onblur="checkElement1(this)"  />
		 	 <font color="orange">* ʱ���ʽΪ200011</font>
		 </td>
		</tr>
  <tr id="footer" > 
    <td colspan=2>
    	<input type="submit" class="b_foot" name="sub" value="��ѯ" onclick="doCheck()">
      <input class="b_foot" name=reset  type=reset onClick="" value=���>
      <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->
