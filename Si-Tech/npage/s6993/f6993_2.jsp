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

<%
    String regionCode = (String)session.getAttribute("regCode");
    
    String iLoginAccept = "0";      //ҵ����ˮ
    String iChnSource   = WtcUtil.repNull((String)request.getParameter("qdType"));       //������ʶ
    String opCode = "4230";         //��������(iOpCode)
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));  //����(iLoginNo)
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));  //��������(iLoginPwd��
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));  //����() 
    String iUserPwd = "";  //��������()
    String inOrgCode = (String)session.getAttribute("orgCode"); //�������Ź���
    String inOpSource = WtcUtil.repNull((String)request.getParameter("xfType")); //������Դ
    String inBizType = WtcUtil.repNull((String)request.getParameter("ywType"));  //ҵ������
    String inPhshType = "";  //��ʱû��
    String inOpCode = WtcUtil.repNull((String)request.getParameter("opType"));   //��������
    
    
    System.out.println("-----------------------iLoginAccept----------------------------"+iLoginAccept);
    System.out.println("-----------------------iChnSource------------------------------"+iChnSource);
    System.out.println("-----------------------opCode----------------------------------"+opCode);
    System.out.println("-----------------------workNo----------------------------------"+workNo);
    System.out.println("-----------------------workPwd---------------------------------"+workPwd);
    System.out.println("-----------------------iPhoneNo--------------------------------"+iPhoneNo);
    System.out.println("-----------------------iUserPwd--------------------------------"+iUserPwd);
    System.out.println("-----------------------inOrgCode-------------------------------"+inOrgCode);
    System.out.println("-----------------------inOpSource------------------------------"+inOpSource);
    System.out.println("-----------------------inBizType-------------------------------"+inBizType);
    System.out.println("-----------------------inPhshType------------------------------"+inPhshType);
    System.out.println("-----------------------inOpCode--------------------------------"+inOpCode);
    
    
try{ 
%>
    <wtc:service name="s4230stmmOrder" retcode="reCode" retmsg="reMsg" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=iLoginAccept%>"/> 
    	<wtc:param value="<%=iChnSource%>"/> 
    	<wtc:param value="<%=opCode%>"/> 
    	<wtc:param value="<%=workNo%>"/> 
    	<wtc:param value="<%=workPwd%>"/> 
    	<wtc:param value="<%=iPhoneNo%>"/> 
    	<wtc:param value="<%=iUserPwd%>"/> 
    	<wtc:param value="<%=inOrgCode%>"/> 							
    	<wtc:param value="<%=inOpSource%>"/> 	
    	<wtc:param value="<%=inBizType%>"/> 	
    	<wtc:param value="<%=inPhshType%>"/> 	
    	<wtc:param value="<%=inOpCode%>"/> 
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
%>

				<script type="text/javascript">
            rdShowMessageDialog("ϵͳ��������ϵ����Ա",0);
            history.go(-1);
        </script>

<%


}
    %>