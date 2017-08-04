<%
/********************
version v1.0
开发商: si-tech
add by zhangleij
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%
			//分页参数设置
		  int rowCount = 0;
			int pageSize = 15; // Rows each page
			int pageCount = 0; // Number of all pages
			int curPage = 0; // Current page
			String strPage; // Transfered pages
			int curData = 0;// 循环中首条数据
			int lastData = 0; // 循环中的最后一条数据
			
			String return_code = "";
    	String return_num = "";
    	List list2 = new ArrayList();
    	List list3 = new ArrayList();
			
    	String opCode = "zgb1";
			String opName = "安保部详单查询记录查询";
			response.setHeader("Pragma", "No-Cache");
			response.setHeader("Cache-Control", "No-Cache");
			response.setDateHeader("Expires", 0);

			String in_login_no = request.getParameter("login_no");
			String in_begin_ymd = request.getParameter("begin_ymd");
			String in_end_ymd = request.getParameter("end_ymd");
			String in_page = request.getParameter("page");
			return_num = request.getParameter("returnNum");
			return_code = request.getParameter("returnCode");
 	 
			String[] inParas1 = new String[2];
			inParas1[0]="select phone_no, login_no, to_char(op_time,'yyyy-MM-dd HH24:mi:ss'), op_note, qry_time from wprinttraceopr where op_code = '5085' ";
			inParas1[1]="";   	
			
			if(!"".equals(in_login_no)) {
			  inParas1[0]=inParas1[0]+" and login_no = :s_login_no ";
			  inParas1[1]=inParas1[1]+"s_login_no="+in_login_no;   	
			}
			
			if(!"".equals(in_begin_ymd)) {
			  inParas1[0]=inParas1[0]+" and op_time > to_date(:s_begin_ymd, 'YYYYMMDD') ";
			  if("".equals(in_login_no)) {
			    inParas1[1]="s_begin_ymd="+in_begin_ymd;    	
			  } else {
			  	inParas1[1]=inParas1[1]+",s_begin_ymd="+in_begin_ymd; 
			  }
			}
			
			if(!"".equals(in_end_ymd)) {
			  inParas1[0]=inParas1[0]+" and op_time < to_date(:s_end_ymd, 'YYYYMMDD')";
			  if("".equals(in_login_no) && "".equals(in_begin_ymd)) {
			    inParas1[1]="s_end_ymd="+in_end_ymd;
			  } else {
			  	inParas1[1]=inParas1[1]+",s_end_ymd="+in_end_ymd;
			  }
			}
			
			
%>

<wtc:service name="TlsPubSelCrm" retcode="retCode" retmsg="retMsg"  outnum="5">
	<wtc:param value="<%=inParas1[0]%>"/>
	<wtc:param value="<%=inParas1[1]%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end" /> 	

<%
    	return_code =retCode;
%>
<%
    if (!return_code.equals("000000") && !return_code.equals("0")) {
%>
<script language="JavaScript">
	rdShowMessageDialog("安保部详单查询记录查询失败! ");
	window.location = "zgb1_1.jsp";
</script>
<%
    } else {
%>

<HEAD>
<TITLE>黑龙江BOSS- 安保部详单查询记录查询</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</HEAD>
<BODY leftmargin="0" topmargin="0">
        <%@ include file="/npage/include/header.jsp"%>
			  <form id=sitechform name=sitechform>
        <div class="title">
            <div id="title_zi">
                安保部详单查询记录列表
            </div>
        </div>
        <table cellspacing="0">
            <tr>
                <th>
                    <div align="center">
                        <b>手机号码</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>工号</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>操作时间</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>操作备注</b>
                    </div>
                </th>
                <th>
                    <div align="center">
                        <b>查询时间</b>
                    </div>
                </th>
            </tr>
            
            <%
            	if(resultList.length > 0) {
                for (int i = 0; i < resultList.length; i++) {
            %>
            <tr>
                <td nowrap><%=resultList[i][0]%></td>
                <td nowrap><%=resultList[i][1]%></td>
                <td nowrap><%=resultList[i][2]%></td>
                <td nowrap><%=resultList[i][3]%></td>
                <td nowrap><%=resultList[i][4]%></td>
            </tr>
            <%
                }
              }
            %>
			  
        </table>
			 <TABLE cellSpacing="0">
				<TR> 
				  <TD id="footer"> 
					  <input type="button"  name="back"  class="b_foot" value="返回" onClick="window.location='zgb1_1.jsp'">
					  <input type="button"  name="back"  class="b_foot" value="关闭" onClick="removeCurrentTab()">
				  </TD>
				</TR>
			  </TABLE>
			</form>
        <%@ include file="/npage/include/footer_simple.jsp"%>
</BODY>
<% } %>
</HTML>

<script language="javascript">


</script>
