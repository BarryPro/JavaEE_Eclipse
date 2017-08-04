 <!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 号码信息查询1506
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode="1506";
	String opName="号码信息查询";
	String phoneNo = request.getParameter("phoneNo");//查询条件
	String regionCode=(String)session.getAttribute("regCode");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>号码信息查询 </TITLE>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
	String sqlFlag = "";
	sqlFlag = " and a.region_code='" + regionCode+"'";
	StringBuffer sqlsBUF=new StringBuffer("");
	
	sqlsBUF.append("select b.res_name,g.status_name,a.choice_fee,to_char(a.begin_time,'YYYY-MM-DD HH24 MI SS'),"); 
	sqlsBUF.append(" a.region_code,nvl(d.region_name,'公共'),a.district_code,nvl(e.district_name,'公共'),a.town_code,nvl(f.town_name,'公共'),"); 
	sqlsBUF.append(" h.login_name||a.login_no,to_char(a.login_accept),to_char(a.assign_accept),a.total_date,to_char(a.op_time,'YYYYMMDD HH24 MI SS'),a.group_id"); 
	sqlsBUF.append(" from dCustRes a,sResCode b,sRegionCode d,sDisCode e,sTownCode f,sPhoneStatus g,dLoginMsg h"); 
	sqlsBUF.append(" where a.phone_no='" +phoneNo+ "' and a.no_type=b.res_code(+) and a.login_no=h.login_no(+) "); 
	sqlsBUF.append(" and a.region_code=d.region_code(+) "); 
	sqlsBUF.append(" and a.region_code=e.region_code(+) and a.region_code=f.region_code(+) "); 
	sqlsBUF.append(" and a.district_code=e.district_code(+) and a.district_code=f.district_code(+) "); 
	sqlsBUF.append(" and a.town_code=f.town_code(+) and a.resource_code=g.status_code " + sqlFlag);
	
	String sqls=sqlsBUF.toString();  
	                                                                    
	System.out.println("sqlsBUF = "+sqls);
	System.out.println("------------11111111111111111-------------");
	
//	ArrayList arlist = new ArrayList();
//	comImpl co=new comImpl();
//	arlist=co.spubqry32("16",sqls);
	String[] inParam = new String[2];
	inParam[0]= sqls;
	inParam[1]= "phoneNo="+phoneNo+",regionCode="+regionCode;
	System.out.println("***&&&&&&&&&AAAAAAAQQQQQQQQQ");
	System.out.println("sqls======="+sqls);
	
%>
		
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="16" retcode="retCode2" retmsg="retMsg3">
		<wtc:sql><%=sqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%	  	 
	System.out.println("------------55555575555555555-------------");
	
//	String [][] result = new String[][]{};
//	result = (String[][])arlist.get(0);
	if (result.length==0) {
%>
<script language="JavaScript">
	rdShowMessageDialog("没有查询到相关数据！");
	history.go(-1);
</script>
<%
	}
	else
	{
		System.out.println(result[0][15]);
		sqlsBUF=new StringBuffer("");
		sqlsBUF.append("select count(*) from dbresadm.dchngroupinfo a,dchngroupmsg b where a.parent_group_id=b.group_id and a.group_id='"+result[0][15]+"'"); 
	//sqlsBUF.append("select trim(b.group_name) from dbresadm.dchngroupinfo a,dchngroupmsg b where a.parent_group_id=b.group_id and a.group_id='"+result[0][15]+"'"); 
		sqls=sqlsBUF.toString();
//		ArrayList arlist1 = new ArrayList();
//		arlist1=co.spubqry32("1",sqls); 
		
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg1">
	<wtc:sql><%=sqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%	  	 
	//	String [][] result1 = new String[][]{};
//		result1 = (String[][])arlist1.get(0);
		System.out.println(result1[0][0]);
		int l=Integer.parseInt(result1[0][0]);
		System.out.println(l-1);
		String title="";
		for(int i=l-1 ;i>=0;i--){
		System.out.println("ssssssssssssssssssssssssssssssssssssssssss");
		sqlsBUF=new StringBuffer("");
		sqlsBUF.append("select trim(b.group_name) from dbresadm.dchngroupinfo a,dchngroupmsg b where a.parent_group_id=b.group_id and a.group_id=:group_id and a.denorm_level=:i"); 
		sqls=sqlsBUF.toString();
		System.out.println(sqls);
//		ArrayList arlist2 = new ArrayList();
//		arlist2=co.spubqry32("1",sqls);
		String[] inParam2 = new String[2];
		inParam2[0]= sqls;
		inParam2[1]= "group_id="+result[0][15]+",i="+i;
		System.out.println("!!!!inParam[0]======="+inParam2[0]);
		System.out.println("!!!!inParam[1]======="+inParam2[1]);
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1"  routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=inParam2[0]%>"/>
		<wtc:param value="<%=inParam2[1]%>"/> 
	</wtc:service>
	<wtc:array id="result2" scope="end"/>
<%	  	 
//		String [][] result2= new String[][]{};
//		result2 = (String[][])arlist2.get(0);
		if(i==l-1){
		title=result2[0][0];
		}else
		{
		title=title+"-"+result2[0][0];
		}
		System.out.println(result2[0][0]);
	}
	System.out.println(title);
	
	sqlsBUF=new StringBuffer("");
	sqlsBUF.append("select count(*) from dHighMsg a,dcustmsg b where a.id_no=b.id_no and b.phone_no='" +phoneNo+ "' and substr(b.run_code,1,2)<'a'");  
	sqls=sqlsBUF.toString();
//	ArrayList arlist3 = new ArrayList();
	System.out.println(sqls);
//	arlist3=co.spubqry32("1",sqls); 
	
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode1" retmsg="retMsg2">
		<wtc:sql><%=sqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result3" scope="end" />	
<%	  	 
//	String [][] result3 = new String[][]{};
//	result3 = (String[][])arlist3.get(0);
	System.out.println(result3[0][0]);
	int l2=Integer.parseInt(result3[0][0]);
%>
<SCRIPT language="JavaScript">
if(<%=l2%>>0){rdShowMessageDialog("该用户为中高端用户!");}
</script>
</HEAD>

<body>

<FORM method=post name="frm1506">
<input type="hidden" name="opCode"  value="1506">
	<%@ include file="/npage/include/header.jsp" %>
<table cellspacing="0">
	<TR> 
		<TD class="blue">服务号码</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value=<%=phoneNo%>>
		</TD>
		<TD class="blue">归属机构</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="group_id" size="40" maxlength="30" value=<%=title%>>
		</TD>
	</TR>
	
	<TR> 
		<TD class="blue">类型名称</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="typeName" size="20" maxlength="30" value=<%=result[0][0]%>>
		</TD>          
		<TD class="blue">号码状态</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="resCode" size="20" maxlength="15" value=<%=result[0][1]%>>
		</TD>
	</TR>
	
	<TR>           
		<TD class="blue">选号费</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="choiceFee" size="20" maxlength="7" value=<%=result[0][2]%>>
		</TD>
		<TD class="blue">启用时间</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="beginTime" size="20" maxlength="20" value=<%=result[0][3]%>>
		</TD>
	</TR> 
	    
	<TR>         
		<TD class="blue">操作人员</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="loginNo" size="20" maxlength="30" value=<%=result[0][10]%>>
		</TD>
		<TD class="blue">操作流水</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="loginAccept" size="20" maxlength="30" value=<%=result[0][11]%>>
		</TD>
	</TR> 
	  
	<TR >          
		<TD class="blue">分配流水</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="assignAccept" size="20" maxlength="30" value=<%=result[0][12]%>>
		</TD>
		<TD class="blue">帐务日期</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="totalDate" size="20" maxlength="30" value=<%=result[0][13]%>>
		</TD>
	</TR> 
	  
	<TR>          
		<TD class="blue">操作时间</TD>
		<TD colspan="3">
			<input type="text" readonly class="InputGrey" name="opTime" size="20" maxlength="30" value=<%=result[0][14]%>>
		</TD>
	</TR>                   
	
	<tr> 
		<td align="center" id="footer" colspan="4">
		&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
		&nbsp; 
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->
<%
}
%>
