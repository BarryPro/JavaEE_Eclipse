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
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = "1500";
  String opName = "综合信息查询之客户经理信息";
  
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String idNo     = request.getParameter("idNo");
	String work_no  = request.getParameter("workNo");
	String work_name= request.getParameter("workName");
	String phoneNo  = request.getParameter("phoneNo");
	String cust_name  = request.getParameter("custName");
	String recodeIDd=request.getParameter("recodeIDd");
	String	sql_str = "select (a.service_no||'-->'||a.name) as sn,a.phone_no "
		+" from dbvipadm.dGrpManagermsg a,dbvipadm.dGrpBigUserMsg b " 
		+" where a.service_no=b.service_no and b.id_no =" + idNo;
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=sql_str%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%	
	String bigCustAdmName = "未知";
	String bigCustAdmPhone = "未知";
	
	if(result!=null&&result.length>0){
		bigCustAdmName = result[0][0];
		bigCustAdmPhone = result[0][1];
	}

	sql_str="select a.name,a.phone_no , b.unit_name, c.unit_id " +
				" from dbvipadm.dGrpManagermsg a ,dbvipadm.dGrpCustMsg b ,dbvipadm.dGrpMemberMsg c " +
				" where a.service_no=b.service_no " +
				" and b.unit_id=c.unit_id  and c.id_no = " + idNo;
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=sql_str%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
<%
	String groupCustAdmName = "未知";
	String groupCustAdmPhone = "未知";
	String groupId = "未知";
	String groupName = "未知";
	
	if(result1!=null&&result1.length>0){
		groupCustAdmName = result1[0][0];
		groupCustAdmPhone = result1[0][1];
		groupId = result1[0][2];
		groupName = result1[0][3];
	}
	
	if (result.length==0 && result1.length==0)
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("没有符合条件的客户经理信息！");
			history.go(-1);
		</script>
<%	
	return;
	}
%>

<%
	String sqlmygp = "select distinct c.unit_id, c.unit_name from dbesopadm.ep_vip_custmsg_orgtree b, dbvipadm.dGrpCustMsg  c where c.unit_id = b.funit_id and b.sunit_id =  '"+groupName+"'";
	System.out.println("gaopengSeeLog1500a====="+sqlmygp);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodegp" retmsg="retMsggp" outnum="2">
		<wtc:sql><%=sqlmygp%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultgp" scope="end" />
<%
	String pUnitId = "";
	String pUnitName = "";
	
	if(resultgp!=null&&resultgp.length>0){
		pUnitId = resultgp[0][0];
		pUnitName = resultgp[0][1];
	}
%>

<HTML><HEAD><TITLE>客户经理信息</TITLE>
<script language="javascript">
	$(document).ready(function(){
		try{
			parent.parent.oprInfoRecode('','','','',"<%=recodeIDd%>");
		}catch(e){
		}
	});
</script>			
</HEAD>
<body>

<FORM method=post name="f1500_dCustDocInAdd">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">客户经理信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户名称:<%=cust_name%></div>
		</div>
	    <TABLE cellSpacing="0">
	      <TBODY>
	        <TR>
	          <TD class="blue">服务号码</TD>
	          <td colspan="3">
	          	<input class="InputGrey" value="<%=phoneNo%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>                
	        <TR>
	          <TD class="blue">大客户经理</TD>
	          <TD>
	          	<input class="InputGrey" value="<%=bigCustAdmName%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">联系电话</TD>
	          <td>
	          	<input class="InputGrey" value="<%=bigCustAdmPhone%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
	        
	        <!--luxc20070320 add -->
	        <TR>
	          <TD class="blue">集团客户经理</td>
	          <td>
	          	<input class="InputGrey" value="<%=groupCustAdmName%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">联系电话</td>
	          <td>
	          	<input class="InputGrey" value="<%=groupCustAdmPhone%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
	        <!--luxc20070320 end -->
	        
	        <TR>
	          <TD class="blue">集团编码</td>
	          <td>
	          	<input class="InputGrey" value="<%=groupName%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">集团名称</td>
	          <td>
	          	<input class="InputGrey" value="<%=groupId%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
	        <%
	        	if (resultgp.length>0)
					{
	        %>
	        <TR>
	          <TD class="blue">父集团编码</td>
	          <td>
	          	<input class="InputGrey" value="<%=pUnitId%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">父集团名称</td>
	          <td>
	          	<input class="InputGrey" value="<%=pUnitName%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
	        <%
	        	}
	        %>
	        
	      </TBODY>
	    </TABLE>
      
      <table cellspacing=0>
          <tr> 
      	    <td id="footer">
	    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
	    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
	    	      &nbsp; 
	    	    </td>
          </tr>
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
