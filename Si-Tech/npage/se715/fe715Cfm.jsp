<%
   /*���ƣ��¾ɷ�����벢�� - ����ύ
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: liuweih
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.10
 ģ�飺�������ҵ������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%  
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));            //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));         //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));            //��½����
	String regionCode =WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));


	String opCode = "e715";	
	String opName = "�¾ɴ��벢����ͣ�ָ�";
%>

<%
	String OprCode ="A";
	String ecid = request.getParameter("ecsiid");
	String codeprop = request.getParameter("BaseServCodeProp1");
	String oldcode = request.getParameter("OldBaseServCode");
	String newcode = request.getParameter("NewBaseServCode");
	

		

%>
	 <wtc:service name="se715Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=ecid%>"/> 
			<wtc:param value="<%=codeprop%>"/> 
			<wtc:param value="<%=oldcode%>"/> 
			<wtc:param value="<%=newcode%>"/> 
			<wtc:param value="<%=OprCode%>"/> 
			<wtc:param value="<%=regionCode%>"/> 
	            	
        </wtc:service>
	<wtc:array id="retStr"  scope="end"/>
<%

	
	if(retCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("�����ɹ���"); 
        	window.location="fe715.jsp"; 
       
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("������Ϣ��<%=retMsg%>",0);	
	            history.go(-1);
	      </script>         
<%            
    }
    
%>
