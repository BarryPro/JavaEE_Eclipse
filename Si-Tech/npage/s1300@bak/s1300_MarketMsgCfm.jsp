
<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String workNo =WtcUtil.repNull((String)session.getAttribute("workNo"));
	String Phone_no         = request.getParameter("Phone_no")       ; // 用户标识	        
	String Marketing_group  = request.getParameter("Marketing_group"); // 营销活动分组标识	
	String Marketing_id     = request.getParameter("Marketing_id")   ; // 营销活动标识	    
	String Accepted_degree  = request.getParameter("Accepted_degree"); // 接受程度	        
	String Instalment       = request.getParameter("Instalment")     ; // 活动批次	   
	String Marketing_name   = request.getParameter("Marketing_name") ; // 营销活动名称
	String Return_message   = request.getParameter("Return_message") ; // 反馈信息	
  String Product_code     = "none"; 
  String Accepted_name    = "";                                      // 接受程度名称
	System.out.println("Phone_no="+Phone_no);                                                      
	int errCode =0;                                        
  String errMsg           ="";                              
	String paramsIn[]       = new String[10]   ;  
	String paramsIn1[]      = new String[7]   ;  
	if(Accepted_degree.equals("3"))
	{
	  Accepted_name="拒绝";
	}
	if(Accepted_degree.equals("2"))
	{
	  Accepted_name="接受";
	}
	if(Accepted_degree.equals("1"))
	{
	  Accepted_name="接触但未营销";
	}
	if(Accepted_degree.equals("1"))
	{
	  paramsIn1[0] = "131001"         ; // function_code 
    paramsIn1[1] =  Accepted_degree;  // 接受程度	            
    paramsIn1[2] =  workNo         ;  // 操作员工号
    paramsIn1[3] =  Return_message ;  // 反馈信息
    paramsIn1[4] =  Product_code   ;  // 产品资费ID	     
    paramsIn1[5] =  Phone_no       ;  // 用户标识	        
    paramsIn1[6] =  Phone_no       ;  // 用户标识	     
    for(int i=0;i<paramsIn1.length;i++){
    	System.out.println("##################paramsIn1["+i+"]->"+paramsIn1[i]);
    }   
    //acceptList = impl.callService("sDynSqlCfm",paramsIn1,"0");
 %>
 	<wtc:service name="sDynSqlCfm" routerKey="phone" routerValue="<%=Phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="0" >
	<wtc:param value="<%=paramsIn1[0]%>"/>
	<wtc:param value="<%=paramsIn1[1]%>"/>
	<wtc:param value="<%=paramsIn1[2]%>"/>
	<wtc:param value="<%=paramsIn1[3]%>"/>
	<wtc:param value="<%=paramsIn1[4]%>"/>
	<wtc:param value="<%=paramsIn1[5]%>"/>
	<wtc:param value="<%=paramsIn1[6]%>"/>
	</wtc:service>
 <%
 		if(retCode1!=null&&!"".equals(retCode1)){
 			errCode = Integer.parseInt(retCode1);
 		}
	  errMsg=retMsg1;
	}else{
  	paramsIn[0] = "131000"; // function_code 1310:缴费营销互动
    paramsIn[1] =  Phone_no;  // 用户标识	              
    paramsIn[2] =  Marketing_group;  // 营销活动分组标识 
    paramsIn[3] =  Marketing_id;  // 营销活动标识	   
    paramsIn[4] =  Accepted_degree;  // 接受程度	       
    paramsIn[5] =  workNo;  // 操作员工号	     
    paramsIn[6] =  Return_message;  // 反馈信息	       
    paramsIn[7] =  Product_code;  // 产品资费ID	     
    paramsIn[8] =  Instalment;  // 活动批次	       
    paramsIn[9] =  Marketing_name;  // 营销活动名称	
    
    for(int i=0;i<paramsIn.length;i++){
    	System.out.println("##################paramsIn["+i+"]->"+paramsIn[i]);
    }
  
    //acceptList = impl.callService("sDynSqlCfm",paramsIn,"0");
 %>
 	<wtc:service name="sDynSqlCfm" routerKey="phone" routerValue="<%=Phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="0" >
	<wtc:param value="<%=paramsIn[0]%>"/>
	<wtc:param value="<%=paramsIn[1]%>"/>
	<wtc:param value="<%=paramsIn[2]%>"/>
	<wtc:param value="<%=paramsIn[3]%>"/>
	<wtc:param value="<%=paramsIn[4]%>"/>
	<wtc:param value="<%=paramsIn[5]%>"/>
	<wtc:param value="<%=paramsIn[6]%>"/>
	<wtc:param value="<%=paramsIn[7]%>"/>
	<wtc:param value="<%=paramsIn[8]%>"/>
	<wtc:param value="<%=paramsIn[9]%>"/>
	</wtc:service>
 <%    
	  if(retCode1!=null&&!"".equals(retCode1)){
 			errCode = Integer.parseInt(retCode1);
 		}
	  errMsg=retMsg1;
  }
  	
     
                                               
  	if(errCode != 0)
  	{
%>
    <script language='javascript'>
    	rdShowMessageDialog("<%=errCode%>[<%=errMsg%>]");
      window.close();
    </script>
<%	
	}else{
	   if(Accepted_degree.equals("1"))
	   {
%>
          <script language='javascript'>
          	rdShowMessageDialog("【<%=Marketing_name%>】营销反馈信息记录成功。<%=Accepted_name%>",2);
	      		window.close();
          </script>
 <%
	  }else{
 %>
	    
          <script language='javascript'>
          	rdShowMessageDialog("【<%=Marketing_name%>】营销反馈信息记录成功。<%=Accepted_name%>",2);
	      		window.close();
          </script>
 <%
       }  
	}
%>

