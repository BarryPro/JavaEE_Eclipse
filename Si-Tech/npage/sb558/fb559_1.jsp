<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String opCode = "b559";
	String opName = "局数据记录查询";
	String workNo = (String)session.getAttribute("workNo");
  String workName = (String)session.getAttribute("workName");
  String regionCode=(String)session.getAttribute("regCode");
%>
<HTML>
	<HEAD>
		<TITLE>局数据记录查询</TITLE>
		<%
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
			function checknum(fData)
			{
				if(fData == "")
					return false;
				if ((isNaN(fData)) || (fData.indexOf(".")!=-1) || (fData.indexOf("-")!=-1))
					return false;
				return true;
			}
			function CheckIsDate(value)   
			{   
			  var   strValue     =   new   String();       
			  var   year   =   new   String();   
			  var   month   =   new   String();   
			  var   day   =   new   String();   
			  strValue   =   value;
			  year   =   strValue.substr(0,4);   
			  month   =   strValue.substr(4,2);   
			  month   =   month-1;     
			  day   =   strValue.substr(6,2);   
			  var   testDate   =   new   Date(year,month,day); 
			  return     (year   ==   testDate.getFullYear())   &&   (month   ==testDate.getMonth())&&(day   ==   testDate.getDate());   
			}
			function doCheck()
			{
				if(document.frmb559.spno.value!="")
				{
					if(!checknum(document.frmb559.spno.value))
					{
						rdShowMessageDialog("SP代码请输入数字！",0);
	        	return false;
					}
				}
				if(document.frmb559.validdate.value!="")
				{
					if(!checknum(document.frmb559.validdate.value))
					{
						rdShowMessageDialog("请输入合法的生效日期！",0);
	        	return false;
					}
				}
				if(document.frmb559.expiredate.value!="")
				{
					if(!checknum(document.frmb559.expiredate.value))
					{
						rdShowMessageDialog("请输入合法的失效日期！",0);
	        	return false;
					}
				}
				if (document.frmb559.searchType.selectedIndex == 0)
				{
					if(document.frmb559.provcode.value!="")
					{
						if(!checknum(document.frmb559.provcode.value))
						{
							rdShowMessageDialog("接入省代码请输入数字！",0);
		        	return false;
						}
					}
					if(document.frmb559.balprov.value!="")
					{
						if(!checknum(document.frmb559.balprov.value))
						{
							rdShowMessageDialog("结算省代码请输入数字！",0);
		        	return false;
						}
					}
					if(document.frmb559.devcode.value!="")
					{
						if(!checknum(document.frmb559.devcode.value))
						{
							rdShowMessageDialog("结算省代码请输入数字！",0);
		        	return false;
						}
					}
					if(document.frmb559.pagecount.value=="")
					{
						document.frmb559.pagecount.value=20;
					}
					else
					{
						if(!checknum(document.frmb559.pagecount.value))
						{
							document.frmb559.pagecount.value=20;
						}
						if(document.frmb559.pagecount.value<20)
						{
							document.frmb559.pagecount.value=20;
						}
					}
				}
				else
				{
					if(document.frmb559.infofee.value!="")
					{
						if(!checknum(document.frmb559.infofee.value))
						{
							rdShowMessageDialog("信息费请输入数字！",0);
		        	return false;
						}
					}
				}
				var oButton = document.getElementById("queryButton"); 
				oButton.disabled = true; 
				if (document.frmb559.searchType.selectedIndex == 0)
				{
					document.frmb559.action="fb559_2.jsp"
					frmb559.submit();
				}
				else
				{
					document.frmb559.action="fb559_3.jsp"
					frmb559.submit();
				}
			}
			function typechange() 
			{
        if (document.frmb559.searchType.selectedIndex == 0) {
            IList1.style.display = "";
            IList2.style.display = "none";
        } else {
            IList1.style.display = "none";
            IList2.style.display = "";
        }
    	}
		</SCRIPT>
		<FORM method=post name="frmb559">
		<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">局数据导入记录查询</div>
			</div>
			<TABLE cellSpacing="0">
				<TR>
					<TD class="blue" width=30%>查询类型</TD>
            <TD>
                <select name="searchType" onchange="typechange()">
                    <option value="0" selected>SP企业局数据</option>
                    <option value="1">SP业务局数据</option>
                </select>
            </TD>
				</TR>
				<TR>
        	<TD class="blue">局数据类型</TD>
            <TD>
                <select name="dsmpType">
                	<option value="0" selected></option>
                	<wtc:qoption name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
                		<wtc:sql>
											select servtype,servname from sdsmpservtype order by servtype
										</wtc:sql>
                	</wtc:qoption>  
                </select>
            </TD>
        </TR>
        <TR>
        	<td  class="blue">导入文件名</td>
					<TD>
          	<input type="text" name="filename" size="20" maxlength="20">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">操作类型</td>
					<TD>
          	<select name="optype">
                    <option value="0" selected></option>
                    <option value="1">新增</option>
                    <option value="2">修改</option>
                    <option value="3">删除</option>
            </select>
          </TD>
        </TR>
        <TR>
        	<td  class="blue">SP企业代码</td>
					<TD>
          	<input type="text" name="spno" size="20" maxlength="20">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">生效日期</td>
					<TD>
          	<input type="text" name="validdate" size="10" maxlength="8">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">失效日期</td>
					<TD>
          	<input type="text" name="expiredate" size="10" maxlength="8">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">每页显示条数</td>
					<TD>
          	<input type="text" name="pagecount" size="10" maxlength="8" value="20">
          </TD>
        </TR>
      </TABLE>
      <TABLE cellSpacing="0" style="display:''" id="IList1">
        <TR>
        	<td  class="blue" width=30%>SP企业名称</td>
					<TD>
          	<input type="text" name="spname" size="20" maxlength="64">
          </TD>
        </TR>
        <TR>
					<TD class="blue" >SP类型</TD>
            <TD>
                <select name="spType">
                    <option value="0" selected></option>
                    <option value="1">普通SP</option>
                    <option value="2">自有SP</option>
                </select>
            </TD>
				</TR>
				<TR>
        <TR>
        	<td  class="blue" >接入省代码</td>
					<TD>
          	<input type="text" name="provcode" size="20" maxlength="3">
          </TD>
        </TR>
         <TR>
        	<td  class="blue" >结算省代码</td>
					<TD>
          	<input type="text" name="balprov" size="20" maxlength="3">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">平台代码</td>
					<TD>
          	<input type="text" name="devcode" size="20" maxlength="21">
          </TD>
        </TR>
			</TABLE>
			<TABLE cellSpacing="0" style="display:none" id="IList2">
				<TR>
        	<td  class="blue" width=30%>业务代码</td>
					<TD>
          	<input type="text" name="bizno" size="20" maxlength="21">
          </TD>
        </TR>
        	<TR>
        	<td  class="blue">业务产品名称</td>
					<TD>
          	<input type="text" name="bizname" size="20" maxlength="64">
          </TD>
        </TR>
        <TR>
					<TD class="blue" >计费类型</TD>
            <TD>
                <select name="bizType">
                    <option value="0" selected></option>
                    <option value="1">免费</option>
                    <option value="2">按条/按次</option>
                    <option value="3">包次</option>
                    <option value="4">包月</option>
                    <option value="5">包天</option>
                    <option value="6">按栏目</option>
                    <option value="7">时长</option>
                </select>
            </TD>
				</TR>
				<TR>
        	<td  class="blue">信息费</td>
					<TD>
          	<input type="text" name="infofee" size="20" maxlength="12">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">结入方比例</td>
					<TD>
          	<input type="text" name="balprop" size="20" maxlength="16">
          </TD>
        </TR>
        <TR>
					<TD class="blue" >二次确认标示</TD>
            <TD>
                <select name="reconfirm">
                    <option value="0" selected></option>
                    <option value="1">不需要</option>
                    <option value="2">需要</option>
                </select>
            </TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0">
				<tr> 
	        <td id="footer"> 
	           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doCheck()">&nbsp;
	           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="document.frmb559.reset();typechange()">&nbsp;
	           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="parent.removeTab('<%=opCode%>')">&nbsp;
	        </td>
		     </tr>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
