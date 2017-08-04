<%
   /*
   * 功能: 查询用户信息
　 * 版本: v1.0
　 * 日期: 2008年4月17日
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期 2009-05-12     修改人  libina     修改目的  增加积分明细查询的链接
   * 修改日期 2009-05-13     修改人  libina     修改目的  修改帐户余额处理方式
   * 修改日期 2009-05-13     修改人  libina     修改目的  将账单历史查询有1350改为1351
   * 修改日期 2009-06-04     修改人  libina     修改目的  屏蔽有安全隐患的信息
   * 修改日期 2009-06-06     修改人  libina     修改目的  优化页面
   * 修改日期 2009-06-24     修改人  libina     修改目的  修改账单历史查询的链接
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
     String workNo = (String)session.getAttribute("workNo");
		 String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
     
     String phone_no = (String)session.getAttribute("activePhone");
     if(phone_no==null||phone_no.equals("")){
       phone_no =request.getParameter("activePhone");
     }
     System.out.println("activePhone"+phone_no);
	String cust_name            = "";
	String id_name              = "";
	String id_iccid             = "";
	String contact_address      = "";
	String vphone_no            = "";
	String open_time            = "";
	String card_name            = "";
	String product_name         = "";
	String town_name            = "";
	String run_name             = "";
	String prepay_fee           = "0";
	String current_point        = "0";
	String vred_flag            = "";
	String vblack_flag          = "";
	String sm_name              = "";
	String grade_code	          = "";
	String region_code	        = "";
	String customer_credibility = "";
%>

<wtc:service name="sKFCustInfo_new" outnum="17" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result0" start="0" length="16" scope="end" />

<%
System.out.println("fcustMsg.jsp__retCode:"+retCode);
if("000000".equals(retCode)){
       if(result0.length>0){
			cust_name            = result0[0][0]==null?"":result0[0][0];
			id_name              = result0[0][1]==null?"":result0[0][1];
			id_iccid             = result0[0][2]==null?"":result0[0][2];
			contact_address      = result0[0][3]==null?"":result0[0][3];
			vphone_no            = result0[0][4]==null?"":result0[0][4];
			open_time            = result0[0][5]==null?"":result0[0][5];
			card_name            = result0[0][6]==null?"":result0[0][6];
			product_name         = result0[0][7]==null?"":result0[0][7];
			town_name            = result0[0][8]==null?"":result0[0][8];
			run_name             = result0[0][9]==null?"":result0[0][9];
			prepay_fee           = result0[0][10]==null?"0.0":result0[0][10];
			current_point        = result0[0][11]==null?"0":result0[0][11];
			vred_flag            = result0[0][12]==null?"":result0[0][12];
			vblack_flag          = result0[0][13]==null?"":result0[0][13];
			sm_name		           = result0[0][14]==null?"":result0[0][14];	
			customer_credibility = result0[0][15]==null?"":result0[0][15];	
      }   
} 
%>
<wtc:array id="result1" start="16" length="1" scope="end" />
<%
String kim_phone = new String();
  if(retCode.equals("000000")){
         if(result1.length>0){          
  	       	for(int i=0;i<result1.length;i++){
  	       	   if(result1[i][0]!=null){
  	       	    	kim_phone = kim_phone+result1[i][0]+"|";
  	       	   }else{
  	       	   		kim_phone="无";
  	       	   }
  	       	}	       	      
         }  
  }
%>
<link href="../../../nresources/default/css/portalet.css"rel="stylesheet"type="text/css">
<link href="../../../nresources/default/css/font_color.css"rel="stylesheet" type="text/css">	
<div id="blueBG">
 <div id="Info_table">
 	<table border="0" cellpadding="0" cellspacing="6" width="100%" class="ctl">
  	<tr>
  	    <th width="10%" nowrap >姓名：</th>
  	  	<td width="30%" nowrap><%=cust_name%></td>
  	  	<th width="10%" nowrap>服务号码：</th>
  	  	<td width="40%"  colspan="3"><%=vphone_no%></td>
  	  	<!--fSimDetailInfo.jsp-->
  	</tr>
  	<tr>
  	    <th nowrap >证件类型：</th>
  	  	<td nowrap><%=id_name%></td>
  	  	<th nowrap>入网时间：</th>
  	  	<td colspan="3" nowrap><%=open_time%></td>  	   	
  	</tr>
  	<tr>
  	    <th nowrap >证件号码：</th>
  	  	<td nowrap><%=id_iccid%></td>
  	  	<th nowrap>品牌：</th>
  	  	<td colspan="3" nowrap><%=null == sm_name?"" : sm_name.trim()%></td>	   	
  	</tr>
  	<tr><th nowrap >地址：</th>
  	  	<td nowrap><%=contact_address%></td>
  	  	<th nowrap>套餐：</th>
  	  	<td colspan="3" nowrap><%=product_name%></td>  	   	
  	</tr>
  	<tr>
  	  	<th nowrap>归属营业厅：</th>
  	  	<td nowrap><%="".equals(town_name)?"未知":town_name%></td>
  	   	<th nowrap>级别：</th>
  	  	<td colspan="3" nowrap><%=card_name%></td>
  	</tr>
  	<tr> 	  	  	     	  	
  	  	<th nowrap>帐户余额：</th>
  	  	<td >
  	  		<span class="green"><%=Double.parseDouble(prepay_fee)*-1%></span>&nbsp;&nbsp;&nbsp;<%if((Double.parseDouble(prepay_fee)*-1)<5) out.print("<img src='../../../nresources/default/images/shine.gif' ><span class='orange'>（提醒缴费）</span>");  %> 
				</td>
				<th nowrap>用户信誉度：</th>
  	  	<td colspan="3" title="<%=customer_credibility%>" nowrap><%=customer_credibility%></td>	
  	</tr>
  	<tr>
  	  	<th nowrap>状态：</th>
  	  	<td  nowrap><span class="green"><%=run_name%></span>&nbsp;&nbsp;&nbsp; <%if(!run_name.equals("正常")) out.print("<img src='../../../nresources/default/images/shine.gif'><span class='orange'>（提醒开通）</span>");  %></td>
  	   	<th nowrap>积分：</th>
  	  	<td colspan="3" nowrap><span class="green"><%=current_point%></span>
  	    <%if(Float.parseFloat(current_point)>300)out.print("<img src='../../../nresources/default/images/shine.gif' ><span class='orange'>（提醒消费）</span>"); %></td>
  	</tr>
  	<tr>
  	  	<th nowrap >黑名单：</th>
  	  	<td nowrap><%=vblack_flag%></td>
  	   	<th nowrap>红名单：</th>
  	  	<td colspan="3" nowrap><%=vred_flag%></td>
  	</tr>
  	<tr>
  	    <th nowrap>亲情号码：</th>
  	  	<td title="<%=kim_phone%>" nowrap>
  	  		<% 
  	  		// xingzhan 20090220 16:10 亲情号码改为弹出窗口模式
  	  				if(kim_phone==null||"".equals(kim_phone)){
  	  		%>
  	  		      无
  	  		<%						
  	  				}else{
  	  		%>
  	  		      <a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fOperKim_PhoneInfo.jsp?kim_phone=<%=kim_phone%>&vphone_no=<%=vphone_no%>');"><span class='orange'>[亲情号码]</span></a>
  	  		<%
  	  				}
  	  		%>
  	  	</td>
  	  	<th colspan="4"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fSimDetailInfo.jsp');"><span class='orange'>[SIM卡详情]</span></a></th>	   	
  	</tr>
  	<tr>
			  <th colspan="2"><a href=javascript:parent.parent.parent.L("2","1515","免费分钟数查询","MessageQuery/s1515/f1515_1.jsp","000")><span class='orange'>[免费分钟数查询]</span></a></th>
  	   	<th colspan="4"><a href=javascript:parent.parent.parent.L("2","1270","主资费变更","../../../page/ProductChange/f1270_login.jsp","000")  ><span class='orange'>[主资费变更]</span></a></th>
  	</tr>
  	<tr> 	  	
  	   	<th colspan="2"><a href=javascript:parent.parent.parent.L("2","1351","帐单历史查询","../npage/portal/kfuser/f1351_kf.jsp?phoneNo=<%=phone_no%>","000")  ><span class='orange'>[帐单历史查询]</span></a></th>
  	    <th colspan="4"><a href=javascript:parent.parent.parent.L("2","7135","新业务超市","../../../page/ProductChange/f7135_login.jsp","000")  ><span class='orange'>[新业务超市]</span></a></th>
  	</tr>
  	<tr>
  	    <th colspan="2"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fKFPointDetail.jsp');"><span class='orange'>[积分明细查询]</span></a></th>
  	  	<th colspan="4"><a href=javascript:parent.parent.parent.L("2","1213","综合变更","PersonChange/s1213/f1213.jsp","000")  ><span class='orange'>[综合变更]</span></a></th>
  	</tr>
	  <tr>
  	    <th colspan="2"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fPayHistoryInfo.jsp');"><span class='orange'>[缴费查询]</span></a></th>
  	    <th colspan="1"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fOperHistoryInfo.jsp');"><span class='orange'>[历史信息]</span></a></th>
  	    <th colspan="3"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fProductService.jsp');"><span class='orange'>[全部产品信息]</span></a></th>
  	</tr>
</table>
</div>
</div>
<script>
function showPageInfo(tagUrl)
{
	window.open(tagUrl,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
}
</script>