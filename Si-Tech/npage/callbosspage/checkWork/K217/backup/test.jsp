<%
  /*
   * 功能: 来电信息查询
　 * 版本: 1.0
　 * 日期: 2008/10/14
　 * 作者: donglei 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<html>
<head>
<title>来电信息查询</title>
</head>


<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title">来电信息查询</div>
		<table cellspacing="0" style="width:650px">
    <tr >
      <td >技能队列 </td>
      <td >
        <select id="skill_quence" name="14_=_skill_quence" size="1" onchange="skill.value=this.options[this.selectedIndex].text">
				  <wtc:qoption name="s151Select" outnum="2">
				  <wtc:sql>select skill_queue_id , skill_queue_id|| '-->' ||skill_queud_name from dagskillqueue</wtc:sql>
				  </wtc:qoption>
        </select>
      </td>
    </tr>
	 <tr >
		</table>    
	</div>
</form>
</body>
</html>

