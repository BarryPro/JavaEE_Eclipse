<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-24 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
  ArrayList arr = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfo = (String[][])arr.get(0);
  String[][] pass = (String[][])arr.get(4);
	String orgCode = baseInfo[0][16];
	String workno = baseInfo[0][2];
	String workname = baseInfo[0][3];
	String nopass = pass[0][0];
	String TPrintDate = request.getParameter("TPrintDate");
	String dateStr=TPrintDate;
	String yy=dateStr.substring(0,4);
	String mm=dateStr.substring(4,6);
	String dd=dateStr.substring(6,8);
	String busy_type=request.getParameter("busy_type");
	String yearMonth = request.getParameter("SBillDate");
	String beginCon = request.getParameter("TBeginContract");
	String endCon = request.getParameter("TEndContract");
	String beginBank = request.getParameter("bank1");
	String endBank = request.getParameter("bank2");
	String TNote = request.getParameter("TNote");
	String belongcode = request.getParameter("SDisCode");
	String TNote1 = workno + "," + nopass + "," + TNote;
  
 
	String[] inParas = new String[10];
    inParas[0] = yearMonth;
    inParas[1] = belongcode;
    inParas[2] = beginBank;
    inParas[3] = endBank;
    inParas[4] = beginCon;
    inParas[5] = endCon;
    inParas[6] = orgCode;
	  inParas[7] = workno;
    inParas[8] = nopass;
    inParas[9] = busy_type;
	%>
	<wtc:service name="se633Print"   retcode="retCode1" retmsg="retMsg1" outnum="21" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
		<wtc:param value="<%=inParas[9]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
	<%
    String[][] result = new String[][]{};
    result = sVerifyTypeArr;
	
	 
	
	String errorCode = "";
	ArrayList resultList = new ArrayList();
	resultList.add(result);
	System.out.println("====resultList====" + resultList.size());
	session.setAttribute("resultList1111",resultList);
	
	int resultSize = result.length;
    if (resultSize != 0) {
	    errorCode = result[0][0];
	}
	
		
	
%>

<HTML><HEAD><TITLE>黑龙江BOSS-托收单打印预览</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%if(resultSize == 0){%>
<script language="JavaScript"> 
	rdShowMessageDialog("预览失败，托收单数量为0！",0);
	window.history.go(-1);
</script>
<%}  else {%>

<%if(!errorCode.equals("000000")){%>
<script language="JavaScript">
	rdShowMessageDialog("预览失败，错误代码:<%=errorCode%>。",0);
	window.history.go(-1);
</script>
<%} else {%>

<script>
  
function doprint() {
   document.form.action="e633Cfm_print.jsp";
   form.submit();
}
</script>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif">
<FORM action="" method=post name=form>
<input type="hidden" name="SBillDate" value="<%=yearMonth%>">
<input type="hidden" name="TBeginContract" value="<%=beginCon%>">
<input type="hidden" name="TEndContract" value="<%=endCon%>">
<input type="hidden" name="bank1" value="<%=beginBank%>">
<input type="hidden" name="bank2" value="<%=endBank%>">
<input type="hidden" name="SDisCode" value="<%=belongcode%>">
<input type="hidden" name="TNote" value="<%=TNote%>">
<input type="hidden" name="TPrintDate" value="<%=TPrintDate%>">
<input type="text" name="busy_type" value="<%=busy_type%>">
  <table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td background="<%=request.getContextPath()%>/images/jl_background_1.gif"> 
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr> 
            <td align="right" width="45%"> 
              <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
            <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=workno%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workname%></td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr> 
            <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                  <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr> 
            <td align="right" width="73%"> 
              <table width="535" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                  <td valign="bottom" width="493"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>托收单打印预览</b></font></td>
                        <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="389" height="30"></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            <td width="27%"> 
              <table border="0" cellspacing="0" cellpadding="4" align="right">
                <tr> 
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr> 
            <td width="45%"> <br>
              <table width=100% height=25 border=0 align="center" cellspacing=2 cellpadding="4">
                <tbody> 
                <tr bgcolor="649ECC"> 
                  <td width="15%">托收单数量：<%=resultSize%></td>
                  <td width="33%"></td>
                  <td width="13%"></td>
                  <td width="39%">部门：<%=orgCode%></td>
                </tr>
                </tbody> 
              </table>
      <% 
      	for(int y=0;y<result.length;y++){ 
      		String date = result[y][5];
      %>
              <table width=100% height=20 border=0 align="center" cellspacing=2 bgcolor="#E8E8E8">
                <tr> 
                	<td> 
                    <div nowrap align="left"><%=workno%></div>
                  </td>
                  <td nowrap>
                    <div align="right">&nbsp;&nbsp;&nbsp;<%=date.substring(0,4)%>&nbsp;&nbsp;<%=date.substring(4,6)%>&nbsp;&nbsp;<%=date.substring(6,8)%></div>
                  </td>
                </tr>                
				<tr>                   
                  <td nowrap align="left"><%=result[y][2]%></td>
				 </tr>
                 <tr>
				  <td nowrap align="center"><%=result[y][18]%>&nbsp;&nbsp;&nbsp;(<%=result[y][19]%>)&nbsp;&nbsp;&nbsp;<%=result[y][20]%></td>
                 
                </tr>                
			 
				
                 <tr>
				  <td nowrap align="center">
					客户合同号:<%=result[y][3]%>&nbsp;&nbsp;&nbsp;手机号码：<%=result[y][4]%>
				  </td>
                 
                </tr> 

				<tr>                  
                
				  <td colspan="2"> 
                    <div align="center"> 大写金额：<%=result[y][17]%>&nbsp;&nbsp;小写金额：<%=result[y][6]%> </div>
                  </td>			  
                </tr>             
					<tr> 
				         <td width="13%" nowrap>
				           <div align="center">
									   <script language="javascript">
										//alert("test "+"<%=result[y][8].substring(0,1)%>");
									   </script>
									   <%
											if(result[y][7].substring(0,1)!="|" &&!((result[y][7].substring(0,1)).equals("|")) )
											{
												%><%=result[y][7]%><%
											}
									   %>   									 
									 <br>  <%
											if(result[y][8].substring(0,1)!="|" &&!((result[y][8].substring(0,1)).equals("|")) )
											{
												%><%=result[y][8]%><%
											}
									   %>
									 <br> <%
											if(result[y][9].substring(0,1)!="|" &&!((result[y][9].substring(0,1)).equals("|")) )
											{
												%><%=result[y][9]%><%
											}
									   %>
									 <br> <%
											if(result[y][10].substring(0,1)!="|" &&!((result[y][10].substring(0,1)).equals("|")) )
											{
												%><%=result[y][10]%><%
											}
									   %>
									 <br> <%
											if(result[y][11].substring(0,1)!="|" &&!((result[y][11].substring(0,1)).equals("|")) )
											{
												%><%=result[y][11]%><%
											}
									   %>	 
									 </div>
				          </td>
				          <td nowrap> 
				            <div align="center">										     
										         <%
											if(result[y][12].substring(0,1)!="|" &&!((result[y][12].substring(0,1)).equals("|")) )
											{
												%><%=result[y][8]%><%
											}
									   %>
										  <br>  <%
											if(result[y][13].substring(0,1)!="|" &&!((result[y][13].substring(0,1)).equals("|")) )
											{
												%><%=result[y][13]%><%
											}
									   %>
										  <br>   <%
											if(result[y][14].substring(0,1)!="|" &&!((result[y][14].substring(0,1)).equals("|")) )
											{
												%><%=result[y][14]%><%
											}
									   %>
										  <br>   <%
											if(result[y][15].substring(0,1)!="|" &&!((result[y][15].substring(0,1)).equals("|")) )
											{
												%><%=result[y][15]%><%
											}
									   %>
										  <br> <%
											if(result[y][16].substring(0,1)!="|" &&!((result[y][16].substring(0,1)).equals("|")) )
											{
												%><%=result[y][16]%><%
											}
									   %>
									  </div>
				          </td>
				          
				        </tr>			
								<tr> 
                  <td colspan="2"> 
                    <div align="center"></div>
                  </td>
                </tr>
              </table>
             <hr size="1">
<%}%>
              <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
                <tbody> 
                <tr bgcolor="#EEEEEE"> 
                  <td align=center bgcolor="F5F5F5" width="100%"> 
                    <input class="button" name=sure type="button" value=打印 onclick="doprint()">
                    &nbsp; 
                    <input class="button" name=reset type=button value=返回 onClick="window.history.go(-1)">
                  </td>
                </tr>
                </tbody> 
              </table>
              <p>&nbsp;</p>
            </td>
          </tr>
        </table>
        <br>
      </td>
    </tr>
  </table>
</FORM>
</BODY></HTML>

<%}}%>