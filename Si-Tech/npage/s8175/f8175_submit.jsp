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
<%
	
	String workNo = (String)session.getAttribute("workNo");	
	String ip_Addr = request.getRemoteAddr();	
	String nopass  = (String)session.getAttribute("password");	
	String regionCode=(String)session.getAttribute("regCode");
%>
<%
	
	String opCode  = "8175";
	String loginNo = request.getParameter("loginNo");
	String spowerCode = request.getParameter("powerCode");
	String opType = request.getParameter("opType");
	String oaNumber = request.getParameter("oaNumber");					//OA���
	String oaTitle = request.getParameter("oaTitle");					//OA����
	System.out.println("liangyl------------------------"+oaNumber);
	System.out.println("liangyl------------------------"+oaTitle);

	System.out.println("loginNo:"+loginNo+" spowerCode:"+spowerCode+" opType:"+opType);
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList list = new ArrayList();
	System.out.println(">>>>>"+spowerCode);	
	String[] powerCode = spowerCode.split("\\|");
	
	for(int i = 0; i < powerCode.length; i ++)
	{
		System.out.println(">>>>>>"+ powerCode[i]);
	}
	
	
	/*list.add(new String[]{workNo});       //��������
	list.add(new String[]{nopass});       //����
	list.add(new String[]{opCode});       //��������
	list.add(new String[]{opType});       //��������
	list.add(new String[]{loginNo});      //����������
	list.add(powerCode);    //������ע
	list.add(new String[]{ip_Addr});      //IP��ַ
	
	String[] acceptArray = new String[]{};*/
	String errCode = "-1";
	String errMsg ="";
	
	
		//acceptArray = impl.callService("s8175Cfm", list, "1","region", regionCode);	
	%>
		<wtc:service name="s8175Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=opType%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:params value="<%=powerCode%>"/>
			<wtc:param value="<%=ip_Addr%>"/>
			<wtc:param value="<%=oaNumber%>"/>
			<wtc:param value="<%=oaTitle%>"/>
		</wtc:service>		
	<%
		errCode = retCode1;
		errMsg = retMsg1;
		System.out.println("retCode1===================="+errCode);
		System.out.println("retMsg1===================="+errMsg);
		System.out.println("retCode1===================="+errCode);
		System.out.println("retMsg1===================="+errMsg);

	
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 	 rdShowMessageDialog("�����ɹ���",2);
			 document.location.replace("<%=request.getContextPath()%>/npage/s8175/f8175_1.jsp");
        </script>
<%	}
    else
    {
%>
		  <script language='jscript'>
	          rdShowMessageDialog("������Ϣ��<%=errMsg%><br>������룺<%=errCode%>", 0);
	          document.location.replace("<%=request.getContextPath()%>/npage/s8175/f8175_1.jsp");
	      </script>
<%
    }
%>
