<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-06 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	
		String cnttOpCode = "7143";
	  String cnttOpName = "免填单打印";	
		String work_no = (String)session.getAttribute("workNo");
		String acceptStr=request.getParameter("acceptStr");
		String phone_no=request.getParameter("phone_no");
		String opCode=request.getParameter("opCode");
		String idNo=request.getParameter("idNo");
		String strHasEval = request.getParameter("haseval");//是否有用户满意度评价 
		String strEvalCode = request.getParameter("evalcode");//用户满意度评价代码 
		System.out.println("strHasEval="+strHasEval);
		System.out.println("strEvalCode="+strEvalCode);	
		
		String paraAray[] = new String[5];
		paraAray[0] =phone_no;
		paraAray[1] = opCode;
	 	paraAray[2] = work_no;
		paraAray[3] = acceptStr;
		paraAray[4] = idNo;
	 	//String[] ret = impl.callService("s7143Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
		<wtc:service name="s7143Cfm" routerKey="phone" routerValue="<%=activePhone%>" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>		
<%
	System.out.println("#######################retCode:"+retCode);
	int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	
	//记录统一接触
	//服务没有返回流水
	System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");	
	String loginAccept="";
	String cnttActivePhone = activePhone;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCode+"&opName="+cnttOpName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone;
	System.out.println("--------------url----:"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
	 
	if(errCode==0){
	//王良 2008年1月3日 修改增加用户满意度评价设置
	String[] retEval = new String[]{};
  if(errCode==0 && strHasEval.equals("1")){
		String strParaAray[] = new String[6];
	  strParaAray[0] = work_no; 	//0  操作工号                iLoginNo  thework_no
	  strParaAray[1] = opCode; 	//1  操作代码                iOpCode   theop_code
	  strParaAray[2] = phone_no; 			//2  移动号码                iPhoneNo  themob                         
	  strParaAray[3] = strEvalCode; //3  评价代码
	  strParaAray[4] = acceptStr; 			//5  操作流水
	  strParaAray[5] = "1"; 
	  //retEval = impl.callService("sCommEvalCfm",strParaAray,"2","phone",phone_no);
%>
		<wtc:service name="sCommEvalCfm" routerKey="phone" routerValue="<%=activePhone%>" outnum="2" >
		<wtc:param value="<%=strParaAray[0]%>"/>
		<wtc:param value="<%=strParaAray[1]%>"/>
		<wtc:param value="<%=strParaAray[2]%>"/>
		<wtc:param value="<%=strParaAray[3]%>"/>
		<wtc:param value="<%=strParaAray[4]%>"/>
		<wtc:param value="<%=strParaAray[5]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>		
<%
			int iReturnCode = retCode==""?999999:Integer.parseInt(retCode);
	    String strReturnMsg = retCode;
    	if(iReturnCode==0){
%>
				<script language="JavaScript">
					rdShowMessageDialog("评价成功!",2);
				</script>
<%    
  		}else{
%>
				<script language="JavaScript">
					rdShowMessageDialog("评价未能成功!");
				</script>
<%  		
  		}
	}
%>
			<script language="JavaScript">
				rdShowMessageDialog("合并打印确认操作成功！",2);
				window.location="f7038_1.jsp?activePhone=<%=activePhone%>";
			</script>
<%
%>   
	
<%
		}else{%>
				<script language="JavaScript">
						rdShowMessageDialog("合并打印确认操作失败!<%=errMsg%>");
						window.location="f7038_1.jsp?activePhone=<%=activePhone%>";
				</script>
<%	
		}
%>
