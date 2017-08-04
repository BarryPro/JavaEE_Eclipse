<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2009年8月25日
　 * 作者: wangzn
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String sPOSpecNumber = request.getParameter("sPOSpecNumber");
  String sProductSpecNumber = request.getParameter("sProductSpecNumber");
  String opName ="当前属性配置信息";
  String opCode = "";
  System.out.println("sProductSpecNumber:"+sProductSpecNumber);	 
  
  String sqlStr="select character_id,character_name,substr(character_attr_code,1,1) from sbbossmembercharacter where productspec_number = '"+sProductSpecNumber+"'";




 //提交的数据 sProductSpecNumber 产品规格编码 字符串类型,characterIdS 成员属性id 字符串数组类型,characterNameS 属性名称 字符串数组类型,characterMustS 是否必填（1必填，0非必填） 字符串数组类型
  String[] characterIdS = request.getParameterValues("characterId");
  String[] characterNameS = request.getParameterValues("characterName");
  String[] characterMustS = request.getParameterValues("characterMust");
  
  //out.print("["+sProductSpecNumber+"]");
  //out.print("["+characterIdS.toString()+"]");
  //out.print("["+characterNameS.toString()+"]");
  //out.print("["+characterMustS.toString()+"]");
  //if(characterIdS!=null){
  //  out.print("["+characterIdS.length+"]");
  //}
%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ include file="/npage/include/header.jsp" %>
<%
  if(characterIdS!=null){  
%>
<wtc:service name="s2039Cfm1" routerKey="region" routerValue="<%=regionCode%>" outnum="2"  retcode="Code" retmsg="Msg">
	<wtc:param value="<%=sProductSpecNumber%>" />
	<wtc:params value="<%=characterIdS%>" />
	<wtc:params value="<%=characterNameS%>" />
	<wtc:params value="<%=characterMustS%>" />
</wtc:service>
<wtc:array id="result1" scope="end"/>
	
<script language="JavaScript">
	rdShowMessageDialog('<%=Msg%>');
</script>
<%}%>




<script language="javascript">
function addColumn(){
	    var tab = document.getElementById("memberTab");	
			var t_row =tab.insertRow(-1);
			var t_cell1=t_row.insertCell(0);
			var t_cell2=t_row.insertCell(1);
			var t_cell3=t_row.insertCell(2);
			var t_cell4=t_row.insertCell(3);
		  
		  t_cell1.innerHTML="<input type=\"text\" name=\"characterId\" value=\"\" v_must=\"1\" v_type=\"string\"  onblur=\"chkvalue(this)\"  >";
		  t_cell2.innerHTML="<input type=\"text\" name=\"characterName\" value=\"\" v_must=\"1\" v_type=\"string\"  >";	
		  t_cell3.innerHTML="<select name=characterMust><option value='0'>非必填</option><option value='1'>必填</option></select>";
		  t_cell4.innerHTML="<input type=\"button\" name=\"b_del\" value=\"删除\" class=\"b_text\" onclick=\"delColumn(this)\" >";
}
function delColumn(obj){
		  var td = obj.parentNode;
		  var tr = td.parentNode;
		  tr.parentNode.removeChild(tr);
}
function chkvalue(obj){
	var flag = 0;
	var characterIds = document.all.characterId;
	if(typeof(characterIds.length)=="undefined"){//有且只有一条数据
		return;
	}else{
		for(var k=0;k<characterIds.length;k++){
  	 		if(characterIds[k].value==obj.value){
  	 				 flag ++;
  	 		}
  	}
	}
	if(flag>1){
		rdShowMessageDialog("该属性ID已经存在");
  	 				 obj.focus();
	}
}
</script>	


<form name="form2"  method="post">
	<input type=hidden name="sProductSpecNumber" value='<%=sProductSpecNumber%>'>
	<div style="height:200px;overflow: auto">
	<table cellspacing="0" id="memberTab">
			   <tr>
			    <th nowrap>属性编码</th> 
	        <th nowrap>属性名</th>
	        <th nowrap>属性配置</th>   
	        <th nowrap>操作</th>
	      </tr>
       
<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
		    <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%  
			for(int i=0;i<result.length;i++){			  
%>		
  			  <tr>
  			  	<td><input type=hidden name=characterId value=<%=result[i][0]%> ><%=result[i][0]%></td>
				    <td><input type=hidden name=characterName value=<%=result[i][1]%> ><%=result[i][1]%></td>
					  <td><select name=characterMust>
					  	      <option value='0' <%if("0".equals(result[i][2])){%>selected<%}%> >非必填</option>
					  	      <option value='1' <%if("1".equals(result[i][2])){%>selected<%}%> >必填</option>
					  	  </select>
					  </td>			
					  <td><input type=button class=b_text value=删除 onclick="delColumn(this)"></td>					 					 
	        </tr>
<%
       }
%>
	     
		
	</table>
	<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
            	  <input class='b_foot'  onClick="addColumn()" style="cursor:hand" type=button value=增加>
            	  &nbsp;
                <input class='b_foot'  onClick="parent.doSubmit();" style="cursor:hand" type=button value=提交>
            </TD>
        </TR>
    </TBODY>
</TABLE>	
</div>
</form>
