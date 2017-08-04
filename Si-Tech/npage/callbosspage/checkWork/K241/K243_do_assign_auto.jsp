<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*,java.text.SimpleDateFormat,java.util.*"%>
<%
	String assignId = WtcUtil.repNull(request.getParameter("assignId"));
	String login_no = (String)session.getAttribute("workNo");
	String[] evterno = request.getParameterValues("evterno");
	String[] contactIdArr = request.getParameterValues("contactIdArr");
	//update by wench
	String caller=request.getParameter("caller_phone");
  String accept_login_no = request.getParameter("accept_login_no");
 	String Contact_id = request.getParameter("Contact_id");
 	String accept_long_begin = request.getParameter("accept_long_begin");
 	String accept_long_end = request.getParameter("accept_long_end");
  String beginTime = request.getParameter("beginTime"); 
  String endTime = request.getParameter("endTime");
  String addc="";
  if(caller!=null&&!"".equals(caller)){
       addc = addc+" and t.CALLER_PHONE='"+caller+"'";
    }
    if(accept_login_no!=null&&!"".equals(accept_login_no)){
       addc = addc+" and t.ACCEPT_LOGIN_NO='"+accept_login_no+"'";
    }
    if(Contact_id!=null&&!"".equals(Contact_id)){
       addc = addc+" and t.CONTACT_ID='"+Contact_id+"'";
    }
    if(beginTime!=null&&!"".equals(beginTime)){
       addc = addc+" and t.BEGIN_DATE>=to_date('"+beginTime+"','yyyy/mm/dd hh24:mi:ss')";
    }
  	if(endTime!=null&&!"".equals(endTime)){
    		addc = addc+" and t.END_DATE<=to_date('"+endTime+"','yyyy/mm/dd hh24:mi:ss')";
    }
    if(accept_long_begin!=null&&!"".equals(accept_long_begin)){
    		addc = addc+" and t.accept_long>="+accept_long_begin;
    }
    if(accept_long_end!=null&&!"".equals(accept_long_end)){
    		addc = addc+" and t.accept_long<="+accept_long_end;
    }
System.out.println("wench evterno"+evterno.length+"wench");
System.out.println("wench contactIdArr"+contactIdArr.length+"wench");


  List list=new LinkedList();
		for(int j = 0; j < contactIdArr.length; j++) {   
		        if(!list.contains(contactIdArr[j])) {   
		            list.add(contactIdArr[j]);  
		          }  
		 }
		 contactIdArr=new String[list.size()];
		for(int l=0;l<list.size();l++)
		{
			contactIdArr[l]=(String)list.get(l);
			
		}

	
	String tempvalue="";
	String tempvalueid="";
for (int k=0;k<evterno.length;k++)
{
tempvalue=tempvalue+"'"+evterno[k]+"',";
}
tempvalue=tempvalue.substring(0,tempvalue.lastIndexOf(","));
for (int k=0;k<contactIdArr.length;k++)
{
tempvalueid=tempvalueid+"'"+contactIdArr[k]+"',";
}
tempvalueid=tempvalueid.substring(0,tempvalueid.lastIndexOf(","));

if(tempvalueid.equals("''"))
{
tempvalueid="'1'";
}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	Calendar c = Calendar.getInstance();
	String thisMonth = sdf.format(c.getTime()); //本月
			c.add(c.MONTH, -1);
	String lastMonth = sdf.format(c.getTime()); //上月
	String[] tablenames = new String[]{"dcallcall"+thisMonth, "dcallcall"+lastMonth};

	Map pMap = new HashMap();
	pMap.put("assignId", assignId);
	pMap.put("tablenames", tablenames);

	int avgCount = 0; //平均每个质检员应分配的流水数
	int allCount = 0; //分配流水总数
	List resultList = KFEjbClient.queryForList("query_K243_autoAssign_getCount", pMap);
	if (resultList != null && resultList.size() > 0) {
		Map map = (Map)resultList.get(0);
		
		allCount = Integer.valueOf(map.get("ALLCOUNT").toString()).intValue();
		allCount=allCount;
		if(( allCount-contactIdArr.length)%evterno.length==0)
		{
		avgCount =( allCount-contactIdArr.length)/evterno.length;
		}
	  else
  	{
  	avgCount =( allCount-contactIdArr.length)/evterno.length+1;
  	}
	}
System.out.println("wench contactIdArr"+avgCount+"wench");
System.out.println("wench contactIdArr"+allCount+"wench");		
	String result = null;
	if (allCount == 0) {
		result = "nodata";
	} else {
		List sqlList = new ArrayList();
		//将满足条件的不满意度流水插入到分配结果表dqcdissatisfyresult
		String cause = " where t.accept_login_no in (select s.login_no from dqcdissatisfystaffno s where s.assign_id='" + assignId + "')"
							+ " and t.contact_id not in ("+tempvalueid+") and t.statisfy_code in ('4','5') and (t.qc_flag is null or t.qc_flag<>'Y')"
							+ addc
							+ " and not exists (select * from dqcdissatisfyresult a where a.contact_id=t.contact_id and a.release_flag='N')"
							+ " and not exists (select * from dqcdissatisfyreject b where b.phone_no=t.caller_phone) and "
							+ "not exists (select * from dqcdissatisfyrejectconid ta where ta.contact_id=t.contact_id) ";
		String insertSql = "insert into dqcdissatisfyresult(result_id,contact_id,qc_finish_flag,release_flag,assign_id,assign_login_no,assign_date)"
								+ " select lpad(seq_qc_dissatisfy_result.nextval,10,'0'),x.contact_id,'N','N','" + assignId + "','" + login_no 
								+ "',sysdate from ("
								+ " select contact_id from dcallcall" + thisMonth + " t"+ cause
								+ " union all"
								+ " select contact_id from dcallcall" + lastMonth + " t" + cause
								+ ") x where rownum <= " + allCount;
		sqlList.add(insertSql);
		//每个质检员分配avgCount条流水
		//resultList = KFEjbClient.queryForList("query_K242_getEvternoAndName", pMap);
		//if (resultList != null) {
			for (int i = 0; i < evterno.length; i++) {
				String evterno1 = evterno[i];
				String updateSql = "update dqcdissatisfyresult set evterno='" + evterno1 + "' where assign_id='" + assignId + "'"
											+ " and evterno is null and rownum <= " + avgCount;
				sqlList.add(updateSql);
			}
			
		//}

		try {
			KFEjbClient.batchUpdate("updatePublic", sqlList);
			result = "success";
		} catch (Exception e) {
			result = "false";
			e.printStackTrace();
		}
	}
%>
	var response = new AJAXPacket();
	response.data.add("result","<%=result%>");
	core.ajax.receivePacket(response);