<%
/********************
version v2.0
开发商: si-tech
liyan 20080721 应收资金管理系统@营业员上交款查询
展示界面 op_code=4928
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>营业员上交款查询</title>
<%
    String workNoFromSession=(String)session.getAttribute("workNo");
//	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	     workNoFlag=true;

    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");	
    String org_code =  (String)session.getAttribute("orgCode");
	  String region_codeT = (String)session.getAttribute("regCode");
    String i_begin_time = request.getParameter("begin_time");
	String i_end_time = request.getParameter("end_time");

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");

	String[] inParas = new String[4];
    inParas[0] = i_begin_time;
	  inParas[1] = i_end_time;
    inParas[2] = work_no;
    inParas[3] = opCode;


	%>
	    <wtc:service name="s4928Init" routerKey="region" routerValue="<%=region_codeT%>" retcode="s1223CfmCode" retmsg="s1223CfmMsg" outnum="20" >
        <wtc:param value="<%=inParas[0]%>"/>
        <wtc:param value="<%=inParas[1]%>"/>
        <wtc:param value="<%=inParas[2]%>"/>
        <wtc:param value="<%=inParas[3]%>"/>
	  	</wtc:service>	
<%
  if("000000".equals(s1223CfmCode)){
%>
		<wtc:array id="result0Temp" start="0" length="1" scope="end"/>
		<wtc:array id="result1Temp" start="1" length="1" scope="end"/>
		<wtc:array id="result2Temp" start="2" length="1" scope="end"/>
		<wtc:array id="result3Temp" start="3" length="1" scope="end"/>
		<wtc:array id="result4Temp" start="4" length="1" scope="end"/>
		<wtc:array id="result5Temp" start="5" length="1" scope="end"/>
		<wtc:array id="result6Temp" start="6" length="1" scope="end"/>
		<wtc:array id="result7Temp" start="7" length="1" scope="end"/>
		<wtc:array id="result8Temp" start="8" length="1" scope="end"/>
		<wtc:array id="result9Temp" start="9" length="1" scope="end"/>
		<wtc:array id="result10Temp" start="10" length="1" scope="end"/>
		<wtc:array id="result11Temp" start="11" length="1" scope="end"/>
		<wtc:array id="result12Temp" start="12" length="1" scope="end"/>
		<wtc:array id="result13Temp" start="13" length="1" scope="end"/>
		<wtc:array id="result14Temp" start="14" length="1" scope="end"/>
		<wtc:array id="result15Temp" start="15" length="1" scope="end"/>
		<wtc:array id="result16Temp" start="16" length="1" scope="end"/>
		<wtc:array id="result17Temp" start="17" length="1" scope="end"/>
		<wtc:array id="result18Temp" start="18" length="1" scope="end"/>
		<wtc:array id="result19Temp" start="19" length="1" scope="end"/>
<%

	String[][] result0 = new String[][]{};
	String[][] result1 = new String[][]{};
    String[][] result2 = new String[][]{};
	String[][] result3 = new String[][]{};
	String[][] result4 = new String[][]{};
	String[][] result5 = new String[][]{};
	String[][] result6 = new String[][]{};
	String[][] result7 = new String[][]{};
	String[][] result8 = new String[][]{};
	String[][] result9 = new String[][]{};
	String[][] result10 = new String[][]{};
	String[][] result11 = new String[][]{};
	String[][] result12 = new String[][]{};
	String[][] result13 = new String[][]{};
	String[][] result14 = new String[][]{};
	String[][] result15 = new String[][]{};
	String[][] result16 = new String[][]{};
	String[][] result17 = new String[][]{};
	String[][] result18 = new String[][]{};
	String[][] result19 = new String[][]{};
	

	String return_code = "0";
	String return_msg = "";
	if (result0Temp!=null) {
	    result0 = result0Temp;
	    result1 = result1Temp;
	    return_code = result0[0][0];
	    System.out.println("return_code="+return_code);
	    return_msg = result1[0][0];
	    System.out.println("return_msg="+return_msg);
	    result16 = result16Temp;
	    System.out.println("result16[0][0]="+result16[0][0]);
	}

	if (return_code.equals("000000")) {

	   if ( Integer.parseInt(result16[0][0])>0)
	   {
	  
		   result2 = result2Temp;
		   result3 = result3Temp;
		   result4 = result4Temp;
		   result5 = result5Temp;
		   result6 = result6Temp;
		   result7 = result7Temp;
		   result8 = result8Temp;
		   result9 = result9Temp;
		   result10 = result10Temp;
		   result11 = result11Temp;
		   result12 = result12Temp;
		   result13 = result13Temp;
		   result14 = result14Temp;
		   result15 = result15Temp;
	       result17 = result17Temp;
		   result18 = result18Temp;
		   result19 = result19Temp;
	   }
	}
	else
	{

		out.println("失败return_code="+return_code);
	}
   %>



<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>
<body >
<form name="frm" method="POST"   action="f4928Cfm.jsp" >
	<%@ include file="/npage/include/header.jsp" %>
<input type=hidden name=opCode value="<%=opCode%>">
<input type=hidden name=opName value="<%=opName%>">
         <table>


          <tr >
	           <td class="blue" nowrap > 营业款归属日期</td>
	           <td class="blue" nowrap > 交款工号</td>
	           <td class="blue" nowrap >交款类型</td>
	           <td class="blue" nowrap > 支票号</td>
	           <td class="blue" nowrap >支票单位</td>
	           <td class="blue" nowrap >帐号</b</td>
	           <td class="blue" nowrap >开户银行代码</td>


 			   <td class="blue" nowrap >上交金额</b></td>
	           <td class="blue" nowrap >操作时间</td>
          	   <td class="blue" nowrap >收款员</td>
	           <td class="blue" nowrap >确认标志</td>
			   <td class="blue" nowrap > 确认时间</td>
	           <td nowrap class="blue">退回标志</td>
          	   <td  nowrap class="blue">退回时间</td>
          	   <td  colspan="2" nowrap class="blue">操作</td>
          </tr>
          <% for (int i = 0;i < result2.length; i++) {  %>
          <tr >
          	   <td  nowrap ><%=result3[i][0]%><%=result7[i][0]%></td>
      		   <td  nowrap ><%=result4[i][0]%></td>
      		   <td nowrap ><%=result5[i][0]%></td>
      		   <td nowrap><%=result6[i][0]%></td>

      		   <td  nowrap><%=result17[i][0]%></td>
      		   <td  nowrap><%=result18[i][0]%></td>
      		   <td nowrap><%=result19[i][0]%></td>

			   <td nowrap ><%=result8[i][0]%></td>
      		   <td  nowrap><%=result9[i][0]%></td>
      		   <td nowrap><%=result15[i][0]%></td>
      		   <td  nowrap ><%=result10[i][0]%></td>
      		   <td nowrap><%=result11[i][0]%></td>
      		   <td  nowrap ><%=result12[i][0]%></td>
      		   <td  nowrap><%=result13[i][0]%> </td>
               <% if (result14[i][0].equals("1 ")){%>
      		   <td class="blue" nowrap><a name="aconfim" href="#" onclick="doConfim('<%=result2[i][0]%>')">清空</a></td>
			   <%}%>
      	 </tr>
      	 <%}%>
        <tr id="footer">
            <td colspan="20" >
                 <input class="b_foot" type=button name=qryP value="返回"  onClick="window.location.href='f4928.jsp?opCode=<%=opCode%>&opName=<%=opName%>'">
            
            	 <input type="hidden" name="login_accept">
            	 <input type="hidden" name="flag">
            	 <input type="hidden" name="begin_time" value=<%=i_begin_time%>>
            	 <input type="hidden" name="end_time" value=<%=i_end_time%>>
            	 </td>
        </tr>
      </table>
       <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>
<script language="JavaScript">
function doConfim(login_accept)
{
    document.frm.login_accept.value = login_accept;
    document.frm.flag.value = 3;  //确认
    document.frm.submit();
	return true;
}
</script>
<%
  }else{
%>
    <script language="JavaScript">
      rdShowMessageDialog("错误代码：<%=s1223CfmCode%><br>错误信息：<%=s1223CfmMsg%>",0);
      window.location.href="f4928.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </script>
<%
  }
%>