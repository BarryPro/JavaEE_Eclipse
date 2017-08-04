<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-------------------------------------------->
<!---日期   2009-01-05                     	---->
<!---作者   xulg                        ---->
<!---代码   f3791_qryCntt           			---->
<!---功能   接触轨迹查询          		---->
<!-------------------------------------------->        
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	String cust_name  = null;
	String workNo= null;
	String orgCode= null;
	String phoneNo= null;
	String opCode = "3791";
	String opName="接触轨迹查询";
	String sqlStr="";	
	String beginDateStr = (new java.text.SimpleDateFormat("yyyy-MM-").format(new java.util.Date()))+"01 00:00:00";
	String endDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
%>

<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="JavaScript">
	function commitJsp()
{		
    page = "f3791_qryCnttCfm.jsp";
    f37911.action=page;
    f37911.method="post";
    f37911.submit();
}
</script>
</HEAD>
<body>
<FORM name="f37911">	
<%@ include file="/npage/include/header.jsp" %>
        <table cellSpacing=0>
         <tr>
          <td width="17%" class="blue">接触ID</td>
          <td width="83%" colspan="3"><input type="text"  name="sContactId" size="40" maxlength="30" onKeyDown="if(event.keyCode==13){ doCheck();return false}"></td>
         </tr>
         
         <tr>
          <td class="blue">查询开始时间</td>
				  <td><input type="text" name="beginDateStr" value="<%=beginDateStr%>" v_type="date_time" v_format="yyyy-MM-dd HH:mm:ss" v_must="1" size="20" onblur="checkElement(this)"></td>
          <td class="blue">查询结束时间</td>
				  <td><input type="text" name="endDateStr" value="<%=endDateStr%>" v_type="date_time" v_format="yyyy-MM-dd HH:mm:ss" v_must="1" size="20" onblur="checkElement(this)"></td>
         </tr>
          <tr> 
      	    <td id="footer" colspan="4">
      	    &nbsp; <input class="b_foot" name=submits onClick="commitJsp()" type=button value=查询>	
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
      </table>
      <input type="hidden" name="workNo" value="<%=workNo%>">
      <input type="hidden" name="orgCode" value="<%=orgCode%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

