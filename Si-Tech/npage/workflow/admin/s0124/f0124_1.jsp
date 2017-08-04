<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.s1100.viewBean.S1100View" %>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<link rel="stylesheet" href="/css/style.css" type="text/css">

<%
  String op_name ="人员角色配置";
  Logger logger = Logger.getLogger("f1024_1.jsp");
  String sqlStr = "";
	S1100View callView = new S1100View();
	ArrayList retArray = new ArrayList();
  String[][] result = new String[][]{};
  String role_name="";
  String role_id="";
  String department = Pub_lxd.repStr(request.getParameter("department"),""); 
  String team_flag = Pub_lxd.repStr(request.getParameter("team_flag"),""); 
  if(!department.equals("")){
  sqlStr ="select  role_code,role_name from sdeptrole where parent_dept='"+department+"' and team_flag='"+team_flag+"'";
  retArray = callView.view_spubqry32("2",sqlStr);
  result = (String[][])retArray.get(0);
  	if(result.length==0){
%>
      <script language='jscript'>
				rdShowMessageDialog("无此信息，请配置！" ,0);
				location = "f0124_1.jsp";
			</script>
<% 
  	}else{
  		role_name=result[0][1];
  		role_id=result[0][0];
  	}
  }
%>
<HTML>
 <HEAD>
  <title><%=op_name%></title>
 </HEAD>
  <SCRIPT type=text/javascript>

function refuse(){
	       frm.action="f0124_1.jsp";
	       frm.submit();
}
function save(){
	var str="";
	for(var i=0; i<document.all.lefts.options.length; i++){  
		if(document.all.lefts.options.length==i){
		str = str+document.all.lefts.options[i].value;
			}else{
    str = str+document.all.lefts.options[i].value + "%";
  }
  }
  document.all.changeid.value=str;
  document.all.roleid.value= "<%=role_id%>";
  frm.action="f0124_2.jsp";
	frm.submit();
}
function config(){
  frm.action="f0124_3.jsp";
	frm.submit();
}
function closed(){
  if(rdShowConfirmDialog("确认数据同步了吗？")==1){
  	window.close();
	}
}
	
  </script>
 <BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif">
  <FORM action="" method="post" name="frm">
   <%@ include file="/page/public/head.jsp" %>
   <div id="Operation_Table">
    <TABLE width=98%  border=0 align="center"  cellSpacing=0 bgcolor="#FFFFFF">
     <TR bgcolor="E8E8E8">

      <TD align="center">选择地区：&nbsp;&nbsp;&nbsp;
        <select name="department">
        		<option value="00" <%=(department.equals("00"))?"selected":""%>>全地区</option>
            <%   
				        try
				        {
                sqlStr ="select department_id,department_name from department_message  where department_id like'__' ";
                retArray = callView.view_spubqry32("2",sqlStr);
                result = (String[][])retArray.get(0);
                int recordNum = result.length;                  
	               for(int i=0;i<recordNum;i++){
	                        out.print("<option value='" + result[i][0] + "' ");
	                        if(!department.equals("")&&department.equals(result[i][0])){
	                         out.print("selected");
	                        }
	                        out.println(" >" + result[i][1] + "</option>");
	                }
				        }catch(Exception e){
				                logger.error("Call sunView is Failed!");
				        }              
						%>
         </select>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
        选择类别：&nbsp;&nbsp;&nbsp;<select name="team_flag">
        	<option value="0" <%=(team_flag.equals("0"))?"selected":""%>>工单受理</option>
        	<option value="1" <%=(team_flag.equals("1"))?"selected":""%>>整理派发</option>
        	<option value="2" <%=(team_flag.equals("2"))?"selected":""%>>工单回复</option>
        	<option value="3" <%=(team_flag.equals("3"))?"selected":""%>>复核归档</option>
        	<option value="4" <%=(team_flag.equals("4"))?"selected":""%>>工单回访</option>
      	 </select>	
      	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="查看" onclick="refuse()">
      </TD>
    

	</tr>
	 <TABLE width=98%  border=0 align="center"  cellSpacing=0 bgcolor="#FFFFFF">
		<tr bgcolor="E8E8E8">


					<td>
						<!-- 抬头信息 -->
						<table width="100%" border="0" align="center" cellpadding="4"
							cellspacing="1">
							<tr bgcolor="F3F6FF">
								<td width="100%" colspan="7" height="10">
								</td>
							</tr>
							<tr bgcolor="F3F6FF">
								<td align="right">
									<%=role_name%>成员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
									<select id="lefts" multiple="" style="width:200px;" size="10">
										 <%   
				        try
				        {
                sqlStr ="select distinct a.dept_id,b.department_name from sdeptrole a,department_message b where a.dept_id=b.department_id and a.role_code='"+role_id+"' order by to_number(a.dept_id) asc";
                retArray = callView.view_spubqry32("2",sqlStr);
                result = (String[][])retArray.get(0);
                int recordNum = result.length;                  
	               for(int i=0;i<recordNum;i++){
	                        out.println("<option value='" + result[i][0] + "' >"+ result[i][0]+"-->>" + result[i][1] + "</option>");
	                }
				        }catch(Exception e){
				                logger.error("Call sunView is Failed!");
				        }              
						%>
									</select>
								</td>
								<td  align="center">
									<table width="70" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<div align="center">
													<a href="javascript:moveSelected(document.all.lefts,document.all.rights)">
														&nbsp;>>>&nbsp;
												  </a>
												</div>
											</td>
											<td width="100%">
												
												
											</td>
											<td>
												<div align="center">
													<a href="javascript:moveSelected(document.all.rights,document.all.lefts)">
														&nbsp;<<<&nbsp;
												  </a>
												</div>
											</td>
										</tr>
									</table>
								</td>
								<td >
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其他成员<br>
									<select id="rights"  multiple="" style="width:200px;" size="10">
										 <%   
						if(!department.equals("")){
				        try
				        {
                sqlStr ="select b.department_id,b.department_name from department_message b where  b.department_id like '____' and not exists (select '1' from sdeptrole a WHERE a.dept_id=b.department_id and a.role_code='"+role_id+"' ) order by to_number(b.department_id) asc";
                retArray = callView.view_spubqry32("2",sqlStr);
                result = (String[][])retArray.get(0);
                int recordNum = result.length;                  
	               for(int i=0;i<recordNum;i++){
	                        out.println("<option value='" + result[i][0] + "' >"+ result[i][0]+"-->>"  + result[i][1] + "</option>");
	                }
				        }catch(Exception e){
				                logger.error("Call sunView is Failed!");
				        }       
				      }       
						%>
									</select>
								</td>
								
							</tr>

						</table>
					</td></tr>
					<tr bgcolor="F3F6FF">
					<td colspan="3" align="center">
						<input type="button" value="保存" onclick="save()">&nbsp;&nbsp;&nbsp;
						<input type="button" value="数据同步" onclick="config()">&nbsp;&nbsp;&nbsp;
						<input type="button" value="关闭" onclick="closed()">
				</td>	
				</tr>
        </TABLE>
	 </div>
	 <input type="hidden" name="changeid" value="">
	 <input type="hidden" name="roleid" value="">
	 <%@ include file="/page/public/foot.jsp" %>
  </FORM>
 </BODY>
</HTML>
<script language="javascript">
/**
  * 移动select的部分内容,必须存在value，此函数以value为标准进行移动
  *
  * oSourceSel: 源列表框对象 
  * oTargetSel: 目的列表框对象
  */
 function moveSelected(oSourceSel,oTargetSel)
 {
     //建立存储value和text的缓存数组
     var arrSelValue = new Array();
     var arrSelText = new Array();
     //此数组存贮选中的options，以value来对应
     var arrValueTextRelation = new Array();
     var index = 0;//用来辅助建立缓存数组
     //存储源列表框中所有的数据到缓存中，并建立value和选中option的对应关系
     for(var i=0; i<oSourceSel.options.length; i++)
     {
         if(oSourceSel.options[i].selected)
         {
             //存储
             arrSelValue[index] = oSourceSel.options[i].value;
             arrSelText[index] = oSourceSel.options[i].text;
             //建立value和选中option的对应关系
             arrValueTextRelation[arrSelValue[index]] = oSourceSel.options[i];
             index ++;
         }
     }
     
     //增加缓存的数据到目的列表框中，并删除源列表框中的对应项
     for(var i=0; i<arrSelText.length; i++)  
     {
         //增加
         var oOption = document.createElement("option");
         oOption.text = arrSelText[i];
         oOption.value = arrSelValue[i];
         oTargetSel.add(oOption);
         //删除源列表框中的对应项
         oSourceSel.removeChild(arrValueTextRelation[arrSelValue[i]]);
     }
 }
</script>