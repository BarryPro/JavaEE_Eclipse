<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.GregorianCalendar"%>
<%
	//SPubCallSvrImpl callView=new SPubCallSvrImpl();
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String phoneNo=request.getParameter("phoneNo");
    String rowNum = "16";
    String getAcceptFlag = "";
	String temp[][]=null;
	String temp2[][]=null;
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	//out.println(dateStr);
	
	String opCode = "3608";
    String opName = "BOSS侧VPMN操作查询";
    
	String[] strDate = new String[6];
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	GregorianCalendar cal = new GregorianCalendar();
	cal.setTime(new Date());
	
	strDate[0] = sdf.format(cal.getTime());
	
	for (int i=1; i< 3; i++)  {
		cal.add(GregorianCalendar.MONTH, -1);
		strDate[i] = sdf.format(cal.getTime());
	}
	
	/*for (int i=0; i<6; i++) {
		out.println(strDate[i]);
	}*/
	StringBuffer phone = new StringBuffer(phoneNo);
	
	StringBuffer sb = new StringBuffer();
	/*for (int i=0; i<3; i++) {
		sb.append("select  a.PHONE_NO, a.LOGIN_NO, to_char(a.OP_TIME, 'yyyy-mm-dd hh24:mi:ss'), c.USER_NAME, a.OP_NOTE ");
		sb.append("from dGrpUserMebMsgHis b, dGrpUserMsg c, wLoginOpr").append(strDate[i]).append(" a ");
		sb.append("where a.ID_NO = b.MEMBER_ID and b.ID_NO = c.ID_NO and a.SM_CODE = 'va' and a.LOGIN_ACCEPT = b.UPDATE_ACCEPT and a.phone_no='").append(phone.toString()).append("' ");
		sb.append("union ");
	}

	sb.setLength(sb.length() - 6);
    System.out.println("### sql = "+sb.toString());*/
	String error_code="";
	String error_msg="";
	ArrayList  inputParam = new ArrayList();
	ArrayList retArray = new ArrayList();
%>
	<wtc:service name="s3608EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="18">			
	<wtc:param value="<%=opCode%>"/>	
	<wtc:param value="<%=workNo%>"/>	
	<wtc:param value="<%=phoneNo%>"/>	
	</wtc:service>	
	<wtc:array id="retArr1" start="0" length="5" scope="end" />    	
	<wtc:array id="retArr2" start="5" length="13" scope="end" />
<%
    error_code = retCode1;
    error_msg = retMsg1;
    System.out.println("## retCode = "+error_code);
    System.out.println("## retMsg  = "+error_msg);
    if("000000".equals(error_code)){
        temp = retArr1;
        temp2 = retArr2;
        System.out.println("--------------s3608---------temp.length="+temp.length);
        System.out.println("--------------s3608---------temp2.length="+temp2.length);
        if(retArr1.length>0 && retArr1[0][0].trim() != ""){
            System.out.println("# retArr1.length = "+retArr1.length);
        }else{
            System.out.println("# return from s3608_2.jsp by s3608EXC -> 没有3个月内的变更历史记录！");
            %>
        		<SCRIPT language="JavaScript">
        			rdShowMessageDialog("没有3个月内的变更历史记录！");
        			//history.go(-1);
        		</SCRIPT>
        	<%
        }
        
        if(retArr2.length>0){
            System.out.println("# retArr2.length = "+retArr2.length);
        }else{
            System.out.println("# return from s3608_2.jsp by s3608EXC -> 查询BOSS侧VPMN信息失败！[retArr2.length=0]");
            %>
        		<SCRIPT language="JavaScript">
        			rdShowMessageDialog("查询BOSS侧VPMN信息失败！",0);
        			history.go(-1);
        		</SCRIPT>
        	<%
        }
    }else{
        System.out.println("# return from s3608_2.jsp by s3608EXC -> retCode="+error_code+",retMsg="+error_msg);
        %>
    		<SCRIPT language="JavaScript">
    			rdShowMessageDialog("错误代码：<%=error_code%>，错误信息：<%=error_msg%>",0);
    			history.go(-1);
    		</SCRIPT>
    	<%
    }
if("000000".equals(error_code) && retArr2.length>0){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>BOSS侧VPMN操作查询</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_custuser">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户基本信息</div>
</div>
<table cellspacing=0>
    <tr>
        <td colspan='6'><font color='red'>提示：如果无BOSS侧V网相关信息，则当前不是V网成员。</font></td>
    </tr>
    <tr>
        <td class='blue' nowrap>机主姓名</td>
        <td><%=temp2[0][0]%></td>
        <td class='blue' nowrap>联系方式</td>
        <td><%=temp2[0][1]%></td>
        <td class='blue' nowrap>开户时间</td>
        <td><%=temp2[0][2]%></td>
    </tr>
    <tr>
        <td class='blue' nowrap>集团代码</td>
        <td><%=temp2[0][3]%></td>
        <td class='blue' nowrap>集团名称</td>
        <td><%=temp2[0][4]%></td>
        <td class='blue' nowrap>加入BOSS侧V网时间</td>
        <td><%=temp2[0][5]%></td>
    </tr>
    <tr>
        <td class='blue' nowrap>BOSS侧VPMN资费代码</td>
        <td><%=temp2[0][6]%></td>
        <td class='blue' nowrap>资费名称</td>
        <td><%=temp2[0][7]%></td>
        <td class='blue' nowrap>资费生效时间</td>
        <td><%=temp2[0][8]%></td>
    </tr>
    <tr>
        <td class='blue' nowrap>集团类别</td>
        <td><%=temp2[0][9]%></td>
        <td class='blue' nowrap>客户经理姓名</td>
        <td><%=temp2[0][10]%></td>
        <td class='blue' nowrap>客户经理工号</td>
        <td><%=temp2[0][11]%></td>
    </tr>
</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">BOSS侧VPMN近三个月操作记录</div>
</div>
            <TABLE cellSpacing="0">
                <TR> 			
                  <Th>操作号码</Th>
                  <Th>操作工号</Th>
                  <Th>操作日期</Th>
                  <Th>集团名称</Th>
                  <Th>操作记录</Th>
                </TR>
			<%
			for(int i=0;i<temp.length;i++){
				out.println("<TR>");
				out.println("<TD>"+temp[i][0]+"</TD>");
				out.println("<TD>"+temp[i][1]+"</TD>");
				out.println("<TD>"+temp[i][2]+"</TD>");
				out.println("<TD>"+temp[i][3]+"</TD>");
				out.println("<TD>"+temp[i][4]+"</TD>");
				out.println("<TR>");
				}
			%>
            </TABLE>

      <table cellspacing=0>
          <tr id="footer"> 
      	    <td>
            	<!--<input name="goBack" class="b_foot" type="button" id="goBack"   onClick="javascript:window.close()" value="返回">-->
            	<input name="goBack" class="b_foot" type="button" id="goBack"   onClick="window.location='s3608_1.jsp?activePhone=<%=phoneNo%>'" value="返回">
                <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
                
    	    </td>
          </tr>
      </table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<% } %>