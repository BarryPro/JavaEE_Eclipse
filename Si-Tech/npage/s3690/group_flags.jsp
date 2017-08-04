   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "3200";
  String opName = "VPMN集团开户";
%>              
<%
  /*begin diling add for 判断是否有优惠类操作权限@2012/11/6 */
  String sm_code = request.getParameter("sm_code");
  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
	String[] favStr = new String[temfavStr.length];
	String sele1disabledFlag = "disabled";
	boolean operFlag = false;
	for(int i = 0; i < favStr.length; i ++) {
		favStr[i] = temfavStr[i][0].trim();
	}
	if (WtcUtil.haveStr(favStr, "a367")) {
		operFlag = true;
	}
	
	if(operFlag&&"vp".equals(sm_code)){
	  sele1disabledFlag = "";
	}
	
	 /*end diling add @2012/11/6 */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	


<%@ page contentType="text/html;charset=GBK"%>

<%
		String iFlags = request.getParameter("flags");
		if (iFlags != null)
		{
			if (iFlags.length() < 36)
			{
				/*LGZ ADD 智能网上暂时不支持>23的数据*/
				iFlags = iFlags + "00000000000000000000000000000000000000000000";
			}
		}
%>

<html>
<head>
<title>集团开户－集团功能代码修改</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">

<script language="JavaScript">	
	function save_to(){
	
		var str="";
		for(i=0;i<document.frm.elements.length;i++){
			if(document.frm.elements[i].name.substring(0,6)=="select"){
				str = str + document.frm.elements[i].value;
			}
		}
	
		//alert(str);
		window.returnValue=str;
		window.close(); 
	}

	function quit(){
		window.close(); 
	}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">     
	
<%@ include file="/npage/include/header_pop.jsp" %>


	<div class="title">
		<div id="title_zi">集团功能代码修改</div>
	</div>
	
	
  <table cellspacing="0" >


    <tr> 
      <td class="blue" nowrap>网内去话</td>
      <td>
        <select name="select1" <%=sele1disabledFlag%> >
          <option <% if(iFlags.substring(0,1).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(0,1).equals("1")) out.println(" selected ");%>value="1">市话</option>
          <option <% if(iFlags.substring(0,1).equals("2")) out.println(" selected ");%>value="2">市话+省内</option>
          <option <% if(iFlags.substring(0,1).equals("3")) out.println(" selected ");%>value="3">市话+省内+省外</option>
          <option <% if(iFlags.substring(0,1).equals("4")) out.println(" selected ");%>value="4">市话+省内+省外+国际</option>
        </select></td>
      <td class="blue" nowrap>网内来话</td>
      <td>
        <select name="select2"  <%=sele1disabledFlag%> >
          <option <% if(iFlags.substring(1,2).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(1,2).equals("1")) out.println(" selected ");%>value="1">市话</option>
          <option <% if(iFlags.substring(1,2).equals("2")) out.println(" selected ");%>value="2">市话+省内</option>
          <option <% if(iFlags.substring(1,2).equals("3")) out.println(" selected ");%>value="3">市话+省内+省外</option>
          <option <% if(iFlags.substring(1,2).equals("4")) out.println(" selected ");%>value="4">市话+省内+省外+国际</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue"  nowrap>网间去话</td>
      <td>
        <select name="select3"  disabled>
          <option <% if(iFlags.substring(2,3).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(2,3).equals("1")) out.println(" selected ");%>value="1">市话</option>
          <option <% if(iFlags.substring(2,3).equals("2")) out.println(" selected ");%>value="2">市话+省内</option>
          <option <% if(iFlags.substring(2,3).equals("3")) out.println(" selected ");%>value="3">市话+省内+省外</option>
          <option <% if(iFlags.substring(2,3).equals("4")) out.println(" selected ");%>value="4">市话+省内+省外+国际</option>
        </select></td>
      <td class="blue" nowrap>网间来话</td>
      <td>
        <select name="select4"  disabled>
          <option <% if(iFlags.substring(3,4).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(3,4).equals("1")) out.println(" selected ");%>value="1">市话</option>
          <option <% if(iFlags.substring(3,4).equals("2")) out.println(" selected ");%>value="2">市话+省内</option>
          <option <% if(iFlags.substring(3,4).equals("3")) out.println(" selected ");%>value="3">市话+省内+省外</option>
          <option <% if(iFlags.substring(3,4).equals("4")) out.println(" selected ");%>value="4">市话+省内+省外+国际</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>网外去话</td>
      <td>
        <select name="select5"  disabled> 
          <option <% if(iFlags.substring(4,5).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(4,5).equals("1")) out.println(" selected ");%>value="1">市话</option>
          <option <% if(iFlags.substring(4,5).equals("2")) out.println(" selected ");%>value="2">市话+省内</option>
          <option <% if(iFlags.substring(4,5).equals("3")) out.println(" selected ");%>value="3">市话+省内+省外</option>
          <option <% if(iFlags.substring(4,5).equals("4")) out.println(" selected ");%>value="4">市话+省内+省外+国际</option>
        </select></td>
      <td class="blue" nowrap>网外来话</td>
      <td>
        <select name="select6"  disabled>
          <option <% if(iFlags.substring(5,6).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(5,6).equals("1")) out.println(" selected ");%>value="1">市话</option>
          <option <% if(iFlags.substring(5,6).equals("2")) out.println(" selected ");%>value="2">市话+省内</option>
          <option <% if(iFlags.substring(5,6).equals("3")) out.println(" selected ");%>value="3">市话+省内+省外</option>
          <option <% if(iFlags.substring(5,6).equals("4")) out.println(" selected ");%>value="4">市话+省内+省外+国际</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>网外号码组去话</td>
      <td>
        <select name="select7" >
          <option <% if(iFlags.substring(6,7).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(6,7).equals("1")) out.println(" selected ");%>value="1">市话</option>
          <option <% if(iFlags.substring(6,7).equals("2")) out.println(" selected ");%>value="2">市话+省内</option>
          <option <% if(iFlags.substring(6,7).equals("3")) out.println(" selected ");%>value="3">市话+省内+省外</option>
          <option <% if(iFlags.substring(6,7).equals("4")) out.println(" selected ");%>value="4">市话+省内+省外+国际</option>
        </select></td>
      <td class="blue" nowrap>网外号码组来话</td>
      <td>
        <select name="select8" >
          <option <% if(iFlags.substring(7,8).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(7,8).equals("1")) out.println(" selected ");%>value="1">市话</option>
          <option <% if(iFlags.substring(7,8).equals("2")) out.println(" selected ");%>value="2">市话+省内</option>
          <option <% if(iFlags.substring(7,8).equals("3")) out.println(" selected ");%>value="3">市话+省内+省外</option>
          <option <% if(iFlags.substring(7,8).equals("4")) out.println(" selected ");%>value="4">市话+省内+省外+国际</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>主叫漫游权限</td>
      <td>
        <select name="select9" >
          <option <% if(iFlags.substring(8,9).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(8,9).equals("1")) out.println(" selected ");%>value="1">省内</option>
          <option <% if(iFlags.substring(8,9).equals("2")) out.println(" selected ");%>value="2">省内+省外</option>
        </select></td>
      <td class="blue" nowrap>被叫漫游权限</td>
      <td>
        <select name="select10" >
          <option <% if(iFlags.substring(9,10).equals("0")) out.println(" selected ");%>value="0">禁止</option>
          <option <% if(iFlags.substring(9,10).equals("1")) out.println(" selected ");%>value="1">省内</option>
          <option <% if(iFlags.substring(9,10).equals("2")) out.println(" selected ");%>value="2">省内+省外</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>集团话务员</td>
      <td>
        <select name="select11" >
          <option <% if(iFlags.substring(10,11).equals("0")) out.println(" selected ");%>value="0">不提供</option>
          <option <% if(iFlags.substring(10,11).equals("1")) out.println(" selected ");%>value="1">提供</option>
          <option <% if(iFlags.substring(10,11).equals("2")) out.println(" selected ");%>value="2">提供但话务员不能作主叫</option>
        </select></td>
      <td class="blue" nowrap>人工总机转接</td>
      <td>
        <select name="select12" >
          <option <% if(iFlags.substring(11,12).equals("0")) out.println(" selected ");%>value="0">不支持</option>
          <option <% if(iFlags.substring(11,12).equals("1")) out.println(" selected ");%>value="1">支持</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>闭合用户群功能</td>
      <td>
        <select name="select13" >
          <option <% if(iFlags.substring(12,13).equals("0")) out.println(" selected ");%>value="0">不提供</option>
          <option <% if(iFlags.substring(12,13).equals("1")) out.println(" selected ");%>value="1">提供优惠群</option>
          <option <% if(iFlags.substring(12,13).equals("2")) out.println(" selected ");%>value="2">提供闭合优惠群</option>
        </select></td>
      <td class="blue" nowrap>信息保密</td>
      <td>
        <select name="select14" >
          <option <% if(iFlags.substring(13,14).equals("0")) out.println(" selected ");%>value="0">不提供</option>
          <option <% if(iFlags.substring(13,14).equals("1")) out.println(" selected ");%>value="1">提供</option>
        </select></td>
    </tr>
<input type="hidden" name="select15" value="<%=iFlags.substring(14,15)%>">
    <tr> 
      <td class="blue" nowrap>群组短消息</td>
      <td>
        <select name="select16" >
          <option <% if(iFlags.substring(15,16).equals("0")) out.println(" selected ");%>value="0">不提供</option>
          <option <% if(iFlags.substring(15,16).equals("1")) out.println(" selected ");%>value="1">提供</option>
        </select></td>
      <td class="blue">通过管理流程拨打话务员对主叫是否收费</td>
      <td>
        <select name="select17" >
          <option <% if(iFlags.substring(16,17).equals("0")) out.println(" selected ");%>value="0">不收费</option>
          <option <% if(iFlags.substring(16,17).equals("1")) out.println(" selected ");%>value="1">收费</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>成员是否能直接呼叫话务员</td>
      <td>
        <select name="select18" >
          <option <% if(iFlags.substring(17,18).equals("0")) out.println(" selected ");%>value="0">不能</option>
          <option <% if(iFlags.substring(17,18).equals("1")) out.println(" selected ");%>value="1">能</option>
        </select></td>
      <td class="blue" nowrap>话务员网内来话是否收费</td>
      <td>
        <select name="select19" >
          <option <% if(iFlags.substring(18,19).equals("0")) out.println(" selected ");%>value="0">不收费</option>
          <option <% if(iFlags.substring(18,19).equals("1")) out.println(" selected ");%>value="1">收费</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>拨打话务员是否转接运营商客服中心</td>
      <td>
        <select name="select20" >
          <option <% if(iFlags.substring(19,20).equals("0")) out.println(" selected ");%>value="0">不转接</option>
          <option <% if(iFlags.substring(19,20).equals("1")) out.println(" selected ");%>value="1">转接</option>
        </select></td>
<input type="hidden" name="select21" value="<%=iFlags.substring(20,21)%>">
      <td class="blue" nowrap>网外号码组</td>
      <td>
        <select name="select22" >
          <option <% if(iFlags.substring(21,22).equals("0")) out.println(" selected ");%>value="0">不提供</option>
          <option <% if(iFlags.substring(21,22).equals("1")) out.println(" selected ");%>value="1">提供</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>个人付费呼叫是否有优惠</td>
      <td>
        <select name="select23" >
          <option <% if(iFlags.substring(22,23).equals("0")) out.println(" selected ");%>value="0">无优惠</option>
          <option <% if(iFlags.substring(22,23).equals("1")) out.println(" selected ");%>value="1">有优惠</option>
        </select></td>
      <td class="blue" nowrap>集团分区分时优惠服务</td>
      <td>
        <select name="select24" >
          <option <% if(iFlags.substring(23,24).equals("0")) out.println(" selected ");%>value="0">不提供</option>
          <option <% if(iFlags.substring(23,24).equals("1")) out.println(" selected ");%>value="1">提供集团登记分区</option>
          <option <% if(iFlags.substring(23,24).equals("2")) out.println(" selected ");%>value="2">提供集团登记小区</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>预置IP服务</td>
      <td>
        <select name="select25" >
          <option <% if(iFlags.substring(24,25).equals("0")) out.println(" selected ");%>value="0">不提供</option>
          <option <% if(iFlags.substring(24,25).equals("1")) out.println(" selected ");%>value="1">提供</option>
        </select></td>
      <td class="blue" nowrap>移动中继业务</td>
      <td>
        <select name="select26" >
          <option <% if(iFlags.substring(25,26).equals("0")) out.println(" selected ");%>value="0">不提供</option>
          <option <% if(iFlags.substring(25,26).equals("1")) out.println(" selected ");%>value="1">提供</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>成员能否使用会议电话功能</td>
      <td>
        <select name="select27" >
          <option <% if(iFlags.substring(26,27).equals("0")) out.println(" selected ");%>value="0">不能</option>
          <option <% if(iFlags.substring(26,27).equals("1")) out.println(" selected ");%>value="1">能</option>
        </select></td>
      <td class="blue">虚拟省级集团内子集团间是否仅使用长号拨打</td>
      <td>
        <select name="select28" >
          <option <% if(iFlags.substring(27,28).equals("0")) out.println(" selected ");%>value="0">不是</option>
          <option <% if(iFlags.substring(27,28).equals("1")) out.println(" selected ");%>value="1">是</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>集团成员使用何种个人套餐</td>
      <td>
        <select name="select29" >
          <option <% if(iFlags.substring(28,29).equals("0")) out.println(" selected ");%>value="0">成员可以各自使用不同的个人套餐类型</option>
          <option <% if(iFlags.substring(28,29).equals("1")) out.println(" selected ");%>value="1">成员使用集团统一规定的个人套餐类型</option>
        </select></td>
      <td class="blue" nowrap>是否支持无线CENTREX业务</td>
      <td>
        <select name="select30" >
          <option <% if(iFlags.substring(29,30).equals("0")) out.println(" selected ");%>value="0">不支持</option>
          <option <% if(iFlags.substring(29,30).equals("1")) out.println(" selected ");%>value="1">支持</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>总机用户呼叫集团外用户时号码显示特性</td>
      <td>
        <select name="select31" >
          <option <% if(iFlags.substring(30,31).equals("0")) out.println(" selected ");%>value="0">使用个人标志</option>
          <option <% if(iFlags.substring(30,31).equals("1")) out.println(" selected ");%>value="1">均显示真实号码</option>
          <option <% if(iFlags.substring(30,31).equals("2")) out.println(" selected ");%>value="2">均显示集团总机号码</option>
          <option <% if(iFlags.substring(30,31).equals("3")) out.println(" selected ");%>value="3">移动网用户显示总机＋分机，其他网用户显示总机</option>
        </select></td>
      <td class="blue">PBX用户呼叫集团外用户时号码显示特性</td>
      <td>
        <select name="select32" >
          <option <% if(iFlags.substring(31,32).equals("0")) out.println(" selected ");%>value="0">显示总机号</option>
          <option <% if(iFlags.substring(31,32).equals("1")) out.println(" selected ");%>value="1">移动网用户显示真实号码，其他网用户显示总机</option>
          <option <% if(iFlags.substring(31,32).equals("2")) out.println(" selected ");%>value="2">均显示真实号码</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>PBX呼叫话单使用何种计费号码</td>
      <td>
        <select name="select33" >
          <option <% if(iFlags.substring(32,33).equals("0")) out.println(" selected ");%>value="0">使用PBX真实号码</option>
          <option <% if(iFlags.substring(32,33).equals("1")) out.println(" selected ");%>value="1">使用集团计费号码</option>
          <option <% if(iFlags.substring(32,33).equals("2")) out.println(" selected ");%>value="2">使用个人计费号码</option>
        </select></td>
      <td class="blue" nowrap>是否使用集团总机特性</td>
      <td>
        <select name="select34" >
          <option <% if(iFlags.substring(33,34).equals("0")) out.println(" selected ");%>value="0">不使用</option>
          <option <% if(iFlags.substring(33,34).equals("1")) out.println(" selected ");%>value="1">使用AIP总机</option>
          <option <% if(iFlags.substring(33,34).equals("2")) out.println(" selected ");%>value="2">使用集团总机业务</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>是否支持拨打网内长号不优惠</td>
      <td>
        <select name="select35" >
          <option <% if(iFlags.substring(34,35).equals("0")) out.println(" selected ");%>value="0">不支持</option>
          <option <% if(iFlags.substring(34,35).equals("1")) out.println(" selected ");%>value="1">支持</option>
        </select></td>
      <td class="blue" nowrap>一次IP呼叫是否享受vpn优惠</td>
      <td>
        <select name="select36" >
          <option <% if(iFlags.substring(35,36).equals("0")) out.println(" selected ");%>value="0">不优惠</option>
          <option <% if(iFlags.substring(35,36).equals("1")) out.println(" selected ");%>value="1">优惠</option>
        </select></td>
    </tr>

    <tr> 
       <TD  id="footer"  colspan="4">
          <input type="Button" name="Button" value="保存" onClick="save_to()" class="b_foot">&nbsp;&nbsp;
          <input type="Button" name="return" value="返回" onClick="quit()" class="b_foot">
       
       </td>
       
       
    </tr>
  </table>

  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
