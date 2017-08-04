<%
  /*
   * 功能: 质检结果确认详情
　 * 版本: 1.0
　 * 日期: 2008/11/11
　 * 作者: hanjc
　 * 版权: sitech
   * update:  mixh 2009/02/19 确认之后的通知、通知标题、通知内容为只读。
   *
 　*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String belongno   = WtcUtil.repNull(request.getParameter("belongno"));   //后续流水号                            
	String submitno   = WtcUtil.repNull(request.getParameter("submitno"));   //提交人工号
	String type       = WtcUtil.repNull(request.getParameter("type"));       //类别0:质检结果通知、1申诉、2答复、3确认                               
	String serialnum  = WtcUtil.repNull(request.getParameter("serialnum"));  //质检单流水                                 
	String staffno    = WtcUtil.repNull(request.getParameter("staffno"));    //被检工号                                   
	String evterno    = WtcUtil.repNull(request.getParameter("evterno"));    //质检工号                       
	String title      = WtcUtil.repNull(request.getParameter("apptitle"));   //标题                                       
	String content    = WtcUtil.repNull(request.getParameter("content"));    //内容 
	//String signataryid = WtcUtil.repNull((String)session.getAttribute("kfWorkNo"));//确认人工号
	String signataryid = WtcUtil.repNull((String)session.getAttribute("workNo"));//确认人工号
	
	//中间传值，质检是否发送提醒标志
	String flag          = WtcUtil.repNull(request.getParameter("flag"));    //内容 
	String contact_id    = WtcUtil.repNull(request.getParameter("recordeserialnum"));    //通话流水 
	String[] sqlStrs     = new String[3];
	String tableName     = "dcallcall";
	if(contact_id.length()>0){
		String nowYYYYMM = contact_id.substring(0, 6);
		tableName = "dcallcall" + nowYYYYMM;
	}
	  
	if("3".equals(type)){
		String sqlUpdateQcinfo = "update dqcinfo set flag='3',signataryid=:v1,affirmtime=sysdate where serialnum=:v2&&"+signataryid+"^"+serialnum;
		String sqlUpdateQcmodInfo = "update dqcmodinfo set flag='3',signataryid=:v1,affirmtime=sysdate where serialnum=:v2 and modflag='1'&&"+signataryid+"^"+serialnum;
		String sqlUpdateDacllcall = "update "+tableName+" set qc_flag='Y',qc_login_no=:v1 where contact_id=:v2&&"+evterno+"^"+contact_id;
		
		sqlStrs[0] = sqlUpdateQcinfo;
		sqlStrs[1] = sqlUpdateQcmodInfo;
		sqlStrs[2] = sqlUpdateDacllcall;    
		//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm=""; 
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrs%>"/>
</wtc:service>
<%
	}
%>
	<wtc:service name="sK203Insert" outnum="3">
	<wtc:param value="<%=belongno%>"/>
	<wtc:param value="<%=submitno%>"/>
	<wtc:param value="<%=type%>"/>
	<wtc:param value="<%=serialnum%>"/>
	<wtc:param value="<%=staffno%>"/>
	<wtc:param value="<%=evterno%>"/>
	<wtc:param value="<%=title%>"/>
	<wtc:param value="<%=content%>"/>
	</wtc:service> 
                          
	var response = new AJAXPacket();
	response.data.add("retCode",<%=retCode%>);
	response.data.add("type","<%=type%>");
	response.data.add("flag","<%=flag%>");
	core.ajax.receivePacket(response);
                      