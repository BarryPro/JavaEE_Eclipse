<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "4941";
 		String opName = "数据库瘦身";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());
%>
	<head>
	<title>黑龙江BOSS-审核记录查询</title>
	<script language="javascript">
		<!--
			/**点击切换标签调用事件**/
			function showMessage(flag){
				var guidanceUl=document.getElementById("guidanceUl");
				for(var i=0;i<guidanceUl.childNodes.length;i++){
					guidanceUl.childNodes[i].className="";
				}
				eval("document.getElementById('li"+flag+"')").className="current";	
				if(flag==1){
					document.InfoFrame.location = "f5555.jsp?opCode=4941&opName=数据库瘦身";
				}else if(flag==2){
					document.InfoFrame.location = "f5553.jsp?opCode=4941&opName=数据库瘦身";
				}else if(flag==3){
					document.InfoFrame.location = "f5552.jsp?opCode=4941&opName=数据库瘦身";
				}
			}		
		
			
			/**关闭页面**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			//-->
	</script>
	
	<!--这段css样式是用来设置切换标签的样式,,,如果有更好的切换标签来替换,,,请删除这段样式,不影响页面其他内容-->
	<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
	  font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	-->
	</style>

</head>

<body>
	<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">

		<div class="title">
			<div id="title_zi">请选择操作类型</div>
		</div>
		
		<!--切换标签,如果有更合适的标签,,可以替换-->
		 <table cellSpacing="0">
		 	<tr>
		 		<td>
					<div id="tabsJ">
						<ul id="guidanceUl">
							<li id="li1" class="current"><a onclick="showMessage(1)"><span>清理记录查询</span></a></li>
							<li id="li2"><a onclick="showMessage(2)"><span>数据库信息表</span></a></li>
							<li id="li3"><a onclick="showMessage(3)"><span>数据清理控制表</span></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
     		<table cellspacing="0">
				<tr>
					<td style="height:0;">
						<iframe frameborder="0" id="InfoFrame" align="center" name="InfoFrame" scrolling="yes" style="width:99%;overflow-y:auto;height:300px;visibility:inherit;" onload="document.getElementById('InfoFrame').style.height=InfoFrame.document.body.scrollHeight+'px'" src="f5555.jsp?opCode=5555&opName=数据库瘦身"></iframe>
						<!--iframe frameBorder="0" id="InfoFrame" align="center" name="InfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:99%;"  onload="document.getElementById('InfoFrame').style.height=InfoFrame.document.body.scrollHeight+'px'" src="f5555.jsp?opCode=5555&opName=数据库瘦身"></iframe-->
					</td>
				</tr>
			</table>
		<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

