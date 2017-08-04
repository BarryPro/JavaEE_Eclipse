<% 
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-12 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String work_no = (String)session.getAttribute("workNo");
	
	String opCode = "i142";
    String opName = "VPMN业务使用时长查询";
  
	String open_time  ="";
	String cust_name  ="";
	String phoneNo  = request.getParameter("phoneNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    

	//出参
	String s_grp_id="无";
	String s_grp_name="无";
	String s_manager_name="无";
	String s_manager_phone="无";
	String s_offer_id="无";
	String s_offer_name="无";
	String s_should_minutes="无";
	String s_fav_minutes="无";
	String s_left_minutes="无";
	 
	
	String  inputParsm [] = new String[2];
	inputParsm[0] = phoneNo;
	inputParsm[1] = dateStr;
 
 
%>
	<wtc:service name="sVpmnSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=dateStr%>"/>
	</wtc:service>   
	<wtc:array id="cussidArr" scope="end"/>
<%
	if(cussidArr!=null&&cussidArr.length>0)
	{
		s_grp_id = cussidArr[0][0];
		s_grp_name = cussidArr[0][1];
		s_manager_name = cussidArr[0][2];
		s_manager_phone = cussidArr[0][3];
		s_offer_id =  cussidArr[0][4];
		s_offer_name  =  cussidArr[0][5];
		s_should_minutes  =  cussidArr[0][6];
		s_fav_minutes  =  cussidArr[0][7];
		s_left_minutes  =  cussidArr[0][8];
	}
	//界面要素：手机号码、归属集团代码及集团名称、客户经理及客户经理电话、VPMN资费套餐代码及资费名称、应赠送的分钟数、当前已使用的分钟数、剩余分钟数。
	 
%>
 
<HTML>
	<HEAD>
	<title>优惠信息查询</title>
	</HEAD>
<BODY>
<FORM method=post name="frm5186">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">VPMN业务使用时长优惠信息查询</div>
		</div>
		<TABLe cellSpacing="0">
	    <TR> 
	    	<td class="blue">手机号码</TD>
          <td>
          	<input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value="<%=phoneNo%>">
          </td>
          <td class="blue">&nbsp</td>
          <td>
           <input type="hidden" readonly class="InputGrey" name="nopass" size="20" maxlength="11" value="<%=nopass%>">
          </td>
          </TR>
			<TR>
				<td class="blue">所属集团代码</TD>
				<TD><input class="InputGrey" name="s_grp_id" value="<%=s_grp_id%>" maxlength="25" size=20 readonly></TD>
				<td class="blue">所属集团名称</TD>
				<TD><input class="InputGrey" name="s_grp_name" value="<%=s_grp_name%>" maxlength="25" size=20 readonly></TD>
			</TR>
			<TR>
				<td class="blue">客户经理电话</TD>
				<TD><input class="InputGrey" name="s_manager_phone" value="<%=s_manager_phone%>" maxlength="25" size=20 readonly></TD>
				<td class="blue">客户经理姓名</TD>
				<TD><input class="InputGrey" name="s_manager_name" value="<%=s_manager_name%>" maxlength="25" size=20 readonly></TD>
			</TR> 
			<TR>
				<td class="blue">VPMN资费套餐代码</TD>
				<TD><input class="InputGrey" name="s_offer_id" value="<%=s_offer_id%>" maxlength="25" size=20 readonly></TD>
				<td class="blue">VPMN资费名称</TD>
				<TD><input class="InputGrey" name="s_offer_name" value="<%=s_offer_name%>" maxlength="25" size=20 readonly></TD>
			</TR>
			<TR >
				<td class="blue">应优惠分钟数</TD>
				<TD><input class="InputGrey" name="s_should_minutes" value="<%=s_should_minutes%>" maxlength="25" size=20 readonly></TD>
				<td class="blue">当前已优惠分钟数</TD>
				<TD><input class="InputGrey" name="s_fav_minutes" value="<%=s_fav_minutes%>" maxlength="25" size=20 readonly></TD>
				 
			</TR>
			<TR >
				<td class="blue">剩余分钟数</TD>
				<TD colspan=3><input class="InputGrey" name="s_left_minutes" value="<%=s_left_minutes%>" maxlength="25" size=20 readonly></TD>
			</TR>
			 
			<!--
 			<tr>
				<td class="blue" colspan=4>套餐内应优惠GPRS流量:<input class="InputGrey" value=" " maxlength="25" size=20 readonly>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 套餐内已优惠GPRS流量:<input class="InputGrey" value=" " maxlength="25" size=20 readonly> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;套餐外已使用GPRS流量:<input class="InputGrey" value=" " maxlength="25" size=30 readonly></TD>
		    	 		    	
			</tr>
			-->
		 
	   </table> 
	    
	  
	   
	   

        
	  <TABLE cellSpacing="0">
	    <TR> 
	      <TD id="footer"> 
	          <input type="button"  name="back"  class="b_foot" value="返回" onClick="location='i142_1.jsp?activePhone=<%=phoneNo%>'">
	          <input type="button"  name="back"  class="b_foot" value="关闭" onClick="removeCurrentTab()">
	      </TD>
	    </TR>
		 
	  </TABLE>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html>


