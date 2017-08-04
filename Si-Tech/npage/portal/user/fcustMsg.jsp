<%
   /*
   * 功能: 查询用户信息
　 * 版本: v1.0
　 * 日期: 2008年4月17日
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/common/portalInclude.jsp" %>

<%!
boolean havingPriv(HttpSession session,String opcode)
{
	java.util.ArrayList list = (java.util.ArrayList)session.getAttribute("allArr");
	String[][] func = (String[][])list.get(1);
	for(int i=0;i<func.length;i++)
	{
		if(func[i][1]!=null&&func[i][1].equals(opcode))
		{
			return true;
		}
	}
	return false;
}
%>

<%
     String workNo = (String)session.getAttribute("workNo");
		 String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);

     //String phone_no = (String)session.getAttribute("activePhone");
     String phone_no = (String)request.getParameter("activePhone");
     
     String product_name  ="";                //套餐    
     String group_name    ="";               //渠道    
     String current_point ="";                //积分    
     String sm_name       ="";                //品牌   
     /* 20090403 zhangshuai begin */
     String attr_code     ="";                //客户属性
     /* 20090403 zhangshuai end */
     String open_time     ="";               //入网时间
     String run_name      ="";                //状态    
     String cust_id       ="";                //用户号  
     String grade         ="";               //级别    
     String pre_fee       ="";                //帐号余额
  
%>

<wtc:service name="sIndexCustMsg" outnum="10" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
       if(result.length>0){
              product_name  =result[0][0];
              group_name    =result[0][1];
              current_point =result[0][2];
              sm_name       =result[0][3];
              open_time     =result[0][4];
              run_name      =result[0][5];
              cust_id       =result[0][6];         
              grade         =result[0][7];
              pre_fee       =result[0][8];  
              /* 20090403 zhangshuai begin */
              attr_code     =result[0][9];
              /* 20090403 zhangshuai begin */
                       
           }
     }
%>	
<%
    
     String cust_name="";    // 客户姓名        
     String id_type="";      // 客户证件类型名称
     String id_iccid="";     // 客户证件号      
     String birthday="";     // 客户出生日期    
     String sex="";          // 客户性别        
     String age="";          // 客户年龄        
     
%>

<wtc:service name="sIndexCustDoc" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=cust_id%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
       if(result.length>0){
              cust_name=result[0][0];
              id_type=result[0][1];
              id_iccid=result[0][2];
              birthday=result[0][3];
              sex=result[0][4];
              age=result[0][5];
           }
     }
     
 System.out.println( id_type);
 System.out.println("*******************************************************");

%>
<div id="blueBG">
 <div id="Info_table">
 	<table border="0" cellpadding="0" cellspacing="0" width="100%">
  	<tr>
  	    <th width=80 nowrap >手机号码:</th>
  	  	<td><%=phone_no.trim()%></td>
  	  	<th  nowrap >VIP客户属性：</th>
  	  	<td><%=grade.trim()%></td>
  	   	<td rowspan="14" width="300px" >         	
  	    </td>
  	</tr>
  	<tr>
  			<th>姓名：</th>
  	    <td><%=cust_name.trim()%></td>
  			<th>品牌：</th>
  	    <td><%=sm_name.trim()%></td>
  	</tr>
  	<tr>
	  		<th nowrap>入网时间：</th>
	  	  <td nowrap ><%=open_time.trim()%></td>
	  	  <!--20090403 zhangshuai begin -->
	  	  <th nowrap>用户属性：</th>
	  	  <td nowrap ><%=attr_code.trim()%></td>
	  	  <!--20090403 zhangshuai end -->
  	</tr>
  	<tr>
	  		<th>套餐：</th>
	  	  <td nowrap >
	  	  	<%=product_name.trim()%>&nbsp;
 	  		  	  	<%if(havingPriv(session,"1270")){%>
	  	  				<a href=javascript:parent.parent.openPage("2","1270","主资费变更","bill/f1270_1.jsp","001")  ><span class='orange'>主资费变更</span></a>
					<%}%>
	  	  </td>
  	</tr>
  	<tr>
	  		<th>渠道：</th>
	  	  <td colspan=3><%=group_name.trim()%></td>
  	</tr>
  	<tr>
	  		<th>状态：</th>
	  	  <td colspan=3  >
	  	  	<span class="green"><%=run_name.trim()%></span>
	  	    <%if(!run_name.trim().equals("正常")) out.print("<img src='../../../nresources/default/images/shine.gif'><span class='orange'>（提醒开通）</span>");  %>
			  </td>
		</tr>
  	<tr>
  		<th nowrap>相关功能：</th>
  	  <td colspan=3  >
        <%if(havingPriv(session,"1302")){%>
				<a href=javascript:parent.parent.openPage("1","1302","缴费(号码)","s1300/s1300.jsp?opCode=1302&opName=号码缴费","000")  ><span class='orange'>号码缴费</span></a>&nbsp;&nbsp;
				<%}%>
				<%if(havingPriv(session,"1300")){%>
					<a href=javascript:parent.parent.openPage("1","1300","缴费(账号)","s1300/s1300_2.jsp?busy_type=2&opCode=1300&opName=帐号缴费","000")  ><span class='orange'>账号缴费</span></a>
				<%}%>
				<%if(havingPriv(session,"1500")){%>
				<a href=javascript:parent.parent.openPage("1","1500","综合信息查询","query/f1500_1.jsp?opCode=1500&opName=综合信息查询","000")  ><span class='orange'>综合信息查询</span></a>
				<!--a href="#" onclick="javascript:window.open('../../../page/query/f1500_1.jsp');"><span class='orange'>综合信息查询</span></a-->
		        <%}%>
		  </td>
		</tr>
  	<tr>
</table>
</div>
</div>
<script>
 $("#wait1").hide();		   
</script>