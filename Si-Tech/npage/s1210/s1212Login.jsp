<%
/********************
version v2.0
������: si-tech
ģ�飺�û����Ѽƻ����
���ڣ�2008.12.1
���ߣ�leimd
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml"> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String phone_no = (String)request.getParameter("activePhone");
%>

<%
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
%>


<head>
<title>�û����Ѽƻ����</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<% 
/**  
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String work_no=baseInfoSession[0][2];
	String loginName = baseInfoSession[0][3];
	String org_Code = baseInfoSession[0][16];
**/
  String work_no = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String org_code = (String)session.getAttribute("orgCode");
  String op_code = "1212";
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
  %>

<script language=javascript>
 onload=function()
 {
    document.all.srv_no.value="<%=phone_no%>";
<%
	if(ReqPageName.equals("s1212Main"))
	{
	  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
	  {        
%>   	 
	    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");	 
<%
	  }
	  else if(retMsg.equals("100"))
	  {
%>
    	rdShowMessageDialog('�ʻ�<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>��Ƿ�ѣ����ܰ���ҵ��');	    
<%
	  }
      else if(retMsg.equals("101"))
	  {
%>
        rdShowMessageDialog('����<%=WtcUtil.repNull(request.getParameter("errCode"))%>��<%=WtcUtil.repStr

(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');	    
<%
	  }
	}
%>
  }


//----------------��֤���ύ����-----------------
function doCfm()
{
  //if(check(frm)){
	
    frm.action="s1212Main.jsp";
    frm.submit();	
  //}
  if(!check(frm)){return false}
}
</script>
</head>
<body>
<form name="frm" method="POST"   onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %> 
 <div class="title">
	<div id="title_zi">�û���¼</div>
</div>
 <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1212Login">
  <table cellspacing="0">
   <tr>
     <td nowrap class="blue" width="20%"> 
       �������
     </td>
     <td nowrap class="blue" colspan="3"> 
          <input type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type=mobphone  maxlength="11" index="0" Class="InputGrey" readOnly>
          <font class="orange">*</font>
      </td>
    </tr>
        <tr>
          <td id="footer" colspan='2'>
              <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()" index="2">      
	          <input class="b_foot" type=button name=qryPage value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
          </td>
        </tr>
   </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">  
   </form>
  </body>
</html>    
