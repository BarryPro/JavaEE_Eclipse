<%
  /*
   * 功能: 全球通开户冲正1121
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String workNo = request.getParameter("workNo");							//工号
	String phoneNo = request.getParameter("phoneNo");								//手机号
	String opCode = request.getParameter("opCode");									//操作代码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String orgCode = request.getParameter("orgCode");
	String loginPwd    = (String)session.getAttribute("password");
	String expire = "";
	// xl add for expire 处理
	String id_no="";
    String SqlStr1 = "select to_char(id_no) from dcustmsg where phone_no = :phoneNo1 ";
	String [] paraIn = new String[2];
	paraIn[0] = SqlStr1;
	paraIn[1] = "phoneNo1="+phoneNo ;
	//xl add new for 判断是否办理过2307 2308
	String count1 = "";
	String count2 = "";
	String count_sql1 = "select to_char(count(*)) from dCustCreditAdjhis where id_no = '?'  and op_code = '2308' ";
	String count_sql2 = "select to_char(count(*)) from dcustcreditadj where id_no = '?' and  EXPIRE_TIME>sysdate ";
	//new 20110914 新增加限制
	String attr_new1="";
	String attr_new2="";
	String sql_new = "select substr(attr_code,0,2),substr(attr_code,3,2) from dcustmsg  where phone_no = '"+phoneNo+"' ";
	%>
    <wtc:service name="TlsPubSelCrm"  outnum="2" >
		<wtc:param value="<%=sql_new%>"/>

	</wtc:service>
	<wtc:array id="attr_new" scope="end"/>
<%
	
	if(attr_new.length>0)
	{
	   attr_new1=attr_new[0][0];
	   attr_new2=attr_new[0][1];
	  
	}
	else
	{
		%> {rdShowMessageDialog("无此服务号码的相关信息!"); } <%
	}
	
%>

	<wtc:service name="TlsPubSelBoss" outnum="1" retmsg="msg1" retcode="code1">
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
	</wtc:service>
	<wtc:array id="result_id" scope="end"/>
	<%
	//System.out.println("ttttt "+SqlStr1);
	if(result_id.length>0)
	{
	   id_no=result_id[0][0];
	}
	else
	{
		%> {rdShowMessageDialog("无此服务号码的相关信息!"); } <%
	}
	
	String sqlStr2 ="select to_char(expire_time,'yyyymmdd') from dCustCreditAdj where id_no = '?'";
	%>
	<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
		<wtc:sql><%=count_sql1%></wtc:sql>
		<wtc:param value="<%=id_no%>"/>
		</wtc:pubselect>
	<wtc:array id="count1_new" scope="end" />
	<%
	if(count1_new.length>0)
	{
		count1=count1_new[0][0].trim();
		//System.out.println("QQQQQQQQQQQQQQQQQsql is  "+count_sql1+" and id_no is "+id_no);
	}
	%>
	<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
		<wtc:sql><%=count_sql2%></wtc:sql>
		<wtc:param value="<%=id_no%>"/>
		</wtc:pubselect>
	<wtc:array id="count2_new" scope="end" />
<%
	
	if(count2_new.length>0)
	{
		count2=count2_new[0][0].trim();
		//System.out.println("1111111111111有效期是 "+expire);
	}
%>
	<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
		<wtc:sql><%=sqlStr2%></wtc:sql>
		<wtc:param value="<%=id_no%>"/>
		</wtc:pubselect>
	<wtc:array id="result_exp" scope="end" />
	<%
	if(result_exp.length>0)
	{
		expire=result_exp[0][0].trim();
		System.out.println("1111111111111有效期是 "+expire);
	}
	 
	// xl end for expire 处理
// xl add for 先判断是否是信誉度用户 如果是则后续进行 否则不予展示后面的
	String credit_count = "0";
	String sql_credit = "select to_char(count(*)) from dcustmsg where phone_no = '?' and limit_owe >0  ";
%>
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="1" retcode="sCreditCode" retmsg="sCreditMsg">
		<wtc:sql><%=sql_credit%></wtc:sql>
		<wtc:param value="<%=phoneNo%>"/>
	</wtc:pubselect>
	<wtc:array id="sCredit" scope="end" />
	  <%//xl add for s2307Init %>
	<wtc:service name="s2307Init" routerKey="region" routerValue="<%=regionCode%>" outnum="29" retcode="retCode2307" retmsg="retMsg2307">
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=orgCode%>"/>
		</wtc:service>
	<wtc:array id="userInfo2307" scope="end"/>
		<%
		String errCode2307 = retCode2307;
		String errMsg2307 = retMsg2307;
		if(errMsg2307.equals(""))
		{
			errMsg2307 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode2307));
			if( errMsg2307.equals("null"))
			{
				errMsg2307 ="未知错误信息";
			}
		} 
		//xl end for s2307Init
	
	if(sCredit.length==0)
	{
		%><script language="JavaScript">rdShowMessageDialog("无此服务号码的相关信誉度信息!");return false;</script><%
	}
	else
	{
		// xl 将原来的上移 begin
		credit_count = sCredit[0][0];
		%><wtc:service name="s1256Init" routerKey="phone" routerValue="<%=phoneNo%>" outnum="31" retcode="retCode" retmsg="retMsg">
			
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=loginPwd%>"/>		
		<wtc:param value="<%=phoneNo%>"/>	
		<wtc:param value=" "/>
			
	</wtc:service>
	<wtc:array id="userInfo" scope="end"/>	
<%	
	if(retMsg.equals("")){
		retMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retCode));
		if( retMsg.equals("null")){
			retMsg ="未知错误信息";
		}
	} 
	if(userInfo.length==0){
%>
		var response = new AJAXPacket();
		response.data.add("backString","");
		response.data.add("flag","9");
		 
		response.data.add("errCode","<%=retCode%>");
		response.data.add("errMsg","<%=retMsg%>");
		//response.data.add("backString","");
		<%
			if(userInfo2307.length==0)
			{
				%>
					response.data.add("flag1","0");
					response.data.add("errCode2307","<%=retCode2307%>");
					response.data.add("errMsg2307","<%=retMsg2307%>");
				<%
			}
			
		%>
		
		core.ajax.receivePacket(response);
<%
	}else{
		
		String strArray = WtcUtil.createArray("userInfo",userInfo.length);

%>
		<%=strArray%>
	<%
		for(int i = 0 ; i < userInfo.length ; i ++){
	    	for(int j = 0 ; j < userInfo[i].length ; j ++){
	%>
				userInfo[<%=i%>][<%=j%>] = "<%=userInfo[i][j].trim()%>";
	<%
			}
		}
		if(userInfo2307.length > 0)
		{
			String strArray2307 = CreatePlanerArray.createArray("userInfo2307",userInfo2307.length);
			%>
			<%=strArray2307%>
			<%
			for(int i = 0 ; i < userInfo2307.length ; i ++)
			{
				for(int j = 0 ; j < userInfo2307[i].length ; j ++)
				{

					 if(j==22)
					 {
						%>
							userInfo2307[<%=i%>][<%=j%>] = "<%=expire%>";
						<%
					 }
					 else
					 {
					  %>

						userInfo2307[<%=i%>][<%=j%>] = "<%=userInfo2307[i][j].trim()%>";
					  <%
					 }
				}
			}
		}	

		
	%>
		
		var response = new AJAXPacket();
		response.data.add("backString",userInfo);
		response.data.add("errCode","<%=retCode%>");
		response.data.add("errMsg","<%=retMsg%>");
		response.data.add("flag","0");
		<%
			if(credit_count == "0"  ||credit_count.equals("0"))
			{
				%>response.data.add("show_flag","0");<%
			}
			else
			{
				%>response.data.add("show_flag","1");<%
			}	
			// xl add for 2307
			if(userInfo2307.length > 0)
			{
				%>
					response.data.add("backString2307",userInfo2307);
					response.data.add("errCode2307","<%=errCode2307%>");
					response.data.add("errMsg2307","<%=errMsg2307%>");
					response.data.add("flag1","0");
				<%
			
			// xl end for 2307
				//xl add new for e068Cfm begin
				String sql_init = "select CREDIT_DETAIL_CODE,to_char(LIMIT_GRADE),CREDIT_EXPIRE,CONTACT_PERSON,CONTACT_PHONE,MANAGER_NAME,MANAGER_PHONE from wcreditcfgopr where phone_no = '?' "; //phoneNo
				%>
				<wtc:pubselect name="TlsPubSelBoss"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="7" retcode="sCreditCode2" retmsg="sCreditMsg2">
				<wtc:sql><%=sql_init%></wtc:sql>
				<wtc:param value="<%=phoneNo%>"/>
				</wtc:pubselect>
				<wtc:array id="sCredit2" scope="end" />	
				<%
					String creditId="";
					if(sCredit2.length>0){
					creditId = sCredit2[0][0];
			
					String strArray2 = WtcUtil.createArray("sCredit2",sCredit2.length);
					%>
					<%=strArray2%>
					<%
					for(int i = 0 ; i < sCredit2.length ; i ++){
						for(int j = 0 ; j < sCredit2[i].length ; j ++){
					%>
						sCredit2[<%=i%>][<%=j%>] = "<%=sCredit2[i][j].trim()%>";
					<%
						}
					}
					%>
					response.data.add("sCreditInit",sCredit2);
					response.data.add("flagInit","0");
					<%
					//e068Cfm end
				}
			}
			%>
			response.data.add("count1","<%=count1%>");
			response.data.add("count2","<%=count2%>");
			//new
			response.data.add("attr_new1","<%=attr_new1%>");
			response.data.add("attr_new2","<%=attr_new2%>");
			core.ajax.receivePacket(response);
		<%}
			// xl 将原来的上移 end
	}
//xl add end
%>	
	
	
