		   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-16
********************/
%>
              
<%
  String opCode = "1428";
  String opName = "���չ�ϵ���";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
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
<html>
<head>
<title>���չ�ϵ���</title>
<%   
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>

 onload=function()
 {
 	self.status="";
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
    	rdShowMessageDialog('�ʻ�<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>��Ƿ�ѣ����ܰ���ҵ��',0);	    
<%
	  }
      else if(retMsg.equals("101"))
	  {
%>
        rdShowMessageDialog('����<%=WtcUtil.repNull(request.getParameter("errCode"))%><%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>',0);	    
<%
	  }
	}
%>
  }


//----------------��֤���ύ����-----------------
function doCfm()
{
    frm.action="s1428_1.jsp";
    frm.submit();	

}
</script>
</head>
<body>
<form name="frm" method="POST"   onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">���չ�ϵ���</div>
	</div>
 <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1212Login">

        <table  cellspacing="0" >

          <tr> 
            <td width="16%"  nowrap> 
              <div align="left" class="blue">�������</div>
            </td>
      <td nowrap  width="34%"> 
        <div align="left"> 
                <input  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type=mobphone  v_name="�������" maxlength="11" index="0" value =<%=activePhone%>  Class="InputGrey" readOnly >
                 <font class="orange">*</font></div>
      </td>
            
    </tr>
 
          <tr > 
            <td colspan="5"  id="footer"> 
              <div align="center"> 
          <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()" index="2" >      
          <input class="b_foot" type=button name=back value="���" onClick="frm.reset()"  >
		  <input class="b_foot" type=button name=qryPage value="�ر�" onClick="removeCurrentTab()"  >
              </div>
      </td>
    </tr>
  </table>

  <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>