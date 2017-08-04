<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import = "java.awt.*" %>
<%@ page import = "java.awt.image.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "javax.imageio.*" %>
<%@ page import = "java.awt.font.*" %>
<%@ page import = "java.awt.geom.*" %>
<%@ page import = "com.sitech.common.*" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

    /* liujian 2012-3-28 19:04:43 变量 begin */
		String firstPageBody = "";
	/* liujian 2012-3-28 19:04:43 变量 end */
		
    String workNo = (String)session.getAttribute("workNo");  //工号
    String phoneNo = request.getParameter("phoneNo");        //手机号码
	String classId = request.getParameter("classId");  //销售品分类
	String servId = request.getParameter("servId");  //id_no
	String relMainOfferId = request.getParameter("relMainOfferId");  //当前主资费
	String opCode = request.getParameter("opCode");  //opCode
	String toPage = request.getParameter("toPage");  //toPage
	String lines_one_page = request.getParameter("lines_one_page");  //lines_one_page
%>

<html>
<head>
    <link href="../query/detail.css" rel="stylesheet" type="text/css"></link>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
    
    <script language="javascript">
    	 /*  liujian  2012-3-14 9:06:36  添加详单js方法 begin */
				var currPage = 1;
				$(function() {
					$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');	
					/****************************注册一系列事件*****************************************/
						$('#firstPage').click(function() {
							 var currPage = '<%=toPage%>';
							 if(parseInt(currPage) > 1) {
							 		location ="fg392_2.jsp?toPage=1&lines_one_page=<%=lines_one_page%>&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&relMainOfferId=<%=relMainOfferId%>&servId=<%=servId%>&classId=<%=classId%>";
								}
						});
						$('#prevPage').click(function() {
							 var currPage = '<%=toPage%>';
							 if(parseInt(currPage) > 1) {
								 var toPage = currPage - 1;
								 location ="fg392_2.jsp?toPage=" + toPage+ "&lines_one_page=<%=lines_one_page%>&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&relMainOfferId=<%=relMainOfferId%>&servId=<%=servId%>&classId=<%=classId%>";
							 }
						});
						$('#nextPage').click(function() {
							var currPage = '<%=toPage%>';
							if( parseInt(currPage) < parseInt($('#pageCount').val()) ) {
							  var toPage = parseInt('<%=toPage%>') + 1;
							  location ="fg392_2.jsp?toPage=" + toPage+ "&lines_one_page=<%=lines_one_page%>&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&relMainOfferId=<%=relMainOfferId%>&servId=<%=servId%>&classId=<%=classId%>";
							}
						});
						$('#lastPage').click(function() {
							var currPage = '<%=toPage%>';
							if( parseInt(currPage) < parseInt($('#pageCount').val()) ) {
							 location ="fg392_2.jsp?toPage=" + $('#pageCount').val() + "&lines_one_page=<%=lines_one_page%>&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&relMainOfferId=<%=relMainOfferId%>&servId=<%=servId%>&classId=<%=classId%>";
							}
						});
						$('#pageSel').change(function() {
							var toPage = $('#pageSel').val();
						  	location = "fg392_2.jsp?toPage=" + toPage +"&lines_one_page=<%=lines_one_page%>&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&relMainOfferId=<%=relMainOfferId%>&servId=<%=servId%>&classId=<%=classId%>";
						});

						/****************************初始化页面*****************************************/
						//showLightBox();
						init();
						
				});
				//初始化
				function init() {
					var packet = new AJAXPacket("../s1270/qryAddOffer.jsp","请稍后...");
					packet.data.add("servId",'<%=servId%>');//id_no
					packet.data.add("relMainOfferId",'<%=relMainOfferId%>');//当前主资费
					packet.data.add("roleId",'<%=classId%>');//资费类型代码
					packet.data.add("offerName","");
					packet.data.add("opCode","<%=opCode%>");
					core.ajax.sendPacket(packet,doQryOfferList);
					packet =null;	

				}
				
				function doQryOfferList(packet) {
					var errorCode = packet.data.findValueByName("errorCode");
					var errorMsg = packet.data.findValueByName("errorMsg");	
					if(errorCode == 0){
						var retAry = packet.data.findValueByName("retAry");
						var strArr = new Array();
						var offer_id = "";
						var offer_name = "";
						if(retAry.length > 0) {
							var pageCount = parseInt((retAry.length -1) / parseInt(<%=lines_one_page%>) + 1);
							$('#pageCount').val(pageCount);
							var currPage = parseInt('<%=toPage%>');
							setSelPage(currPage);
							$('#pageSel').val(currPage);
							var lines_one_page = parseInt('<%=lines_one_page%>');
							var _toCurrPageRes = currPage*lines_one_page;
							var len = retAry.length - _toCurrPageRes > 0 ? _toCurrPageRes : retAry.length;
							$('#pageCountSpan').text(pageCount);
							$('#currPageSpan').text(currPage);
							for(var i=(currPage-1)*lines_one_page ; i<len; i++){
								offer_id = retAry[i][0];
								offer_name = retAry[i][1];
								offer_desc = retAry[i][9];
								strArr.push('<tr><td>' + offer_id + '</td>');
								strArr.push(    '<td>' + offer_name + '</td>');
								strArr.push(    '<td>' + offer_desc + '</td></tr>');
							}
						}
						if(strArr.length > 0) {
							$('#groupTbody').append(strArr.join(''));
						}
						$(window.parent.document).find("iframe[@id='groupIframe']").css('height',$("body").height()+20 + 'px');		
					//	showGroupTable(true);
					}else{
						rdShowMessageDialog(errorMsg);
						return false;	
					}	
				}
				
				//设置颜色和click事件
				function setToPageAttr() {
						var count = $('#pageCount').val();
						if(parseInt(count) == 1) {
								$('#nextPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
								$('#lastPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
						}
				}
				
				function setSelPage(pageCount) {
						if(!pageCount) {
								$('#pageSel').append('<option value = 1>第1页</option>');
						}else {
							var count = parseInt(pageCount);
							var pageArr = new Array();
							for( var i = 1; i <= count; i++) {
									pageArr.push('<option value = ' + i + '>第' + i + '页</option>');
							}
							$('#pageSel').append(pageArr.join(''));
						}
				}
				
				/*  liujian  2012-3-14 9:06:36  添加详单js方法 end */
		</script>
		
</head>
<!-- yuanqs 2010/9/13 11:01:43 -->
<body  topmargin="0">
	<form name="frm2" action="" method="post" >
		<input type="hidden" value="" id="pageCount" />
		<input type="hidden" value="" id="rowNum" />
		
		<div id="groupTable" style="overflow: auto">
			<div id="Operation_Table" style="padding:0px">
					<table id="tabList2" cellspacing=0>
							<thead>	
								<tr>
									<th width="10%">销售品ID</th>			
									<th width="15%">销售品名称</th>
									<th>销售品描述</th>
								</tr>
							</thead>
							<tbody id="groupTbody">
									
							</tbody>
							
					</table>
					<table cellspacing="0">
				    <tbody> 
				      <tr> 
				    			<td> 共有<span id="pageCountSpan"></span>页，当前页为第<span id="currPageSpan"></span>页 </td>
	 							<td><span name="firstPage" id="firstPage" class="detail_href">【首页】   </span> </td>
	          					<td><span name="prevPage" id="prevPage" class="detail_href" >  【上一页】 </span> </td>
	         					<td><span name="nextPage" id="nextPage" class="detail_href" >  【下一页】 </span> </td>
			  		      		<td><span name="lastPage" id="lastPage" class="detail_href" > 【尾页】    </span> </td>		    
						  		<td width="10%">
						  				<select id="pageSel" name="pageSel" style="width:80px">
									    </select>
						  		</td>		 
				      </tr>
				    </tbody> 
				  	</table>
			</div>
		</div>
	</form>
</body>
</html>