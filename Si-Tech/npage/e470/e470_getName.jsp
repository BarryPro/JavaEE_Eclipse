<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	 					//操作工号
	String phone_no = request.getParameter("phoneNo").trim();					//用户号码
	String unit_id = request.getParameter("unitId").trim(); 
	//System.out.println("AAAAAAAAAAAAAAAAAAAAAA unit_id is "+unit_id);
	String[] inParas1 =new String[2];
	/*
	inParas1[0] = "select nvl(unit_name,' ') from dgrpcustmsg a,dgrpmembermsg b,dcustmsg c where a.unit_id=b.unit_id  and     b.id_no=c.id_no and a.unit_id=:unit_id and c.phone_no= :phone_no ";
	inParas1[1]="unit_id="+unit_id+",phone_no="+phone_no; 
	select nvl(unit_name,' ') from dgrpcustmsg where unit_id=to_number(:unit_id)
	*/
	inParas1[0] = "select nvl(unit_name,' ') from dgrpcustmsg   where unit_id=:unit_id   ";
	inParas1[1]="unit_id="+unit_id;
	String i1="";
	//System.out.println("11111111111111 inParas1[0] is "+inParas1[0]+" and is "+inParas1[1]);
%>
	<wtc:service name="TlsPubSelCrm" retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
 
	</wtc:service>
	<wtc:array id="resultCount" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	String count_1 = "";
	
	if(resultCount!=null&&resultCount.length>0)
	{
		//System.out.println("111111111111111111111resultCount[0][0] is "+resultCount[0][0]);
		i1=resultCount[0][0];
		count_1="0";
		
	}
	else
	{
		//System.out.println("11111111111111111111resultCount is "+resultCount.length);
		count_1="1";
	}
%>	
 
 
	var response = new AJAXPacket();
			
	response.data.add("flagName","<%=count_1%>");
	response.data.add("grpName","<%=i1%>");
 
	core.ajax.receivePacket(response);
 