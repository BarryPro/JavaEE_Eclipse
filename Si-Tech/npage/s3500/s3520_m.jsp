<%
/********************
 version v2.0
开发商: si-tech
修改人	修改时间	修改原因
niuhr 2009/11/12	集团配置功能改造
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=gbk"%>
<%if ((request.getCharacterEncoding() == null)) {	request.setCharacterEncoding("GBK");}%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="sitech.www.frame.jdbc.SqlQuery" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	    
	String opCode = "3520";
	String opName = "用户附加字段表";
			
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));   
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String  powerCode= (String)session.getAttribute("powerCode");
	//String strDate=new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
	List sqlList = new ArrayList();	
	    
	//进行工号权限检验
    String sqlStr = "";
    String busiType = "";
    String fieldCode = "";
    String fieldName = "";
	String fieldPurpose="";
    String fieldType = "";
	String fieldLength = "";
	String fieldNote = "";

    int suc_flag = -1;
    PrdMgrSql sqlSrvCode=new PrdMgrSql();
%>

<%

  String action=request.getParameter("action");
  String  strbusi = " select busi_type ,busi_name from suserbusitype order by busi_type ";
  int len1 = 0;

try {
    busiType = request.getParameter("busiType").trim();
    fieldCode = request.getParameter("fieldCode").trim();
    fieldName =  request.getParameter("fieldName").trim();
    fieldPurpose = request.getParameter("fieldPurpose").trim();
	fieldType = request.getParameter("fieldType").trim();
    fieldLength = request.getParameter("fieldLength").trim();
	fieldNote = request.getParameter("fieldNote").trim();


    //修改角色
    	if ("modify".equals(action)) 
    	{
    	    sqlStr = "update  sUserFieldCode  set field_code='"+fieldCode+"', " +
    	                                "field_name='"+fieldName+"', " +
    	                                "field_purpose='"+fieldPurpose+"', " +
										"field_type='"+fieldType+"', " +
										"field_length='"+fieldLength+"', " +
										"field_note='"+fieldNote+"'";
    	
			sqlStr = sqlStr + "where busi_type = '" + busiType + "' and field_code = '"+fieldCode+"'";
					sqlList.add(sqlStr);
    	            int flag=sqlSrvCode.updateTrsaction(sqlList);
					if(flag==1)
					{
						%>
						<script>
						rdShowMessageDialog("修改成功！",2)
						</script>
						<%
					}
					else{
						%>
						<script>
						rdShowMessageDialog("修改失败！",0)
						</script>
						<%
					}
			suc_flag = 1;
    	}
    }catch (Exception ex) {
        throw new Exception(sqlStr+"操作失败！!!\n后台错误信息为："+ex);
  }

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:sql><%=strbusi%> </wtc:sql>
</wtc:pubselect>
<wtc:array id="rows1" scope="end"/>
	
<%			
	if(retCode.equals("000000"))
	{	
		for(int i=0;i<rows1.length;i++)
		{
             //System.out.println("rows["+i+"][0]"+rows[i][0]);
             //System.out.println("rows["+i+"][1]"+rows[i][1]);
		}	
        len1=rows1.length;
	}
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("查询业务类型信息出错！!",0);
			/* document.location.replace("<%=request.getContextPath()%>/npage/s5630/f5630_1.jsp"); */
			window.location="s3520.jsp";
		</script>
<%
	}		
%>

<HTML xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>   

/*************************************************************************************/

function checkDate(theDate)
{
    var chars= "0123456789";
    var tempDate=trim(theDate);
    if(tempDate.length!=10)
    {
    	rdShowMessageDialog("请输入合法的日期！",1)
      	return false;
	}
    var year=tempDate.substring(0,4);
    var month=tempDate.substring(5,7);
    var day=tempDate.substring(8,10);

    if(tempDate.substring(4,5)!="-"||tempDate.substring(7,8)!="-")
    {
		rdShowMessageDialog("请输入合法的日期！",1)
        return false;
    }
	var tempDate2=year+month+day;
	for(var i=0;i<=tempDate2.length;i++)
	{
		if(chars.indexOf(tempDate2.charAt(i))==-1)
		{
			rdShowMessageDialog("请输入合法的日期！",1)
			return false;
		}
	}
    if(!js_checkBirthday(year,month,day))
	{
		return false;
    }
        return true;
}

function js_checkBirthday(y1,m1,d1)
{
    //校验输入的日期是否合法
    //alert("y,m,d="+y1+","+m1+","+d1);
    var y=parseInt(y1,10);
    var m=parseInt(m1,10);
    var d=parseInt(d1,10);
    //alert("y,m,d="+y+","+m+","+d);
    if(m<1||m>12)
    {
      rdShowMessageDialog("请输入正确的月份！",1)
      return false;
    }

	if ( m==4 || m==6 || m==9 || m==11 )
	{
		if (d<1||d>30)
        {
			rdShowMessageDialog("请输入正确的日期！",1)
        	return false;
        }
    }
    else if ( m==02 )
    {
		if ( ((y % 4)==0) && ((y % 100)!=0) || ((y % 400)==0) )
		{
        	if ( d<1 || d>29 )
        	{
          		rdShowMessageDialog("请输入正确的日期！",1)
          		return false;
        	}
      	}
      	else
      	{
        	if ( d<1 || d>28 )
        	{
           		rdShowMessageDialog("请输入正确的日期！",1)
          		return false;
        	}
      }
    }
    else
    {
		if ( d<1 || d>31 )
		{
        	rdShowMessageDialog("请输入正确的日期！",1)
        	return false;
		}
    }
    if(y<1900||y>2100)
    {
		rdShowMessageDialog("请输入有效的年份！",1)
		return false;
    }
    return true;
  }
function compareDate()
{
    var d = new Date();
	var s1=""
    var sDate = d.getDate();
	var sDate1 ="";
	if(sDate<10)
 	    sDate1 = "-0"+sDate;
	else
		sDate1 = "-"+sDate;
	var sMonth = d.getMonth()+1;
	if(sMonth<10)
	    sMonth = "-0"+sMonth;
	else
		sMonth = "-"+sMonth;
	s1 += d.getYear()+sMonth + sDate1;
	//startDate、endDate为输入框名称

	if(TestMForm.beginTime.value>TestMForm.endTime.value || TestMForm.beginTime.value == TestMForm.endTime.value){
		rdShowMessageDialog("开始日期在结束日期之前",1)
		TestMForm.endTime.focus();
		return false;
	}
	 return true;
}
function checkTable()
{
	var beginDate;
	var endDate;
	if(trim(document.TestMForm.fieldName.value).length==0){
		rdShowMessageDialog("字段名称不能为空！",1)
		document.TestMForm.fieldName.focus();
		return false;
	}

	if(trim(document.TestMForm.fieldPurpose.value).length==0){
		rdShowMessageDialog("字段用途不能为空！",1)
		document.TestMForm.fieldPurpose.focus();
		return false;
	}
	return true;
}
function submitInputModify(url){
         
	if(checkTable())
	{
    	submitMe(url);
	}
		else return;
}
function submitInput(url){
	submitMe(url);
}
function submitMe(url){
	window.TestMForm.action=url;
	window.TestMForm.method='post';
	window.TestMForm.submit();
}
function submitInput2(url){
//  if(checkTable())
//  {
//    submitMe(url);
//  }
//  else
//  {
//    return false;
//  }
submitMe(url);
}
//截掉字符串前后空格
function trim(arg)
{
  if(arg.length==0)
  {
    return '';
  }

    //定位第一个非空格位置
  for(var i=0;i<arg.length;i++)
  {
    var onechar=arg.charAt(i);
    if(onechar!=' ')
    {
      break;
    }
  }
  arg=arg.substring(i,arg.length);

    if(arg.length==0)
  {
    return '';
  }

    //定位第一个非空格位置(逆向搜索)
  for(var i=arg.length;i>0;i--)
  {
    var onechar=arg.charAt(i-1);
    if(onechar!=' ')
    {
      break;
    }
  }
  arg=arg.substring(0,i);
  return arg;
}

</script>

</HEAD>
<BODY>
<FORM name="TestMForm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi" >用户附加字段代码表</div>
	</div> 
	<table cellspacing="0">
		<tr>
               <td class="blue">业务类型定义</td>
               <td  colspan="3">
               	  <!--<SELECT name="busiType" id="busiType">
               	  	<option value="1000" <%=(busiType!=null&&busiType.equals("1000"))?"selected":""%>>1000--IDC业务</option>
               	  	<option value="1001" <%=(busiType!=null&&busiType.equals("1001"))?"selected":""%>>1001--群英网绑定业务</option>
               	  	<option value="1002" <%=(busiType!=null&&busiType.equals("1002"))?"selected":""%>>1002--群英网可选业务</option>
               	  	<option value="1003" <%=(busiType!=null&&busiType.equals("1003"))?"selected":""%>>1003--群英网特有属性</option>
               	  	<option value="1004" <%=(busiType!=null&&busiType.equals("1004"))?"selected":""%>>1004--山西BOSSVPMN</option>
               	  </SELECT>
               	  -->
               	  <SELECT name="busiType" id="busiType" disabled>
    	             	 <% 
    	             	  for(int i = 0; i < len1; i++){
    	             	    System.out.println(busiType+"===+++++===="+rows1[i][0]);
    	             	 %>
    	               <option value="<%=rows1[i][0].trim()%>" <%if(busiType.equals(rows1[i][0].trim()))out.println("selected");%>><%=rows1[i][0].trim()%>&nbsp;-&gt&nbsp;<%=rows1[i][1].trim()%></option>
											<%
										  }
											%>
				</select>
               	 <!--<SELECT name="busiType" id="busiType">
    	             	<% for(int i = 0; i < len1; i++){%>
    	               	 	<option value="<%=rows1[i][0].trim()%>"><%=rows1[i][0].trim()%>&nbsp;-&gt&nbsp;<%=rows1[i][1].trim()%></option>
						<%}%>
				</select>-->
               </td>
		</tr>
		<tr >
               <td class="blue">字段代码</td>
               <td>
                  <input name="fieldCode" type="text" class="button" id="fieldCode"  maxlength="5"  value="<%=(fieldCode==null)?"":fieldCode%>" readonly>
               </td>
               <td class="blue">字段代码名称</td>
               <td>
                  <input name="fieldName" type="text" class="button" id="fieldName" maxlength="20" value="<%=(fieldName==null)?"":fieldName%>" >
			   </td>
		</tr>
		<tr>
			 <td class="blue">字段用途</td>
             <td >
				  <select name="fieldPurpose">
				    <option></option>
					<option value="10" <%=(fieldPurpose!=null&&fieldPurpose.equals("10"))?"selected":""%>>费用代码</option>
					<option value="11" <%=(fieldPurpose!=null&&fieldPurpose.equals("11"))?"selected":""%>>其它</option>
				  </select>
			 </td>
             <td class="blue">字段类型</td>
             <td>
				<select name="fieldType">
					<option></option>
					<option value="09" <%=(fieldType!=null&&fieldType.equals("09"))?"selected":""%>>09--其它</option>
					<option value="10" <%=(fieldType!=null&&fieldType.equals("10"))?"selected":""%>>10--整型</option>
					<option value="11" <%=(fieldType!=null&&fieldType.equals("11"))?"selected":""%>>11--浮点型</option>
					<option value="12" <%=(fieldType!=null&&fieldType.equals("12"))?"selected":""%>>12--字符型</option>
					<option value="13" <%=(fieldType!=null&&fieldType.equals("13"))?"selected":""%>>13--金额'XXXX.YY'</option>
					<option value="14" <%=(fieldType!=null&&fieldType.equals("14"))?"selected":""%>>14--日期型'YYYYMMDD'</option>
					<option value="15" <%=(fieldType!=null&&fieldType.equals("15"))?"selected":""%>>15--日期型'YYYYMMDD HH24:MI:SS'</option>
					<option value="16" <%=(fieldType!=null&&fieldType.equals("15"))?"selected":""%>>16--BOOL型</option>
					<option value="17" <%=(fieldType!=null&&fieldType.equals("15"))?"selected":""%>>17--固定列表</option>
				</select>
			 </td>
		</tr>
		<tr>
				<td class="blue">字段最大长度</td>
				<td>
				<input name="fieldLength" type="text" class="button" id="fieldLength" maxlength="8" value="<%=(fieldLength==null)?"":fieldLength%>" >
				</td>
				<td class="blue">字段备注说明</td>
				<td>
                  <input name="fieldNote" type="text" class="button" id="fieldNote"  maxlength="4"  value="<%=(fieldNote.equals("null"))?"":fieldNote%>" colspan="3">
               </td>
		</tr>		
	</table>
    <TABLE cellSpacing="0" >
		<TR>
			<TD id="footer" align="center">
				<input name="confirm" type="button"class="b_foot"  value="修改" onClick="submitInputModify('s3520_m.jsp?action=modify&fieldCode=<%=fieldCode%>&busiType=<%=busiType%>')">
                <input name="back" type="reset" class="b_foot"  value="返回" onClick="submitInput('s3520.jsp')">
			</TD>
			<TD></TD>
		</TR>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</HTML>

