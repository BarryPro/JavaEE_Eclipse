<%
    /********************
     * @ OpCode    :  6991
     * @ OpName    :  SIM�������ʷ����ϸ��Ϣ��ѯ
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-01-28
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%> 
<%
    String regionCode = (String)session.getAttribute("regCode");
    String workNo = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
    String phoneNo   = WtcUtil.repNull((String)request.getParameter("phoneNo"));       
    String phoneNoj =  WtcUtil.repNull((String)request.getParameter("phoneNoja"));  
    String smsDeti = WtcUtil.repNull((String)request.getParameter("smsDeti"));    
    String signdate =new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()).toString();
    String reportTypeVal = WtcUtil.repNull((String)request.getParameter("reportTypeVal"));    
    
    System.out.println("-----------------------phoneNo----------------------------"+phoneNo);
    System.out.println("-----------------------signdate----------------------------"+signdate);
    System.out.println("-----------------------phoneNoj------------------------------"+phoneNoj);
    System.out.println("-----------------------smsDeti----------------------------------"+smsDeti);
 System.out.println("-----------------------reportTypeVal----------------------------------"+reportTypeVal);
    
    
try{ 
%>
    <wtc:service name="sShortMsgPros" retcode="reCode" retmsg="reMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=workNo%>"/> 
    	<wtc:param value="<%=password%>"/> 
    	<wtc:param value="01"/>
    	<wtc:param value="<%=phoneNo%>"/> 
    	<wtc:param value="<%=phoneNoj%>"/> 
    	<wtc:param value="<%=smsDeti%>"/> 
    	<wtc:param value="<%=signdate%>"/> 
    	<wtc:param value="<%=reportTypeVal%>"/> 
    </wtc:service>
<%

System.out.println("---------------reCode-------------"+reCode);
System.out.println("---------------reMsg--------------"+reMsg);
    if("000000".equals(reCode)){
%>    
      <script type="text/javascript">
            rdShowMessageDialog("�����ɹ�",2);
            removeCurrentTab();
        </script>  
   <%        
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("����ʧ�ܣ�������룺<%=reCode%>,������Ϣ��<%=reMsg%>",0);
            history.go(-1);
        </script>
    <%
    }
    
}catch(Exception ex)    {
System.out.println(ex);
%>

				<script type="text/javascript">
            rdShowMessageDialog("ϵͳ��������ϵ����Ա",0);
            history.go(-1);
        </script>

<%


}
    %>