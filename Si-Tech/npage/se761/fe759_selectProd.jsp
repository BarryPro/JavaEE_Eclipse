<%
  /* *********************
   * 功能: 资费革命，翻页用
   * 版本: 1.0
   * 日期: 2012-4-13 10:58:53
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String prodOfferId = request.getParameter("prodOfferId");
	String prodofferName = request.getParameter("prodofferName");
	String prodLibMark = request.getParameter("prodLibMark");
	String prodLibName = request.getParameter("prodLibName");
	String prodSumRes = request.getParameter("prodSumRes");
	String prodResUnit = request.getParameter("prodResUnit");
	String prodOfferMin = request.getParameter("prodOfferMin");
	String prodOfferMax = request.getParameter("prodOfferMax");
	String prodStock = request.getParameter("prodStock");
	String prodBeginDate = request.getParameter("prodBeginDate");
	String minDate97 = request.getParameter("minDate97");
	String prodEndDate = request.getParameter("prodEndDate");
	String prodDiscountPrice = request.getParameter("prodDiscountPrice");
	String prodType = request.getParameter("prodType");
%>