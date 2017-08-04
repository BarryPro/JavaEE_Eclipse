<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 终止基本接入号
　 * 版本: v1.0
　 * 日期: 2009年03月04日
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%@ page import="java.text.*"%>
<%
	String opCode = "e539";	
	String opName = "终止基本接入号";	//header.jsp需要的参数   
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
		String loginNo=(String)session.getAttribute("workNo"); 
	String workName = (String)session.getAttribute("workName");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
		String workPwd = (String)session.getAttribute("password");
	String queryInfo = request.getParameter("ecsiid");
	String ecsiname = request.getParameter("ecsiname");
	String phone_no = request.getParameter("phone_no");
	String regionCode = orgCode.substring(0,2);
	
		 String[][] result = new String[][]{};
	String  currentYear= (String)session.getAttribute("currentYear");
	
%>
<head>
	<script language="JavaScript">
		function  queryMod(v_id)
	{		
		var alterCodeProp;	
			
		alterCodeProp=document.form1["operId" +v_id].value+"|";

		document.all.OprCode.value="e542";
		document.all.alterCode.value=document.getElementById("operId1"+v_id).value;
		var OprCode=document.all.OprCode.value;
		var alterCode=document.all.alterCode.value+"|";
		var packet = new AJAXPacket("fe539_modCfm1.jsp","请稍候......");
 		packet.data.add("OprCode",OprCode);
 		packet.data.add("queryName",document.all.queryName.value);
 		packet.data.add("queryValue",document.all.queryValue.value);
 		packet.data.add("phone_no",document.all.phone_no.value);
 		packet.data.add("alterCodeProp",alterCodeProp);
 		packet.data.add("alterCode",alterCode);
 		packet.data.add("v_id",v_id);
    core.ajax.sendPacket(packet);
		packet =null;	
	}
		function doProcess(myPacket)
	{
		var errCode    = myPacket.data.findValueByName("retCode");
		var retMessage = myPacket.data.findValueByName("retMsg");//声明返回的信息
		var retFlag    = myPacket.data.findValueByName("retFlag");
		var v_id    = myPacket.data.findValueByName("v_id");
		
		//alert (retFlag);
		//alert("description"+v_id);
		//alert($("#description1").val());
		
		if(retFlag=="1")
		{
			if(errCode.trim()=="000000")
			{
				rdShowMessageDialog("操作成功！");
				document.getElementById('description'+v_id.trim()).innerHTML="已终止";
				document.getElementById('operator'+v_id.trim()).disabled=true;
			}
			else
			{
				rdShowMessageDialog(retMessage);
			}
			
		}
		else
		{
			rdShowMessageDialog(retMessage);
			//window.location.replace("f3598_1.jsp");
		}
				
		
	}
</script>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>

<div id="productList" >
<div class="title"><div id="title_zi">基本接入号信息列表</div></div>
<table cellspacing="0" id="productTab" >
    <tr align="center">
        <th nowrap>基本接入号</th>
        <th nowrap>类型 </th>
        <th nowrap>状态</th>   
        <th nowrap>操作</th>   
        
    </tr>
 <wtc:service name="se539Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="e542"/>
              <wtc:param value="<%=loginNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=queryInfo%>"/>
              <wtc:param value="1"/>
              <wtc:param value=""/>
   </wtc:service>
   <wtc:array id="rows"  scope="end" />
	<%
  		    if (retCode.equals("000000")){
  		        result = rows;
  		    }else{
  		        %>
  		            <script type=text/javascript>
  		                rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
  		                window.close();
  		            </script>
  		        <%
  		    }
    System.out.println("rows="+result.length);
       for(int i=0;i<result.length;i++){

       System.out.println(result[i][0]);
       System.out.println(result[i][1]);
       System.out.println(result[i][2]);
       
    %>
    <tr align="center">

        <td nowrap class="blue" >
        	<input type="hidden" id="operId<%=i+1%>" value="<%=result[i][1].trim()%>"/>
			<input type="hidden" id="operId1<%=i+1%>" value="<%=result[i][0].trim()%>"/>			
				<a><%=result[i][0].trim()%></a></td>
        </td>
<%      if("01".equals(result[i][1].trim()))
        {
%>
        <td nowrap class="blue">短信</td>
<%      }
        else if("02".equals(result[i][1].trim()))
        {
%>
				<td nowrap class="blue">彩信</td>
<%      }
				else
        {
%>
		<td nowrap class="blue">WAPPush</td>
<%      }
%>
<%      
		String stopFlag="";  
		String resumeFlag="";
		if("1".equals(result[i][2].trim()))
        {
          resumeFlag="disabled";
%>
          <td nowrap class="blue" id="description<%=i+1 %>" value="2w">正常</td>   
<%      }
        else if("3".equals(rows[i][2].trim()))
        {
           stopFlag="disabled";
%>
        <td nowrap class="blue" id="description<%=i+1 %>">暂停</td> 
<%
        }
%>
        <td class="blue">
        <input name="operator<%=i+1%>"  style="cursor:hand" type="button" value="终止" class="b_text" onclick="queryMod(<%=i+1%>)">
		
	    </td>	
        	
        
    </tr>
    <%
       }
    %>
</table>
</div>

<table cellSpacing=0> 
  <tr>
    <td align="center" id="footer" colspan="4">
      <input class="b_foot" name=back onClick="window.location='fe539.jsp'" style="cursor:hand" type=button value=返回>
      <input class="b_foot" name=reset type=button value="关闭" onClick="parent.removeTab('<%=opCode%>')">
    </td>
  </tr>
</table>
   <input type="hidden" name="alterCodeProp" class="button" id="alterCodeProp" value="" size=7 >
   <input type="hidden" name="alterCode"  class="button" id="alterCode" value="" size=18 >
   <input type="hidden" name="OprCode" class="button" id="OprCode" value="" size=7 >
   <input type="hidden" name="queryValue" class="button" id="queryValue" value="<%=queryInfo%>" size=18 >
   <input type="hidden" name="queryName" type="text" class="button" id="queryName" value="<%=ecsiname%>" size=18 >
   <input type="hidden" name="phone_no" type="text" class="button" id="phone_no" value="<%=phone_no%>" size=18 >
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>