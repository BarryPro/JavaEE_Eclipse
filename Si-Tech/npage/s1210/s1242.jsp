 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-16 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	  String srv_no=request.getParameter("srv_no");
	  System.out.println("===================srv_no==============="+srv_no);
	  if(activePhone==null){
	  	activePhone=srv_no;
	  }
	  HashMap hm=new HashMap();
	  hm.put("1","û�пͻ�ID��");
	  hm.put("3","�������");
	  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
	  
	  hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��"); 
	  hm.put("13","���������������"); 
	  hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
%>
<html>
<head>
<title>���뱸��</title>
<%
	String opCode = "1242";	
	String opName = "���뱸��";	//header.jsp��Ҫ�Ĳ���  
	String phone=request.getParameter("phone");
	
   	String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
%>


	<script language=javascript>
		  onload=function()
		  {
		 	self.status="";
		    <%
			  if(workNoFlag)
			  {
			%>
		 		document.all.srv_no.value=<%=userPhoneNo%>;
				document.all.srv_no.readOnly=true;
				document.all.qryPage.focus();
		   <%
			  }
			  else
			  {
			%>
		       document.all.srv_no.focus();
		    <%
			  }
			%>
		
		<%
			if(ReqPageName.equals("sa242Main"))
			{
			  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
		 	  if(!retMsg.equals("100") && !retMsg.equals("101") && !retMsg.equals("102"))
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
		      else if(retMsg.equals("102"))
			  {
		%>
		       rdShowMessageDialog('�������������������Ϊ��<%=WtcUtil.repNull(request.getParameter("BackupSimNo"))%>��');	    
		
		<%
			  }
			}
		%>
		  }
		
		
		//----------------��֤���ύ����-----------------
		function doCfm()
		{
		  if(check(frm))
		  {	
		    frm.action="s1242Main.jsp";
		    frm.submit();	
		  }
		}
	</script>
</head>
<body>	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">���뱸��</div>
	</div>	
  	<input type="hidden" name="ReqPageName" id="ReqPageName" value="sa242">
        <table cellspacing="0">      
	    <tr> 
	            <td width="16%"  nowrap class="blue"> �������</td>	            
	      	    <td nowrap  width="34%"> 	        
	                <input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type=mobphone   maxlength="11" index="0" value ="<%=activePhone%>"  readonly class="InputGrey">
	                <font class="orange">*</font>
	      	    </td>	            
	    </tr>
	</table>
	<table cellspacing="0">       
          <tr> 
            <td id="footer">               
          	<input  type=button class="b_foot" name=qryPage value="ȷ��" onClick="doCfm()" index="2">    
          	<input  type=button class="b_foot" name=back value="���" onClick="frm.reset()">
		<input  type=button class="b_foot" name=qryP value="�ر�" onClick="removeCurrentTab()">
      	   </td>
         </tr>
       </table>
   	<%@ include file="/npage/include/footer_simple.jsp" %>    
   </form>
</body>
</html>
