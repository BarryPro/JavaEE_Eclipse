<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-19 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	
	String ip_Addr = request.getRemoteAddr();		
	String loginNo = (String)session.getAttribute("workNo");		
	String nopass  = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	
	String roleCode = request.getParameter("roleCode");	//��ɫ����
	String popeDomCode = request.getParameter("popeDomCode");	
	String[] rolePdom  = request.getParameterValues("rolePdom");  //Ȩ�޴���
	String[] old_check = request.getParameterValues("old_check");//��ѡ���־
	String[] new_check = request.getParameterValues("new_check");//��ѡ���־	
	for(int i = 0; i < old_check.length; i ++)
	{
		System.out.println(">>>>>>>>>>>>>>"+i+">>>>>>>>>>> "+old_check[i]+" <<<<<<<<<<<<<<<<<<");
		System.out.println(">>>>>>>>>>>>>>"+i+">>>>>>>>>>> "+new_check[i]+" <<<<<<<<<<<<<<<<<<");
	}	
	String loginNote = loginNo + "���н�ɫ��Ȩ�޴��뻥������";
		
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
 	/*ArrayList paramsIn = new ArrayList();
 	
 	paramsIn.add(new String[]{loginNo});
    	paramsIn.add(new String[]{nopass});
   	 paramsIn.add(new String[]{"8057"});
    	paramsIn.add(new String[]{ip_Addr});
	paramsIn.add(new String[]{loginNote});
	paramsIn.add(new String[]{roleCode});
	paramsIn.add(rolePdom);
	paramsIn.add(old_check);
	paramsIn.add(new_check);*/
	
    	//String[] retStr = null;
	
	//retStr = impl.callService("s8057_Ist", paramsIn, "2", "region", regionCode); 
%>
	<wtc:service name="s8057_Ist" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="8057"/>
		<wtc:param value="<%=ip_Addr%>"/>
		<wtc:param value="<%=loginNote%>"/>
		<wtc:param value="<%=roleCode%>"/>
		<wtc:params value="<%=rolePdom%>"/>
		<wtc:params value="<%=old_check%>"/>
		<wtc:params value="<%=new_check%>"/>
	</wtc:service>	
<%
	
	String errCode=retCode1;
	String errMsg=retMsg1;
	if(!errCode.equals("000000"))
	{
	%>        
		<script language='jscript'>
			rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			history.go(-1);
		</script> 
	<%  
	}
	else
	{
	%>
		<script language='jscript'>
			rdShowMessageDialog("�����ɹ�!",2);
			parent.rightFrame.location="funclist.jsp?&roleCode="+"<%=roleCode%>"+"&popeDomCode="+"<%=popeDomCode%>";
		</script> 
	<%		
	}	

%>