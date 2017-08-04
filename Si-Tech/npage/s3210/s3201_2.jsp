<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-10-13
********************/
%>
              
<%
  String opCode = "3201";
  String opName = "智能网VPMN操作查询";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 




<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String loginNo=     (String)session.getAttribute("workNo");    //工号 
	String phoneNo=request.getParameter("phoneNo");
	String qryType=request.getParameter("qryType");
	System.out.println("######################"+phoneNo);
	System.out.println("3201######################"+qryType);
	String sqlStr="";
    String rowNum = "16";
    String getAcceptFlag = "";
	String temp[][]=null;
	String temp1[][]=null;
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String error_code="";
	String error_msg="";
	String userpass = "";
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(activePhone);
	try{
   		 userpass = contactInfo. getPasswdVal (2);
   	}catch(Exception e)
	  {   
	      System.out.println(e.toString());
	  }

	//wuxy alter 为解决申告中操作时间、下月套餐不匹配问题 20081116修改
	/*
	sqlStr = "select update_login ,to_char(update_time,'YYYY-MM-DD HH24:MI:SS') , phone_no , function_name ,pkg_name1 ,pkg_name2 from ("
	       + " select a.update_login as update_login , a.update_time as update_time ,a.phone_no as phone_no ,"
	       + " d.function_name as function_name , e.pkg_name as pkg_name1 ,f.pkg_name as pkg_name2 "
	       + " from dvpmnusrmsghis a ,dloginmsg c ,sfunccode d ,svpmnpkgcode e,svpmnpkgcode f,dcustmsg b  "
	       + " where a.id_no=b.id_no and a.update_login=c.login_no and a.update_code=d.function_code "
	       + " and substr(c.org_code,0,2)=e.region_code and a.curpkgtype=e.pkg_code and "
	       + " substr(c.org_code,0,2)=f.region_code and a.pkgtype=f.pkg_code and a.update_code=any('3210','3212','3215') "
	       + " and b.phone_no='"+phoneNo+"' "
	       + " union "
	       + " select a.update_login as update_login ,a.update_time as update_time ,a.phone_no as phone_no, "
	       + " e.function_name as function_name ,f.pkg_name as pkg_name1 ,h.pkg_name as pkg_name2 "
	       + " from dvpmnusrmsghis a ,dvpmnusrmsghis c,dloginmsg d,sfunccode e,svpmnpkgcode f ,"
	       + " svpmnpkgcode h ,dcustmsg b "
	       + " where a.id_no=b.id_no and a.update_code='3214' and a.update_accept=c.login_accept "
	       + " and c.id_no=b.id_no and a.update_login=d.login_no and a.update_code=e.function_code "
	       + " and substr(d.org_code,0,2)=f.region_code and c.curpkgtype=f.pkg_code  and "
	       + " c.pkgtype=h.pkg_code and substr(d.org_code,0,2)=h.region_code and b.phone_no='"+phoneNo+"' "
	       + " union "
	       + " select a.update_login as update_login ,a.update_time as update_time ,a.phone_no as phone_no ,"
	       + " e.function_name as function_name ,f.pkg_name as pkg_name1 ,h.pkg_name as pkg_name2 "
	       + " from dvpmnusrmsghis a,dvpmnusrmsg b,dloginmsg d, sfunccode e,svpmnpkgcode f,svpmnpkgcode h ,dcustmsg c "
	       + " where a.id_no=c.id_no and b.id_no=c.id_no and a.update_accept=b.login_accept and "
	       + " a.update_login=d.login_no and a.update_code=e.function_code and b.curpkgtype=f.pkg_code "
	       + " and substr(d.org_code,0,2)=f.region_code and b.pkgtype=h.pkg_code and "
	       + " substr(d.org_code,0,2)=h.region_code and a.update_code='3214' and c.phone_no='"+phoneNo+"'"
	       + " ) "
	       + " order by update_time ";
	System.out.println("sqlStr="+sqlStr);
	*/
  //retArray = callView.sPubSelect("6",sqlStr);
  %>
	<wtc:service name="s3201EXC" routerKey="region" routerValue="<%=regionCode%>"  retcode="code" retmsg="msg" outnum="12">
		<wtc:param value="3201" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="<%=userpass%>" />
		<wtc:param value="<%=qryType%>" />
	</wtc:service>
	<wtc:array id="result_t" scope="end" />		  
  <%
	temp=result_t; 
	error_code = code;
     error_msg= msg;
	if(temp.length==0){
	%>
		<SCRIPT language="JavaScript">
			rdShowMessageDialog("没有该号码的相关操作纪录！");
			history.go(-1);
		</SCRIPT>
	<%
		return;
	}
	
%>
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>BOSS侧VPMN操作查询</TITLE>
</HEAD>
<body >


<FORM method=post name="f1500_custuser">
 <%@ include file="/npage/include/header.jsp" %>    
 <div class="title">
		<div id="title_zi">BOSS侧VPMN操作查询</div>
	</div>
           
              		<%
     		if (qryType.equals("s"))
				{
					out.println("<table><tr><th  width=\"15%\">当前短号</th><td>"
						+temp[0][5]+"</td></tr></table>");
				}
				%>  
           
            <TABLE  cellSpacing=0>
              <TBODY>
                <TR  align='center'> 			
                  <Th nowrap align="center">操作工号</Th>
                  <Th nowrap align="center">操作日期</Th>
                  <Th nowrap width="15%" >操作号码</Th>
                  <Th nowrap align="center">操作名称</Th>
				 	<%
				 	if ( qryType.equals("s") )
				 	{
				 	%><Th> 历史短号</Th><%
				 	}
					else
					{
					%><Th> 成员资费</Th><%
					}
				 	%>
				  
				  <Th nowrap align="center">集团编号</Th>
				  <Th nowrap align="center">集团名称</Th>
				  <Th nowrap align="center">集团类别</Th>
				  <Th nowrap align="center">智能网编号</Th>
				  <Th nowrap align="center">客户经理姓名</Th>
				  <Th nowrap align="center">客户经理工号</Th>
                </TR>
			<%
			for(int i=0;i<temp.length;i++){
				temp=result_t; 
				out.println("<TR   align='center'>");
				out.println("<TD  >"+temp[i][0]+"</TD>");
				out.println("<TD >"+temp[i][1]+"</TD>");
				out.println("<TD >"+temp[i][2]+"</TD>");
				out.println("<TD >"+temp[i][3]+"</TD>");
				
				if (qryType.equals("s"))
				{
					out.println("<TD >"+temp[i][4]+"</TD>");
				}
				else
				{
					out.println("<TD >"+temp[i][5]+"</TD>");
				}
			
				
				out.println("<TD >"+temp[i][6]+"</TD>");
				out.println("<TD >"+temp[i][7]+"</TD>");
				out.println("<TD >"+temp[i][8]+"</TD>");
				out.println("<TD >"+temp[i][9]+"</TD>");
				out.println("<TD >"+temp[i][10]+"</TD>");
				out.println("<TD >"+temp[i][11]+"</TD>");
				out.println("<TR >");
				}
			%>
              </TBODY>
            </TABLE>
     

     
      <table  cellspacing=0>
        <tbody> 
          <tr align="center"> 
      	    <td id=footer>
    	       <input class="b_foot" name=back onClick="window.location='s3201_1.jsp'" type=button value=返回>
    	      
    	    </td>
          </tr>
        </tbody> 
      </table>
    
   <%@ include file="/npage/include/footer.jsp" %>

</FORM>
</BODY>
</HTML>