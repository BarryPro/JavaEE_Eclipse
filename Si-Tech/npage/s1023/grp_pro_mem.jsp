<%
  /*
   * 功能: 集团产品成员信息分时图
　 * 版本: v1.0
　 * 日期: 2011年05月10日
　 * 作者: zhoujf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String sqlStr = "";
	String sqlStr1 = "";
	String sqlStmt2="";
	String id_no =  request.getParameter("id_no")==null?"":request.getParameter("id_no");
	String implRegion= (String)session.getAttribute("regCode");	
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="";
  String opName="集团产品成员信息";
  String sqlStmt="  select b.phone_no, b.name, c.sm_name,b.id_no,   t.offer_name,t3.card_name  from DCUSTMSGADD   a,DGRPMEMBERMSG  b,ssmcode  c,product_offer t,product_offer_instance t1,sgrpbigcardcode   t3 where a.id_no = b.id_no and b.id_no = t1.serv_id and t.offer_id = t1.offer_id and t1.eff_date < sysdate and t1.exp_date > sysdate and t.offer_type = 10 and c.sm_code = b.sm_code and b.card_code = t3.card_code and substr(b.belong_code, 0, 2) = c.region_code and a.FIELD_CODE = '1004'  AND a.FIELD_VALUE ='"+id_no+"'";  
		/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
		//查询总记录数
	sqlStr  =  "SELECT count(*) from ("	+ sqlStmt + ")"; 
		        
	//查询内容        
	sqlStr1 = "select * from (select row_.*,rownum id from (" + sqlStmt + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; //查询指定条数的记录
	System.out.println("sqlStr1:"+sqlStr1);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="10">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
		
		<%
			System.out.println("result=====1023 begin===11111111111111111111111111==========\n"+sqlStr);
			System.out.println("result=====1023 begin=============\n"+sqlStr);
		System.out.println("result=================="+result2.length);
		String[][] memNO=new String[result2.length][2];
		for(int ii=0;ii<result2.length;ii++){
				 sqlStmt2="select b.run_name,c.sm_name from DCUSTMSG a ,sruncode b,ssmcode c where c.region_code=b.region_code and substr(a.run_code,1,1)=b.run_code and substr(a.belong_code,0,2)=b.region_code and c.sm_code=a.sm_code and a.id_no='"+result2[ii][3]+"'";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sqlStmt2%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result3" scope="end" />
		<%
		memNO[ii][0]=result3[0][0];
		memNO[ii][1]=result3[0][1];
		System.out.println("result======zhoujs======1023  END======\n"+memNO[ii][1]);
		System.out.println("result======zhoujs======1023  END======\n"+memNO[ii][0]);
		}
		String[][] allNumStr = new String[][]{};
		String[][] result1   = new String[][]{};

	try 
	{
		//allNumStr = (String[][])retList.get(0);
		allNumStr=result;
		//System.out.println("allNumStr = " + allNumStr[0][0]);
		System.out.println("\n==================\nok2");	
	}
	catch(Exception e)
	{
		System.out.println("\n==================\nerror2");
	}
	
	try 
	{
		//result1 = (String[][])retList1.get(0);	
		result1=result2;	
		System.out.println("\n==================\nok3");	
	}
	catch(Exception e)
	{
		System.out.println("\n==================\nerror3");
	}
	
	System.out.println("allNumStr = " + allNumStr[0][0]);
	
	if(result1 == null || result1.length == 0)
	{
	%>
		<script language='jscript'>
		function closeDivWin(obj){
		if(!obj){
			obj = parent;
		}
		obj.$(".window .close:last").click();
		}
			rdShowMessageDialog("没有查到相关记录！");
			closeDivWin();			
		</script>      
	<%            
	}
		System.out.println("result======zhoujs======1023  END======\n");
		%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>

<script type=text/javascript>
		
	function grp(id_no){
			var url = "grp_main.jsp?unit_id="+unit_id;
    	window.open(url,"","width=800,height=600,left=10,top=10,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
	}
</script>
<script type=text/javascript>
	
	function grp(id_no){
			var url = "grp_main.jsp?id_no="+id_no;
    	window.open(url,"","width=800,height=600,left=10,top=10,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
	}
</script>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>

<div class="title"><div id="title_zi">集团产品基本信息</div></div>
<table cellSpacing=0>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>集团成员号码</th>
				<th>集团成员姓名</th>
				<th>集团成员号码品牌</th>
				<th>集团成员号码状态</th>
				<th>集团成员套餐</th>
				<th>集团成员VIP类别</th>
      	
			</tr>
		<%	
		for(int i = 0; i < result1.length; i++)
		{		  
		%>			
			<tr>				
				<td nowrap align='center'><%=result1[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=memNO[i][0].trim()%>&nbsp;</td>
        <td nowrap align='center'><%=result1[i][4].trim()%>&nbsp;</td>
        <td nowrap align='center'><%=result1[i][5].trim()%>&nbsp;</td>
			</tr>
		<%
		}
		%>	
		<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%	
					    //实现分页
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
					%>
					</div>
				</td>				
			</tr>						
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>


