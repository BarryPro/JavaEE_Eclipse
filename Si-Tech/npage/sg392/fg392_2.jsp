<%
    /********************
     version v2.0
     ������: si-tech
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

    /* liujian 2012-3-28 19:04:43 ���� begin */
		String firstPageBody = "";
	/* liujian 2012-3-28 19:04:43 ���� end */
		
    String workNo = (String)session.getAttribute("workNo");  //����
    String phoneNo = request.getParameter("phoneNo");        //�ֻ�����
	String classId = request.getParameter("classId");  //����Ʒ����
	String servId = request.getParameter("servId");  //id_no
	String relMainOfferId = request.getParameter("relMainOfferId");  //��ǰ���ʷ�
	String opCode = request.getParameter("opCode");  //opCode
	String toPage = request.getParameter("toPage");  //toPage
	String lines_one_page = request.getParameter("lines_one_page");  //lines_one_page
%>

<html>
<head>
    <link href="../query/detail.css" rel="stylesheet" type="text/css"></link>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
    
    <script language="javascript">
    	 /*  liujian  2012-3-14 9:06:36  ����굥js���� begin */
				var currPage = 1;
				$(function() {
					$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');	
					/****************************ע��һϵ���¼�*****************************************/
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

						/****************************��ʼ��ҳ��*****************************************/
						//showLightBox();
						init();
						
				});
				//��ʼ��
				function init() {
					var packet = new AJAXPacket("../s1270/qryAddOffer.jsp","���Ժ�...");
					packet.data.add("servId",'<%=servId%>');//id_no
					packet.data.add("relMainOfferId",'<%=relMainOfferId%>');//��ǰ���ʷ�
					packet.data.add("roleId",'<%=classId%>');//�ʷ����ʹ���
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
				
				//������ɫ��click�¼�
				function setToPageAttr() {
						var count = $('#pageCount').val();
						if(parseInt(count) == 1) {
								$('#nextPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
								$('#lastPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
						}
				}
				
				function setSelPage(pageCount) {
						if(!pageCount) {
								$('#pageSel').append('<option value = 1>��1ҳ</option>');
						}else {
							var count = parseInt(pageCount);
							var pageArr = new Array();
							for( var i = 1; i <= count; i++) {
									pageArr.push('<option value = ' + i + '>��' + i + 'ҳ</option>');
							}
							$('#pageSel').append(pageArr.join(''));
						}
				}
				
				/*  liujian  2012-3-14 9:06:36  ����굥js���� end */
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
									<th width="10%">����ƷID</th>			
									<th width="15%">����Ʒ����</th>
									<th>����Ʒ����</th>
								</tr>
							</thead>
							<tbody id="groupTbody">
									
							</tbody>
							
					</table>
					<table cellspacing="0">
				    <tbody> 
				      <tr> 
				    			<td> ����<span id="pageCountSpan"></span>ҳ����ǰҳΪ��<span id="currPageSpan"></span>ҳ </td>
	 							<td><span name="firstPage" id="firstPage" class="detail_href">����ҳ��   </span> </td>
	          					<td><span name="prevPage" id="prevPage" class="detail_href" >  ����һҳ�� </span> </td>
	         					<td><span name="nextPage" id="nextPage" class="detail_href" >  ����һҳ�� </span> </td>
			  		      		<td><span name="lastPage" id="lastPage" class="detail_href" > ��βҳ��    </span> </td>		    
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