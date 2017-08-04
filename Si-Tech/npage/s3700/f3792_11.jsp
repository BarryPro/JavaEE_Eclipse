<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-------------------------------------------->
<!---日期   2008-7-7                     	---->
<!---作者   zhouzy                        ---->
<!---代码   f1500_qryCntt           			---->
<!---功能   客户统一接触查询          		---->
<!-------------------------------------------->        
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	String cust_name  = request.getParameter("custName");
	String workNo=request.getParameter("workNo");
	String orgCode=request.getParameter("orgCode");
	String phoneNo=request.getParameter("phoneNo");

	String sqlStr="";	
	String beginDateStr = (new java.text.SimpleDateFormat("yyyy-MM-").format(new java.util.Date()))+"01 00:00:00";
	String endDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String opCode = "3793";
	String opName="接触信息查询";
%>

<HTML><HEAD><TITLE>查询客户统一接触信息</TITLE>
<script language="JavaScript">
	function commitJsp()
{		
		if(!check(f1500qryCntt)){
			return false;
		}
    page = "f3792_22.jsp";
    f1500qryCntt.action=page;
    f1500qryCntt.method="post";
    f1500qryCntt.submit();
}
</script>
</HEAD>
<body>
<FORM name="f1500qryCntt">	
<%@ include file="/npage/include/header.jsp" %>
 <div class="title"><div id="title_zi">查询客户统一接触信息</div></div>
        <table cellSpacing=0>
         <tr>
                <td width="17%" class="blue">手机号码</td>
				  <td width="83%" colspan= '3'><input type="text" name= 'phoneNo' id = 'phoneNo' value= ''></td>
         </tr>
         <tr>
          <td class="blue">渠道标识</td>
				  <td>
				  	<select name="chnCode">
				  		<option value="">全部</option>
	            <%sqlStr ="select trim(chn_code),trim(chn_code)||'->'||chn_name from sChnCode";%>
					 	  <wtc:qoption name="sPubSelect" outnum="2">
						  	<wtc:sql><%=sqlStr%></wtc:sql>
					    </wtc:qoption>				 
					  </select>
				  </td>
          <td class="blue">接触交互方式</td>
				  <td>
				  	<select name="activeCode">
				  		<option value="">全部</option>
	            <%sqlStr ="select trim(interactive_code),interactive_name from sInteractiveCode";%>
					 	  <wtc:qoption name="sPubSelect" outnum="2">
						  	<wtc:sql><%=sqlStr%></wtc:sql>
					    </wtc:qoption>				 
					  </select>
				  </td>
         </tr>
         <tr>
          <td class="blue">业务操作类型</td>
				  <td colspan="3">
				  	<select name="op_code">
	           <wtc:qoption name="sPubSelect" outnum="2">
	           <option value=''>全部操作</option>
	           <wtc:sql>select function_code,function_code||'-->'||function_name from sFuncCode where function_code<'9999' and length(rtrim(function_code))=4 and rownum<500
	            </wtc:sql>
	          </wtc:qoption>		 		 
					  </select>
				  </td>
         </tr>
         <tr>
          <td class="blue">查询开始时间</td>
				  <td><input type="text" name="beginDateStr" value="<%=beginDateStr%>" v_type="date_time" v_format="yyyy-MM-dd HH:mm:ss" v_must="1" size="20" onblur="checkElement(this)"></td>
          <td class="blue">查询开始时间</td>
				  <td><input type="text" name="endDateStr" value="<%=endDateStr%>" v_type="date_time" v_format="yyyy-MM-dd HH:mm:ss" v_must="1" size="20" onblur="checkElement(this)"></td>
         </tr>
          <tr> 
      	    <td id="footer" colspan="4">
      	    &nbsp; <input class="b_foot" name=submits onClick="commitJsp()" type=button value=查询>	
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
      </table>
      <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
      <input type="hidden" name="workNo" value="<%=workNo%>">
      <input type="hidden" name="orgCode" value="<%=orgCode%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

