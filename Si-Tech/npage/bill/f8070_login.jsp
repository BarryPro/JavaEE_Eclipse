   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opCode = "8070";
  String opName = "�¸���Ϣ��Ӫ����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html;charset=GBK"%>	
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>�¸���Ϣ��Ӫ����</title>
<%
    String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    String work_no =(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");

	  String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;

/***************��Ҫ�жϹ����Ƿ��Ǽ��Ź���*****************/

 
  String sql1 = " select count(*) from shighlogin where login_no='" +work_no+"' and op_code='8070'";
  System.out.println("sql1====="+sql1);
  //ArrayList agentCodeArr1 = co1.spubqry32("1",sql1);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%  
  if(result_t1[0][0].equals("0")){
%>

<script language="JavaScript">
  	rdShowMessageDialog("�˹��Ų��������",0);
  	removeCurrentTab();
</script>
<%}%>

  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
    document.all.srv_no.focus();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  
// if(!check(document.all.frm)) return false; 
  var radio1 = document.getElementsByName("opFlag");
  
  for(var i=0;i<radio1.length;i++)
  {
   
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	if(document.all.vUnitId.value==""){
    			rdShowMessageDialog("�����뼯��ID��",0);
    			return;
     		}
	    	frm.action="f8070_1.jsp";
	    	document.all.opcode.value="8070";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("������ҵ����ˮ��",0);
	    	return;
	    }
	   
	    	frm.action="f8071_1.jsp";
	    	document.all.opcode.value="8071";
	    	
	  }
	}
  }
	    
	
 
  frm.submit();	
  return true;
}
function opchange(){
	

	 if(document.all.opFlag[0].checked==true) 
	{
	  	
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.vUnitId_id.style.display = "";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  	document.all.vUnitId_id.style.display = "none";
	  	
	  }

}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	

<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">�¸���Ϣ��Ӫ����</div>
	</div>
    <table  cellspacing="0">

	  <TR> 
	          <TD  class="blue">��������</TD>
              <TD >
		<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >����&nbsp;&nbsp;
		<input type="radio" name="opFlag" value="two" onclick="opchange()" >����
	          </TD>
		 
		      <input type="hidden" name="opcode" >
         </TR>    
         <tr> 
            <td  nowrap> 
              <div align="left" class="blue">�ֻ�����</div>
            </td>
            <td nowrap > 
            <div align="left"> 
            	<%
            	String pn_no = request.getParameter("pn_no");
            	%>
                <input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  v_name="�������" maxlength="11" index="0" value =<%=activePhone!=null?activePhone:pn_no%>  Class="InputGrey" readOnly >
                 <font class="orange">*</font></div>
            </td>

         </tr>
         <TR  style="display:''" id="vUnitId_id"> 
	          <TD  class="blue">����ID</TD>
              <TD >
			<input  type="text" name="vUnitId" id=="vUnitId" v_must=1 >
			 <font class="orange">*</font>
	          </TD>
         </TR>    
         <TR style="display:none" id="backaccept_id"> 
	          <TD  class="blue">ҵ����ˮ</TD>
              <TD >
			<input  type="text" name="backaccept" v_must=1 >
			 <font class="orange">*</font>
	          </TD>

         <tr> 
            <td colspan="5" > 
              <div align="center" id="footer"> 
              <input  type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2" class="b_foot">    
              <input  type=button name=back value="���" onClick="frm.reset()" class="b_foot">
		      <input  type=button name=qryP value="�ر�" onClick="removeCurrentTab();" class="b_foot">
              </div>
           </td>
        </tr>
      </table>

    <%@ include file="/npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>
