<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2008-12-31
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%@ include file="../../include/title_name.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>SIM��Ӫ��</title>
<%
    String opCode = "1442";
    String opName = "SIM��Ӫ��";
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
	
	ArrayList initArr = new ArrayList();
    ArrayList groupArr = new ArrayList();

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	String dirtPage=request.getParameter("dirtPage");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  //core.loadUnit("debug");
  //core.loadUnit("rpccore");

   
  onload=function()
  {
  	//core.rpc.onreceive = doProcess;    
 	self.status="";

	document.all.srv_no.focus();
    /* 
 	if("<%=op_code%>"=="1442")
  	  document.all.qryPage.disabled=true;
    */
<%
	if(ReqPageName.equals("s1442Main"))
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
    	rdShowMessageDialog('�ʻ�<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>��Ƿ��<%=WtcUtil.repNull(request.getParameter("oweFee"))%>Ԫ�����ܰ���ҵ��');	    
<%
	  }
      else if(retMsg.equals("101"))
	  {
%>
        rdShowMessageDialog('����<%=WtcUtil.repNull(request.getParameter("errCode"))%>��<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
<%
	  }
	}
%>
  }
function typechange(){
	if(document.all.change_code.value=='1'){
		if(rdShowConfirmDialog("�Ƿ��������ˣ�")==1){
        		document.all.phoneno_z.style.display = "";
        		document.all.phoneno_z.focus();
	    
		}else
		{
		
        		document.all.phoneno_z.style.display = "none";
	
		}
	}else{
	document.all.phoneno_z.style.display = "none";}
}

//----------------��֤���ύ����-----------------
function doCfm()
{

  if(((document.all.srv_no.value).trim()).length==0)
  {
    rdShowMessageDialog("������벻��Ϊ�գ�");
    document.all.srv_no.focus();
    return false;
  }
  if(document.all.phoneno_z.style.display!="none" && document.all.change_code.value=='1'){
   if(((document.all.phone_z.value).trim()).length==0){
   	rdShowMessageDialog("ת���˺��벻��Ϊ�գ�");
   	document.all.phone_z.focus();
   	return false;
   }
  
  }
 

  if(check(frm))
  {
		 frm.action="s1442Main.jsp";
		 frm.submit(); 
  }
}
 //--------3---------��֤��ťר�ú���-------------
 function chgSmCode1220()
 {
    if("<%=op_code%>"=="1220")
    {
		if(((document.all.srv_no.value).trim()).length==0)
		{
		  return true;
		}
		else
		{
		  if(checkElement("srv_no")==false) return false;
		}
		var myPacket = new AJAXPacket("chgSmCode1442.jsp","���ڻ��ҵ��Ʒ�ƣ����Ժ�......");
		myPacket.data.add("srv_no",(document.all.srv_no.value).trim());
		myPacket.data.add("verifyType","smcode");

		core.ajax.sendPacket(myPacket);
		myPacket = null;
    }
	else
    {
		frm.qryPage.focus();
	}
 }

//-------------------------------------------------------
function doProcess(packet)
 {
	var errCode=packet.data.findValueByName("errCode");
	var errMsg=packet.data.findValueByName("errMsg");
	var verifyType = packet.data.findValueByName("verifyType");

 	self.status="";

	if(parseInt(errCode)!=0)
	{
 	  rdShowMessageDialog("����"+errCode+"��"+errMsg,0);
	}
	else
	{
		//document.all.qryPage.disabled=false;

/*     
 		if (verifyType=="smcode")
		{
 	  		document.all.smCode.value=jtrim(smCode);
             if(document.all.smCode.value=="cb" || document.all.smCode.value=="z0") 
			  document.all.cus_pass.disabled=false;
			else
			{
              if(js_pwFlag=="true")                   //���Ż�Ȩ��ʱ
				document.all.cus_pass.disabled=true;
			  else                                    //û���Ż�Ȩ��ʱ
                document.all.cus_pass.disabled=false;
			}
 
			if(frm.cus_pass.disabled){ frm.qryPage.focus();}else{ frm.cus_pass.focus();}
	  	}
	  	else */

		//{
            frm.action="s1442Main.jsp";
			frm.submit();
	  	//}
	}
 }
</script>
</head>
<body>
<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û���Ϣ</div>
</div>
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1442">
<input type="hidden" name="smCode" id="smCode" value="gn">
<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
<input type="hidden" name="org_code" id="org_code" value="<%=org_Code%>">
<input type="hidden" name="work_no" id="work_no" value="<%=work_no%>">
<table cellspacing="0">
    <tr> 
        <td class=blue nowrap>�û�����</td>
        <td nowrap> 
            <input class="InputGrey" readOnly type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_must=0 v_maxlength=16 v_type=mobphone maxlength="11" >
            <font class="orange">* </font>
        </td>
        <td class=blue nowrap>�������</td>
        <td nowrap>
            <select size="1" name="change_code" onchange="typechange()">
                <option value="0" selected>0--&gt;SIM��Ӫ��</option>
                <option value="1" >1--&gt;���ֻ���</option>
                <option value="2" >2--&gt;ȫ��ͨǩԼ����</option>
                <option value="3" >3--&gt;�´�����</option>
            </select>
            <font class="orange">* </font>
        </td>
    </tr>
    <tr id="phoneno_z" style="display:none">
        <td class="blue" nowrap>ת���˺���</td>
        <td nowrap colspan=3>
            <input type="text" maxlength="11" name="phone_z" size="16">
            <font class="orange">* </font>
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4" > 
            <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()"  >    
            <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
            <input class="b_foot" type=button name=shut value="�ر�" onClick="removeCurrentTab()"  >
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
