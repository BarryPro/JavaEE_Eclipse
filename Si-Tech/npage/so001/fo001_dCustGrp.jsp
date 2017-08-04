 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%request.setCharacterEncoding("GB2312");%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	String opCode = "5082";
	String opName = "集团信息查询";
	//输入参数 用户ID、手机号码、操作工号、操作员、角色、部门
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String phoneNo  = request.getParameter("phoneNo");

	String sql_str="select c.unit_id,c.unit_name,c.boss_vpmn_code,c.service_no,c.contact_phone,a.product_code,d.product_name "
	         +"from dGrpUsermsg a,dGrpUserMebMsg b,dGrpcustmsg c,sproductcode d "
	         +"where a.id_no = b.id_no and b.member_no = '"+phoneNo+"' and a.cust_id = c.cust_id and a.product_code = d.product_code ;";
	
	System.out.println(sql_str);
	
%>
    <wtc:service name="s5082EXC"  outnum="20" retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="5082" />
    	<wtc:param value="<%=workNo%>" />
    	<wtc:param value="3" />    	
    	<wtc:param value="<%=phoneNo%>" />     			
    	</wtc:service>
    <wtc:array id="result" scope="end"/>
<%	

 	if (result.length==0)
	{
%>
<script language="javascript">
	rdShowMessageDialog("没有找到任何数据");
	history.go(-1);
</script>
<%	}else{
	
%>

<HEAD><TITLE>用户归属集团信息</TITLE>
</HEAD>
<body>



<FORM method=post name="f1500_dCustInnet">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户归属集团信息</div>
</div>
            <TABLE cellSpacing="0" >
                <TR >
                  <TD class="blue">手机号码 <input class="InputGrey" value="<%=phoneNo%>" maxlength="25" size=25 readonly /></TD>
                  <TD></TD>
                  <TD></TD>
                </TR>                
             <TR bgcolor="EEEEEE" >
                  <TD class="blue">集团编号<input class="InputGrey" value="<%=result[0][0]%>" maxlength="25" size=25 readonly></TD>
                  <TD class="blue">集团名称<input class="InputGrey" value="<%=result[0][1]%>" maxlength="25" size=25 readonly></TD>
                  <TD class="blue">VPMN编号<input class="InputGrey" value="<%=result[0][2]%>" maxlength="25" size=25 readonly></TD>
                </TR>
                <TR>
                  <TD class="blue">客户经理<input class="InputGrey" value="<%=result[0][3]%>" maxlength="25" size=25 readonly></TD>
                  <TD>经理名称：<input class="button" value="<%=result[0][4]%>" maxlength="25" size=25 readonly></TD>
                  <TD colspan="3" class="blue">联系电话：<input class="InputGrey" value="<%=result[0][4]%>" maxlength="25" size=25 readonly ></TD>
                </TR>
            </table>
          </td>
        </tr>
      </table>
      <table cellSpacing="0">
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
      </table>

</FORM>


<%}%>
<%@ include file="/npage/include/footer.jsp" %>
</BODY>
</HTML>