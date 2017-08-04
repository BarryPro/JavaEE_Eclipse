<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@page contentType="text/html;charset=gb2312" %>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");      //工号
				
	/* 接受输入参数 */
	     
	String Phone_no         = request.getParameter("phoneNo")       ; //        
	String Group_no         = request.getParameter("grounNo"); // 智能网集团号码
  	/*String orgCode          = baseInfo[0][16];*/
  	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = (String)session.getAttribute("regCode");
	System.out.println("Phone_no="+Phone_no);                                                      
	                                                      
	int errCode             =0;                                        
  	String errMsg           ="";                              
	String paramsIn[]       = new String[4]   ;  
	
	
	
  	paramsIn[0]             =  Phone_no        ; // 
    paramsIn[1]             =  Group_no       ;  //            
    paramsIn[2]             =  orgCode        ;
    paramsIn[3]             =  workNo         ;//wuxy alter 20090514 为记录操作日志传递参数
    //acceptList = impl.callService("sDeletZNWCfm",paramsIn,"0");
  %>
	<wtc:service name="sDeletZNWCfmEXC" routerKey="region" routerValue="<%=regionCode%>"  retcode="errCode1" retmsg="errMsg1" outnum="6">
		<wtc:param value="<%=Phone_no%>" />
		<wtc:param value="<%=Group_no%>" />
		<wtc:param value="<%=orgCode%>" />
		<wtc:param value="<%=workNo%>" />
	</wtc:service>
	<wtc:array id="retStrBossMsg" scope="end" />		  
  <%    
  	if(!errCode1.equals("000000"))
  	{
%>
    <script language='javascript'>
    	rdShowMessageDialog("<%=errCode1%>[<%=errMsg1%>]",0)
      window.close();
    </script>
<%	}
	else
	{
	%>
    <script language='javascript'>
    	rdShowMessageDialog("删除智能网侧数据成功",2)
      window.close();
    </script>
<% }
	
%>

