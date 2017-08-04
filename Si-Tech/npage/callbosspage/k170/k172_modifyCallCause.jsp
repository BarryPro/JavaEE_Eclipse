<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm=""; 
//来电原因异动修改 保存操作页面
//获取参数
String workNo = (String)session.getAttribute("workNo");
String kfWorkNo = (String)session.getAttribute("kfWorkNo");
String strPreNodeId=request.getParameter("strPreNodeId");
String strPreNodeName=request.getParameter("strPreNodeName");
String strNodeId=request.getParameter("strNodeId")==null?"":request.getParameter("strNodeId");
	String strNodeName=request.getParameter("strNodeName")==null?"":request.getParameter("strNodeName");
//排除特殊情况
		if(!strNodeId.equals("")&&(strNodeName.indexOf("<>")!=-1||strNodeName.toUpperCase().indexOf("<UNDEFINED>")!=-1))
		{
			String nodeInsql = "";
			String[] nodeIds = strNodeId.split(",");
			for(int i=1;i<nodeIds.length;i++){
				if(i==1)
					nodeInsql = "'"+nodeIds[i]+"'";
				else{
					nodeInsql = nodeInsql+",'"+nodeIds[i]+"'";
				}
			}
			if(!nodeInsql.equals("")){
			strNodeName = "";
			String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where 1=1 and t.callcause_id  in ("+nodeInsql+") and t.is_del='N' and visible='1' order by t.callcause_id";
			%>
		<wtc:service name="s152Select" outnum="5">
		<wtc:param value="<%=sqlStr%>"/>
		</wtc:service>
		<wtc:array id="resultList" start="0" length="5" >
			<%
				for(int i=1;i<nodeIds.length;i++){
					for(int j = 0; j < resultList.length; j++){
							if(nodeIds[i].equals(resultList[j][0])){
									strNodeName = strNodeName+"<span id="+resultList[j][0]+" ><"+resultList[j][0]+"→"+resultList[j][4]+"><br></span>";
							}
					}
			  }
			%>
		</wtc:array>
			<%
			}
		}
String strContactId=request.getParameter("strContactId");
String strContactMonth= request.getParameter("contactMonth");
String remarkInfo=WtcUtil.repNull(request.getParameter("remarkInfo"));
	System.out.println("strContactId222222222:\t"+strContactId);
String strUpdSql="update dcallcall"+strContactMonth+" t set t.call_cause_id='"+strNodeId+"',";
       strUpdSql+="t.callcausedescs=:v1,t.bak=:v2 where t.contact_id=:v3&&"+strNodeName+"^"+remarkInfo+"^"+strContactId;
       
String strInsert="insert into DLOGCALLCAUSEHIS t (t.serial_no,t.login_no,t.oper_date,t.pre_call_cause_id,t.pre_call_cause_des,t.last_call_cause_id,t.last_call_cause_des,t.contact_id,t.kf_login_no) ";
       strInsert+="values(SEQ_CALLCAUSELOG.NEXTVAL,:v1,sysdate,:v2,:v3,:v4,";
       strInsert+=":v5,:v6,:v7)&&"+workNo+"^"+strPreNodeId+"^"+strPreNodeName+"^"+strNodeId+"^"+strNodeName+"^"+strContactId+"^"+kfWorkNo;
       System.out.println("strInsert:\tt___________"+strInsert);       
List sqlList=new ArrayList();
System.out.println("########################"+strUpdSql);
String[] sqlArr = new String[]{};
		     sqlList.add(strUpdSql);
		     sqlList.add(strInsert);
		     sqlArr = (String[])sqlList.toArray(new String[0]);
String outnum = String.valueOf(sqlArr.length + 1);   
%>
   <wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);	
