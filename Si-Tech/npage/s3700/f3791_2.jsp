<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-------------------------------------------->
<!---日期   2003-10-24                    ---->
<!---作者   HYZ                           ---->
<!---代码   f1500_Main                    ---->
<!---功能   综合信息查询                  ---->
<!---修改   dengyuan @2008-05-19          ---->
<!-------------------------------------------->
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="java.io.*" %>

<% 	
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String powerName = (String)session.getAttribute("powerCode");
	String orgCode = (String)session.getAttribute("orgCode");
	
	String regionCode = orgCode.substring(0,2);
  //输入参数 查询类型，查询条件，机构代码，工号，权限代码。 
	String inStr  = request.getParameter("condText")==null?"":request.getParameter("condText");//得到传入参数

	String opCode = "3791";
	String opName="接触轨迹查询";
	
		String result0= "";
		String result1= "";
		String result2= "";
		String result3= "";
		String result4= "";
		String result5= "";
		String result6= "";
		String result7= "";
		String result8= "";
		String result9= "";
		
 %>                    
	<wtc:service name="sQryCnttTrack" outnum="11">
		<wtc:param value="<%=inStr%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%    
System.out.println("_________________________________________________________________________");
	    for(int i=0;i<result.length;i++){
	      for(int j=0;j<result[i].length;j++){
	      System.out.println("############################result["+i+"]["+j+"]"+"   "+result[i][j]);
	      
	      }
	    
	    
	    }
System.out.println("_________________________________________________________________________");
	if (!retCode.equals("000000")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=retMsg%><br>错误代码 '<%=retCode%>'。");
	history.go(-1);
</script>
<%
	}
		if (result.length==0){
%>
<script language="JavaScript">
	rdShowMessageDialog("无此记录！");
	history.go(-1);
</script>
<%
}else{
		result0=result[0][0];
		result1=result[0][1];
		result2=result[0][2];
		result3=result[0][3];
		result4=result[0][4];
		result5=result[0][5];
		result6=result[0][6];
		result7=result[0][7];
		result8=result[0][8];
		result9=result[0][9];
	}
	  
	
	%>


<HTML>
<HEAD>
<TITLE><%=opName%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp"%>
<!-- 客户信息表单 Start -->
<DIV class="title">	
  <div id="title_zi">接触轨迹信息</div>	  
	  <div id="FormSub">
     </div>  
</DIV>
  <table align="center" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td class="Blue">接触ID</td>
      <td> 
        <%=result0%>
        </td>
      <td class="Blue">轨迹标识</td>
      <td> 
       <b>         <%=result1%></b>
        </td>
         </tr>
    <tr > 
      <td class="Blue">接触轨迹类型</td>
      <td> 
           <%=result2%>
        </td>
   
      <td class="Blue">接触流水号</td>
      <td> 
          <%=result3%>
        </td>
         </tr>
    <tr > 
      <td class="Blue">接触轨迹内容</td>
      <td> 
         <%=result4%>
      </td>
      <td class="Blue">IVR节点编号</td>
      <td> 
          <%=result5%>&nbsp;
	    </td>
	    </TR>
	    <TR >    
      <td class="Blue">用户按键时间</td>
      <td> 
       <b>       <%=result6%></b>
       </td>
      <td class="Blue">用户操作轨迹简要</td>
      <td >
	       <%=result7%>
	    </td>
	     </tr>
    <tr > 
      <td class="Blue">备注</td>
      <td> 
          <%=result8%>
       </td>
      <td class="Blue">轨迹名称</td>
        <td> 
         <%=result9%>&nbsp;
       </td>
    </TR>
  </table>
	<!-- 表单内容 End -->
<!-- 客户信息表单 End -->



<table  border=0  cellpadding=0 cellspacing=0>
  <tr > 
    <td id="footer">
      &nbsp; <input   class="b_foot" name=back onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value="关闭">
      &nbsp; 
    </td>
  </tr>
</table>
	<%@ include file="/npage/include/footer.jsp"%>
</BODY></HTML>
<!--***********************************************************************-->
