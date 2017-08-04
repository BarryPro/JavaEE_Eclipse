
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
<%@ page import="sitech.www.frame.jdbc.SqlQuery" %>
<%@ page import="java.util.List"%>
<!--<%@ page import="java.util.Vector" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>-->

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
    int pageSize =10;            // Rows each page
    int pageCount;               // Number of all pages
    int curPage;                 // Current page
    //需要参数传递
    int beginPos;                 // Begin Position
    int endPos;                   // End Position
    String strPage;               // Transfered pages

    PrdMgrSql PriceCodeSql = new PrdMgrSql();
    String action = request.getParameter("myaction");
    
    //取省份代码
    String province_run=null;
    province_run = PriceCodeSql.functionBindOne("select agent_prov_code from sProvinceCode where run_flag='Y'");
%>

<%
try {
    //===================================================================
    // SEARCH
    //===================================================================
    if ("doLoad".equals(action)) {
        modeType=  request.getParameter("modeType");//模式代码
        typeName=  request.getParameter("typeName");//模式名称
        if( modeType.length() != 0 )
        {
            sSqlCondition = sSqlCondition+"and a.user_type like '%"+modeType+"%'";
        }

        if( typeName.length() != 0 )
        {
            if(province_run.equals("16"))
            {
            	sSqlCondition = sSqlCondition+"and b.attr_name like '%"+typeName+"%'";
            }
            else
            {
            	sSqlCondition = sSqlCondition+"and b.type_name like '%"+typeName+"%'";
            }
        }
		
		if(province_run.equals("16"))
    	{
			sqlStr = "select a.user_type, b.attr_name from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr and a.group_flag = 'N' "+sSqlCondition+" order by a.product_attrcode";
		}
		else
		{
			sqlStr = "select a.user_type, b.type_name from sSmSelPAttr a, sBillModeType b where a.user_type = b.mode_type and a.group_flag = 'N' and b.region_code='"+regionCode+"'"+sSqlCondition+" order by a.user_type";
		}
        search_flag = 2;
    }


    if(search_flag == 1){
    // SHOW ALL THE CONTENTS OF THE TABLE
    // ITINIALIZATION, ENTER; ADD, DELETE
    	if(province_run.equals("16"))
    	{
        	rowCount = PriceCodeSql.functionBindOneInt ("select count(*) from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr and a.group_flag = 'N'");
        }
        else
        {
        	rowCount = PriceCodeSql.functionBindOneInt ("select count(*) from sSmSelPAttr a, sBillModeType b where a.user_type = b.mode_type and a.group_flag = 'N' and b.region_code='"+regionCode+"'");
        }
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
        PageVo pv=null;
        if(province_run.equals("16"))
    	{
       		pv = PriceCodeSql.queryBindPageVo("select a.user_type, b.attr_name from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr and a.group_flag = 'N' order by a.product_attrcode", beginPos, endPos);
        }
        else
        {
        	pv = PriceCodeSql.queryBindPageVo("select a.user_type, b.type_name from sSmSelPAttr a, sBillModeType b where a.user_type = b.mode_type and a.group_flag = 'N' and b.region_code='"+regionCode+"' order by a.product_attrcode", beginPos, endPos);
        }
        list = pv.getList();

    }
    else {
    // ENTER BY CLICKING SEARCH, PAGEDOWN BUTTON
		search_flag = 2;
		if(province_run.equals("16"))
    	{
        	rowCount = PriceCodeSql.functionBindOneInt ("select count(*) from sSmSelPAttr a, sProductAttrCode b where a.product_attrcode = b.product_attr and a.group_flag = 'N' "+sSqlCondition);
        }
        else
        {
        	rowCount = PriceCodeSql.functionBindOneInt ("select count(*) from sSmSelPAttr a, sBillModeType b where a.user_type = b.mode_type and a.group_flag = 'N' and b.region_code='"+regionCode+"'"+sSqlCondition);
        }
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
function doLoad(operateCode)
{
   if(operateCode=="load")
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
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="getUserType.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}
//==============================================================================
// DELETE
//==============================================================================
function doDelete( )
{
	var form = document.sitechform ;
  	var ilength = parseInt(form.chkBoxNum.value);
  	var szIdList="";
  	var p=0;

  	for(i=0;i<ilength;i++)
  	{
            if (eval('form.ChkBoxDelete_'+i).checked)
             {
      		szIdList=szIdList+"'"+eval('form.ChkBoxDelete_'+i).value+"',";
      		p++;
             }
         }

	if(p<=0)
    {
        	rdShowMessageDialog("请选择要删除的记录！",1)
    		return;
  	}

  	szIdList=szIdList.substring(0,szIdList.length-1);

	//alert(szIdList);
	if(confirm('是否删除？'))
        	location.href='getUserType.jsp?myaction=del_price&price_code='+szIdList;
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
	window.dialogArguments.sp_form.userType.value=modeType;
	window.close();
}
</SCRIPT>
</HEAD>

<BODY>
<FORM  id="sitechform" name="sitechform" method="post" >
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi"> 用户类型查询 </div>
	</div>

      <table cellspacing="0" >
        <!-- THE FIRST LINE OF THE CONTENT -->
        <tr>
          <td class = "blue"> 模式代码 </td>
          <td >
             <input name="modeType" type="text" maxlength="4" value=<%=(search_flag==1)?"":modeType%>>
             </td>
          <td class = "blue"> 模式名称 </td>
          <td>
             <input name="typeName" type="text" maxlength="20" value=<%=(search_flag==1)?"":typeName%>>
          </td>
        </tr>
        <tr>
      </table>
      
      <TABLE cellSpacing="0" >
			<TR id='footer'>
				<TD id="footer" align="center">          	                    	           	              	                          	
        	        <input name="search" type="button" class="b_foot" id="search" value="查询" onClick="doLoad('load');return false;">
            		<input name="back" onClick="window.close()" type="button" class="b_foot" value="返回">
			    </td>
			</tr>
       </table>
          
      <table cellspacing="0">
			<input type="hidden" name="chkBoxNum"  value="<%=list.size()%>">
			<tr>
				<TH class="blue" align="center"><div>模式代码</div></TH>
				<TH class="blue" align="center"><div>模式名称</div></TH>
           </tr>
                <% for ( int i = 0; i < list.size(); i++ ) {
                      String[] array = (String[]) list.get(i);
		      
						   if (i%2==0){%>
                          
						  <tr>
		      
						  <%} else{%>
		          
						  <tr>
		      
						  <%}
                 
				%>
                
             <td align="center" >
				<a href="javascript:selectPriceCode('<%=array[0]%>','<%=array[1]%>')"><%=array[0]%></a>
             </td>
             <td align="center"><%=array[1]%></td>
           </tr>
                <% } %>
		</table>
        <!--------------------- PgUP&PgDn BUTTON IN THE BUTTOM OF THE LIST ---------------------->
            <TABLE cellspacing="0" align="center" 	>
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
            </TABLE>
	<%@ include file="/npage/include/footer_pop.jsp" %>  
</FORM>
</BODY>
</base>
</HTML>
