<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ����
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<head>
<title>��ͥ����ƻ����</title>
<%

	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
	//2011/6/23 wanghfa��� ������Ȩ������ start
  boolean pwrf=false;
	String pubOpCode = "7123,7124,7125,7126";
	String pubWorkNo = (String)session.getAttribute("workNo");
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	System.out.println("====wanghfa====f7123.jsp==== pwrf = " + pwrf);
	//2011/6/23 wanghfa��� ������Ȩ������ end
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
//2010-7-21 14:05 wanghfa��� �����ʹ���µĵ������ start
	<%-- if ("true" == "<%=pwrf%>") {
	 	document.all.chief_cus_pass.disabled = true;
	 	document.all.cus_pass.disabled = true;
		document.all.cus_pass_button[0].disabled = true;
		document.all.cus_pass_button[1].disabled = true;
	} else if ("false" == "<%=pwrf%>") { --%>
	 	document.all.chief_cus_pass.disabled = false;
	 	document.all.cus_pass.disabled = false;
		document.all.cus_pass_button[0].disabled = false;
		document.all.cus_pass_button[1].disabled = false;
		$("input[name='chief_cus_pass']").attr("v_must","1");
	//}
//2010-7-21 14:05 wanghfa��� �����ʹ���µĵ������ start
    document.all.chief_srv_no.focus();
	document.all.opFlag.value= "one";
	document.all.member_id.style.display="none";
	
  }

 function chg_opType(){
	  var frm1=document.frm;
	  if(eval('frm1.open_type').value == "0"){
		  document.all.member_id.style.display="none";
		  document.all.chief_srv_no.focus();
	  }else if(eval('frm1.open_type').value == "1"){
		  document.all.family_id.style.display="";
		  document.all.member_id.style.display="";
	  }else if(eval('frm1.open_type').value == "2"){
		  document.all.family_id.style.display="none";
		  document.all.member_id.style.display="";
	  }else {
		 document.all.member_id.style.display="none";
		 document.all.family_id.style.display="";
	  }
  }
  function onClick1(){
  	  document.all.opr_type.style.display="";
  }
  
  function onClick3(){
  	document.all.open_type.value=0;
  	document.all.member_id.style.display="none";
	  document.all.opr_type.style.display="none";
  }
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  
  if(eval('frm.open_type').value == "1"){
  	if(!check(frm)) return false;
  }else if((eval('frm.open_type').value == "0") || (eval('frm.open_type').value == "3")){
  	if(!checkElement(frm.chief_srv_no))	return false;
  }else if(eval('frm.open_type').value == "2"){
  	if(!checkElement(frm.srv_no))	return false;
  }
  
  if(!checkElement(frm.chief_cus_pass))	return false;
  
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  
	  if(opFlag=="one")
	  {
	    if(document.frm.open_type.value=="1"){
			if(document.frm.chief_srv_no.value==document.frm.srv_no.value){
				rdShowMessageDialog("�ҳ�����ͳ�Ա���벻����ͬ��");
			}
		}
		frm.action="f7123_2.jsp";
	  }else if(opFlag=="two")
	  {
	    frm.action="f7123_3.jsp";
	  }
	}
  }
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
	<%@ include file="/npage/common/pwd_comm.jsp" %><!--2010-7-21 18:54 wanghfa��� ���С�����������빦�� start-->

		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
	      <TR> 
	          <TD class="blue">��������</TD>
              <TD>
			       <input type="radio" name="opFlag" value="one" checked onClick="onClick1()">ҵ�����&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="two" onClick="onClick3()">��ͥ��Ϣ��ѯ&nbsp;&nbsp;
	          </TD>
	          <td>&nbsp;</td>
	          <td>&nbsp;</td>
         </TR>
         <tr id="family_id"> 
            <td class="blue" nowrap> 
              <div align="left">�ҳ�����</div>
            </td>
			<td> 
                <input class="button"  type="text" name="chief_srv_no" id="chief_srv_no" v_minlength=1 v_maxlength=16  v_type="string" v_must=1 index="0">
                <font color="orange">*</font>
            </td>
            <td class="blue" nowrap> 
              <div align="left" >����</div>
            </td>
<!--2010-7-21 14:05 wanghfa��� �����ʹ���µĵ������ start-->
			<td> 
			<div align="left">
				  <jsp:include page="/npage/common/pwd_one_new.jsp">
					  <jsp:param name="width1" value="16%"  />
					  <jsp:param name="width2" value="34%"  />
					  <jsp:param name="pname" value="chief_cus_pass"  />
					  <jsp:param name="pwd" value="12345"  />
				 </jsp:include>
				
			</div>
			</td>
<!--2010-7-21 14:05 wanghfa��� �����ʹ���µĵ������ end-->
         </tr>
		 <tr id="member_id" style='none'> 
            <td class="blue"> 
              <div align="left">��Ա����</div>
            </td>
			<td> 
                <input class="button"  type="text" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16  v_type="string" v_must=1 index="0">
                <font color="orange">*</font>
            </td>
			<td nowrap class="blue"> 
              <div align="left">���룺</div>
            </td>
<!--2010-7-21 14:05 wanghfa��� �����ʹ���µĵ������ start-->
			<td> 
			<div align="left">
				  <jsp:include page="/npage/common/pwd_one_new.jsp">
					  <jsp:param name="width1" value="16%"  />
					  <jsp:param name="width2" value="34%"  />
					  <jsp:param name="pname" value="cus_pass"  />
					  <jsp:param name="pwd" value="12345"  />
				 </jsp:include>
				
			</div>
			</td>
<!--2010-7-21 14:05 wanghfa��� �����ʹ���µĵ������ end-->
         </tr>
		 <tr id="opr_type"> 
			<td class="blue" > 
				<div align="left">��������</div>
            </td>
			<TD class="blue">
			<SELECT NAME="open_type" id="open_type" onChange="chg_opType()">
                <option value="0">�½���ͥ</option>
                <option value="1">�����ͥ</option>
								<option value="2">�˳���ͥ</option>
								<option value="3">ȡ����ͥ</option>
			</SELECT>
			</TD>
			<td>&nbsp;</td>
	        <td>&nbsp;</td>
         </tr>
         <tr> 
            <td colspan="5" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
     
   <input type="hidden" name="op_code" value="7123">
   <input type="hidden" name="opCode" value="<%=opCode%>">
   <input type="hidden" name="opName" value="<%=opName%>">
     <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>
