<%
/********************
 version v2.0
������: si-tech
update:yanpx@2008-10-08
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>

<%
  request.setCharacterEncoding("GBK");
  String opCode = request.getParameter("opCode");;//ģ�����
  String opName = "��������";//ģ������
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String workNoFromSession=(String)session.getAttribute("workNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");

	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
    favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=true;
%>
<%
  //comImpl co=new comImpl();

  String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  //System.out.println("sql====="+sql);
  //ArrayList agentCodeArr = co.spubqry32("2",sql);
  //String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
  onload=function()
  {
    document.all.srv_no.focus();
    document.all.backaccept_id.style.display = "";
		document.all.bind_id.style.display = "none";
		document.all.bltys.style.display = "none";
  }

//----------------��֤���ύ����-----------------
var subButt2;
function controlButt(subButton){
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
 //if(!check(frm)) return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {

	    	frm.action="f1145_1.jsp";
	    	document.all.opcode.value="1145";

	  }
	  else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("������ҵ����ˮ��");
	    	return;
	    }
	    	frm.action="f1146_1.jsp";
	    	document.all.opcode.value="1146";
	  }
	}
  }



  frm.submit();
  return true;
}
function opchange(){


	
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��������</div>
	</div>
      <table cellspacing="0">
		<tr>
		  <td class="blue" width="16%">��������</td>
		  <td width="34%">
				<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>����
		  </td>
		   <td class="blue" nowrap width="16%"> �ֻ����� </td>
            <td nowrap width="34%">
                <input value="<%=activePhone%>" readonly Class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  v_name="�������" maxlength="11" index="0">
            </td>
		</tr>
        <tr id="bind_id">
           <td class="blue" width="16%"  >��������</td>
	       <td><input type="radio" name="sale_type" value="0"  checked>����&nbsp;&nbsp;
	       	  <input type="radio" name="sale_type" value="1" >��������
	       	  <input type="hidden" name="opcode" ></td>
		    <td class="blue" nowrap width="16%" >����Ӫ�����û����¹���</td>
		    <td><input type="radio" name="bind_type" value="0" checked>��������&nbsp;&nbsp;
		  	    <input type="radio" name="bind_type" value="1">�������</td>
         </tr>
         <tr class="blue" style="display:none" id="backaccept_id">
	        <td>��������</td>
	        <td><input type="radio" name="back_type" value="0" checked>��������&nbsp;&nbsp;
		  	    <input type="radio" name="back_type" value="1">�������</td>
	        <td>ҵ����ˮ</td>
            <td><input type="text" name="backaccept" v_must=1 >
				<font class="orange">*</font>
	        </td>

         </tr>
                    	  
         <tr>
            <td colspan="4" align="center">
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab(<%=opCode%>);">
           </td>
        </tr>
      </table>
    <input type="hidden" name="opCode" value="<%=opCode%>">
    <%@ include file="/npage/include/footer_simple.jsp"%>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
   </form>
</body>
</html>
