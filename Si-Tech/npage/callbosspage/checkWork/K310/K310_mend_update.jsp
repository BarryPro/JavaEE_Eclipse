<%
  /*
   * 功能: 总计划修改ajax数据操作
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者:
　 * 版权: sitech
   *
 　*/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
String workNo = (String)session.getAttribute("workNo");
//更新总计划表条件
String contentMore="";
//更新被检计划表条件
String contentbqcMore = "";
//更新质检员计划表条件
String contentcheckMore = "";   
String[] bqc=new String[]{};
String[] qc=new String[]{};
String[] ubqc=new String[]{};
String[] uqc=new String[]{};
String[] sqlArr = new String[]{};
List sqlList=new ArrayList();

bqc=(String[])request.getParameterValues("bqcArray");
qc=(String[])request.getParameterValues("qcArray");
ubqc = (String[])request.getParameterValues("bqcUncheckArray");
uqc=(String[])request.getParameterValues("qcUncheckArray");


String plan_id=request.getParameter("plan_id");
String content_id=request.getParameter("content_id");
String object_id=request.getParameter("object_id");

String MIN_TIME=request.getParameter("MIN_TIME")==null?"":request.getParameter("MIN_TIME");
String start_date=request.getParameter("start_date")==null?"":request.getParameter("start_date");
String MAX_TIME=request.getParameter("MAX_TIME")==null?"":request.getParameter("MAX_TIME");
String PLAN_NAME=request.getParameter("PLAN_NAME")==null?"":request.getParameter("PLAN_NAME");
String end_date=request.getParameter("end_date")==null?"":request.getParameter("end_date");
String PRIORITY=request.getParameter("PRIORITY")==null?"":request.getParameter("PRIORITY");
String PLAN_TIME=request.getParameter("PLAN_TIME")==null?"":request.getParameter("PLAN_TIME");
String tmpParam = "";
String tmpParam1 ="";
String tmpParam2 ="";
if(!MIN_TIME.equals(""))
{
	contentMore=contentMore+"MIN_TIME=:MIN_TIME,";
	if("".equals(tmpParam)){
			tmpParam+="&&"+MIN_TIME;
	}
}
if(!start_date.equals(""))
{
		contentMore=contentMore+"begin_date=to_date(:start_date,'yyyyMMdd hh24:mi:ss'),";
		if("".equals(tmpParam)){
			tmpParam+="&&"+start_date;
		}else{
			tmpParam+="^"+start_date;
		}
}
if(!MAX_TIME.equals(""))
{
contentMore=contentMore+"MAX_TIME=:MAX_TIME,";
		if("".equals(tmpParam)){
			tmpParam+="&&"+MAX_TIME;
		}else{
			tmpParam+="^"+MAX_TIME;
		}
}
if(!PLAN_NAME.equals(""))
{
		contentMore=contentMore+"PLAN_NAME=:PLAN_NAME,";
		if("".equals(tmpParam)){
			tmpParam+="&&"+PLAN_NAME;
		}else{
			tmpParam+="^"+PLAN_NAME;
		}
}
if(!end_date.equals(""))
{
		contentMore=contentMore+"end_date=to_date(:end_date,'yyyyMMdd hh24:mi:ss'),";
		if("".equals(tmpParam)){
			tmpParam+="&&"+end_date;
		}else{
			tmpParam+="^"+end_date;
		}
}
if(!PLAN_TIME.equals(""))
{
		contentMore=contentMore+"PLAN_TIME=:PLAN_TIME,";
		if("".equals(tmpParam)){
			tmpParam+="&&"+PLAN_TIME;
		}else{
			tmpParam+="^"+PLAN_TIME;
		}
}
contentbqcMore = contentMore;
tmpParam1= tmpParam;
if(!PRIORITY.equals(""))
{
		contentMore=contentMore+"PRIORITY=:PRIORITY,";
		if("".equals(tmpParam)){
			tmpParam+="&&"+PRIORITY;
		}else{
			tmpParam+="^"+PRIORITY;
		}
}

contentMore = contentMore+"UPDATE_LOGIN_NO=:workNo,";
if("".equals(tmpParam)){
			tmpParam+="&&"+workNo;
		}else{
			tmpParam+="^"+workNo;
		}
contentMore = contentMore+"UPDATE_DATE=sysdate ";

contentbqcMore = contentbqcMore+"UPDATE_LOGIN_NO=:workNo,";
if("".equals(tmpParam1)){
			tmpParam1+="&&"+workNo;
		}else{
			tmpParam1+="^"+workNo;
		}
contentbqcMore = contentbqcMore+"UPDATE_DATE=sysdate ";

contentcheckMore = "UPDATE_LOGIN_NO=:workNo,UPDATE_DATE=sysdate ";
tmpParam2 ="&&"+workNo;

String strDeldqcplanTemp="update dqcplan set "+contentMore
		+" where PLAN_ID= :v1 and content_id=:v2 and object_id=:v3"+tmpParam+"^"+plan_id.trim()+"^"+content_id.trim()+"^"+object_id.trim();
String strUpdatebqcTmp = "update DQCLOGINPLAN set "+contentbqcMore
+" where PLAN_ID= :v1 and content_id=:v2 and object_id =:v3 ";
String strUpdateCheckTmp = "update DQCCHECKLOGINPLAN set "+contentcheckMore;



String strDelDQCLOGINPLANTemp="delete from DQCLOGINPLAN where PLAN_ID= :v1 and content_id=:v2 and object_id=:v3 and LOGIN_NO=:v4" ;
String strDelDQCCHECKLOGINPLANTemp="delete from DQCCHECKLOGINPLAN where PLAN_ID= :v1 and CHECK_LOGIN_NO=:v2";
sqlList.add(strDeldqcplanTemp);

if(bqc!=null)
{
	for(int j=0;j<bqc.length;j++)
	{
		String tempSql="";
		tempSql=strUpdatebqcTmp+" and login_no=:v4"+tmpParam1+"^"+plan_id.trim()+"^"+content_id.trim()+"^"+object_id.trim()+"^"+bqc[j].trim();
		sqlList.add(tempSql);
	}
}
if(qc!=null)
{
	for(int j=0;j<qc.length;j++)
	{
		String tempSql="";
		tempSql=strUpdateCheckTmp+"where PLAN_ID= :v1 and check_login_no=:v2"+tmpParam2+"^"+plan_id.trim()+"^"+qc[j].trim();
		sqlList.add(tempSql);
	}
}
if(ubqc!=null){
	for(int m=0;m<ubqc.length;m++)
	{
		String tempSql="";
		tempSql=strDelDQCLOGINPLANTemp+"&&"+plan_id+"^"+content_id+"^"+object_id+"^"+ubqc[m];
		sqlList.add(tempSql);
	}
}
if(uqc!=null){
	for(int n=0;n<uqc.length;n++)
	{
		String tempSql="";
		tempSql=strDelDQCCHECKLOGINPLANTemp+"&&"+plan_id+"^"+uqc[n];
		sqlList.add(tempSql);
	}
}
int totalNum=1;
if(bqc!=null)
{
totalNum=totalNum+bqc.length;
}
if(qc!=null)
{
totalNum=totalNum+qc.length;
}
if(ubqc!=null){
totalNum=totalNum+ubqc.length;
}
if(uqc!=null)
{
totalNum=totalNum+uqc.length;
}
sqlArr = (String[])sqlList.toArray(new String[0]);
List sqlList_temp = new ArrayList();
String[] sqlArr2 = new String[]{};
String outnum = String.valueOf(sqlArr.length + 1); 
%>
<%

for(int i = 0; i < sqlArr.length; i++){   
	int m = i%5;
	if(m==0) {
		if(i!=0){
		sqlArr2 = (String[])sqlList_temp.toArray(new String[0]);
		
		outnum = String.valueOf(sqlArr2.length + 1);
		%>
		<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
		<wtc:param value="<%=sqlMulKfCfm%>"/>
		<wtc:param value="dbchange"/>
		<wtc:params value="<%=sqlArr2%>"/>
		</wtc:service>
		<wtc:array id="retRows"  scope="end"/>	
		<%
		sqlList_temp = new ArrayList();
		}
	}
	sqlList_temp.add(sqlArr[i]);
	if(i==sqlArr.length-1){
		sqlArr2 = (String[])sqlList_temp.toArray(new String[0]);
		outnum = String.valueOf(sqlArr2.length + 1);
				%>
		<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
		<wtc:param value="<%=sqlMulKfCfm%>"/>
		<wtc:param value="dbchange"/>
		<wtc:params value="<%=sqlArr2%>"/>
		</wtc:service>
		<wtc:array id="retRows"  scope="end"/>		
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retCode%>");
		core.ajax.receivePacket(response);	
				<%
		break;
		}
}
%>