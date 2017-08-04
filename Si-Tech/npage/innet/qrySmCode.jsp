<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.25
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>




<%if ((request.getCharacterEncoding() == null))
	  {request.setCharacterEncoding("gb2312");}%>


<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); //定义session
	//String[][] baseInfoSession = (String[][])arrSession.get(0);
	//String[][] otherInfoSession = (String[][])arrSession.get(2);
	//String[][] pass = (String[][])arrSession.get(4);
	
	//String loginNo = baseInfoSession[0][2];  //取login_no
	//String loginName = baseInfoSession[0][3]; //取login_name
	//String powerCode= otherInfoSession[0][4];
	String opCode = "1104";
    String opName = "普通开户";
	String powerCode = (String)session.getAttribute("powerCode");
	//String orgCode = baseInfoSession[0][16];
	String orgCode = (String)session.getAttribute("orgCode");
	String ip_Addr = request.getRemoteAddr();
	
	String regionCode = orgCode.substring(0,2);
	//String regionName = otherInfoSession[0][5];
	//String loginNoPass = pass[0][0];
	
	List sqlList = new ArrayList();
		
	String sSqlCondition=null;
	String sqlStr = "";

    ArrayList retArray = new ArrayList();
    //String[][] qryResult = new String[][]{};
 	//SPubCallSvrImpl callView = new SPubCallSvrImpl();

	String modeType = request.getParameter("modeType");
	String smCode = request.getParameter("smCode");
	String modeCode = request.getParameter("modeCode");
	String modeName = request.getParameter("modeName");
	String serviceFlag ="";   
	 //add by  liutong @20080825
	if (modeType != null)
	{
		if(modeType.trim().length()!=0)
		{
			sSqlCondition="and a.mode_type = '"+modeType+"'";
		}

		if (smCode != null)
		{
			if(smCode.trim().length()!=0)
			{
				sSqlCondition=sSqlCondition+" and a.sm_code = '"+smCode+"'";
			}
		}		

		if (modeCode != null)
		{
			if(modeCode.trim().length()!=0)
			{
				sSqlCondition=sSqlCondition+" and a.mode_code = '"+modeCode+"'";
			}
		}
		
		if (modeName != null)
		{
			if(modeName.trim().length()!=0)
			{
				sSqlCondition=sSqlCondition+" and a.mode_name like '%"+modeName+"%'";
			}
		}
		sqlStr = "select a.mode_code, a.mode_name, b.sm_code, b.sm_name"
				+"  from sBillModeCode a, sSmCode b"
				+" where a.sm_code = b.sm_code"
				+"   and a.region_code = b.region_code"
				+"   and a.region_code = '" + regionCode + "' ";
		if (sSqlCondition != null)
		{
			sqlStr = sqlStr +sSqlCondition+" order by a.mode_code,b.sm_code";
		}
		//System.out.println("sqlStr="+sqlStr);
		/**try
		{
			retArray = callView.sPubSelect("4",sqlStr);
			qryResult = (String[][])retArray.get(0);
		}
		catch(Exception e)
		{
			//System.out.println("查询错误!!");
		}
		**/
		
	}
	
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="qryResult" scope="end" />
	<%
	if(!retCode1.equals("000000")){
	    serviceFlag="close";
 
	}
	
%>
<%
 if(serviceFlag=="close"){
 %>
     <script language="javascript">
   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>");
   	  window.close();
   	  </script>
   	  
 <%
 }

%>
<HTML>
<HEAD>
<TITLE>品牌代码查询</TITLE>
</HEAD>

<BODY>
<FORM name="frm" method="post" action="qrySmCode.jsp">


     <%@ include file="/npage/include/header_pop.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">用户附加字段代码表</div>
		</div>  

     

		<table cellspacing="0">
		   <tr>
			   <td width="19%" class=blue>业务类型定义</td>
			   <td width="31%">
			   	  <SELECT name="modeType" id="smCode">
<%
					//String[][] modeTypes = null;
					sqlStr = "select mode_type,type_name"
							+"  from sBillModeType"
							+" where region_code = '" + regionCode + "'";
				/**	try
					{
						retArray = callView.sPubSelect("2",sqlStr);
						modeTypes = (String[][])retArray.get(0);
					}
					catch(Exception e)
					{
						//System.out.println("查询错误!!");
					}
					**/
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="modeTypes" scope="end" />
<%
					if (modeTypes != null)
					{
						for (int i = 0; i < modeTypes.length; i ++)
						{
							out.println("<option value='" + modeTypes[i][0] + "'");
							if (modeTypes[i][0].equals(modeType))
							{
								out.println(" selected");
							}
							out.println(">" + modeTypes[i][0] + "--" + modeTypes[i][1] + "</option>");
						}
					}
%>
			   	  </SELECT>
			   </td>
			   <td width="19%" class=blue>品牌代码</td>
			   <td width="31%">
				  <input name="smCode" type="text" class="button" id="smCode" maxlength="2" value="<%=(smCode==null)?"":smCode%>">
			   </td>
		   </tr>
		   <tr>
				<td class=blue>模版代码</td>
				<td>
				<input name="modeCode" type="text" class="button" id="modeCode" maxlength="8" value="<%=(modeCode==null)?"":modeCode%>">
				</td>
				<td class=blue>模版名称</td>
				<td>
				<input name="modeName" type="text" class="button" id="modeName" maxlength="20" value="<%=(modeName==null)?"":modeName%>" >
				</td>
		   </tr>
			<tr>
				<td colspan="4" id=footer>
					<div align="center">
						<input name="bQry" class="b_foot" type="submit" id="bQry" value="查询">
					</div>
				</td>
			</tr>
		</table>
	</div>
<div id="Operation_Table"> 

<div class="title">
			<div id="title_zi">查询结果</div>
		</div>  


				<table cellspacing="0">
				   <tr>
					 <th>模版代码</th>
					 <th>模版名称</td>
					 <th>品牌代码</td>
					 <th>品牌名称</td>
				   </tr>
<%
             String tbClass="";
					if (qryResult != null)
					{
						for (int i=0;i<qryResult.length;i++)
						{  if(i%2==0){
									tbClass="Grey";
								}else{
									tbClass="";
								}

							out.println("<tr class="+tbClass+">");
							out.println("<td>" + qryResult[i][0] + "</td>");
							out.println("<td>" + qryResult[i][1] + "</td>");
							out.println("<td>" + qryResult[i][2] + "</td>");
							out.println("<td>" + qryResult[i][3] + "</td>");
							out.println("</tr>");
						}
					}
%>
				</table>
 <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>
