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
<%if ((request.getCharacterEncoding() == null))
      {request.setCharacterEncoding("GBK");}%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.channelmng.PrdMgrSql" %>
<%@ page import="sitech.www.frame.jdbc.PageVo" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>

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
	    
	//进行工号权限检验
%>

<%
  	String sqlStr     = "";

    int success_flag = -1;
    int search_flag = 1;

    String sSqlCondition="";
    Vector vTemp = null;
    boolean  codeExist = false;
    List list = null;
    int Temp ;

	String modeType       =  "";
    String typeName       =  "";
    int rowCount ;
    int pageSize =20;            // Rows each page
    int pageCount;               // Number of all pages
    int curPage;                 // Current page
    //需要参数传递
    int beginPos;                 // Begin Position
    int endPos;                   // End Position
    String strPage;               // Transfered pages
    
    String userType = request.getParameter("userType");  
      
    PrdMgrSql PriceCodeSql = new PrdMgrSql();
    String action = request.getParameter("myaction");
    

%>

<%
try {
    //===================================================================
    // SEARCH
    //===================================================================

    
   
    if ("dofind".equals(action)) {
       
        modeType=  request.getParameter("modeType");
        typeName=  request.getParameter("typeName"); 
             
        if( modeType.length() != 0 )
        {
            sSqlCondition = sSqlCondition+"and field_grp_no like '%"+modeType+"%'";
        }

        if( typeName.length() != 0 )
        {
            sSqlCondition = sSqlCondition+"and field_grp_name like '%"+typeName+"%'";
        }
           		
		   sqlStr = "select field_grp_no,field_grp_name from sUserTypeGroup where 1=1 "+sSqlCondition+" and user_type = '"+userType+"'"; 
		   sqlStr = sqlStr + " union select 0,'默认组' from dual";
		   sqlStr = sqlStr + " order by field_grp_no";
		  
		      
        search_flag = 2;
    }


   
    
    if(search_flag == 1){
    // SHOW ALL THE CONTENTS OF THE TABLE
    // ITINIALIZATION, ENTER; ADD, DELETE
        rowCount = PriceCodeSql.functionBindOneInt ("select count(*) from ( select field_grp_no from sUserTypeGroup where user_type = '"+userType+"' union select 0 from dual)" );
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }
        else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        beginPos = ( curPage - 1 ) * pageSize + 1;
        endPos = beginPos + pageSize - 1;
        if ( endPos > rowCount ) endPos = rowCount;
        PageVo pv = PriceCodeSql.queryBindPageVo("select field_grp_no,field_grp_name from sUserTypeGroup where 1=1 "+sSqlCondition+" and user_type = '"+userType+"'"+" union select 0,'默认组' from dual order by field_grp_no", beginPos, endPos);
        list = pv.getList();

    }
    else {
    // ENTER BY CLICKING SEARCH, PAGEDOWN BUTTON
		search_flag = 2;
        rowCount = PriceCodeSql.functionBindOneInt ("select count(*) from (select field_grp_no from sUserTypeGroup where 1=1 "+sSqlCondition+" and user_type = '"+userType+"' union select 0 from dual)" );
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ){
          	curPage = 1;
        }
        else{
            curPage = Integer.parseInt(strPage);
         	 if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        beginPos = ( curPage - 1 ) * pageSize + 1;
        endPos = beginPos + pageSize - 1;
        if( endPos > rowCount ) endPos = rowCount;

        //条件查询
        PageVo pv2=PriceCodeSql.queryBindPageVo(sqlStr,beginPos,endPos);
        list = pv2.getList();
    }

}
catch (Exception ex) {
    throw new Exception(sqlStr+"Operation Error! Background Error Message is "+ex);
}
%>
<base target="_self">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<TITLE><%=opName%></TITLE> 
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>
 
//===============================================================
// CHECK THE INPUT, MAKE SURE IT IS ALL NUMBER.
//===============================================================
function isnumber(str)
{
	var number_chars = "1234567890";
	var i;
	for (i=0;i<str.length;i++)
	{
		if (number_chars.indexOf(str.charAt(i))==-1) return false;
	}
	return true;
}
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInputAdd(url){
    submitMe(url);
}
function submitMe(url){
    window.sitechform.action=url;
    window.sitechform.method='post';
    window.sitechform.submit();
}
//=========================================================================
// LOAD PAGES.
//=========================================================================
function dofind(operateCode)
{
   if(operateCode=="find")
   { 
   	window.sitechform.page.value=""; 
   }
   else if(operateCode=="first")
   {
   	window.sitechform.page.value=1;
   }
   else if(operateCode=="pre")
   {
   	window.sitechform.page.value=<%=(curPage-1)%>;
   }
   else if(operateCode=="next")
   {
   	window.sitechform.page.value=<%=(curPage+1)%>;
   }
   else if(operateCode=="last")
   {
   	window.sitechform.page.value=<%=pageCount%>;
   }
   window.sitechform.myaction.value="dofind";
   window.sitechform.action="getGrp_No.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

//===============================================================================
// SELECT ALL THE ROWS IN THE LIST
//===============================================================================
function doSelectAll()
{
    var form = document.sitechform ;
    var p = 0;
    var ilength = parseInt(form.chkBoxNum.value);
    for ( i = 0; i < ilength;i++ )
    {
    	if ( eval('form.ChkBoxDelete_'+i).checked == true)
    	{
           p = p +1;
    	}
    }
    if ( p == ilength )
    {
    	for ( i = 0 ; i < ilength; i++ )
    	{
            eval ( 'form.ChkBoxDelete_' + i ).checked = false ;
     	}
    }
    else
    {
    	for ( i=0; i < ilength; i++ )
    	{
     		eval('form.ChkBoxDelete_'+i).checked = true ;
    	}
    }
}
//=============================================================================
// TRIM THE INPUT VALUE
//=============================================================================
  	 function trim(arg)
    {
  	 	if( arg.length == 0)
  	 	{
     		return ' ';
  	 	}

   		//  Positioning the first unblank
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
     		return ' ';
   		}

    	// Find the first unblank position
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

function selectPriceCode(modeType,typeName)
{
	window.dialogArguments.sp_form.grpCode.value=modeType;
	window.close();
}
</SCRIPT>
</HEAD>
<BODY>
<FORM  id="sitechform" name="sitechform" method="post" >
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi"> 查询表单组号 </div>
	</div>

      <!------------------------------------------------------------------------------------->
      <!------------------------- THE CONTENT OF THE PROGRAM -------------------------------->
      <!------------------------------------------------------------------------------------->
		<table cellspacing="0" >
        <!-- THE FIRST LINE OF THE CONTENT -->
			<tr>
        	  <td class = "blue"> 表单组号 </td>
        	  <td>
        	     <input name="modeType" type="text" maxlength="5" value=<%=(search_flag==1)?"":modeType%>>
        	     </td>
        	  <td class = "blue"> 组号名称 </td>
        	  <td>
        	     <input name="typeName" type="text" maxlength="20" value=<%=(search_flag==1)?"":typeName%>>
        	  </td>
			</tr>
		</table>
		<TABLE cellSpacing="0" >
			<TR id='footer'>
				<TD id="footer" align="center">          	                    	           	              	                          	
        	        <input name="search" type="button" class="b_foot" id="search" value="查询" onClick="dofind('find');return false;">
            		<input name="back" onClick="window.close()" type="button" class="b_foot" value="返回">
			    </td>
			</tr>
       </table>
      
        <!----------------------------------------------------------------------------------------->
        <!----------------------------------------- LIST ------------------------------------------>
	<!----------------------------------------------------------------------------------------->
		<table cellspacing="0">
              <input type="hidden" name="chkBoxNum"  value="<%=list.size()%>">
              <tr>
                <TH nowrap align="center"><div>&nbsp;</div></TH>
				<TH nowrap align="center"><div>表单组号</div></TH>
				<TH nowrap align="center"><div>组号名称</div></TH>
           	  </tr>
           	  
                <% for ( int i = 0; i < list.size(); i++ ) {
                      String[] array = (String[]) list.get(i);
		      
						   if (i%2==0){%>
                          
						  <tr>
		      
						  <%} else{%>
		          
						  <tr>
		      
						  <%}
                 
				%>
                  <td align="center"><input type='radio' id='priceRadio' name='priceRadio' onClick="javascript:selectPriceCode('<%=array[0]%>','<%=array[1]%>')"></td>
                  <td align="center"><%=array[0]%></td>
                  <td align="center"><%=array[1]%></td>
                </tr>
                <% } %>
            </table>
        <!--------------------- PgUP&PgDn BUTTON IN THE BUTTOM OF THE LIST ---------------------->

            <table cellspacing="0">
              <tr>
			  	<input type="hidden" name="page" value="">
		      	<input type="hidden" name="myaction" value="">
                <td class="listformbottom"  height="35" align="right" width="450">
                  <%if(pageCount!=0){%>
                  第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
                  <%} else{%>
                  <font color="red">当前记录为空！</font>
                  <%}%>
                  <%if(pageCount!=1 && pageCount!=0){%>
                  <a href="#" onClick="dofind('first');return false;">首页</a>
                  <%}%>
                  <%if(curPage>1){%>
                  <a href="#" onClick="dofind('pre');return false;">上一页</a>
                  <%}%>
                  <%if(curPage<pageCount){%>
                  <a href="#" onClick="dofind('next');return false;">下一页</a>
                  <%}%>
                  <%if(pageCount>1){%>
                  <a href="#" onClick="dofind('last');return false;">尾页</a>
                  <%}%>
                </td>
              </tr>
            </table>
            
      <%@ include file="/npage/include/footer_pop.jsp" %>  

</FORM>
</BODY>
</base>
</HTML>
