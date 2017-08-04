<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
String work_type = request.getParameter("work_type");

String region_code = request.getParameter("region_code");
String workNo = (String)session.getAttribute("workNo");
String opCode = "5019";
String ip = (String)session.getAttribute("ipAddr");
String op_note ="操作员： "+workNo+"对公告信息进行操作,地区："+ region_code; 
String regionCode = (String)session.getAttribute("regCode");

System.out.println("-------------work_type------------"+work_type);    	
String paramIn[] = new String[]{};
if(work_type.equals("a"))			//增加
	{
		paramIn = new String[]{
		work_type,region_code,(String)request.getParameter("bullet_code1"),
		(String)request.getParameter("is_ok1"),(String)request.getParameter("bullet_content1").trim(),
		 (String)request.getParameter("boot_name1"),"",workNo,"5019",(String)request.getParameter("anoRank1"),regionCode
		 };
	}
if(work_type.equals("u"))			//修改
	{
		paramIn = new String[]{
		work_type,region_code,(String)request.getParameter("bullet_code2"),
		(String)request.getParameter("is_ok2"),(String)request.getParameter("bullet_content2").trim(),
		 (String)request.getParameter("boot_name2"),"",workNo,"5019",(String)request.getParameter("anoRank2"),regionCode
		 };
	}
if(work_type.equals("d"))			//删除
	{
		paramIn = new String[]{
		work_type,region_code,(String)request.getParameter("bullet_code3"),
		(String)request.getParameter("is_ok3"),(String)request.getParameter("bullet_content3").trim(),
		 (String)request.getParameter("boot_name3"),"",workNo,"5019",(String)request.getParameter("anoRank3"),regionCode
		 };
	}


for(int i=0;i<paramIn.length;i++){
	System.out.println("----------paramIn["+i+"]---------"+paramIn[i]);
}
%>

	<wtc:service name="s5019Cfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paramIn[0]%>" />
		<wtc:param value="<%=paramIn[1]%>" />
		<wtc:param value="<%=paramIn[2]%>" />
		<wtc:param value="<%=paramIn[3]%>" />
		<wtc:param value="<%=paramIn[4]%>" />
		<wtc:param value="<%=paramIn[5]%>" />
		<wtc:param value="<%=paramIn[6]%>" />
		<wtc:param value="<%=paramIn[7]%>" />
		<wtc:param value="<%=paramIn[8]%>" />
		<wtc:param value="<%=paramIn[9]%>" />			
		<wtc:param value="<%=paramIn[10]%>" />				
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
<%
				String ret_code = code;
                String ret_msg = msg;
                System.out.println("---------------ret_code-------------"+ret_code);
                System.out.println("---------------ret_msg--------------"+ret_msg);
                
if(ret_code.equals("000000")){
%>
<script language='jscript'>
rdShowMessageDialog('操作成功！请返回！',2);
window.location="f5019_1.jsp?opCode=5019&opName=公告栏参数话管理";

</script>
<%}else{%>
<script language='jscript'>
var ret_code = "<%=ret_code%>";
var ret_msg = "<%=ret_msg%>";
rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
history.go(-1);
</script>
</script>
<%}%>