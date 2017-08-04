<%
  /*
   * 功能: e_mail登记
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>
<%! 
		/** 
		 函数说明: 输入一个基本的sql.然后页面参数模式是  [排序号_=_字段名] 或  [排序号_like_字段名]
		 其中column为查询字段.第一位是排序号.排序号不能重复.重复多个将保存一个值.且必须是数字.大小不限如1,11,123.
		 */ 
        public String returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();

		   //输入语句.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
		String value="";
		//将结果保存在这里.key是数字.对数字进行排序.value里面放置object数组存值.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i]
			.toString();
			//String name
			names = name.split("_");
			//将name按照'_'分成3个数组.
			if (names.length >= 3) {
		//如果不能分说明名字不合法.太少区分不了.
		    value = request.getParameter(name);
		//按照名字得到value
		if (value.trim().equals("")) {
			//如果value是""跳过.
			continue;
		}
		Object[] objs = new Object[3];
		objs[0] = names[1];
		//保持 第一个字符串.是like 或是 =
		name = name.substring(name.indexOf("_") + 1);
		name = name.substring(name.indexOf("_") + 1);
		//这地方做数据库的字段处理.第三个'_'以后的都是数据库字段了.
		objs[1] = name;
		//第二个字符串.查询名字.
		objs[2] = value;
		//第三个.查询的值.
	//	System.out.println("~~~~~~~~~~~~~" + objs[0]);
		try {
			temp.put(Integer.valueOf(names[0]), objs);
			//这个地方是将字符串转换成数字.然后进行排序.比如19要在2之后.
		} catch (Exception e) {

		}
		//将排序号码放在key里面,ojbs数组放到value里面.
			}
		}
		Object[] objNos = temp.keySet().toArray();
		//得到一个倒序的数组.
		Arrays.sort(objNos);
		//对数字进行排序.
		for (int i = 0; i < objNos.length; i++) {
			Object[] objs = null;
			objs = (Object[]) temp.get(objNos[i]);
			//下面对like 和 = 分别处理.
			if (objs[0].toString().toLowerCase().equalsIgnoreCase(
			"like")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%"
				+ objs[2].toString().trim() + "%%' ");
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append( objs[1] + " " + objs[0] + " '"
				+ objs[2].toString().trim() + "' ");
			}
		}

        return buffer.toString();
}

%>


<%
		/*midify by guozw 20091114 公共查询服务替换*/
	 String myParams="";
	 String org_code = (String)session.getAttribute("orgCode");
	 String regionCode = org_code.substring(0,2);

    String opCode="K208";
    String opName="质检查询-e_mail登记";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
		
  	String sqlStr = "select to_char(t1.cust_id),t1.contact_mailaddress from dcustdoc t1,dcustmsg t2 where ";
  	String sqlJoinStr = " and t1.cust_id=t2.cust_id";
    String phone_no   =  request.getParameter("0_=_t2.phone_no"); 
    String contact_mailaddress = request.getParameter("contact_mailaddress");

    String[][] dataRows = new String[][]{};
    String cust_id= request.getParameter("cust_id");
    String action = request.getParameter("myaction");
    System.out.println("============action=="+action);
%>			
<%	if ("doLoad".equals(action)) {
      sqlStr+=returnSql(request)+sqlJoinStr;
      System.out.println("==========sqlStr=="+sqlStr);
        %>		           
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
				<wtc:array id="queryList" scope="end"/>
				<%
				dataRows = queryList;
				if(dataRows.length!=0){
				   cust_id = dataRows[0][0];
				   System.out.println("===========dataRows[0][0]="+dataRows[0][0]);
				}
    }
   if ("modify".equals(action)) {
     sqlStr = "update dcustdoc set contact_mailaddress= :contact_mailaddress where cust_id= :cust_id";
     myParams = "contact_mailaddress="+contact_mailaddress+",cust_id="+cust_id ;
     %>
      <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="0">
				<wtc:param value="<%=sqlStr%>"/>
			</wtc:service>
		<%
		if(retCode.equals("000000")){
		%>
		   <script language="javascript">rdShowMessageDialog("修改成功！",2);</script>
		<%
		}else{
			%>
		   <script language="javascript">rdShowMessageDialog("修改失败！",1);</script>
		  <%
		}
   }
%>


<html>
<head>
<title>e_mail登记</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
		 checkElement(this); 
	}	
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInputCheck(flag){
       if(flag=='doLoad'&&  document.sitechform.phone_no.value == ""){
    	   showTip(document.sitechform.phone_no,"用户号码不能为空"); 
    	   sitechform.phone_no.focus(); 	
       }else if(flag=='modify'&& document.sitechform.contact_mailaddress.value == ""){
    	   showTip(document.sitechform.contact_mailaddress,"email地址不能为空"); 
    	   sitechform.contact_mailaddress.focus(); 	
       }else{
         hiddenTip(document.sitechform.phone_no);
         hiddenTip(document.sitechform.contact_mailaddress);
         submitMe(flag);
    	}
}
function submitMe(flag){
   window.sitechform.myaction.value=flag;
   window.sitechform.action="K208_qcEmailRegQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}
</script>
</head>


<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
		<div class="title"><div id="title_zi"> 查询条件 </div></div>
		<table cellspacing="0" style="width:100%;">
     <tr >
      <td > 用户号码
      <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"-->
				<input id="phone_no" name="0_=_t2.phone_no" type="text"  onkeyup="value=value.replace(/[^\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" value=<%=(phone_no==null)?"":phone_no%> >
				<font color="orange">*</font>
			</td>
      <td id="footer" style="width:360px">
       <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck('doLoad');return false;">
      </td>
    </tr>
		</table> 
<br>
		<div class="title"><div id="title_zi">email查询结果</div></div>
		<table cellspacing="0" >
     <tr >
      <td > 
      	<%=(dataRows.length!=0&&dataRows[0][1]!=null)?dataRows[0][1]:"&nbsp;"%>
      </td>
    </tr>
		</table> 
<br>
		<div class="title"><div id="title_zi">修改email</div></div>
		<table cellspacing="0" >
     <tr >
      <td > Email地址：
				<input id="contact_mailaddress" name="contact_mailaddress" type="text"  value="" >
			</td>
      <td id="footer" style="width:360px">
      	<p id="footer">
       <input name="modify" type="button"  id="modify" class="b_foot" value="修改" onClick="submitInputCheck('modify');return false;">
      </p>
      </td>
    </tr>
		</table>    
	</div>  	
	<input name="myaction" type="hidden" value="">
  <input name="cust_id" type="hidden" value="<%=cust_id%>">
</form>
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</body>
</html>

