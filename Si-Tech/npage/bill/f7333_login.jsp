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
<title>���ļ�ͥ����Ʒ����</title>
<%

	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
    document.all.chief_srv_no.focus();
	
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
	if(document.frm.open_type.value=="0"){
		document.all.opCode.value = "7333";
	  	document.all.opName.value = "���ļ�ͥ��Ʒ����";
		if(document.frm.chief_srv_no.value==""){
			rdShowMessageDialog("�ҳ����벻��Ϊ�գ�");
			document.all.chief_srv_no.focus();
			}
		frm.action="f7333_2.jsp";	
		}
	  else if(document.frm.open_type.value=="1")
	  {	
		document.all.opCode.value = "7334";
		document.all.opName.value = "���ļ�ͥ��Ʒȡ��";
	  	if(document.frm.chief_srv_no.value==""){
			rdShowMessageDialog("�ҳ����벻��Ϊ�գ�");
			document.all.chief_srv_no.focus();
			}
		frm.action="f7333_4.jsp";
	  }else if(document.frm.open_type.value=="2"){
	  		document.all.opCode.value = "7337";
	  		document.all.opName.value = "���ļ�ͥ��Ʒ���";
	  	if(document.frm.chief_srv_no.value==""){
			rdShowMessageDialog("�ҳ����벻��Ϊ�գ�");
			document.all.chief_srv_no.focus();
			}
		frm.action="f7333_3.jsp";
		}
		//else 
		//{
			//document.all.opCode.value = "7337";	
			//document.all.opName.value = "���������";
			//frm.action="f7333_5.jsp";	
		//}
		//alert(document.all.opName.value+document.all.opCode);
  //frm.action="f7333_2.jsp";
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
         <tr id="family_id"> 
            <td class="blue" nowrap > 
              <div align="left">�ҳ�����</div>
            </td>
			<td> 
                <input class="InputGrey"  type="text" name="chief_srv_no" id="chief_srv_no" v_minlength=1 v_maxlength=16  v_type="string" v_must=1 index="0" value="<%=phoneNo%>" readonly >
                <font color="orange">*</font>
            </td>
            
         </tr>
		 <tr id="opr_type"> 
			<td class="blue" > 
				<div align="left">��������</div>
            </td>
			<TD class="blue" colspan=4>
			<SELECT NAME="open_type" id="open_type" >
                <option value="0">�����Ʒ</option>
                <option value="1">ȡ����Ʒ</option>
				<option value="2">�����Ʒ</option>
				
			</SELECT>
			</TD>
			
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
     
   <input type="hidden" name="op_code" value="7333">
   <input type="hidden" name="opCode" value="<%=opCode%>">
   <input type="hidden" name="opName" value="<%=opName%>">
     <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>
