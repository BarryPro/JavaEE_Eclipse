<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团信息查询</TITLE>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String opCode = "5082";
	String opName = "集团信息查询";
    
	String idNo = request.getParameter("idNo");//查询条件
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	String vStartPos = ""+iStartPos;
	String vEndPos = ""+iEndPos;
	
	System.out.println("idNo:"+idNo);

    
    String[][] result1 = new String[][]{};
    int recordNum = 0;
    try{
    %>

    	<wtc:service name="bs_s242ConCfm"  outnum="6" retcode="errcode" retmsg="errmsg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=idNo%>" />

    	</wtc:service>
    	<wtc:array id="retArr1" scope="end"/>
    
    <%
        if("000000".equals(errcode)){
            if(retArr1.length>0){
                result1 = retArr1;
                for(int i = 0;i<result1.length;i++) {
            		for(int j = 0;j<result1[0].length;j++)
            		    System.out.println("result1["+i+"]["+j+"]"+result1[i][j]);
        	    }
        	    recordNum = Integer.parseInt(result1[0][5].trim());

        	}
        }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("错误代码：<%=errcode%>,错误信息：<%=errmsg%>",0);
                    history.go(-1);
                </script>
            <%
        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("调用服务bs_s242ConCfm失败！",0);
            </script>
        <%
        e.printStackTrace();
    }
%>
</HEAD>
<% if (!(result1.length>0) || result1[0][0].trim().equals("")){%>
<script language="javascript">
	rdShowMessageDialog("没有找到任何数据",0);
	history.go(-1);
</script>
<%}else{%>
<body>
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团信息查询</div>
</div>
    <table cellspacing="0">
      <tr>
      	<!--<td>成员序号</td> -->
        <th>账户号码</th>
		<th>账户名称</th>
        <th>用户预存</th>
        <th>可划拨预存</th>
        <th>未出帐话费</th>

      </tr>
  <%
		for(int y=0;y<result1.length;y++){
	  %>
	  
	  <tr>
	  <%    
		for(int j=0;j<result1[0].length-1;j++){
	  %>
	    <td><%=result1[y][j]%></td>
	  <%
		}
	  %>
	   </tr>
	  <%
	    }
	  %>
    </table>

 <table cellspacing="0" id=contentList>
	<tr>
	 <td>
<%	
    //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,recordNum);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
     </TD>
    </TR>
 </TABLE>

    <table cellspacing=0>
      <tr id="footer"> 
		<td>
			  <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
			  <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
			  <input class="b_foot_long" name=print onClick="printxls()" type=button value=导出为XLS表格>
		</td>
	  </tr>
	</table>
<script>
	function printxls(){
		window.open("f5082_6_printxls.jsp?idNo=<%=idNo%>");
	}	
</script>
<%@ include file="/npage/include/footer.jsp" %>
</FORM></BODY></HTML>
<%}%>