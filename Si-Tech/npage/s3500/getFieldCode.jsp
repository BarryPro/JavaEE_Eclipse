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
<%if ((request.getCharacterEncoding() == null)){request.setCharacterEncoding("GBK");}%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="sitech.www.frame.jdbc.PageVo" %>
<%@ page import="sitech.www.frame.jdbc.SqlQuery" %>

<%
		String opCode = "3522";
		String opName = "用户类型与附加字段代码对应表";
		
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));   
		String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String  powerCode= (String)session.getAttribute("powerCode");
		List sqlList = new ArrayList();
	    
	//进行工号权限检验
    int rowCount =0;
    int pageSize=10;               //每页行数
    int pageCount =0;              //总的页数
    int curPage =0;                //当前页
    //需要参数传递
		int beginPos;               //结果集中数据的起始位置
		int endPos;                 //结果集中数据的终止位置
		String strPage;             //作为参数传过来的页
		String sSqlCondition="";
		List list=null;
		String sqlStr = "";
		
		String busiType = "";
		String fieldCode = "";
		String fieldName = "";
		String fieldPurpose="";
		String fieldType = "";
		String fieldLength = "";
		String fieldNote = "";
		String openParamFlag = "";//newadd
		String updateFlag = "";//newadd

    int que_flag = 1;

     Vector vTemp=null;
     PrdMgrSql sqlSrvCode=new PrdMgrSql();
     boolean bUserExist=false;
     String action=request.getParameter("action");

   try
   {
				busiType = request.getParameter("busiType");
				fieldCode = request.getParameter("fieldCode");
				fieldName = request.getParameter("fieldName");
				fieldPurpose = request.getParameter("fieldPurpose");
				fieldType = request.getParameter("fieldType");
				fieldLength = request.getParameter("fieldLength");
				fieldNote = request.getParameter("fieldNote");
				openParamFlag = request.getParameter("openParamFlag");
				updateFlag = request.getParameter("updateFlag");
				System.out.println("busiType=" + busiType +"\t  11111111111 fieldCode"+ fieldCode);
    //查询角色
	if ("que_user".equals(action)) {
				System.out.println("in que_user");
			  sSqlCondition="and busi_type = '"+busiType+"'";
			  if(fieldCode.trim().length()!=0)
			  {
			      sSqlCondition=sSqlCondition+"and field_code like '%"+fieldCode+"%'";
			  }
				if(fieldName.trim().length()!=0){
				  sSqlCondition=sSqlCondition+"and field_name like '%"+fieldName+"%'";
				}
				if(fieldPurpose.trim().length()!=0){
				  sSqlCondition=sSqlCondition+"and field_purpose like '%"+fieldPurpose+"%'";
				}
				if(fieldType.trim().length()!=0){
				  sSqlCondition=sSqlCondition+"and field_type like '%"+fieldType+"%'";
				}
				  if(fieldLength.trim().length()!=0){
				  sSqlCondition=sSqlCondition+"and field_length like '%"+fieldLength+"%'";
				}
				sqlStr = "select  field_code,field_name,field_purpose,field_type,field_length,field_note from sUserFieldCode where 1=1 "+sSqlCondition+" order by field_code";
				System.out.println("sqlStr="+sqlStr);

        //点击查询、翻页按钮进入
        //分页2'
					rowCount = sqlSrvCode.functionBindOneInt ("SELECT count(*)  FROM sUserFieldCode a where 1=1 "+sSqlCondition);
					strPage = request.getParameter("page");
					System.out.println("strPagestrPagestrPagestrPage"+strPage);
					
					if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
							curPage=1;
					}else{
							curPage=Integer.parseInt(strPage);
					    if(curPage<1) curPage=1;
					}
					pageCount=(rowCount+pageSize-1)/pageSize;
					if(curPage>pageCount)	curPage=pageCount;
					beginPos=(curPage-1)*pageSize+1;
					endPos=beginPos+pageSize-1;
					if(endPos>rowCount) 	endPos=rowCount;

				//条件查询
				PageVo pv2=sqlSrvCode.queryBindPageVo("select  field_code,field_name,field_purpose,field_type,field_length,field_note from sUserFieldCode where 1=1 "+sSqlCondition,beginPos,endPos);
				list = pv2.getList();
				//System.out.println("非初始进入");
				que_flag = 2;
		}
		if("fanye".equals(action))
		{    
				sSqlCondition="and busi_type = '"+busiType+"'";
				if(fieldCode.trim().length()!=0)
				{
					sSqlCondition=sSqlCondition+"and field_code like '%"+fieldCode+"%'";
				}
				if(fieldName.trim().length()!=0){
					sSqlCondition=sSqlCondition+"and field_name like '%"+fieldName+"%'";
				}
				if(fieldPurpose.trim().length()!=0){
				sSqlCondition=sSqlCondition+"and field_purpose like '%"+fieldPurpose+"%'";
				}
				if(fieldType.trim().length()!=0){
				sSqlCondition=sSqlCondition+"and field_type like '%"+fieldType+"%'";
				}
				if(fieldLength.trim().length()!=0){
				sSqlCondition=sSqlCondition+"and a.field_length like '%"+fieldLength+"%'";
				}
		
        //点击查询、翻页按钮进入
        //分页2'
				rowCount = sqlSrvCode.functionBindOneInt ("SELECT count(*)  FROM sUserFieldCode a where 1=1 "+sSqlCondition);
				System.out.println("@@@@@@@@@@@@@@@@rowCount="+rowCount);
				System.out.println("################sSqlCondition="+sSqlCondition);
        strPage = request.getParameter("page");
        if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
			  curPage=1;
        }else{
          curPage=Integer.parseInt(strPage);
          if(curPage<1) curPage=1;
        }
        pageCount=(rowCount+pageSize-1)/pageSize;
        if (curPage>pageCount) 	curPage=pageCount;
        beginPos=(curPage-1)*pageSize+1;
        endPos=beginPos+pageSize-1;
        if(endPos>rowCount) 	endPos=rowCount;

        //条件查询
        PageVo pv2=sqlSrvCode.queryBindPageVo("select  field_code,field_name,field_purpose,field_type,field_length,field_note from sUserFieldCode where 1=1 "+sSqlCondition+ "order by field_code",beginPos,endPos);
        list = pv2.getList();
		    que_flag = 2;
    }

    if(que_flag==1){
				//查询全部
				//初始、链接进入；新增、删除
				//分页2
				rowCount = sqlSrvCode.functionBindOneInt ("SELECT count(*)  FROM sUserFieldCode a where 1=1 and busi_type = '"+busiType+"' order by field_code");
		
        strPage = request.getParameter("page");
        if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
			    curPage=1;
        }else{
            curPage=Integer.parseInt(strPage);
          if(curPage<1) curPage=1;
        }
        pageCount=(rowCount+pageSize-1)/pageSize;
        if (curPage>pageCount) curPage=pageCount;
        beginPos=(curPage-1)*pageSize+1;
        endPos=beginPos+pageSize-1;
        if(endPos>rowCount) endPos=rowCount;

        PageVo pv=sqlSrvCode.queryBindPageVo("select  field_code,field_name,field_purpose,field_type,field_length,field_note from sUserFieldCode where busi_type = '"+busiType+"' order by field_code",beginPos,endPos);
		    list = pv.getList();
		    System.out.println("初始进入");
    }

    }catch (Exception ex) {
        throw new Exception(sqlStr+"操作失败!!\n后台错误信息为："+ex);
    }


%>
<%
	int len1 = 0;
	String  strbusi = " select busi_type ,busi_name from suserbusitype where 1=1 order by busi_type ";
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
			document.location.replace("<%=request.getContextPath()%>/npage/s5630/f5630_1.jsp");
		</script>
<%
	}		
%>
<base target="_self">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<TITLE><%=opName%></TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>
  function selectPriceCode(fieldCode)
  {
	window.dialogArguments.sp_form.fieldCode.value=fieldCode;
	window.close();
  }
  function checkDate(theDate)
  {
    var chars= "0123456789";
    var tempDate=trim(theDate);
    if(tempDate.length!=10)
    {
    	rdShowMessageDialog("请输入合法的日期！！",2)
		return false;
      }
    var year=tempDate.substring(0,4);
    var month=tempDate.substring(5,7);
    var day=tempDate.substring(8,10);

    if(tempDate.substring(4,5)!="-"||tempDate.substring(7,8)!="-")
    {
		 rdShowMessageDialog("请输入合法的日期！",2)
		return false;
    }
    var tempDate2=year+month+day;
     for(var i=0;i<=tempDate2.length;i++)
     {
      if(chars.indexOf(tempDate2.charAt(i))==-1)
      {
		rdShowMessageDialog("请输入合法的日期！",2)
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
  /********************比较日期大小**********************/
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
	if(cm_form.beginTime.value < s1){
		rdShowMessageDialog("起始日期不能早于今天",1)
		cm_form.beginTime.focus();
		return false;
	}
	if(trim(cm_form.beginTime.value)>trim(cm_form.endTime.value) || trim(cm_form.beginTime.value) == trim(cm_form.endTime.value)){
		rdShowMessageDialog("开始日期在结束日期之前",1)
		cm_form.endTime.focus();
		return false;
	}
	return true;
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

function checkTable()
{
	var beginDate;
	var endDate;
	if(trim(document.cm_form.fieldCode.value).length==0)
	{
		rdShowMessageDialog("字段号码不能为空！",1)
		cm_form.fieldCode.focus();
		return false;
 	}
	if(trim(document.cm_form.fieldCode.value).length!=5)
	{
     	rdShowMessageDialog("字段号码为五位！",1)
     	cm_form.fieldCode.focus();
     	return false;
 	}
	if(trim(document.cm_form.fieldName.value).length==0)
	{
		rdShowMessageDialog("服务名称不能为空！",1)
		cm_form.fieldName.focus();
		return false;
	}
	if(trim(document.cm_form.fieldPurpose.value).length==0)
	{
		rdShowMessageDialog("字段用途不能为空！",1)
		cm_form.fieldPurpose.focus();
		return false;
	}
 	return true;
}
//分页3
 function doLoad(operateCode)
 {
    if(operateCode=="load")
    {
      window.cm_form.page.value="";
    }
    else if(operateCode=="first")
    {
      window.cm_form.page.value=1;
    }
    else if(operateCode=="pre")
    {
      window.cm_form.page.value=<%=(curPage-1)%>;
    }
    else if(operateCode=="next")
    {
      window.cm_form.page.value=<%=(curPage+1)%>;
    }
    else if(operateCode=="last")
    {
      window.cm_form.page.value=<%=pageCount%>;
    }
      window.cm_form.myaction.value="doLoad";
      window.cm_form.action="getFieldCode.jsp?action=fanye&busiType=<%=busiType%>";
      window.cm_form.method='post';
      window.cm_form.submit();
 }



function doSelectAll()
{
	var form = document.cm_form ;
	var p = 0;
	var ilength = parseInt(form.chkBoxNum.value);
	for (i=0; i<ilength;i++ )
	{
		if (eval('form.ChkBoxDelete_'+i).checked == true)
		{
		  p = p +1;
		}
	}
	if (p==ilength)
	{
		for (i=0; i<ilength;i++ )
		{
		   eval('form.ChkBoxDelete_'+i).checked = false ;
		}
	}
	else
	{
		for (i=0; i<ilength;i++ )
		{
		   eval('form.ChkBoxDelete_'+i).checked = true ;
		}
	}	
}
function doDelete( )
{
	var form = document.cm_form ;
	var ilength = parseInt(form.chkBoxNum.value);
	var szIdList="";
	var p=0;
	
	for(i=0;i<ilength;i++)
	{
		if(eval('form.ChkBoxDelete_'+i).checked)
		{
		  szIdList=szIdList+"'"+eval('form.ChkBoxDelete_'+i).value+"';";
		  p++;
		}
	}
	
	if(p<=0)
	{
		rdShowMessageDialog("请选择要删除的记录！",1)
		return;
	}
	
	szIdList=szIdList.substring(0,szIdList.length-1);
	
	if(confirm('是否删除？'))
	location.href='s3520.jsp?action=del_sm&fieldCode='+szIdList;

}
function submitInputAdd(url){
	if(checkTable())
	{
		submitMe(url);
	}
	else return;
}
function submitInput(url)
{
    submitMe(url);
}
function submitMe(url)
{
    if(url.substring(url.length-8)=="add_user")
    {
          window.cm_form.action=url;
          window.cm_form.method='post';
          window.cm_form.submit();
    }
    else{
          window.cm_form.action=url;
          window.cm_form.method='post';
          window.cm_form.submit();
    }


}
function changeServiceName(){
	document.all.serviceName.value=document.all.cmType.value;
}

function clearForm()
{
	var e = document.forms[0].elements;
	for(var i=0;i<e.length;i++)
	{
  		if(e[i].type=="select-one"||e[i].type=="text")
		E[i].value="";
	}
}


</SCRIPT>

</HEAD>
<BODY>
<FORM  id="cm_form" name="cm_form" method="post" >
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi"> 用户附加字段代码表 </div>
	</div>
	<table cellspacing="0">
           <tr>
               <td class = "blue">业务类型：</td>
               <!--<td colspan=3>
               	  <SELECT name="busiType" id="busiType">
               	  	<option value="1000" <%=(busiType!=null&&busiType.equals("1000"))?"selected":""%>>1000--IDC业务</option>
               	  </SELECT>
			   </td>-->			   
			   <td colspan=3>               
               	  <SELECT name="busiType" id="busiType">
    	             	<% for(int i = 0; i < len1; i++){
    	             	    if(rows1[i][0].trim().equals(busiType)){%>
    	               	 	<option value="<%=rows1[i][0].trim()%>"><%=rows1[i][0].trim()%>&nbsp;-&gt&nbsp;<%=rows1[i][1].trim()%></option>
						<%}
						}%>
				</select>
			   </td>
           <tr>
               <td class = "blue">字段代码</td>
               <td>
                  <input name="fieldCode" type="text" class="button" id="fieldCode"  maxlength="5"  value="<%=(fieldCode==null)?"":fieldCode%>" >
               </td>
               <td class = "blue">字段代码名称</td>
               <td>
                  <input name="fieldName" type="text" class="button" id="fieldName" maxlength="20" value="<%=(fieldName==null)?"":fieldName%>" >
			   </td>
           </tr>
           <tr>
		   <td class = "blue">字段用途</td>
               <td>
				  <select name="fieldPurpose">
				    <option></option>
					<option value="10" <%=(fieldPurpose!=null&&fieldPurpose.equals("10"))?"selected":""%>>费用代码</option>
					<option value="11" <%=(fieldPurpose!=null&&fieldPurpose.equals("11"))?"selected":""%>>其它</option>
				  </select>
			   </td>
             <td class = "blue">字段类型</td>
             <td>
				<select name="fieldType">
					<option></option>
					<option value="10" <%=(fieldType!=null&&fieldType.equals("10"))?"selected":""%>>整型</option>
					<option value="11" <%=(fieldType!=null&&fieldType.equals("11"))?"selected":""%>>浮点型</option>
					<option value="12" <%=(fieldType!=null&&fieldType.equals("12"))?"selected":""%>>字符型</option>
					<option value="13" <%=(fieldType!=null&&fieldType.equals("13"))?"selected":""%>>金额'XXXX.YY'</option>
					<option value="14" <%=(fieldType!=null&&fieldType.equals("14"))?"selected":""%>>日期型'YYYYMMDD'</option>
					<option value="15" <%=(fieldType!=null&&fieldType.equals("15"))?"selected":""%>>日期型'YYYYMMDD HH24:MI:SS'</option>
				</select>
			 </td>
           </tr>
		   <tr>
				<td class = "blue">字段最大长度</td>
				<td>
					<input name="fieldLength" type="text" class="button" id="fieldLength" maxlength="8" value="<%=(fieldLength==null)?"":fieldLength%>" >
				</td>
				<td class = "blue">字段备注说明</td>
				<td>
                  <input name="fieldNote" type="text" class="button" id="fieldNote"  maxlength="225"  value="<%=(fieldNote==null)?"":fieldNote%>" colspan="3">
               </td>
           </tr>
	</TABLE>

		<TABLE cellSpacing="0" >
			<TR id='footer'>
				<TD id="footer" align="center">          	                    	           	              	                          	
        	        <input name="que_user" class="b_foot" type="button" id="que_user"    onClick="submitInput('getFieldCode.jsp?action=que_user&busiType ='+ busiType)" value="查询">
					<input name="goBack" class="b_foot" type="button" id="goBack"   onClick="javascript:window.close()" value="返回">				
			    </td>
			</tr>
        	     <%if ("add_user".equals(action)&& bUserExist){%>
                	<SCRIPT LANGUAGE=javascript>alert("该品牌已经存在!")</SCRIPT>
                <%}%>        	        
       </table>
       
              
		<table cellspacing="0">
			<input type="hidden" name="chkBoxNum"  value="<%=list.size()%>">
			<tr>
			    <TH nowrap align="center"><div>&nbsp;</div></TH>
				<TH nowrap align="center"><div>字段代码</div></TH>
				<TH nowrap align="center"><div>字段代码名称</div></TH>
				<TH nowrap align="center"><div>字段用途</div></TH>
				<TH nowrap align="center"><div>字段类型</div></TH>
				<TH nowrap align="center"><div>字段最大长度</div></TH>
				<TH nowrap align="center"><div>字段备注说明</div></TH>                     
			</tr>
       <% for (int i=0;i<list.size();i++) { %>
					<% String[] array = (String[]) list.get(i);
					   String arr4 ="";
					   String arr2="";
					   if (array[3].equals("10"))
						   arr4="整型";
					   if (array[3].equals("11"))
						   arr4="浮点型";
					   if (array[3].equals("12"))
						   arr4="字符型";
					   if (array[3].equals("13"))
						   arr4="金额";
					   if (array[3].equals("14"))
						   arr4="日期型";
					   if (array[3].equals("15"))
						   arr4="日期时间型";
					   if (array[2].equals("10"))
						   arr2="费用代码";
					   if (array[2].equals("11"))
						   arr2="其它";

					%>
                      <%if((i+1)%2==1){%>
                          <tr bgcolor="F5F5F5" height="20">
		      <%}else{%>
			  <tr>    
		      <%}%>
		             <td align="center" class="listformtext"><input type='radio' id='priceRadio' name='priceRadio' onClick="javascript:selectPriceCode('<%=array[0]%>')" /></td>
                     <td align="center" class="listformtext"><%=array[0]%></td>
					 <td align="center" class="listformtext"  height="20"> <%=array[1]%> </td>
					 <td align="center" class="listformtext"  height="20"> <%=arr2%> </td>
                     <td align="center" class="listformtext"  height="20"> <%=arr4%> </td>
                     <td align="center" class="listformtext"  height="20"><%=array[4]%></td>
                     <td align="center" class="listformtext"  height="20"><%=(array[5]==null)?"":array[5]%></td>            
                   </tr>
                   <% } %>
        </table>
        			
				<table cellspacing="0" align="center"	>
					<input type="hidden" name="page" value="">
					<input type="hidden" name="myaction" value="">
					<tr>
            
						<td class="listformbottom"  height="35" align="right" width="450">
            			  <%if(pageCount!=0){%>
            			  第 <%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
            			  <%} else{%>
            			  <font color="red">当前记录为空！</font>
            			  <%}%>
            			  <%if(pageCount!=1 && pageCount!=0){%>
            			  <a href="#" onClick="doLoad('first');return false;">首页</a>
            			  <%}%>
            			  <%if(curPage>1){%>
            			  <a href="#" onClick="doLoad('pre');return false;">上一页</a>
            			  <%}%>
            			  <%if(curPage<pageCount){%>
            			  <a href="#" onClick="doLoad('next');return false;">下一页</a>
            			  <%}%>
            			  <%if(pageCount>1){%>
            			  <a href="#" onClick="doLoad('last');return false;">尾页</a>
            			  <%}%>
            			</td>

    				</tr>
  				</table>
		
	<%@ include file="/npage/include/footer_pop.jsp" %>  
   </FORM>
  </BODY>
 </HTML>
