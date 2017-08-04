<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠品领取查询1245
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
	String opCode="1245";
	String opName="赠品领取查询";
	String regionCode=(String)session.getAttribute("regCode");
	Logger logger = Logger.getLogger("f1245_cfm.jsp");
	
	String op_code = "1245";    //操作代码
	String bz = request.getParameter("bz");			 //标记
	String phone_no = request.getParameter("i1");    //服务号码
	System.out.println(".....................phonecfm............."+phone_no);
	String login_no = request.getParameter("login_no"+bz);	     //工号
	String present_code = request.getParameter("present_code"+bz);	     //赠送代码
	String end_time = request.getParameter("end_time"+bz);  //赠送截至时间
	String op_note = request.getParameter("note");    //备注
	System.out.println("bz==============="+bz);
	System.out.println("login_no==============="+login_no);
	System.out.println("login_no==============="+request.getParameter("login_no0"));
	
	String retCode ="";
	String retMessage = "";	
	String serviceName = "s1295_Apply";
    try{
   		String[] paraStrIn = new String[]{phone_no,login_no,op_code,present_code,end_time,op_note};
 %>
 	<wtc:service name="s1295_Apply" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="returnCode" retmsg="retMsg">
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=present_code%>"/>
		<wtc:param value="<%=end_time%>"/>
		<wtc:param value="<%=op_note%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
 <%  		
    retCode = returnCode;
    retMessage = retMsg;
   		}catch(Exception e){
			e.printStackTrace();
  	  }
		 	
		if(!retCode.equals("000000"))
		{
		      
%>          
            <script language='jscript'>
                rdShowMessageDialog('<%=retMessage%>' + '[' + '<%=retCode%>' + ']',0);
               location = "f1245_2.jsp?i1=<%=phone_no%>";
            </script>
<%		}
        else
        {
%>			<script>
				rdShowMessageDialog("确认成功！",2);
                location = "f1245_1.jsp?activePhone=<%=phone_no%>";
            </script>
<%            
        }
%>
