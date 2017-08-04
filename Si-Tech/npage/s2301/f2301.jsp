<%
 /*
  * version v2.0
  * 开发商: si-tech
  *
  * update:zhouby@2012-11-12 页面改造,修改样式
  *
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.ArrayList"%>
<head>
<%
    request.setCharacterEncoding("GBK");

    String opCode = "2301";
    String opName = "黑名单管理";

    ArrayList arr1 = (ArrayList)session.getAttribute("allArr");
    String workNo = (String)session.getAttribute("workNo");
    String nopass = (String)session.getAttribute("password");
    
    String[][] baseInfo = (String[][])arr1.get(0);
    String[][] info = (String[][])arr1.get(2);
    String[][] favInfo = (String[][])arr1.get(3);

    int favFlag = 0 ;
    for(int i = 0 ; i < favInfo.length ; i ++){
        if(favInfo[i][0].trim().equals("a272")){
            favFlag = 1;
        }
    }
%>

<title>黑名单管理</title>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%@ include file="/npage/include/public_title_name.jsp" %>

</head>
<script language="javascript">
    var printFlag=9;
    var flag = 0;
    var timeFlag = 0;
    
    onload = function(){
        self.status="";
        document.all.phoneNo.focus();
        document.all.id1.style.display = "none";
        document.all.id2.style.display = "none";
    }
    
    function doProcess(packet){
      var backString = packet.data.findValueByName("backString");
      var cfmFlag = packet.data.findValueByName("flag");
    
      if(cfmFlag==1){
          var errCode = packet.data.findValueByName("errCode");
          var errMsg = packet.data.findValueByName("errMsg");
        
          var errCodeInt = parseInt(errCode);
    
          if(errCodeInt==0){
              rdShowMessageDialog("操作成功！", 2);
              document.frm.backLoginAccept.value = backString[0][0];
              window.location = "f2301.jsp";
    
              flag=0;
              resett();
          }else{
              rdShowMessageDialog(errCode + " : " + errMsg, 1);
              window.location="f2301.jsp";
              resett();
              return;
          }
      }
      
      if(cfmFlag==11){
          rdShowMessageDialog("该号码不在黑名单中！");
          document.all.id1.style.display = "none";
          document.all.id2.style.display = "none";
          document.frm.submit.disabled=false;
          
          document.frm.opType.options[0].selected=true; 
        
          flag=1;
      }
      
      if(cfmFlag==12){
          rdShowMessageDialog("该号码已经存在黑名单中！");
          document.all.id1.style.display = "";
          document.all.id2.style.display = "";
          document.frm.submit.disabled=false;
          
          document.frm.opType.options[1].selected=true; 
        
          flag=1;
          document.frm.belong_code.value=backString[0][0];
          document.frm.op_time.value=backString[0][1];
          document.frm.org_code.value=backString[0][2];
          document.frm.login_no.value=backString[0][3];
          document.frm.op_code.value=backString[0][4];
          document.frm.op_note.value=backString[0][5];
      }
    }
    
    function submitCfm(){
        if(flag==1){
            var opTypeI = 0 ;
            var opTypeFin = "";
            for(opTypeI = 0 ; opTypeI < document.frm.opType.length ; opTypeI ++){
                if(document.frm.opType.options[opTypeI].selected){
                    opTypeFin = document.frm.opType.options[opTypeI].value;
                }
            }
          
            if(document.frm.remark.value.length==0){
                document.frm.remark.value="黑名单管理";
            }
          
            document.frm.submit.disabled=true;
            var myPacket = new AJAXPacket("f2301Cfm.jsp?sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value, 
                                          "正在提交，请稍候......");
            
            myPacket.data.add("loginAccept",document.frm.loginAccept.value);
            myPacket.data.add("opCode",document.frm.opCode.value);
            myPacket.data.add("workNo",document.frm.workNo.value);
            myPacket.data.add("noPass",document.frm.noPass.value);
            myPacket.data.add("orgCode",document.frm.orgCode.value);
            
            myPacket.data.add("opType",opTypeFin);  
            myPacket.data.add("blackType",document.frm.idType.value);
            myPacket.data.add("blackNo",document.frm.phoneNo.value);
            
            myPacket.data.add("handFee",document.frm.handFeeT.value);
            myPacket.data.add("factPay",document.frm.handFeeT.value);
        
            myPacket.data.add("ipAdd",document.frm.ipAdd.value);
            
            core.ajax.sendPacket(myPacket);
      
            myPacket = null;
        }else{
            rdShowMessageDialog("请先查询证件信息！");
        }
    }
    
    
    function resett(){
        document.all.id1.style.display = "none";
        document.all.id2.style.display = "none";
        document.frm.phoneNo.value="";
        
        document.frm.qry.disabled=false;
        
        document.frm.phoneNo.disabled=false;
        
        document.frm.submit.disabled=true;
        
        printFlag=9;
        flag=0;
    }
    
    function getUserInfo(){
        setValidateAttr();
        
        if (!checkElement(document.frm.phoneNo)){
            return;
        }
        
        document.frm.phoneNo.readonly = true;
        var myPacket = new AJAXPacket("getUser.jsp", "正在提交，请稍候......");
      
        myPacket.data.add("phoneNo",document.frm.phoneNo.value);
        myPacket.data.add("idType",document.frm.idType.value);
    
        core.ajax.sendPacket(myPacket);
    
        myPacket = null;
    }
    
    function setValidateAttr() {
        var type = $('select[name="idType"]').get(0).selectedIndex;
        if (type == '0') {
            $('input[name="phoneNo"]').attr('v_type','idcard');
        } else {
            $('input[name="phoneNo"]').removeAttr('v_type');
        }
    }
    
</script>
<body>
<form action="" method="post" name="frm">
  <%@ include file="/npage/include/header.jsp" %>
  
  <div class="title">
    <div id="title_zi">操作区</div>
  </div>
  
  <table cellspacing="0" align="center">
    <tr> 
      <td nowrap>证件号码：</td>
      <td> 
        <input class="" type=text name=phoneNo v_must="1" />
      </td>
      <td nowrap>证件类型：</td>
      <td colspan="3">
        <select name="idType">
          <wtc:qoption name="sPubSelect" outnum="2">
            <wtc:sql>select id_type, id_type||'-'||id_name from sIdType order by id_type</wtc:sql>
          </wtc:qoption>
        </select>
        <input name=qry value="查询" onClick="getUserInfo()" type="button" class="b_text">
      </td>
    </tr>
    
    <tr> 
      <td width="14%">操作类型： </td>
      <td colspan="5">
        <select name=opType>
          <option value="A">增加</option>
          <option value="D">删除</option>
        </select>
      </td>
    </tr>
    
    <tr id="id1"> 
      <td>归属代码： </td>
      <td><input class=button type=text readonly name=belong_code></td>
      <td>操作时间： </td>
      <td><input class=button type=text readonly name=op_time></td>
      <td nowrap>营业员归属地： </td>
      <td colspan=3><input class=button readonly type=text name=org_code></td>
    </tr>
    
    <tr id="id2"> 
      <td>操作工号： </td>
      <td><input class=button type=text readonly name=login_no></td>
      <td>操作代码： </td>
      <td><input class=button type=text readonly name=op_code></td>
      <td>操作备注： </td>
      <td><input class=button readonly type=text name=op_note></td>
    </tr>
    
    <tr> 
      <td>用户备注：</td>
      <td colspan="5">
        <input class=button id=Text3 type=text size=60 maxlength="60" name=remark value="" index="2">
      </td>
    </tr>
  </table>
  
  <table cellspacing="0" align="center">
    <tr>
      <td id="footer">
        <input class="b_foot" name=submit  index="3" type=button value="确认" onclick="submitCfm()" onKeyUp="if(event.keyCode==13){submitCfm()}" disabled >
        <input class="b_foot" type=button name=back value="清除" onclick="window.location='f2301.jsp'">
        <input class="b_foot" type=button name=close value="关闭" onClick="parent.removeTab('<%=opCode%>')"  >
      </td>
    </tr>
  </table>
  
  <input type=hidden name=loginAccept value="0">
  <input type=hidden name=opCode value="2301">
  
  <input type=hidden name=workNo value=<%=baseInfo[0][2]%>>
  <input type=hidden name=noPass value=<%=nopass%>>
  <input type=hidden name=orgCode value=<%=baseInfo[0][16]%>>
  <input type=hidden name=sysRemark value="黑名单管理">
  <input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
  <input type=hidden name=handFeeT value="0">
  <input type=hidden name=qryFlagT value="">
  <input type=hidden name=customPass>
  <input type=hidden name=idCardNo>
  <input type=hidden name=custAddress>
  <input type=hidden name=backLoginAccept>
  <input type=hidden name=timeFlag value="0">
  <input type=hidden name=favFlag value="<%=favFlag%>">
  <input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>">

  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
