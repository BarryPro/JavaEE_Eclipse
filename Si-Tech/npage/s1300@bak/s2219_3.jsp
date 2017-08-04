   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "2219";
  String opName = "批量局拆特殊用户延期";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
	String orgcode = (String)session.getAttribute("orgCode");  
	String workno=(String)session.getAttribute("workNo");    //工号 
        String workname =(String)session.getAttribute("workName");//工号名称  	        
        String regionCode = (String)session.getAttribute("regCode"); 
        
String nopass = "111111";
String op_code = "2219"  ;
String remark = request.getParameter("remark");
String serverIp=request.getServerName();
System.out.println("remark:"+remark);
//定义变量
//输入参数    


String [][] result = new String[][]{};
String    iErrorNo ="";
String    sErrorMessage = " ";
String    sReturnCode = "";
int   	  flag = 0;
String [] inputPar=new String []{workno,nopass,orgcode,op_code,remark,serverIp};
String total_fee = "";
String total_no = "";
	try
	{	
		//arlist = callView.callFXService("s2219Cfm",inputPar,"3");
%>

	<wtc:service name="s2219Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5" >
		<wtc:params value="<%=inputPar%>"/>					
	</wtc:service>
	<wtc:array id="result_t1" scope="end"/>		

<%		
if(result_t1!=null)
		result = result_t1;
		iErrorNo =retCode;
		System.out.println("*********:'"+iErrorNo+"'");
		sErrorMessage = retMsg;
	//	System.out.println("-------------------------"+arlist.size());

		
		//String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(iErrorNo));

		if (!iErrorNo.equals("000000"))
		{
			System.out.println(" 错1误代码 : " + iErrorNo);
			System.out.println(" 错误2信息 : " + sErrorMessage);
            flag = -1;
		}

	// 判断处理是否成功
	if (flag == 0)
	{	

		total_no = result_t1[0][2];
	
	}
	else
	{
		System.out.println("failed, 请检查 !");
	}
	
		}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	
%>
<HTML><HEAD><TITLE>黑龙江BOSS-批量局拆特殊用户延期</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript">
<!--
function gohome()
{
document.location.replace("s2219.jsp");
}
-->
</script>
</HEAD>
<BODY>
<FORM action="s2219_3.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">批量局拆特殊用户延期</div>
	</div>

            <table cellspacing="0">
              <tbody> 
              <tr > 
                <td width="13%" class="blue">操作类型</td>
                <td width="35%">
                  <select name = "SOprType" size = "1" >
                    <option value = "1" selected> 批量局拆特殊用户延期</option>
                  </select>
                </td>
                <td width="13%" class="blue">部门</td>
                <td width="39%"><%=orgcode%></td>
              </tr>
              </tbody> 
            </table>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td colspan="2">
                    <div align="center">批量局拆特殊用户延期完成。
					
					<br> 					
					   <% if (flag == 0){%>
                          共延期号码数量<%=total_no%>。
                       <% } else { %>
                          错误代码'<%=iErrorNo%>'。<br>错误信息'<%=sErrorMessage%>'。");
                       <% } %>					   
					      <br>失败的号码，请检查<a target="_blank" href="/npage/tmp/<%=orgcode.substring(0,2)%>delay2219.txt.err"><%=orgcode.substring(0,2)%>delay2219.txt.err</a>文件。
						  
					 </div>
                  </td>
                </tr>
                </tbody> 
              </table>
            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td align=center  width="100%" id="footer"> 
                  <input  name=sure disabled type=submit value=确认 class="b_foot">
                  <input  name=reset type=reset value=返回 onClick="gohome()" class="b_foot">
                  &nbsp; </td>
              </tr>
              </tbody> 
            </table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>



