<%
/********************
 version v2.0
开发商: si-tech
*
*update:jiangjian@2011-11-07 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

    boolean flag1 = false;
    String operCode=request.getParameter("flag1");
	String offer_id = "";
	if(operCode==null)
	{
	  flag1 = false;
	}
	else
	{
	  flag1 = true;
	  offer_id=request.getParameter("offer_id");
	}
    String opCode = "g508";
	String opName = "选择入网小区权限配置";
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code1 = org_code.substring(0,2);		
	  
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

function goto()
{
  window.open(url);
}

function check()
{
   var offer_id = document.getElementById("offer_id").value;
   if(offer_id == "" || offer_id == null)
   {
      alert("请输入offer_id！");
      return false;
   }
	frm.action="g508_1.jsp";
	frm.submit();
}
function check1()
{
/*   var date = document.getElementById("offer_id").value;
   if(date == "" || date == null)
   {
      alert("请选择日期！");
      return false;
   }
 */
	frm.action="g508_2.jsp";
	frm.submit();
}
function sel1() {	 
	window.location.href='g508_1.jsp';
}
function sel2(){
	window.location.href='g508_3.jsp';
}
 
-->
	   
 </script> 
<title>黑龙江BOSS-普通缴费</title>
</head>
<body leftmargin="2" topmargin="2" marginwidth="0" marginheight="0" >
<form action="" method="post" name="frm"> 
	<input type=hidden name=flag1 value=1>
	<%@ include file="/npage/include/header.jsp" %>  
  
  <div class="title">
			<div id="title_zi">选择入网小区权限配置</div>
  </div>
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">配置方式</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1" checked>offer_id配置 
          <input name="busyType2" type="radio" onClick="sel2()" value="1">批量配置
      </td>
      
    </tr>
  </table>

    <table cellspacing="0">
      <tbody> 
     <tr> 
        <td class="blue" width="100%" align=center>资费id：

          <input type="text" id="offer_id" name="offer_id" value="<%=offer_id%>" onClick="fPopCalendar(date,date);return false" >

	       <input type="button" name="query" class="b_foot" onclick="check()" value="查询"  >  
        </td>
     </tr>
	   
    </tbody>
  </table>
  <div class="title">
			<div id="title_zi"></div>
		</div>
<%
if(flag1)
{  
  String sqlStr1 = "";

//  sqlStr1 = "SELECT a.OFFER_ID,a.PHONE_NO,a.STATIC_FEE,a.SHOULD_PAY,a.FAVOUR_FEE,b.FEE FROM DFEE_STATIS_HIS a,dbbillprg.sphonefee b where a.region_code=:region_code1 and a.phone_no=b.phone_no and a.select_flag=b.select_flag and a.select_flag=:flag1 and to_char(a.update_time,'YYYYMMDD')=to_char(b.indate,'YYYYMMDD') and to_char(a.update_time,'YYYYMMDD')=:date1";  
    
  sqlStr1 = "select trim(f.region_code) as region_code, trim(f.rate_code) as rate_code, trim(f.flag_code) as flag_code, trim(f.flag_code_name) as flag_code_name "
   +"from product_offer a, region  b, dchngroupinfo c, sregioncode d, pricing_combine e, srateflagcode f,product_offer_attr g "
   +"where a.offer_id = b.offer_id "
   +"and b.group_id = c.group_id "
   +"and c.parent_group_id = d.group_id "
   +"and a.pricing_plan_id = e.pricing_plan_id "
   +"and e.detail_code = f.rate_code "
   +"and d.region_code = f.region_code "
   +"and a.offer_id=g.offer_id "
   +"and g.offer_attr_seq='60001' "
   +"and a.offer_id =:offer_id "
   +"and b.group_id = (SELECT group_id FROM dloginmsg WHERE login_no =:login_no)";
  
  String[] inParas1 = new String[2];
  inParas1[0]=sqlStr1;
  inParas1[1]="offer_id="+offer_id+",login_no="+workno;		

%>
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=region_code1%>"  retcode="return_code" retmsg="return_msg" outnum="6">
<wtc:param value="<%=inParas1[0]%>"/>
<wtc:param value="<%=inParas1[1]%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

	
<%
    
if(result.length == 0)
{
   out.println("没有数据");
}
else{
%>
<input type=hidden name="sum" value=<%=result.length%> />
<table cellspacing="0" id="print1">
      <tbody> 
       <tr> 
        <td class="blue" align=center >地市代码</td>
        <td class="blue" align=center >小区总代码</td>
        <td class="blue" align=center >小区代码</td>
        <td class="blue" align=center >小区名称</td>
        <td class="blue" align=center >区县代码</td>
      </tr>	
      <tr>    
<%
       for(int i=0 ;i<result.length ;i++)
       {
       	  out.println("<tr>");
          out.println("<td class=blue align=center > <input type=text align=center readonly name=attr0"+i+" value="+result[i][0]+"></td>");    
          out.println("<td class=blue align=center > <input type=text align=center readonly name=attr1"+i+" value="+result[i][1]+"></td>");    
          out.println("<td class=blue align=center > <input type=text align=center readonly name=attr2"+i+" value="+result[i][2]+"></td>");    
          out.println("<td class=blue align=center name=attr3"+i+">"+result[i][3]+"</td>");
          out.println("<td class=blue align=center ><input type=text maxlength=10 name=attr4"+i+" value=></td>");
          out.println("</tr>");
       }
%>    
  </tbody>
</table> 
<%}}%>
<table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" onclick="check1()" value="更新"  >
          &nbsp;

       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>


</body>
</HTML>