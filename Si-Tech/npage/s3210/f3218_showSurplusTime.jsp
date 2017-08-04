<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
  String opCode = WtcUtil.repNull(request.getParameter("opCode"));
  String opName = WtcUtil.repNull(request.getParameter("opName"));
  String v_phoneNo = WtcUtil.repNull(request.getParameter("v_phoneNo"));
  String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String password = WtcUtil.repNull((String)session.getAttribute("password"));
  String[][] result1 = new String[][]{};
  //获取当前系统时间
  Date currentTime = new Date(); 
  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
  String currentTimeString = formatter.format(currentTime);
  //out.print("opCode="+opCode+"--opName="+opName+"--v_phoneNo="+v_phoneNo+"--currentTimeString="+currentTimeString);
	try{
%>		
  <wtc:service name="s5186FavMsg"  routerKey="region" routerValue="<%=regionCode%>" outnum="12" retcode="errcode" retmsg="errmsg" >
    <wtc:param value="<%=workNo%>" />
    <wtc:param value="<%=password%>" />
    <wtc:param value="<%=opCode%>" />
    <wtc:param value="<%=v_phoneNo%>" />
    <wtc:param value="<%=currentTimeString%>" />
  </wtc:service>
  <wtc:array id="retArr1" scope="end"/>
    <%
        if("000000".equals(errcode)){
            if(retArr1.length>0){
              result1 = retArr1;
              for(int i = 0;i<result1.length;i++) {
          		  for(int j = 0;j<result1[0].length;j++)
          		    System.out.println("liujian5082---result1["+i+"]["+j+"]"+result1[i][j]);
      	    }
        	}else{
        	  if (result1[0][11].trim().equals("")){
       %>
          <script language="javascript">
          	rdShowMessageDialog("没有找到任何数据",0);
          	//history.go(-1);
          	window.close();
        </script>
       <% 
        	  }
        	}
        }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("错误代码：<%=errcode%><br>错误信息：<%=errmsg%>",0);
                    //history.go(-1);
                    window.close();
                </script>
            <%
        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("调用服务s5186FavMsg失败！",0);
                window.close();
            </script>
        <%
        e.printStackTrace();
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>智能网资费剩余分钟时长</TITLE>
</HEAD>
<% if (!(result1.length>0) || result1[0][11].trim().equals("")){%>
<script language="javascript">

<%}else{%>
<body>
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
  <div class="title">
  	<div id="title_zi">智能网资费剩余分钟时长展示</div>
  </div>
  <table cellspacing="0">
    <tr>
      <td>智能网资费剩余分钟时长</td>
      <td><%=result1[0][11]%></td>
    </tr>
  </table>
  <table cellspacing=0 >
    <tr id="footer"> 
      <td>
      	  <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
      </td>
    </tr>
  </table>
<script>
</script>
<%@ include file="/npage/include/footer.jsp" %>
</FORM></BODY></HTML>
<%}%>