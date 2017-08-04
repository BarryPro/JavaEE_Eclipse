<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
	int valid = 1;	//0:正确，1：系统错误，2：业务错误
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regionCode"));
	String phoneNo=request.getParameter("phoneNo");
	String starttime=request.getParameter("starttime");
    String endtime=request.getParameter("endtime");
	System.out.println("######################"+phoneNo);
	System.out.println("######################"+starttime);
	System.out.println("######################"+endtime);

	String error_code="";
	String error_msg="";
	String result[][] = new String[][]{};
    String opCode = "3135";
    String opName = "智能网产品变更历史查询";
    String[] ParamsIn = null;
	ArrayList retArray = null;
	ParamsIn = new String[] {phoneNo,starttime,endtime,regionCode};
    //retArray = callView.callFXService("s3515Qry", ParamsIn, "12", "region", regionCode);
    try{
    System.out.println("### = "+phoneNo);
    System.out.println("### = "+starttime);
    System.out.println("### = "+endtime);
    System.out.println("### = "+regionCode);
    %>
        <wtc:service name="s3135EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
        	<wtc:param value="<%=phoneNo%>"/>
        	<wtc:param value="<%=starttime%>"/> 
            <wtc:param value="<%=endtime%>"/> 
            <wtc:param value="<%=regionCode%>"/> 
        </wtc:service>
        <wtc:array id="retArr1" scope="end"/>
    <%
        error_code = retCode1;
        error_msg = retMsg1;
        if("000000".equals(error_code)){
            if(retArr1.length>0){
                valid = 0;
                result = retArr1;
            }else{
                valid = 1;
            }
        }else{
            valid = 2;
        }
    }catch(Exception e){
        %>
        <script type=text/javascript>
            rdShowMessageDialog("调用服务s3515Qry失败！",0);
            history.go(-1);
        </script>
        <%
        e.printStackTrace();
    }
	//callView.printRetValue();
    //error_code = callView.getErrCode();
    //error_msg= callView.getErrMsg();
	
	if(valid==1){
	%>
		<script language="JavaScript">
		rdShowMessageDialog("没有符合条件的数据!");
		history.go(-1);
		</script>
		
	<%
		return;
	}
   else if(valid==2){
   	%>
	<SCRIPT language="JavaScript">
			rdShowMessageDialog("业务错误！<br>错误代码：'<%=error_code%>'。<br>错误信息：'<%=error_msg%>'。",0);
			history.go(-1);
		</SCRIPT>
<% 
       return ;
   }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>智能网产品变更历史查询</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_custuser">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">智能网产品变更历史查询</div>
</div>
            <TABLE cellSpacing=0>
                <TR> 	
                <Th>操作工号</Th>
                <Th>操作日期</Th>
                <Th>智能网编号</Th>
                <Th>操作名称</Th>
                <Th>集团编号</Th>	
                <Th>集团名称</Th>	
                <Th>集团类型</Th>		
                <Th>主叫号码显示方式</Th>
                <Th>网内费率索引</Th>
                <Th>网外号码组费率索引</Th>				  
                </TR>
			<%
			for(int i=0;i<result.length;i++){				
				out.println("<Tr>");
				out.println("<TD nowrap>"+result[i][0]+"</TD>");
				out.println("<TD nowrap>"+result[i][1]+"</TD>");
				out.println("<TD nowrap>"+result[i][2]+"</TD>");
				out.println("<TD nowrap>"+result[i][3]+"</TD>");
				out.println("<TD >"+result[i][4]+"</TD>");
				out.println("<TD >"+result[i][5]+"</TD>");
				out.println("<TD >"+result[i][6]+"</TD>");
				out.println("<TD >"+result[i][7]+"</TD>");
				out.println("<TD >"+result[i][8]+"</TD>");
				out.println("<TD >"+result[i][9]+"</TD>");	
				out.println("<TR >");
				}
			%>

      </table>
      <table cellspacing=0>
          <tr id="footer"> 
      	    <td>
      	    	<input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	        <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
    	    </td>
          </tr>
      </table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>