<%
  /*
   * 功能: 向dqcresultaffirm表插入质检确认数据
　 * 版本: 1.0
　 * 日期: 2010/4/11
　 * 作者: tangsong
　 * 版权: sitech
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
	core.ajax.receivePacket(response);
                      