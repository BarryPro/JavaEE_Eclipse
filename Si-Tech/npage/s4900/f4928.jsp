<%
/********************
version v2.0
开发商: si-tech
liyan 20080805 应收资金管理系统@营业员上交款查询
展示界面 op_code=4928
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>营业员上交款查询</title>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
    String workNoFromSession=(String)session.getAttribute("workNo");
	//String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	     workNoFlag=true;

    String work_no = (String)session.getAttribute("workNo");
    String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
    String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>
<body >
<form name="frm" method="POST" action="f4928Qry.jsp" >
	<%@ include file="/npage/include/header.jsp" %>
<input type=hidden name=opCode value="<%=opCode%>">
<input type=hidden name=opName value="<%=opName%>">
	<div class="title">
        		<div id="title_zi">营业员上交款查询</div>
        	</div>
      <table >
     	<tr >
           <TD class="blue">开始时间：&nbsp;<input type="text" v_type="date" v_name="开始时间" class="button" name="begin_time" value=<%=dateStr%> size="17" maxlength="8" v_type="0_9" v_name="开始时间" v_must=1  ></TD>
           <TD class="blue">结束时间：&nbsp;<input type="text" v_type="date" v_name="结束时间" class="button" name="end_time" value=<%=dateStr%> size="17" maxlength="8" v_type="0_9" v_name="结束时间" v_must=1  ></TD>
       </tr>
	   <tr>
           <td colspan="2" ><div align="center">

           </div></td>
       </tr>
       		
          <TR id="footer">

        <TD colspan=6>
               <input class="b_foot" type=button name="confirm" value="查询" onClick="doCfm(this)" index="2">
               <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
      		     <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">

        </TD>

    </TR>
      
       <tr><td colspan="2" ><font color="#FF0000">注：查询结果包括审批通过、审批未通过，不包括已经清空的数据。</font></td></tr>

      </table>
 <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>

<script language="JavaScript">
function doCfm()
 {
	//判断时间是否有效
	if(!check(frm))
	{
		return false;
	}
	var begin_time=document.frm.begin_time.value;
	var end_time=document.frm.end_time.value;
	/*
	if (isValidYYYYMMDD(document.frm.begin_time.value) != 0)
    {
	  	rdShowMessageDialog("开始时间格式不对! <br>应为：YYYYMMDD ");
	  	document.frm.begin_time.focus();
	  	return false;
    }*/
	if(begin_time>end_time)
	{
		rdShowMessageDialog("开始时间不可比结束时间大");
		return false;
	}
	document.frm.submit();
	return true;
}
</script>