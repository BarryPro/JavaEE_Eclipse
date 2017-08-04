

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = "3234";
  String opName = "查询集团网外号码列表";
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误

    String callData[][] = new String[][]{};
    String[] ParamsIn = null;

	String iOpCode = request.getParameter("Op_Code");
	String iWorkNo = request.getParameter("WorkNo");
	String iWorkName = request.getParameter("WorkName");
	String iNoPass = request.getParameter("NoPass");
	String iSystemNote = request.getParameter("TBackNote");
	String iGrpId = request.getParameter("TGrpId");
    String iRegion_Code = (String)session.getAttribute("regCode");

  %>
<wtc:service name="sd970Qry" routerKey="region" routerValue="<%=iRegion_Code%>"  retcode="error_code" retmsg="error_msg" outnum="3">
		<wtc:param value="<%=iGrpId%>" />
	</wtc:service>
	<wtc:array id="result_t" start="0" length="1" scope="end" />
  <%
	
    if( !error_code.equals("000000")){
        valid = 2;
    }else{
        if(result_t.length==0){
            valid = 1;
        }else{
            valid = 0;
            callData = result_t;
        }
    }

 if( valid == 1){%>
<script language="JavaScript">

	rdShowMessageDialog("没有相关的查询数据!!");
	history.go(-1);
</script>

<%}else if ( valid == 2 ) {
%>
<script language="JavaScript">
	rdShowMessageDialog("错误代码：<%=error_code%><br>错误信息：<%=error_msg%>",0);
	history.go(-1);
</script>
<%
}
else{%>
<html>
<head>
<title>查询集团网外号码列表</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

</head>

<BODY>
<FORM action="" method="post" name="form">
<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">查询集团网外号码列表</div>
	</div>
	<table cellspacing="0" >
		<tr >
			 <td class="blue">集团号</TD>
				  
            <td class="blue">网外号码</TD>
         	</TR>
         <% for (int i=0;i<callData.length;i++){%>
			<tr >
			      <td class="blue"><%=iGrpId%></td>
                  
                  <td class="blue">
                   <%=callData[i][0]%>
                  </td>
			 </tr>
		<%}%>
    </table>
        <TABLE cellSpacing="0">
          <TR >
            <TD noWrap  colspan="6" id="footer">
                <input type="button" name="return" class="b_foot" value="返回" onclick="history.go(-1)">
                <input type="button" name="return" class="b_foot" value="关闭" onClick="removeCurrentTab()">
            </TD>
          </TR>
        </TABLE>
			<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html>
<%}%>