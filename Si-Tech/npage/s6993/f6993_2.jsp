<%
    /********************
     * @ OpCode    :  6991
     * @ OpName    :  SIM卡变更历史和详细信息查询
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
    
    String iLoginAccept = "0";      //业务流水
    String iChnSource   = WtcUtil.repNull((String)request.getParameter("qdType"));       //渠道标识
    String opCode = "4230";         //操作代码(iOpCode)
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));  //工号(iLoginNo)
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));  //工号密码(iLoginPwd）
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));  //号码() 
    String iUserPwd = "";  //号码密码()
    String inOrgCode = (String)session.getAttribute("orgCode"); //操作工号归属
    String inOpSource = WtcUtil.repNull((String)request.getParameter("xfType")); //操作来源
    String inBizType = WtcUtil.repNull((String)request.getParameter("ywType"));  //业务类型
    String inPhshType = "";  //暂时没用
    String inOpCode = WtcUtil.repNull((String)request.getParameter("opType"));   //操作类型
    
    
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
            rdShowMessageDialog("操作成功",2);
            removeCurrentTab();
        </script>  
   <%        
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("操作失败！错误代码：<%=reCode%>,错误信息：<%=reMsg%>",0);
            history.go(-1);
        </script>
    <%
    }
    
}catch(Exception ex)    {
%>

				<script type="text/javascript">
            rdShowMessageDialog("系统错误，请联系管理员",0);
            history.go(-1);
        </script>

<%


}
    %>